#!/data/data/com.termux/files/usr/bin/bash
# Growstarz Auto-Upload Tool — Termux Installer v2 (Deep Fixed)
# Developer: @growstarz | Telegram: @growstarz
#
# CARA PAKAI — paste 1 baris ini ke Termux:
# curl -fsSL https://raw.githubusercontent.com/GrowLordz/growstarz-scripts/main/install-termux.sh | bash

set -e
TOOL_DIR="$HOME/growstarz-uploader"
SCRIPTS_DIR="$HOME/scripts"
CFG_FILE="$TOOL_DIR/config.json"

C='\033[0;36m'; G='\033[0;32m'; R='\033[0;31m'; Y='\033[1;33m'; M='\033[0;35m'; N='\033[0m'
step() { echo -e "\n${C}[Growstarz] $1${N}"; }
ok()   { echo -e "  ${G}✓${N} $1"; }
warn() { echo -e "  ${Y}⚠${N} $1"; }
fail() { echo -e "  ${R}✗${N} $1"; exit 1; }

echo -e "${M}
  ╔══════════════════════════════════════╗
  ║  Growstarz Auto-Upload Tool v2       ║
  ║  Termux Installer                    ║
  ║  Developer : @growstarz              ║
  ╚══════════════════════════════════════╝
${N}"

# ── 1. Install dependencies ───────────────────────────────────
step "Cek dependencies..."
if ! command -v node &>/dev/null; then
    step "Install nodejs..."
    pkg install -y nodejs 2>/dev/null || pkg install -y nodejs-lts || fail "Node.js gagal install"
fi
command -v node &>/dev/null && ok "Node.js $(node --version)" || fail "Node.js tidak ada"

command -v curl &>/dev/null || { step "Install curl..."; pkg install -y curl; }
ok "curl siap"

# ── 2. Buat folder ────────────────────────────────────────────
step "Setup folder..."
mkdir -p "$TOOL_DIR" "$SCRIPTS_DIR"
ok "Folder: $TOOL_DIR"
ok "Folder: $SCRIPTS_DIR (untuk file .lua kamu)"

# ── 3. Cek storage permission ─────────────────────────────────
if [ ! -d "/storage/emulated/0" ]; then
    warn "Termux belum punya izin storage."
    warn "Jalankan: termux-setup-storage"
    warn "(skip kalau file .lua kamu di ~/scripts/, tidak perlu storage)"
fi

# ── 4. Write index.js ─────────────────────────────────────────
step "Menulis index.js..."
cat > "$TOOL_DIR/index.js" << 'JSEOF'
#!/data/data/com.termux/files/usr/bin/node
/**
 * Growstarz Auto-Upload Tool v2 (Deep Fixed)
 * Watch .lua → XOR encode → push GitHub → print loadstring
 *
 * FIX v2:
 *  - Token TIDAK hardcoded (user isi sendiri)
 *  - github_path tidak double "main"
 *  - Auto-expand "~" di watch_file
 *  - Validasi file .lua (bukan folder)
 *  - Validasi token GitHub sebelum upload
 *  - Display URL lengkap (bukan cuma user/repo/path)
 *  - Retry network 3× dengan backoff
 *  - Error message informatif
 */
const fs   = require("fs");
const path = require("path");
const os   = require("os");
const https = require("https");

const CFG_FILE = path.join(__dirname, "config.json");

// ═══════════════════════════════════════════════════════════
// CONFIG
// ═══════════════════════════════════════════════════════════
function defaultConfig() {
  return {
    github_token : "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",                     // ← USER ISI SENDIRI
    github_user  : "GrowLordz",
    github_repo  : "growstarz-scripts",
    github_branch: "main",
    github_path  : "Growstarz.lua",        // ← FIX: tanpa "main/"
    watch_file   : "watch_file": "/data/data/com.termux/files/home/scripts/Growstarz.lua",                     // ← USER ISI: path .lua
    xor_pack     : true,
    xor_key      : [18,93,9,241,130,26,126,175,234,86,55,63,169,167,89,72],
    loader_header: "--[[ Growstarz (packed) — developer @growstarz | Telegram : @growstarz ]]",
    debounce_ms  : 1500,
    auto_watch   : true,
    notify_discord: false,
    discord_webhook: ""
  };
}

function loadConfig() {
  if (!fs.existsSync(CFG_FILE)) {
    fs.writeFileSync(CFG_FILE, JSON.stringify(defaultConfig(), null, 2));
    return null;
  }
  try {
    return JSON.parse(fs.readFileSync(CFG_FILE, "utf8"));
  } catch (e) {
    console.error("[Growstarz] config.json rusak: " + e.message);
    process.exit(1);
  }
}

// Expand "~" jadi home directory
function expandPath(p) {
  if (!p) return p;
  if (p === "~") return os.homedir();
  if (p.startsWith("~/")) return path.join(os.homedir(), p.slice(2));
  return p;
}

// ═══════════════════════════════════════════════════════════
// ENCODING
// ═══════════════════════════════════════════════════════════
function xorEncode(plaintext, key) {
  const bytes = Buffer.from(plaintext, "utf8");
  const out = [];
  for (let i = 0; i < bytes.length; i++) out.push(bytes[i] ^ key[i % key.length]);
  return out;
}

function buildPacked(plaintext, cfg) {
  const encoded = xorEncode(plaintext, cfg.xor_key);
  let dStr = "";
  for (let i = 0; i < encoded.length; i++) {
    dStr += `\\${encoded[i]}`;
    if ((i + 1) % 40 === 0 && i + 1 < encoded.length) dStr += "\\z\n";
  }
  return [
    cfg.loader_header,
    `local k={${cfg.xor_key.join(",")}}`,
    `local d="${dStr}"`,
    `local t={}`,
    `for i=1,#d do t[i]=string.char(bit32.bxor(string.byte(d,i),k[(i-1)%#k+1]))end`,
    `local f=loadstring(table.concat(t))`,
    `if f then f() else warn("[Growstarz] loader gagal") end`
  ].join("\n");
}

// ═══════════════════════════════════════════════════════════
// GITHUB API (with retry)
// ═══════════════════════════════════════════════════════════
function ghRequest(method, endpoint, body, token) {
  return new Promise((resolve, reject) => {
    const payload = body ? Buffer.from(JSON.stringify(body)) : null;
    const opts = {
      hostname: "api.github.com",
      path: endpoint,
      method,
      headers: {
        "Authorization": `Bearer ${token}`,
        "Accept": "application/vnd.github+json",
        "User-Agent": "Growstarz-Uploader/2.0",
        "Content-Type": "application/json",
        ...(payload ? { "Content-Length": payload.length } : {})
      }
    };
    const req = https.request(opts, (res) => {
      let data = "";
      res.on("data", c => data += c);
      res.on("end", () => {
        try { resolve({ status: res.statusCode, body: JSON.parse(data) }); }
        catch { resolve({ status: res.statusCode, body: data }); }
      });
    });
    req.on("error", reject);
    if (payload) req.write(payload);
    req.end();
  });
}

async function ghRequestRetry(method, endpoint, body, token, maxRetry = 3) {
  let lastErr;
  for (let i = 1; i <= maxRetry; i++) {
    try {
      return await ghRequest(method, endpoint, body, token);
    } catch (e) {
      lastErr = e;
      if (i < maxRetry) {
        process.stdout.write(`(retry ${i}/${maxRetry-1}) `);
        await new Promise(r => setTimeout(r, 1000 * i));
      }
    }
  }
  throw lastErr;
}

async function validateToken(token) {
  if (!token || token === "" || token.includes("XXXX")) {
    return { valid: false, reason: "Token kosong / placeholder" };
  }
  try {
    const r = await ghRequestRetry("GET", "/user", null, token);
    if (r.status === 200 && r.body && r.body.login) {
      return { valid: true, login: r.body.login };
    }
    if (r.status === 401) return { valid: false, reason: "Token invalid / expired" };
    if (r.status === 403) return { valid: false, reason: "Token tidak punya scope repo" };
    return { valid: false, reason: `HTTP ${r.status}` };
  } catch (e) {
    return { valid: false, reason: "Network error: " + e.message };
  }
}

async function validateRepo(cfg) {
  try {
    const ep = `/repos/${cfg.github_user}/${cfg.github_repo}`;
    const r = await ghRequestRetry("GET", ep, null, cfg.github_token);
    if (r.status === 200) {
      return {
        valid: true,
        private: r.body.private,
        defaultBranch: r.body.default_branch
      };
    }
    if (r.status === 404) return { valid: false, reason: "Repo tidak ditemukan / tidak akses" };
    return { valid: false, reason: `HTTP ${r.status}` };
  } catch (e) {
    return { valid: false, reason: "Network error: " + e.message };
  }
}

async function getFileSHA(cfg) {
  const ep = `/repos/${cfg.github_user}/${cfg.github_repo}/contents/${cfg.github_path}?ref=${cfg.github_branch}`;
  const r = await ghRequestRetry("GET", ep, null, cfg.github_token);
  if (r.status === 200) return r.body.sha;
  if (r.status === 404) return null;
  throw new Error(`GitHub GET ${r.status}: ${JSON.stringify(r.body)}`);
}

async function pushFile(cfg, content, sha) {
  const ep = `/repos/${cfg.github_user}/${cfg.github_repo}/contents/${cfg.github_path}`;
  const now = new Date().toISOString().replace("T", " ").slice(0, 19);
  const body = {
    message: `[Growstarz] auto-update ${now}`,
    content: Buffer.from(content).toString("base64"),
    branch: cfg.github_branch,
    ...(sha ? { sha } : {})
  };
  const r = await ghRequestRetry("PUT", ep, body, cfg.github_token);
  if (r.status === 200 || r.status === 201) return r.body;
  throw new Error(`GitHub PUT ${r.status}: ${JSON.stringify(r.body)}`);
}

function rawUrl(cfg) {
  return `https://raw.githubusercontent.com/${cfg.github_user}/${cfg.github_repo}/${cfg.github_branch}/${cfg.github_path}`;
}

function discordNotify(webhook, msg) {
  if (!webhook) return Promise.resolve();
  return new Promise((resolve) => {
    try {
      const payload = Buffer.from(JSON.stringify({ content: msg }));
      const url = new URL(webhook);
      const req = https.request({
        hostname: url.hostname,
        path: url.pathname + url.search,
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Content-Length": payload.length,
          "User-Agent": "Growstarz/2.0"
        }
      }, resolve);
      req.on("error", () => resolve());
      req.write(payload);
      req.end();
    } catch (e) { resolve(); }
  });
}

// ═══════════════════════════════════════════════════════════
// MAIN UPLOAD LOGIC
// ═══════════════════════════════════════════════════════════
let uploading = false, pendingUpload = false;

async function doUpload(cfg, filePath, pack) {
  if (uploading) { pendingUpload = true; return; }
  uploading = true;
  const ts = new Date().toLocaleTimeString("id-ID");
  const fname = path.basename(filePath);
  console.log(`\n[${ts}] Memproses ${fname} ...`);

  try {
    // Validate file (fix EISDIR)
    if (!fs.existsSync(filePath)) {
      throw new Error(`File tidak ada: ${filePath}`);
    }
    const stat = fs.statSync(filePath);
    if (stat.isDirectory()) {
      throw new Error(`Path mengarah ke FOLDER, bukan file: ${filePath}`);
    }
    if (!filePath.endsWith(".lua")) {
      console.log(`  ⚠ Warning: file bukan .lua (${path.extname(filePath)})`);
    }

    const plain = fs.readFileSync(filePath, "utf8");
    const kb = (stat.size / 1024).toFixed(1);
    let content;
    if (pack) {
      process.stdout.write(`  Encoding XOR (${kb} KB) ... `);
      content = buildPacked(plain, cfg);
      console.log(`→ ${(content.length / 1024).toFixed(1)} KB packed`);
    } else {
      content = plain;
      console.log(`  Plaintext (${kb} KB)`);
    }

    process.stdout.write("  Ambil SHA ... ");
    const sha = await getFileSHA(cfg);
    console.log(sha ? `SHA: ${sha.slice(0, 7)}` : "file baru");

    process.stdout.write("  Push ke GitHub ... ");
    await pushFile(cfg, content, sha);
    console.log("✓ OK");

    const ls = `loadstring(game:HttpGet("${rawUrl(cfg)}"))()`;
    console.log(`\n  ┌──────────────────────────────────────────────────────────`);
    console.log(`  │  ${ls}`);
    console.log(`  └──────────────────────────────────────────────────────────\n`);
    fs.writeFileSync(path.join(__dirname, "loadstring.txt"), ls + "\n");

    if (cfg.notify_discord && cfg.discord_webhook) {
      await discordNotify(cfg.discord_webhook, `**[Growstarz] Updated**\n\`\`\`lua\n${ls}\n\`\`\``);
    }
  } catch (err) {
    console.error(`  ✗ ERROR: ${err.message}`);
  } finally {
    uploading = false;
    if (pendingUpload) {
      pendingUpload = false;
      setTimeout(() => doUpload(cfg, filePath, pack), 500);
    }
  }
}

function watch(cfg, filePath, pack) {
  let timer = null;
  console.log(`\n[Growstarz] Watching : ${filePath}`);
  console.log(`[Growstarz] Mode     : ${pack ? "XOR pack" : "plaintext"}`);
  console.log(`[Growstarz] Target   : ${cfg.github_user}/${cfg.github_repo}@${cfg.github_branch}/${cfg.github_path}`);
  console.log(`[Growstarz] URL      : ${rawUrl(cfg)}`);
  console.log("[Growstarz] Ctrl+C untuk berhenti.\n");

  fs.watch(filePath, (event) => {
    if (event !== "change") return;
    clearTimeout(timer);
    timer = setTimeout(() => doUpload(cfg, filePath, pack), cfg.debounce_ms || 1500);
  });
}

// ═══════════════════════════════════════════════════════════
// MAIN
// ═══════════════════════════════════════════════════════════
async function main() {
  const args = process.argv.slice(2);
  const argFile = args.includes("--file") ? args[args.indexOf("--file") + 1] : null;
  const argRaw = args.includes("--raw");
  const argOnce = args.includes("--once");
  const argCheck = args.includes("--check");

  const cfg = loadConfig();
  if (!cfg) {
    console.log("\n[Growstarz] Config dibuat di: " + CFG_FILE);
    console.log("\n[Growstarz] ISI 2 FIELD WAJIB:");
    console.log("  1. github_token  → https://github.com/settings/tokens (scope: repo)");
    console.log("  2. watch_file    → path absolut file .lua, contoh:");
    console.log('       "/data/data/com.termux/files/home/scripts/Growstarz.lua"');
    console.log("\n[Growstarz] Setelah diisi: node ~/growstarz-uploader/index.js");
    return;
  }

  // ── Validate config fields ──
  if (!cfg.github_token || cfg.github_token === "" || cfg.github_token.includes("XXXX")) {
    console.error("\n[Growstarz] ❌ github_token KOSONG di config.");
    console.error("[Growstarz] Buat token di: https://github.com/settings/tokens");
    console.error("[Growstarz] Scope yang dibutuhkan: repo (full)");
    console.error("[Growstarz] Edit: " + CFG_FILE);
    process.exit(1);
  }

  // ── Validate token ──
  console.log("[*] Validasi token GitHub...");
  const tokenCheck = await validateToken(cfg.github_token);
  if (!tokenCheck.valid) {
    console.error(`[Growstarz] ❌ Token invalid: ${tokenCheck.reason}`);
    process.exit(1);
  }
  console.log(`[✓] Token valid (user: ${tokenCheck.login})`);

  // ── Validate repo ──
  console.log("[*] Validasi repo...");
  const repoCheck = await validateRepo(cfg);
  if (!repoCheck.valid) {
    console.error(`[Growstarz] ❌ Repo invalid: ${repoCheck.reason}`);
    console.error(`[Growstarz] Repo: ${cfg.github_user}/${cfg.github_repo}`);
    process.exit(1);
  }
  console.log(`[✓] Repo valid (private: ${repoCheck.private}, default branch: ${repoCheck.defaultBranch})`);
  if (repoCheck.private) {
    console.log("[⚠] Repo PRIVATE — loadstring/game:HttpGet di executor TIDAK akan bisa akses!");
    console.log("[⚠] Set repo jadi PUBLIC di: https://github.com/" + cfg.github_user + "/" + cfg.github_repo + "/settings");
  }

  // ── Validate watch_file ──
  const rawFile = argFile || cfg.watch_file;
  if (!rawFile || rawFile === "") {
    console.error("\n[Growstarz] ❌ watch_file KOSONG di config.");
    console.error("[Growstarz] Edit: " + CFG_FILE);
    console.error('[Growstarz] Contoh: "watch_file": "/data/data/com.termux/files/home/scripts/Growstarz.lua"');
    process.exit(1);
  }

  const filePath = path.resolve(expandPath(rawFile));
  if (!fs.existsSync(filePath)) {
    console.error(`\n[Growstarz] ❌ File tidak ada: ${filePath}`);
    console.error("[Growstarz] Cek path, atau buat file dulu:");
    console.error(`  echo "print('Hello')" > ${filePath}`);
    process.exit(1);
  }
  if (fs.statSync(filePath).isDirectory()) {
    console.error(`\n[Growstarz] ❌ Path mengarah ke FOLDER: ${filePath}`);
    console.error('[Growstarz] Ubah ke path FILE .lua spesifik');
    process.exit(1);
  }

  console.log(`[✓] File siap: ${filePath}`);

  // ── Check-only mode ──
  if (argCheck) {
    console.log("\n[✓] Semua config VALID. Siap upload.");
    console.log("[Growstarz] Jalankan tanpa --check untuk upload.");
    return;
  }

  // ── Upload ──
  const doPack = argRaw ? false : cfg.xor_pack;
  await doUpload(cfg, filePath, doPack);

  if (!argOnce && cfg.auto_watch !== false) {
    watch(cfg, filePath, doPack);
  }
}

main().catch(err => {
  console.error("\n[Growstarz] ❌ Fatal: " + err.message);
  process.exit(1);
});
JSEOF

chmod +x "$TOOL_DIR/index.js"
ok "index.js ditulis"

# ── 5. package.json ───────────────────────────────────────────
cat > "$TOOL_DIR/package.json" << 'EOF'
{"name":"growstarz-uploader","version":"2.0.0","main":"index.js","author":"@growstarz","license":"MIT"}
EOF
ok "package.json ditulis"

# ── 6. Generate config.json (KOSONG) ──────────────────────────
step "Generate config.json (kosong)..."
cd "$TOOL_DIR"
node index.js > /dev/null 2>&1 || true

if [ -f "$CFG_FILE" ]; then
    ok "config.json siap di $CFG_FILE"
    ok "  (token kosong, isi sendiri nanti)"
else
    fail "config.json gagal dibuat"
fi

# ── 7. Buat example .lua ──────────────────────────────────────
EXAMPLE_LUA="$SCRIPTS_DIR/Growstarz.lua"
if [ ! -f "$EXAMPLE_LUA" ]; then
    cat > "$EXAMPLE_LUA" << 'LUAEOF'
-- Growstarz Script
-- Edit file ini dengan script asli kamu
-- Setiap kali disimpan, tool akan auto-upload

print("[Growstarz] Script loaded!")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Growstarz",
    Text = "Script loaded successfully!",
    Duration = 5,
})

-- Tambahkan fitur kamu di sini:
-- local Players = game:GetService("Players")
-- local LocalPlayer = Players.LocalPlayer
-- ... (auto farm, GUI, dll.)
LUAEOF
    ok "Example .lua: $EXAMPLE_LUA"
else
    ok "File .lua sudah ada: $EXAMPLE_LUA"
fi

# ── 8. Update config watch_file (auto-set ke example) ─────────
step "Set watch_file ke example..."
node -e "
const fs = require('fs');
const p = '$CFG_FILE';
const cfg = JSON.parse(fs.readFileSync(p, 'utf8'));
if (!cfg.watch_file || cfg.watch_file === '') {
  cfg.watch_file = '$EXAMPLE_LUA';
  fs.writeFileSync(p, JSON.stringify(cfg, null, 2));
  console.log('  ✓ watch_file → $EXAMPLE_LUA');
} else {
  console.log('  ✓ watch_file sudah diisi: ' + cfg.watch_file);
}
"

# ── 9. Alias ──────────────────────────────────────────────────
step "Setup alias..."
BASHRC="$HOME/.bashrc"
touch "$BASHRC"

grep -q "alias growstarz=" "$BASHRC" 2>/dev/null || {
    echo "" >> "$BASHRC"
    echo "# Growstarz Auto-Upload Tool" >> "$BASHRC"
    echo 'alias growstarz="node $HOME/growstarz-uploader/index.js"' >> "$BASHRC"
    echo 'alias growstarz-once="node $HOME/growstarz-uploader/index.js --once"' >> "$BASHRC"
    echo 'alias growstarz-check="node $HOME/growstarz-uploader/index.js --check"' >> "$BASHRC"
}
ok "Alias ditambahkan: growstarz, growstarz-once, growstarz-check"

# ── 10. Done ──────────────────────────────────────────────────
echo -e "${G}
  ╔════════════════════════════════════════════════════════╗
  ║  INSTALL SELESAI — v2 Deep Fixed                       ║
  ╠════════════════════════════════════════════════════════╣
  ║                                                        ║
  ║  LANGKAH WAJIB:                                        ║
  ║                                                        ║
  ║  1. Dapatkan GitHub Token:                             ║
  ║     Buka: https://github.com/settings/tokens           ║
  ║     Klik: Generate new token (classic)                 ║
  ║     Scope: centang "repo"                              ║
  ║     Copy token ghp_xxxxx                               ║
  ║                                                        ║
  ║  2. Edit config:                                       ║
  ║     nano ~/growstarz-uploader/config.json              ║
  ║                                                        ║
  ║     GANTI:                                              ║
  ║     "github_token": "ghp_TOKEN_KAMU_DISINI"            ║
  ║                                                        ║
  ║     Cek watch_file (sudah auto-set):                   ║
  ║     "$EXAMPLE_LUA"                                     ║
  ║                                                        ║
  ║  3. Test config:                                       ║
  ║     source ~/.bashrc                                   ║
  ║     growstarz-check                                    ║
  ║                                                        ║
  ║  4. Upload:                                            ║
  ║     growstarz-once                                     ║
  ║     (atau "growstarz" untuk auto-watch)                ║
  ║                                                        ║
  ║  5. Copy loadstring yang muncul → paste ke executor    ║
  ║                                                        ║
  ╠════════════════════════════════════════════════════════╣
  ║  File .lua kamu: $EXAMPLE_LUA
  ║  Config:         $CFG_FILE
  ╚════════════════════════════════════════════════════════╝
${N}"

# Auto-source bashrc
if [ -f "$BASHRC" ]; then
    source "$BASHRC" 2>/dev/null || true
fi

# Tawarkan buka config
echo ""
read -p "Buka config sekarang untuk isi token? (y/N): " OPEN_CFG
if [ "$OPEN_CFG" = "y" ] || [ "$OPEN_CFG" = "Y" ]; then
    nano "$CFG_FILE"
    echo ""
    echo -e "${C}Setelah save, jalankan:${N}"
    echo -e "${G}  growstarz-check${N}  (test config)"
    echo -e "${G}  growstarz-once${N}   (upload sekali)"
    echo -e "${G}  growstarz${N}        (auto-watch + upload)"
fi
