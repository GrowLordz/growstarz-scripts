local genv=(getgenv and getgenv())or _G if genv.__ANCHHub_LoadingAt and(os.clock()-genv.__ANCHHub_LoadingAt)<4.5 then
 return end
genv.__ANCHHub_LoadingAt=os.clock()for idx,key in ipairs({"__ANCHHubSession","__Tadonoki","__Alfian","__GTFarm"})do
 if genv[key]then
 genv[key].Alive=false if genv[key].Cleanup then
 pcall(genv[key].Cleanup)
end
end
genv[key]=nil
end
local session={Alive=true,Connections={}}session.Cleanup=function()session.Alive=false end
genv.__ANCHHubSession=session genv.ANCHHubGB_Loaded=os.clock()
local function isAlive()return session.Alive and genv.__ANCHHubSession==session
end
local function trackConn(conn)if conn then
 table.insert(session.Connections,conn)end
return conn end
do

local getThreadIdentity=getthreadidentity or get_thread_identity or getidentity or(syn and syn.get_thread_identity)if type(getThreadIdentity)=="function"then
 pcall(function()session.Ident=getThreadIdentity()
end)end
session.Exec=coroutine.create(function(yieldFn)while true do

local ok,err=pcall(yieldFn)yieldFn=coroutine.yield(ok,err)
end
end)
end
local function execSafe(fn)
local setThreadIdentityFn=setthreadidentity or set_thread_identity or setidentity or(syn and syn.set_thread_identity)
local function restoreIdent()if session.Ident and type(setThreadIdentityFn)=="function"then
 pcall(setThreadIdentityFn,session.Ident)
end
end
local execCoroutine=session.Exec if execCoroutine and coroutine.status(execCoroutine)=="suspended"then

local resumeOk,resumeVal=coroutine.resume(execCoroutine,function()restoreIdent()fn()
end)if resumeOk and resumeVal~=false then
 return true
end
end
restoreIdent()return pcall(fn)
end
local clonerefFn=(cloneref or clonereference or function(ref)return ref
end)
local Players=clonerefFn(game:GetService("Players"))
local ReplicatedStorage=clonerefFn(game:GetService("ReplicatedStorage"))
local StarterGui=clonerefFn(game:GetService("StarterGui"))
local GuiService=clonerefFn(game:GetService("GuiService"))
local UserInputService=clonerefFn(game:GetService("UserInputService"))
local HttpService=clonerefFn(game:GetService("HttpService"))
local RunService=clonerefFn(game:GetService("RunService"))
local TeleportService=clonerefFn(game:GetService("TeleportService"))
local VirtualUser=clonerefFn(game:GetService("VirtualUser"))
local TextChatService=clonerefFn(game:GetService("TextChatService"))
local TextService=clonerefFn(game:GetService("TextService"))
local LocalPlayer=Players.LocalPlayer
local PlayerGui=LocalPlayer:WaitForChild("PlayerGui",5)
local Shared=ReplicatedStorage:FindFirstChild("Shared")or ReplicatedStorage:WaitForChild("Shared",3)
local WorldRemotes=ReplicatedStorage:FindFirstChild("WorldRemotes")or ReplicatedStorage:WaitForChild("WorldRemotes",1)
local DropItem=WorldRemotes and WorldRemotes:FindFirstChild("DropItem")
local SetTileRemote=WorldRemotes and WorldRemotes:FindFirstChild("SetTile")
local TakeDrop=WorldRemotes and WorldRemotes:FindFirstChild("TakeDrop")
local PickTitle=WorldRemotes and WorldRemotes:FindFirstChild("PickTitle")
local WorldClosed=WorldRemotes and WorldRemotes:FindFirstChild("WorldClosed")
local ItemDB=genv.__ANCH_ItemDBCache or{}
local function loadItemDB()if next(ItemDB)~=nil then
 return ItemDB end
pcall(function()
local _R=game:GetService("ReplicatedStorage")
local _S=_R:FindFirstChild("Shared")or Shared
local _T=_S and _S:FindFirstChild("ItemDB")if _T then

local _U,_V=pcall(require,_T)if _U and type(_V)=="table"then
 if type(rawget(_V,2))=="table"or type(_V[2])=="table"then
 ItemDB=_V else
 for _W,_X in ipairs({"items","Items","list","byId","data","db"})do

local _Y=rawget(_V,_X)if type(_Y)=="table"and(type(_Y[2])=="table"or type(_Y["2"])=="table")then
 ItemDB=_Y break
end
end
if next(ItemDB)==nil then
 ItemDB=_V
end
end
genv.__ANCH_ItemDBCache=ItemDB
end
end
end)return ItemDB end
loadItemDB()
local _Z,_ba=pcall(function()return Shared and require(Shared:FindFirstChild("Inventory"))
end)
local netOk,Net=pcall(function()return Shared and require(Shared:FindFirstChild("Net"))
end)
local _bd,_be=pcall(function()return Shared and require(Shared:FindFirstChild("Roles"))
end)
local _bf,_bg=pcall(function()return Shared and require(Shared:FindFirstChild("Sfx"))
end)
local _bh,_bi=pcall(function()return Shared and require(Shared:FindFirstChild("Splice"))
end)
local _bj=PlayerGui and(PlayerGui:FindFirstChild("GameGui")or PlayerGui:WaitForChild("GameGui",2))
local _bk,_bl=pcall(function()return _bj and require(_bj:FindFirstChild("Particles"))
end)
local _bm,_bn=pcall(function()return _bj and require(_bj:FindFirstChild("WorldMenu"))
end)
local configFile="ANCHHub_GrowBlox.json"
local rejoinFile="ANCHHub_Rejoin_"..tostring(LocalPlayer.UserId)..".json"
local pabrikFile="ANCHHub_Pabrik_"..tostring(LocalPlayer.UserId)..".json"
local autoMoveFile="ANCHHub_AutoMove_"..tostring(LocalPlayer.UserId)..".json"
local growboxLua="ANCHHub_GrowBlox.lua"
local maxItems=10000
local tileDelay=0.3
local cooldownTime=0.34
local config={prefix="/",dropId=242,longhandRange=3,blinkMin=0.2,blinkMax=0.5,winDrop=0,pos1={},pos2={},fastPull=false,fastKick=false,fastBan=false,fastDrop=false,fastDropCount=0,fastRecycle=false,fastRecycleCount=0,autoRestore=true,autoReload=true,autoWarp=false,launcher=true,lastWorld="",scriptUrl="",session={},reconnectOn=false,reconnectWorld=true,reconnectServer=true,reconnectKeep=false,reconnectDelay=5,targetWorld="",walkSpeed=100,mutePunch=true,visualAnim=true,liteMode=false,customWatermark=true,watermarkText="GSZ HUB",selectedRole="none",calibX=0,calibY=0,collectMode="Legit",collectAround=false,collectRadius=3,vendMode="Isi stock dari drop",vendPoint="",vendDropX=-1,vendDropY=-1,vendItems={},farmMode="Place + Break",farmPlaceMs=250,farmDelay=0.22,farmAfterBreakMs=300,farmMultiTarget=1,farmHitsOverride=0,farmBreakBg=true,farmPlaceId=2,farmGrid={["1,0"]=true},farmTake=true,farmAutoDropSeed=false,farmSeedDropAt=200,farmSeedKeep=0,farmDropWorld="",farmDropX=-1,farmDropY=-1,clearSweep="Zig-zag",clearIncludeBg=true,clearBreakDelay=0.16,clearTpDelay=0.22,clearTake=true,clearModFly=true,harvestDoHarvest=true,harvestDoPlant=false,harvestSeedId=3,harvestUseBlock=false,harvestScaffoldId=2,harvestDelay=0.22,harvestPlantDelay=0.25,harvestTpDelay=0.30,harvestTake=true,harvestModFly=false,dfBreakDelay=0.15,dfTpDelay=0.28,dfTake=true,dfModFly=true,dfReplacePlatform=true,spliceA=3,spliceB=5,spliceRoam=true,spliceMs=300,pabrikSeedId=3,pabrikMaxSeed=100,pabrikWholeWorld=true,pabrikTiles={["1,0"]=true},pabrikBreakX=-1,pabrikBreakY=-1,pabrikBreakSec=120,pabrikDrop=true,pabrikDropWorld="",pabrikDropX=-1,pabrikDropY=-1,trashOn=false,trashList={},trashAt=150,trashKeep=0,convertLockOn=false,moveMode="legit",moveMethod="Legit Walking",navSpeed=1,moveStepDelay=0.28,clickTpShift=false,guardWho="Staff (Mod/Dev)",guardStopAll=true,guardLeave=false,guardAutoBack=true,guardBackSec=60,guardCalmSec=5,chatText="",chatInterval=6,bonusAutoQuest=false,bonusAutoRedeem=false,scanAuto=false,scanLayer="Semua",scanFilter="",moveWorld1="",moveWorld2="",moveDropX=-1,moveDropY=-1,moveItemId=2,webhookOn=false,webhookUrl="",webhookReportMin=0,whPenjaga=true,whStop=true,whFull=true,whBonus=true,whRejoin=true,whPabrik=true,}
local function loadConfig()pcall(function()if isfile and readfile and isfile(configFile)then

local _by=HttpService:JSONDecode(readfile(configFile))for _bz,_bA in pairs(_by)do
 if config[_bz]~=nil and type(_bA)==type(config[_bz])then
 config[_bz]=_bA
end
end
end
end)
end
local isLoading=true
local function saveConfig()if isLoading then
 return end
pcall(function()if writefile then
 writefile(configFile,HttpService:JSONEncode(config))
end
end)end
loadConfig()
local getGC=getgc or(debug and debug.getgc)
local getUpvalue=(debug and debug.getupvalue)or getupvalue
local setUpvalue=(debug and debug.setupvalue)or setupvalue
local getConstants=(debug and debug.getconstants)or getconstants
local function getUpvalues(_bI)if debug and debug.getupvalues then

local _bJ,_bK=pcall(debug.getupvalues,_bI)if _bJ and type(_bK)=="table"then
 return _bK
end
end
local _bL={}if getUpvalue then
 for _bM=1,255 do

local _bN,_bO=pcall(getUpvalue,_bI,_bM)if not _bN then
 break end
_bL[_bM]=_bO
end
end
return _bL
end
local function trim(_bQ)return(tostring(_bQ or""):gsub("^%s+",""):gsub("%s+$",""))
end
local notifyFn=nil
local function notify(_bT,_bU,_bV,_bW)if isLoading and not _bW then
 return
end
if notifyFn then

local _bX=pcall(notifyFn,tostring(_bT),_bU,_bV)if _bX then
 return
end
end
pcall(function()StarterGui:SetCore("SendNotification",{Title=_bU or "ANCH HUB | GrowBlox",Text=tostring(_bT),Duration=_bV or 4,})
end)end
local GameRefs={World=nil,Inv=nil,InvTable=nil,SetTile=nil,Punch=nil,State=nil,Menu=nil,Gems=nil,Hud=nil,Trees=nil,Others=nil,Rigs=nil,Particles={},}
local DropRefs={list=nil,update=nil,brokeAt={},seen={},nextTick=0}
local ArmAnim={fn=nil,idx=nil,set=nil,Particles=nil}
local _cb={}
local tileCooldowns={}
local unknownCD={}
local invConn=nil
local invCallback=nil
local stats={T0=os.clock(),Gems0=nil,Placed=0,Broken=0,Collected=0,Harvested=0,Planted=0,Items={},}
local webhook={Queue={},LastFull={},Status="-",}do
(function()
local function _ci()return(syn and syn.request)or(http and http.request)or http_request or request or(fluxus and fluxus.request)
end
function webhook.Valid(_cj)_cj=tostring(_cj or"")for _ck,_cl in ipairs({"discord.com","discordapp.com","ptb.discord.com","canary.discord.com"})do
 if string.sub(_cj,1,#_cl+22)=="https://".._cl.."/api/webhooks/"then
 return true
end
end
return false
end
function webhook.Send(_cm,_cn)if not config.webhookOn or not webhook.Valid(config.webhookUrl)then
 return
end
local _co=_cm=="test"or _cm=="report"or(_cm=="penjaga"and config.whPenjaga)or(_cm=="stop"and config.whStop)or(_cm=="full"and config.whFull)or(_cm=="bonus"and config.whBonus)or(_cm=="rejoin"and config.whRejoin)or(_cm=="pabrik"and config.whPabrik)if not _co or#webhook.Queue>=20 then
 return end
table.insert(webhook.Queue,tostring(_cn))end
task.spawn(function()while isAlive()do

local _cp=table.remove(webhook.Queue,1)if not _cp then
 task.wait(0.5)else

local _cq=_ci()if not _cq then
 webhook.Status="Executor tidak mendukung request HTTP"else

local _cr=HttpService:JSONEncode({username="ANCH Hub | GrowBlox",content=string.format("**[%s]** %s",LocalPlayer.Name,_cp),})
local _cs,_ct=pcall(_cq,{Url=config.webhookUrl,Method="POST",Headers={["Content-Type"]="application/json"},Body=_cr,})
local _cu=_cs and type(_ct)=="table"and tonumber(_ct.StatusCode or _ct.Status)or nil if _cs and(_cu==nil or _cu<300)then
 webhook.Status="Terkirim "..os.date("%H:%M:%S")else
 webhook.Status="Gagal kirim ("..tostring(_cu or _ct)..")"
end
end
task.wait(2.5)
end
end
end)end)()
end
local keyState={active=false,left=false,right=false,jump=false,down=false}
local flyState={up=false,down=false}
local _cx=genv.__ANCH_TrueOrigIsDown
local applyKeys,clearKeys do
(function()
local _cA=clonerefFn(game:GetService("VirtualInputManager"))
local _cB={left=false,right=false,jump=false}
local function _cC(_cD,_cE,_cF)if _cB[_cD]==_cF then
 return end
_cB[_cD]=_cF pcall(function()if _cA and _cA.SendKeyEvent then
 _cA:SendKeyEvent(_cF,_cE,false,game)
end
end)end
applyKeys=function()if not keyState.active then
 _cC("left",Enum.KeyCode.A,false)_cC("right",Enum.KeyCode.D,false)_cC("jump",Enum.KeyCode.Space,false)return end
_cC("left",Enum.KeyCode.A,keyState.left==true)_cC("right",Enum.KeyCode.D,keyState.right==true)_cC("jump",Enum.KeyCode.Space,keyState.jump==true)end
clearKeys=function()keyState.left,keyState.right,keyState.jump,keyState.down=false,false,false,false _cC("left",Enum.KeyCode.A,false)_cC("right",Enum.KeyCode.D,false)_cC("jump",Enum.KeyCode.Space,false)
end
local function _cG(_cH,_cI,...)if isAlive()then
 if keyState.active then
 if _cI=="keyLeft"then
 return keyState.left
end
if _cI=="keyRight"then
 return keyState.right
end
if _cI=="keyJump"then
 return keyState.jump
end
if _cI=="keyDown"then
 return keyState.down
end
end
if flyState.up and _cI=="keyJump"then
 return true
end
if flyState.down and _cI=="keyDown"then
 return true
end
end
if _cx then
 return _cx(_cH,_cI,...)end
return false
end
local function _cJ()if _bm and type(_bn)=="table"and type(rawget(_bn,"isDown"))=="function"then

local _cK=rawget(_bn,"isDown")if not _cx and not(isexecutorclosure and pcall(isexecutorclosure,_cK)and isexecutorclosure(_cK))then
 _cx=_cK genv.__ANCH_TrueOrigIsDown=_cK end
rawset(_bn,"isDown",_cG)return
end
if getGC then
 task.spawn(function()for _cL,_cM in ipairs(getGC(true))do
 if type(_cM)=="table"then

local _cN=rawget(_cM,"isDown")if type(_cN)=="function"then
 if not _cx and not(isexecutorclosure and pcall(isexecutorclosure,_cN)and isexecutorclosure(_cN))then
 _cx=_cN genv.__ANCH_TrueOrigIsDown=_cN end
rawset(_cM,"isDown",_cG)
end
end
end
end)
end
end
_cJ()end)()end
do
(function()
local function _cO(_cP)if not getConstants or(islclosure and not islclosure(_cP))then
 return false
end
local _cQ,_cR=pcall(getConstants,_cP)if not _cQ or type(_cR)~="table"then
 return false
end
local _cS,_cT,_cU=false,false,false for _cV,_cW in pairs(_cR)do
 if _cW=="tile"or _cW=="SetTile"then
 _cS=true elseif _cW=="placedAt"then
 _cT=true elseif _cW=="flips"then
 _cU=true
end
end
return _cS and _cT and _cU
end
local function _cX(_cY)if not getConstants or(islclosure and not islclosure(_cY))then
 return false
end
local _cZ,_da=pcall(getConstants,_cY)if not _cZ or type(_da)~="table"then
 return false
end
local _db,_dc=false,false for _dd,_de in pairs(_da)do
 if _de=="Empty the Vending Machine first!"then
 _db=true elseif _de=="newCrack"or _de=="HarvestProvider"then
 _dc=true
end
end
return _db and _dc
end
local function isStateFn(_dg)
local _dh=rawget(_dg,"state")if type(_dh)~="function"then
 return false
end
local _di,_dj=pcall(_dh)return _di and type(_dj)=="table"and type(_dj.x)=="number"and type(_dj.y)=="number"and _dj.facing~=nil and _dj.vx~=nil
end
local function isNativeCode(_dl)if _dl==_cO or _dl==_cX then
 return false
end
if isexecutorclosure then

local _dm,_dn=pcall(isexecutorclosure,_dl)if _dm and _dn then
 return false
end
end
return true
end
local function isDropList(_dp)if type(_dp)~="table"or _dp==GameRefs.World then
 return false
end
local _dq=rawget(_dp,1)if _dq==nil then
 return next(_dp)==nil end
return type(_dq)=="table"and rawget(_dq,"uid")~=nil and rawget(_dq,"frame")~=nil
end
function ArmAnim.isArmFn(_dr)if not getConstants or(islclosure and not islclosure(_dr))then
 return false
end
local _ds,_dt=pcall(getConstants,_dr)if not _ds or type(_dt)~="table"then
 return false
end
local _du,_dv,_dw=false,false,false for _dx,_dy in pairs(_dt)do
 if _dy=="forearm"then
 _du=true elseif _dy=="heldReach"then
 _dv=true elseif _dy=="punchReach"then
 _dw=true
end
end
return _du and _dv and _dw
end
function ArmAnim.bind(_dz)if not(getUpvalue and setUpvalue)then
 return false
end
local _dA,_dB={},0 for _dC=1,16 do

local _dD,_dE=pcall(getUpvalue,_dz,_dC)if not _dD then
 break end
_dA[_dC]=_dE if _dE~=nil then
 _dB=_dC
end
end
for _dF=1,_dB-1 do

local _dG=_dA[_dF]if _dG==nil or(type(_dG)=="table"and rawget(_dG,"t")~=nil and rawget(_dG,"facing")~=nil)then
 ArmAnim.fn,ArmAnim.idx,ArmAnim.set=_dz,_dF,setUpvalue return true
end
end
return false
end
local function scanConnections()if not getconnections then
 return
end
local _dI,_dJ,_dK={},{},0 for _dL,_dM in ipairs({"RenderStepped","Heartbeat","Stepped"})do

local _dN,_dO=pcall(function()return RunService[_dM]
end)if _dN and _dO then

local _dP,_dQ=pcall(getconnections,_dO)if _dP and type(_dQ)=="table"then
 for _dR,_dS in ipairs(_dQ)do

local _dT,_dU=pcall(function()return _dS.Function
end)if _dT and type(_dU)=="function"then
 table.insert(_dI,_dU)
end
end
end
end
end
local _dV=1 while _dV<=#_dI and _dK<450 do

local _dW=_dI[_dV]_dV=_dV+1 if not _dJ[_dW]then
 _dJ[_dW]=true _dK=_dK+1 if not ArmAnim.fn and ArmAnim.isArmFn(_dW)then
 ArmAnim.bind(_dW)
end
for _dX,_dY in pairs(getUpvalues(_dW))do

local _dZ=type(_dY)if _dZ=="table"then
 if not GameRefs.World then

local _ea,_eb=pcall(function()return type(rawget(_dY,"fg"))=="table"and type(rawget(_dY,"bg"))=="table"and type(rawget(_dY,"w"))=="number"and rawget(_dY,"w")>0 and rawget(_dY,"spawn")~=nil
end)if _ea and _eb then
 GameRefs.World=_dY
end
end
if not GameRefs.Inv and _Z and _ba then

local _ec,_ed=pcall(function()return getmetatable(_dY)==_ba and type(rawget(_dY,"slots"))=="table"
end)if _ec and _ed then
 GameRefs.Inv=_dY
end
end
if not GameRefs.State then

local _ee,_ef=pcall(isStateFn,_dY)if _ee and _ef then
 GameRefs.State=rawget(_dY,"state")
end
end
elseif _dZ=="function"and not _dJ[_dY]then
 if not ArmAnim.fn and ArmAnim.isArmFn(_dY)then
 ArmAnim.bind(_dY)end
table.insert(_dI,_dY)
end
end
end
end
end
local function findTrees()
local _eh=GameRefs.World if not _eh then
 return false
end
for _ei,_ej in ipairs({"tileChanged","treeChanged","setTree"})do

local _ek=rawget(_eh,_ej)if type(_ek)=="function"then

local _el=getUpvalues(_ek)
local _em={}for _en,_eo in pairs(_el)do
 if type(_eo)=="table"and _eo~=_eh then
 _em[_eo]=true
end
end
for _ep,_eq in pairs(_el)do
 if type(_eq)=="function"then

local _er=getUpvalues(_eq)
local _es,_et,_eu=false,0,{}for _ev,_ew in pairs(_er)do
 if rawequal(_ew,_eh)then
 _es=true elseif type(_ew)=="table"then
 _et=_et+1 if _em[_ew]then
 table.insert(_eu,_ew)
end
end
end
if _es and _et<=3 and#_eu==1 then
 GameRefs.Trees=_eu[1]return true
end
end
end
end
end
return false
end
local lastScanTime=0 function GameRefs.Scan(_ey)
local _ez=os.clock()if not _ey and(_ez-lastScanTime)<2.5 and GameRefs.World then
 return true end
lastScanTime=_ez loadItemDB()GameRefs.World,GameRefs.Inv,GameRefs.InvTable,GameRefs.SetTile,GameRefs.Punch,GameRefs.State,GameRefs.Menu,GameRefs.Gems,GameRefs.Hud,GameRefs.Others=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil GameRefs.Particles={}scanConnections()if getGC then
 for gcIdx,gcItem in ipairs(getGC(true))do

local gcType=type(gcItem)if gcType=="table"then
 if next(ItemDB)==nil or type(ItemDB[2])~="table"then

local _eF,_eG=pcall(function()
local _eD=rawget(gcItem,2)
local _eE=rawget(gcItem,242)return type(_eD)=="table"and type(_eE)=="table"and(type(rawget(_eD,"name"))=="string"or type(rawget(_eD,"hits"))=="number")
end)if _eF and _eG then
 ItemDB=gcItem
end
end
if not GameRefs.World then

local _eH,_eI=pcall(function()return type(rawget(gcItem,"fg"))=="table"and type(rawget(gcItem,"bg"))=="table"and type(rawget(gcItem,"w"))=="number"and type(rawget(gcItem,"h"))=="number"and rawget(gcItem,"spawn")~=nil
end)if _eH and _eI then
 GameRefs.World=gcItem
end
end
if not GameRefs.InvTable then

local _eJ,_eK=pcall(function()return type(rawget(gcItem,"onDrop"))=="function"and type(rawget(gcItem,"canDrop"))=="function"and type(rawget(gcItem,"isWorn"))=="function"
end)if _eJ and _eK then
 GameRefs.InvTable=gcItem GameRefs.Hud=GameRefs.Hud or gcItem
end
end
if not GameRefs.Inv and _Z and _ba then

local _eL,_eM=pcall(function()return getmetatable(gcItem)==_ba and type(rawget(gcItem,"slots"))=="table"
end)if _eL and _eM then
 GameRefs.Inv=gcItem
end
end
if not GameRefs.State then

local _eN,_eO=pcall(isStateFn,gcItem)if _eN and _eO then
 GameRefs.State=rawget(gcItem,"state")
end
end
if not GameRefs.Menu then

local _eP,_eQ=pcall(function()return type(rawget(gcItem,"openBackpack"))=="function"and type(rawget(gcItem,"ui"))=="table"
end)if _eP and _eQ then
 GameRefs.Menu=gcItem
end
end
if not GameRefs.Gems then

local _eR,_eS=pcall(function()return type(rawget(gcItem,"addGems"))=="function"
end)if _eR and _eS then
 GameRefs.Gems=gcItem
end
end
if not GameRefs.Hud then

local _eT,_eU=pcall(function()return type(rawget(gcItem,"punchRange"))=="function"and type(rawget(gcItem,"buildRange"))=="function"
end)if _eT and _eU then
 GameRefs.Hud=gcItem
end
end
if not GameRefs.Others then

local _eV,_eW=pcall(function()return type(rawget(gcItem,"list"))=="function"and type(rawget(gcItem,"where"))=="function"and type(rawget(gcItem,"playerAt"))=="function"
end)if _eV and _eW then
 GameRefs.Others=gcItem
end
end
if not GameRefs.Rigs then

local _eZ,_fa=pcall(function()
local _eX,_eY=rawget(gcItem,1),rawget(gcItem,-1)return type(_eX)=="table"and type(_eY)=="table"and typeof(rawget(_eX,"body"))=="Instance"and typeof(rawget(_eY,"head"))=="Instance"
end)if _eZ and _fa then
 GameRefs.Rigs=gcItem
end
end
if _bk and _bl then

local _fb,_fc=pcall(function()return getmetatable(gcItem)==_bl and type(rawget(gcItem,"live"))=="table"
end)if _fb and _fc then
 table.insert(GameRefs.Particles,gcItem)
end
end
elseif gcType=="function"and isNativeCode(gcItem)then
 if not GameRefs.SetTile and _cO(gcItem)then
 GameRefs.SetTile=gcItem elseif not GameRefs.Punch and _cX(gcItem)then
 GameRefs.Punch=gcItem
end
end
end
end
if GameRefs.World and(not GameRefs.SetTile or not GameRefs.Punch)and debug and debug.info then
 for _fd,_fe in ipairs(getGC(true))do
 if type(_fe)=="function"then

local _ff,_fg=pcall(debug.info,_fe,"n")if _ff and(_fg=="setTile"or _fg=="hit")then
 for _fh,_fi in pairs(getUpvalues(_fe))do
 if _fi==GameRefs.World then
 if _fg=="setTile"and not GameRefs.SetTile then
 GameRefs.SetTile=_fe
end
if _fg=="hit"and not GameRefs.Punch then
 GameRefs.Punch=_fe
end
end
end
end
end
end
end
if not GameRefs.Inv and GameRefs.World and type(rawget(GameRefs.World,"backpackNow"))=="function"then
 for _fj,_fk in pairs(getUpvalues(GameRefs.World.backpackNow))do
 if type(_fk)=="table"and type(_fk.slots)=="table"then
 GameRefs.Inv=_fk break
end
end
end
if invConn then
 pcall(function()invConn:Disconnect()end);invConn=nil
end
if GameRefs.Inv and typeof(GameRefs.Inv.changed)=="Instance"then
 invConn=trackConn(GameRefs.Inv.changed.Event:Connect(function()if isAlive()and invCallback then
 pcall(invCallback)
end
end))
end
function DropRefs.findUpdate()
local _fl,_fm=GameRefs.World,DropRefs.list
local _fn=_fl and rawget(_fl,"dropTaken")if type(_fn)~="function"or not _fm then
 return false
end
for _fo,_fp in pairs(getUpvalues(_fn))do
 if type(_fp)=="function"then
 for _fq,_fr in pairs(getUpvalues(_fp))do
 if rawequal(_fr,_fm)then
 DropRefs.update=_fp return true
end
end
end
end
return false
end
function DropRefs.findRefs()
local _fs=GameRefs.World
local _ft=_fs and rawget(_fs,"dropList")if type(_ft)=="function"then

local _fu,_fv=pcall(_ft)if _fu and isDropList(_fv)then
 if DropRefs.list~=_fv then
 DropRefs.update=nil end
DropRefs.list=_fv if not DropRefs.update then
 DropRefs.findUpdate()end
return true
end
end
DropRefs.list,DropRefs.update=nil,nil
local _fw=_fs and rawget(_fs,"dropTaken")if type(_fw)=="function"then
 for _fx,_fy in pairs(getUpvalues(_fw))do
 if not DropRefs.list and isDropList(_fy)then
 DropRefs.list=_fy elseif not DropRefs.update and type(_fy)=="function"then
 DropRefs.update=_fy
end
end
if DropRefs.list and not DropRefs.update then
 DropRefs.findUpdate()
end
end
local _fz=WorldRemotes and WorldRemotes:FindFirstChild("DropTaken")if not DropRefs.list and _fz and getconnections then

local _fA,_fB=pcall(getconnections,_fz.OnClientEvent)if _fA and type(_fB)=="table"then
 for _fC,_fD in ipairs(_fB)do

local _fE,_fF=pcall(function()return _fD.Function
end)if _fE and type(_fF)=="function"then
 for _fG,_fH in pairs(getUpvalues(_fF))do
 if not DropRefs.list and isDropList(_fH)then
 DropRefs.list=_fH elseif not DropRefs.update and type(_fH)=="function"then
 DropRefs.update=_fH
end
end
end
if DropRefs.list then
 break
end
end
end
end
return DropRefs.list~=nil end
DropRefs.findRefs()GameRefs.Trees=nil if not GameRefs.Trees then
 findTrees()
end
if GameRefs.World and type(rawget(GameRefs.World,"treeLook"))=="function"and getUpvalue then

local _fI,_fJ=pcall(getUpvalue,GameRefs.World.treeLook,8)if _fI and type(_fJ)=="table"then
 GameRefs.Trees=_fJ
end
end
local _fK=WorldRemotes and WorldRemotes:FindFirstChild("TreeChanged")if not GameRefs.Trees and _fK and getconnections then

local _fL,_fM=pcall(getconnections,_fK.OnClientEvent)if _fL and type(_fM)=="table"then
 for _fN,_fO in ipairs(_fM)do

local _fP,_fQ=pcall(function()return _fO.Function
end)if _fP and type(_fQ)=="function"then
 for _fR,_fS in pairs(getUpvalues(_fQ))do
 if type(_fS)=="table"and _fS~=GameRefs.World and rawget(_fS,"fg")==nil then

local _fT,_fU=next(_fS)if _fU==nil or(type(_fU)=="table"and type(rawget(_fU,"p"))=="number")then
 GameRefs.Trees=_fS break
end
end
end
end
if GameRefs.Trees then
 break
end
end
end
end
return GameRefs.World~=nil
end
end)()
end
local function getWorld()if GameRefs.World and type(rawget(GameRefs.World,"fg"))=="table"then
 return GameRefs.World end
GameRefs.Scan()return GameRefs.World
end
local function getInvTable()if GameRefs.InvTable then
 return GameRefs.InvTable end
GameRefs.Scan()return GameRefs.InvTable
end
local function getRigs()if GameRefs.Rigs then
 return GameRefs.Rigs end
GameRefs.Scan()return GameRefs.Rigs
end
local function getItemData(_fZ)if not _fZ then
 return nil
end
if next(ItemDB)==nil then
 loadItemDB()
end
local _ga=tonumber(_fZ)
local _gb=(_ga and(rawget(ItemDB,_ga)or ItemDB[_ga]))or rawget(ItemDB,tostring(_fZ))or ItemDB[tostring(_fZ)]if type(_gb)=="table"then
 return _gb
end
if type(ItemDB.get)=="function"then

local _gc,_gd=pcall(ItemDB.get,_ga or _fZ)if _gc and type(_gd)=="table"then
 return _gd
end
end
return nil
end
local function getItemName(_gf)
local _gg=getItemData(_gf)if type(_gg)=="table"then

local _gh=rawget(_gg,"name")or _gg.name or rawget(_gg,"title")or rawget(_gg,"itemName")or rawget(_gg,1)if type(_gh)=="string"and _gh~=""then
 return _gh
end
end
return "Item #"..tostring(_gf)
end
local function countInv(_gj)if not _gj then
 return 0
end
if not GameRefs.Inv then
 GameRefs.Scan()
end
local _gk=GameRefs.Inv if not _gk then
 return 0
end
if type(_gk.count)=="function"then

local _gl,_gm=pcall(function()return _gk:count(_gj)
end)if _gl and type(_gm)=="number"then
 return _gm
end
end
local _gn=0 if type(_gk.slots)=="table"then
 for _go,_gp in pairs(_gk.slots)do
 if type(_gp)=="table"and _gp.id==_gj then
 _gn+=(_gp.n or 0)
end
end
end
return _gn
end
local function getSeedForBlock(_gr)
local _gs=_gr and ItemDB[_gr]if not _gs then
 return nil
end
local _gt=_gs.seedId or(_gr+1)
local _gu=ItemDB[_gt]return(_gu and _gu.kind=="seed")and _gt or nil
end
local function getBlockForSeed(_gw)if not _gw then
 return nil
end
local _gx=_gw-1
local _gy=ItemDB[_gx]if _gy and _gy.kind~="seed"and(_gy.seedId==nil or _gy.seedId==_gw)then
 return _gx end
return nil
end
local _gz=nil
local function getDirtId()if _gz then
 return _gz
end
if ItemDB[2]and type(ItemDB[2].name)=="string"and ItemDB[2].name:lower()=="dirt"then
 _gz=2 return 2
end
for _gB,_gC in pairs(ItemDB)do
 if type(_gB)=="number"and type(_gC)=="table"and type(_gC.name)=="string"and _gC.name:lower()=="dirt"then
 _gz=_gB return _gB
end
end
return 2
end
local _gD=nil
local function getDirtSeedId()if _gD then
 return _gD
end
local _gF=getSeedForBlock(getDirtId())if _gF then
 _gD=_gF return _gF end
return 3
end
local function getFallbackState()
local _gH=PlayerGui:FindFirstChild("GameGui")
local _gI=_gH and _gH:FindFirstChild("World")
local _gJ=_gI and _gI:FindFirstChild("Camera")
local _gK=_gJ and _gJ:FindFirstChild("Tiles")
local _gL=_gJ and _gJ:FindFirstChild("PlayerView")if not(_gK and _gL and _gK:IsA("GuiObject")and _gL:IsA("GuiObject"))then
 return nil
end
local _gM=_gK:FindFirstChildWhichIsA("ImageLabel")
local _gN=(_gM and _gM.AbsoluteSize.X>0)and _gM.AbsoluteSize.X or 64
local _gO=_gL.AbsolutePosition+(_gL.AbsoluteSize/2)
local _gP=_gO-_gK.AbsolutePosition return{x=_gP.X/_gN,y=(_gP.Y/_gN)+0.475,vx=0,vy=0,facing=1,grounded=true,dead=false,active=true,}
end
local function getPlayerState()if not GameRefs.State then
 GameRefs.Scan()
end
if GameRefs.State then

local _gR,_gS=pcall(GameRefs.State)if _gR and type(_gS)=="table"and type(_gS.x)=="number"and type(_gS.y)=="number"and _gS.active~=false then
 return _gS
end
end
return getFallbackState()
end
local function getPlayerPos()
local _gU=getPlayerState()if _gU then
 return _gU.x+config.calibX,_gU.y+config.calibY,(_gU.facing and _gU.facing<0)and-1 or 1 end
return nil,"Karakter belum berada di world"
end
function ArmAnim.Swing(_gV,_gW,_gX)if not config.visualAnim or not(ArmAnim.fn and ArmAnim.idx and ArmAnim.set)then
 return
end
local _gY=getPlayerState()
local _gZ=(_gY and _gV+0.5<_gY.x)and-1 or 1 pcall(ArmAnim.set,ArmAnim.fn,ArmAnim.idx,{t=os.clock(),x=_gV+0.5,y=_gW+0.5,facing=_gZ,kind=_gX})
end
function ArmAnim.Place(_ha,_hb,_hc)if not config.visualAnim then
 return end
ArmAnim.Swing(_ha,_hb,"build")
local _hd=ItemDB[_hc]if _hd and _hd.kind~="seed"and GameRefs.Particles and#GameRefs.Particles>0 then

local _he=ArmAnim.Particles or GameRefs.Particles[1]ArmAnim.Particles=_he pcall(function()_he:place(_ha+0.5,_hb+0.5)
end)end
end
local function getPlayerTile()
local _hg,_hh=getPlayerPos()if not _hg then
 return nil end
return math.floor(_hg),math.floor(_hh-0.475)
end
local function getWorldName()
local _hj=getWorld()
local _hk=_hj and rawget(_hj,"name")return type(_hk)=="string"and _hk or""
end
local function getTileAt(_hm,_hn,_ho,_hp)
local _hq=_hm or getWorld()if not _hq or _ho<0 or _hp<0 or _ho>=_hq.w or _hp>=_hq.h then
 return nil
end
local _hr=rawget(_hq,_hn)
local _hs=_hr and _hr[_hp]return _hs and(_hs[_ho]or 0)or nil
end
local function inBounds(_hu,_hv,_hw)
local _hx=_hu or getWorld()return _hx and type(_hx.w)=="number"and _hv>=0 and _hw>=0 and _hv<_hx.w and _hw<_hx.h
end
local function getItemLayer(_hz)
local _hA=ItemDB and ItemDB[_hz]return(type(_hA)=="table"and _hA.background)and "bg"or "fg"
end
local function getPunchRange()
local _hC=GameRefs.Hud or getInvTable()if _hC and type(_hC.punchRange)=="function"then

local _hD,_hE=pcall(_hC.punchRange)if _hD and type(_hE)=="number"and _hE>0 then
 return _hE
end
end
return 2.5
end
local function getBuildRange()
local _hG=GameRefs.Hud or getInvTable()if _hG and type(_hG.buildRange)=="function"then

local _hH,_hI=pcall(_hG.buildRange)if _hH and type(_hI)=="number"and _hI>0 then
 return _hI
end
end
return 2.5
end
local function sendSetTile(_hK,_hL,_hM,_hN,_hO)if _hN~=0 and ArmAnim.Place then
 ArmAnim.Place(_hL,_hM,_hN)
end
if not GameRefs.SetTile then
 GameRefs.Scan()
end
if GameRefs.SetTile then

local _hP=pcall(GameRefs.SetTile,_hK,_hL,_hM,_hN,false,_hO==true)if _hP then
 tileCooldowns[_hL..",".._hM]=os.clock()return true
end
end
if netOk and type(Net)=="table"and type(Net.tile)=="table"then

local _hQ=pcall(Net.tile.send,{layer=(_hK=="bg")and 2 or 1,x=_hL,y=_hM,id=_hN,flip=_hO==true,})if _hQ then

local _hR=getWorld()if _hR and _hR[_hK]and _hR[_hK][_hM]then
 _hR[_hK][_hM][_hL]=_hN end
tileCooldowns[_hL..",".._hM]=os.clock()return true end
elseif SetTileRemote then
 pcall(function()SetTileRemote:FireServer(_hK,_hL,_hM,_hN,_hO==true)
end)
local _hS=getWorld()if _hS and _hS[_hK]and _hS[_hK][_hM]then
 _hS[_hK][_hM][_hL]=_hN end
tileCooldowns[_hL..",".._hM]=os.clock()return true end
return false
end
local function placeTile(_hU,_hV,_hW)if not _hU or _hU<=0 then
 return false
end
if countInv(_hU)<=0 then
 return false
end
local _hX=getItemLayer(_hU)
local _hY=sendSetTile(_hX,_hV.x,_hV.y,_hU,(_hW or 1)<0)if not _hY then
 return false
end
if GameRefs.Inv and type(GameRefs.Inv.remove)=="function"then
 pcall(function()GameRefs.Inv:remove(_hU,1)
end)end
stats.Placed+=1 return true
end
local function waitCooldown(_ia,_ib)
local _ic=_ia..",".._ib
local _id=tileCooldowns[_ic]if _id then

local _ie=os.clock()-_id if _ie<cooldownTime then
 task.wait(cooldownTime-_ie)end
tileCooldowns[_ic]=nil
end
end
local unbreakableIds={[6]=true,[8]=true,[202]=true,[204]=true,[206]=true,[242]=true,[1796]=true,[4994]=true,[5814]=true,[7188]=true,}
local function isBreakable(_ih,_ii,_ij)if not _ih or _ih==0 or unbreakableIds[_ih]then
 return false
end
local _ik=getWorld()if _ik and _ii and _ij then
 if typeof(_ik.spawn)=="Vector2"and _ii==math.floor(_ik.spawn.X)and _ij==math.floor(_ik.spawn.Y)then
 return false
end
if type(_ik.lock)=="table"and _ik.lock.x==_ii and _ik.lock.y==_ij then
 return false
end
end
local _il=getItemData(_ih)if not _il then
 if _ik and _ij and _ij>=_ik.h-6 then
 return false end
return true
end
if _il.lock or _il.area or _il.guildLock or _il.vend or _il.display or _il.bedrock or _il.unbreakable or _il.door or _il.entrance then
 return false
end
local _im=tostring(rawget(_il,"name")or _il.name or""):lower()if _im:find("bedrock",1,true)or _im:find("lock",1,true)or _im:find("main door",1,true)or _im:find("white door",1,true)or _im:find("vending",1,true)then
 return false
end
local _in=(_il.kind=="seed")and 20 or _il.hits if type(_in)=="number"then
 return _in>0
end
if _il.staffHits then
 return false end
return true
end
local function punchTile(_ip,_iq,_ir)if _ir==nil then
 _ir=true
end
local _is=getWorld()if not _is then
 return nil
end
local _it=getTileAt(_is,"fg",_ip,_iq)if _it==nil then
 return nil
end
local _iu=getTileAt(_is,"bg",_ip,_iq)
local _iv,_iw if _it~=0 then
 _iv,_iw="fg",_it elseif _ir and _iu and _iu~=0 then
 _iv,_iw="bg",_iu
end
if not _iv or not isBreakable(_iw,_ip,_iq)then
 return nil end
waitCooldown(_ip,_iq)if not GameRefs.Punch then
 GameRefs.Scan()
end
if GameRefs.Punch then

local _ix=pcall(GameRefs.Punch,_ip,_iq,config.mutePunch or nil,nil)if not _ix then
 return nil end
ArmAnim.Swing(_ip,_iq,"punch")if getTileAt(_is,_iv,_ip,_iq)~=_iw then
 stats.Broken+=1 DropRefs.brokeAt[_ip..",".._iq]=os.clock()return "broke",_iw,_iv end
return "hit",_iw,_iv end
return nil
end
local _iy=false
local _iz={}
local _iA=nil
local function isFlying()if _iy then
 return true
end
for _iC,_iD in pairs(_iz)do
 if _iD then
 return true
end
end
return false
end
local function _iE()
local _iF=getWorld()if not _iF then
 return
end
if isFlying()then
 _iF.ghost=true else
 flyState.up,flyState.down=false,false _iF.ghost=(LocalPlayer:GetAttribute("Ghost")==true)
end
if _iA then
 _iA.Enabled=_iy
end
end
local function setFlyModule(_iH,_iI)_iz[_iH]=_iI and true or nil _iE()
end
local function enableFly()_iy=true _iE()return true
end
local function disableFly()_iy=false _iE()return true end
trackConn(RunService.Heartbeat:Connect(function()if not isAlive()then
 return
end
local _iL=GameRefs.World if not _iL then
 return
end
if DropRefs.collecting then
 _iL.speedScale=1 elseif config.walkSpeed~=100 then
 _iL.speedScale=config.walkSpeed/100
end
if isFlying()and _iL.ghost~=true then
 _iL.ghost=true
end
end))
local ClickTP={clickOn=false,token=0,conn=nil,last="-",BadEdge={},PlacedScaffolds=0,}do
(function()
local _iN,_iO=math.floor,math.abs
local function tileGetLocal(_iQ,_iR)
local _iS=getWorld()
local _iT=_iS and _iS.fg and _iS.fg[_iR]return(_iT and _iT[_iQ])or 0
end
local function _iU(_iV,_iW)
local _iX=tileGetLocal(_iV,_iW)if _iX~=0 then
 return ItemDB[_iX]end
return nil
end
local function _iY(_iZ,_ja)
local _jb=getWorld()if not _jb then
 return true
end
if _iZ<0 or _iZ>=_jb.w or _ja>=_jb.h then
 return true
end
if _ja<0 then
 return false
end
local _jc=_iU(_iZ,_ja)if not _jc then
 return false
end
if _jc.combiner then

local _jd,_je=pcall(_jb.combinerShut,_iZ,_ja)return(not _jd)or(_je and true or false)
end
if _jc.vip then

local _jf,_jg=pcall(_jb.vipMay,_iZ,_ja)return not(_jf and _jg)
end
if _jc.entrance then

local _jh=_jb.switches and _jb.switches[_ja*_jb.w+_iZ]if _jc.gate then
 return not(_jh and _jh.off==true)
end
if _jh and _jh.public then
 return false
end
local _ji,_jj=pcall(function()return _jb.areas.mayBuild(_jb.lock,_iZ,_ja)end)return not(_ji and _jj)end
return _jc.solid and true or false
end
local function _jk(_jl,_jm)
local _jn=_iU(_jl,_jm)return _jn~=nil and(_jn.deadly or _jn.hurts or _jn.laser)and true or false
end
local function _jo(_jp,_jq)
local _jr=_iU(_jp,_jq)return _jr~=nil and _jr.platform and true or false
end
local function _js(_jt,_ju)return not _iY(_jt,_ju)and not _jk(_jt,_ju)
end
local function _jv(_jw,_jx)return not _jk(_jw,_jx+1)and(_iY(_jw,_jx+1)or _jo(_jw,_jx+1))
end
local function _jy(_jz,_jA,_jB,_jC)return _iO(_jA+0.5-_jz.x)<=_jC and _iO(_jB+0.5-(_jz.y-0.475))<=_jC
end
local function _jD(_jE,_jF)
local _jG=getWorld()if not _jG or _jE<0 or _jF<0 or _jE>=_jG.w or _jF>=_jG.h then
 return false
end
if tileGetLocal(_jE,_jF)~=0 then
 return false
end
local _jH,_jI=pcall(function()if _jG.areas and type(_jG.areas.canEdit)=="function"and not _jG.areas.canEdit(_jE,_jF)then
 return false
end
if type(_jG.builderOk)=="function"and not _jG.builderOk(_jE,_jF,true)then
 return false end
return true end)return(not _jH)or _jI
end
local function _jJ()
local _jK={config.harvestScaffoldId,getDirtId(),config.farmPlaceId,}for _jL,_jM in ipairs(_jK)do
 if type(_jM)=="number"and _jM>0 and countInv(_jM)>0 then

local _jN=ItemDB[_jM]if _jN and _jN.solid and _jN.kind~="seed"then
 return _jM
end
end
end
if GameRefs.Inv and type(GameRefs.Inv.slots)=="table"then
 for _jO,_jP in ipairs(GameRefs.Inv.slots)do

local _jQ=_jP.id and ItemDB[_jP.id]if _jQ and _jQ.solid and _jQ.kind~="seed"and not _jQ.lock and(_jP.n or 0)>0 then
 return _jP.id
end
end
end
return getDirtId()
end
local function _jR(_jS,_jT)
local _jU=_jJ()if not _jU or countInv(_jU)<=0 or not _jD(_jS,_jT)then
 return false
end
local _jV=getPlayerState()if _jV and not _jy(_jV,_jS,_jT,getBuildRange()+0.5)then
 return false
end
if placeTile(_jU,{x=_jS,y=_jT},1)then
 ClickTP.PlacedScaffolds+=1 return true end
return false end
ClickTP.SolidAt=_iY ClickTP.OpenAt=_js ClickTP.RealSupport=_jv ClickTP.PlaceScaffold=_jR ClickTP.StateReaches=_jy ClickTP.PlaceOk=_jD function ClickTP.Los(_jW,_jX,_jY,_jZ)if _jZ-_jX>=2 then
 for _ka=_jX+1,_jZ-1 do
 if _iY(_jY,_ka)then
 return false
end
end
elseif _jX-_jZ>=2 then
 for _kb=_jZ+1,_jX-1 do
 if _iY(_jY,_kb)then
 return false
end
end
end
return true
end
function ClickTP.AirCheck(_kc)if not _kc or _kc.grounded then
 ClickTP.AirAt=nil return
end
if not ClickTP.AirAt then
 ClickTP.AirAt=os.clock()elseif os.clock()-ClickTP.AirAt>3 then
 ClickTP.AirAt=nil
local _kd=(_kc.facing or 1)<0 keyState.active=true keyState.right,keyState.left=_kd,not _kd task.wait(0.2)keyState.right,keyState.left=false,false
end
end
local function _ke(_kf,_kg,_kh,_ki,_kj)_kh+=1
local _kk=_kh while _kk>1 do

local _kl=_kk//2 if _kf[_kl]<=_ki then
 break end
_kf[_kk],_kg[_kk]=_kf[_kl],_kg[_kl]_kk=_kl end
_kf[_kk],_kg[_kk]=_ki,_kj return _kh
end
local function _km(_kn,_ko,_kp)
local _kq=_ko[1]
local _kr,_ks=_kn[_kp],_ko[_kp]_kn[_kp],_ko[_kp]=nil,nil _kp-=1 if _kp>0 then

local _kt=1 while true do

local _ku=_kt*2 if _ku>_kp then
 break
end
if _ku<_kp and _kn[_ku+1]<_kn[_ku]then
 _ku+=1
end
if _kr<=_kn[_ku]then
 break end
_kn[_kt],_ko[_kt]=_kn[_ku],_ko[_ku]_kt=_ku end
_kn[_kt],_ko[_kt]=_kr,_ks end
return _kq,_kp
end
function ClickTP.AStar(_kv,_kw,_kx,_ky,_kz,_kA,_kB,_kC)
local _kD=getWorld()if not _kD then
 return nil,false,{}
end
local _kE,_kF=_kD.w,_kD.h
local _kG=_kE*_kF _kA=_kA or 0.4
local _kH=_iN(_kA)
local _kI=math.ceil(-_kA+0.025)
local _kJ=_iN(_kA+0.025)
local _kK,_kL,_kM={},{},{}
local function _kN(_kO,_kP)if _kO<0 or _kO>=_kE or _kP>=_kF then
 return false
end
if _kP<0 then
 return true
end
local _kQ=_kP*_kE+_kO
local _kR=_kK[_kQ]if _kR==nil then
 _kR=_js(_kO,_kP);_kK[_kQ]=_kR end
return _kR
end
local function _kS(_kT,_kU)if _kT<0 or _kT>=_kE or _kU<0 or _kU>=_kF then
 return false
end
local _kV=_kU*_kE+_kT
local _kW=_kL[_kV]if _kW==nil then
 _kW=_jv(_kT,_kU);_kL[_kV]=_kW end
return _kW
end
local function _kX(_kY,_kZ)if not _kB or _kY<0 or _kY>=_kE or _kZ<0 or _kZ>=_kF then
 return false
end
local _la=_kZ*_kE+_kY
local _lb=_kM[_la]if _lb==nil then
 _lb=_jD(_kY,_kZ);_kM[_la]=_lb end
return _lb
end
local function heuristic(_ld,_le)
local _lf=_iO(_ky-_ld)-_kA
local _lg=_kz-_le
local _lh=_iO(_lg)-_kA
local _li=(_lg<0)and 1.5 or 0.5 return(_lf>0 and _lf or 0)+_li*(_lh>0 and _lh or 0)
end
local function _lj(_lk,_ll)if _kx[_ll*_kE+_lk]then
 return true
end
if _kA>=1 then
 for _lm=_ll+_kI,_ll+_kJ do
 if _lm>=0 and _lm<_kF then

local _ln=_lm*_kE for _lo=_lk-_kH,_lk+_kH do
 if _lo>=0 and _lo<_kE and _kx[_ln+_lo]and not(_lo==_lk and _lm==_ll+1)then
 return true
end
end
end
end
end
return false
end
local _lp,_lq,_lr,_ls,_lt={},{},{},{},{}
local _lu=0
local function _lv(_lw,_lx,_ly,_lz,_lA)_lu+=1 _lp[_lu],_lq[_lu],_lr[_lu],_ls[_lu],_lt[_lu]=_lw,_lx,_ly,_lz,_lA
end
local function _lB(_lC,openNodeKey)_lu=0 for _lE=-1,1,2 do

local _lF=_lC+_lE if _kN(_lF,openNodeKey)then
 if _kS(_lF,openNodeKey)then
 _lv(_lF,openNodeKey,"walk",1,false)else if _kX(_lF,openNodeKey+1)then
 _lv(_lF,openNodeKey,"walk",3,true)
end
local _lG=openNodeKey+1 while _lG<_kF and _lG-openNodeKey<=40 and _kN(_lF,_lG)and not _kS(_lF,_lG)do
 _lG+=1
end
if _lG<_kF and _kN(_lF,_lG)and _kS(_lF,_lG)then
 _lv(_lF,_lG,"fall",1+0.5*(_lG-openNodeKey),false)
end
if _kN(_lC,openNodeKey-1)and _kN(_lC,openNodeKey-2)then
 for _lH=2,3 do

local _lI=_lC+(_lH-1)*_lE if not(_kN(_lI,openNodeKey)and _kN(_lI,openNodeKey-1)and _kN(_lI,openNodeKey-2))then
 break
end
if _lH==3 and _kS(_lI,openNodeKey)then
 break
end
local _lJ=_lC+_lH*_lE if _kN(_lJ,openNodeKey-1)and _kN(_lJ,openNodeKey-2)then
 for _lK=0,2 do
 if not _kN(_lJ,openNodeKey+_lK)then
 break
end
if _kS(_lJ,openNodeKey+_lK)then
 _lv(_lJ,openNodeKey+_lK,"gap",_lH+0.5+0.5*_lK,false)break
end
end
end
end
end
end
end
for _lL=1,3 do
 if not _kN(_lC,openNodeKey-_lL)then
 break
end
if _kN(_lC,openNodeKey-_lL-1)and _kN(_lF,openNodeKey-_lL)and _kS(_lF,openNodeKey-_lL)and _kN(_lF,openNodeKey-_lL-1)then
 _lv(_lF,openNodeKey-_lL,"jump",1+1.5*_lL,false)
end
end
for _lM=1,2 do
 if _kN(_lC,openNodeKey-1)and(_lM==1 or _kN(_lC,openNodeKey-2))and _kN(_lF,openNodeKey-_lM)and _kS(_lF,openNodeKey-_lM)and not(_kN(_lC,openNodeKey-_lM-1)and _kN(_lF,openNodeKey-_lM-1))then
 _lv(_lF,openNodeKey-_lM,"stair",3+1.5*_lM,false)
end
end
end
if _kB and _kN(_lC,openNodeKey-1)and _kN(_lC,openNodeKey-2)and _kN(_lC,openNodeKey-3)and _kX(_lC,openNodeKey)then
 _lv(_lC,openNodeKey-1,"pillar",4,true)end
return _lu
end
local _lN=_kw*_kE+_kv
local _lO,_lP,_lQ,_lR,_lS={[_lN]=0},{},{},{},{}
local _lT,_lU,_lV={},{},0 _lV=_ke(_lT,_lU,_lV,heuristic(_kv,_kw),_lN)
local _lW=0
local _lX=os.clock()while _lV>0 do
 local _lY _lY,_lV=_km(_lT,_lU,_lV)if not _lS[_lY]then
 _lS[_lY]=true
local _lZ,_ma=_lY%_kE,_lY//_kE if _lj(_lZ,_ma)then

local _mb={}
local _mc=_lY while _mc~=_lN do

local _md=_lP[_mc]table.insert(_mb,1,{fx=_md%_kE,fy=_md//_kE,x=_mc%_kE,y=_mc//_kE,kind=_lQ[_mc],build=_lR[_mc],key=_md*_kG+_mc,})_mc=_md end
return _mb,false,_lS end
_lW+=1 if _lW>6500 then
 return nil,false,_lS
end
if _lW%400==0 then
 task.wait()if _kC and _kC()then
 return nil,false,_lS
end
end
local _me=_lO[_lY]
local _mf=_lB(_lZ,_ma)for _mg=1,_mf do

local _mh=_lq[_mg]*_kE+_lp[_mg]if not _lS[_mh]then

local _mi=ClickTP.BadEdge[_lY*_kG+_mh]if not(_mi and _mi>_lX)then

local _mj=_me+_ls[_mg]
local _mk=_lO[_mh]if _mk==nil or _mj<_mk then
 _lO[_mh],_lP[_mh],_lQ[_mh],_lR[_mh]=_mj,_lY,_lr[_mg],_lt[_mg]_lV=_ke(_lT,_lU,_lV,_mj+heuristic(_lp[_mg],_lq[_mg]),_mh)
end
end
end
end
end
end
return nil,true,_lS
end
local function _ml(_mm,_mn,_mo)
local _mp=_mn-_mm.x
local _mq=_mm.vx or 0
local _mr=_mm.grounded and 48 or 17
local _ms=0 if _iO(_mp)>_mo then
 _ms=_mp>0 and 1 or-1 if _mq*_ms>0 and(_mq*_mq)/(2*_mr)>=_iO(_mp)-_mo*0.5 then
 _ms=0
end
end
keyState.left=_ms<0 keyState.right=_ms>0
end
local function walkToX(_mu,_mv,_mw)
local _mx=getWorld()if not _cx or not getPlayerState()then
 if _mx and _mx.goTo then
 pcall(_mx.goTo,_mu,_mv)task.wait(math.max(0.25,config.moveStepDelay))return true end
return false end
keyState.active=true
local _my=_mu+0.5
local _mz=getPlayerState()if not _mz then
 clearKeys();return false
end
local _mA=1.6+_iO(_my-_mz.x)*0.38
local _mB=os.clock()while os.clock()-_mB<=_mA and isAlive()do
 if _mw and _mw()then
 clearKeys();return false
end
local _mC=getPlayerState()if not _mC or _mC.dead then
 clearKeys();return false
end
local _mD,_mE=_iN(_mC.x),_iN(_mC.y-0.475)if _mC.grounded and _mE~=_mv then
 clearKeys();return false end
_ml(_mC,_my,0.1)if _mD==_mu and _iO(_mC.x-_my)<=0.22 and _mC.grounded and _iO(_mC.vx or 0)<2.2 then
 clearKeys()return true end
task.wait()end
clearKeys()return false
end
local function executeStep(_mG,_mH)keyState.active=true
local _mI=_mG.x+0.5
local _mJ=1.6+0.3*(_mG.y-_mG.fy)
local _mK=os.clock()while os.clock()-_mK<=_mJ and isAlive()do
 if _mH and _mH()then
 clearKeys();return false
end
local _mL=getPlayerState()if not _mL or _mL.dead then
 clearKeys();return false end
_ml(_mL,_mI,0.1)if _mL.grounded then

local _mM,_mN=_iN(_mL.x),_iN(_mL.y-0.475)if _mN==_mG.y then
 if _mM==_mG.x and _iO(_mL.x-_mI)<=0.25 then
 clearKeys()return true end
elseif _mN~=_mG.fy then
 clearKeys()return false
end
end
task.wait()end
clearKeys()return false
end
local function executePillar(_mP,_mQ)if not walkToX(_mP.fx,_mP.fy,_mQ)then
 return false end
keyState.active=true
local _mR=_mP.fy-_mP.y
local _mS=_mP.y+1
local _mT=_mS-((_mR==1)and 0 or 0.4)
local _mU=_mP.x+0.5 clearKeys()task.wait()keyState.jump=true
local _mV=os.clock()
local _mW=false while os.clock()-_mV<=1.8 and isAlive()do
 if _mQ and _mQ()then
 clearKeys();return false
end
local _mX=getPlayerState()if not _mX or _mX.dead then
 clearKeys();return false
end
if not _mX.grounded then
 _mW=true
end
if keyState.jump and(_mX.y<=_mT or(_mW and(_mX.vy or 0)>=0))then
 keyState.jump=false
end
if _mX.y<=_mS+0.25 then
 _ml(_mX,_mU,0.1)else
 _ml(_mX,_mP.fx+0.5,0.15)
end
if _mW and _mX.grounded then

local _mY,_mZ=_iN(_mX.x),_iN(_mX.y-0.475)clearKeys()return(_mZ==_mP.y and _mY==_mP.x and _iO(_mX.x-_mU)<=0.26)
end
if not _mW and os.clock()-_mV>0.38 then
 break end
task.wait()end
clearKeys()return false
end
local function _na(_nb,_nc)if not walkToX(_nb.fx,_nb.fy,_nc)then
 return false end
keyState.active=true
local _nd=getPlayerState()if not _nd then
 clearKeys();return false
end
local _ne=(_nb.x>_nb.fx)and 1 or-1
local _nf=_nb.fx+0.5+_ne*0.6
local _ng=_nd.y
local _nh=_nb.x+0.5 clearKeys()
local _ni=os.clock()
local _nj,_nk,_nl=false,false,0 while os.clock()-_ni<=2.2 and isAlive()do
 if _nc and _nc()then
 clearKeys();return false
end
local _nm=getPlayerState()if not _nm or _nm.dead then
 clearKeys();return false
end
if not _nj then
 keyState.left,keyState.right=_ne<0,_ne>0 if(_nm.x-_nf)*_ne>=0 or not _nm.grounded then
 _nj,_nl=true,os.clock()keyState.jump=_nm.grounded end
else if not _nm.grounded then
 _nk=true
end
if keyState.jump and(_nm.y<=_ng-1 or(_nk and(_nm.vy or 0)>=0))then
 keyState.jump=false end
_ml(_nm,_nh,0.1)if _nk and _nm.grounded then

local _nn,_no=_iN(_nm.x),_iN(_nm.y-0.475)clearKeys()return(_no==_nb.y and _nn==_nb.x and _iO(_nm.x-_nh)<=0.26)
end
if not _nk and os.clock()-_nl>0.38 then
 break
end
end
task.wait()end
clearKeys()return false
end
local function _np(_nq,_nr)if not walkToX(_nq.fx,_nq.fy,_nr)then
 return false end
keyState.active=true
local _ns=(_nq.x>_nq.fx)and 1 or-1
local _nt=_nq.y+1
local _nu=_nq.fx+0.5+_ns*0.17 for _nv=1,3 do

local _nw=os.clock()while os.clock()-_nw<=0.8 and isAlive()do
 if _nr and _nr()then
 clearKeys();return false
end
local _nx=getPlayerState()if not _nx or _nx.dead then
 clearKeys();return false end
_ml(_nx,_nu,0.03)if _iO(_nx.x-_nu)<=0.06 and _iO(_nx.vx or 0)<1 then
 break end
task.wait()end
clearKeys()task.wait()
local _ny=getPlayerState()if not _ny then
 return false
end
local _nz=_ny.y keyState.jump=true _nw=os.clock()
local _nA,_nB=false,nil while os.clock()-_nw<=1.8 and isAlive()do
 if _nr and _nr()then
 clearKeys();return false
end
local _nC=getPlayerState()if not _nC or _nC.dead then
 clearKeys();return false
end
if not _nC.grounded then
 _nA=true
end
if keyState.jump and(_nC.y<=_nt-0.1 or(_nA and(_nC.vy or 0)>=0))then
 keyState.jump=false
end
local _nD=(_nv==1 and _nC.y<=_nt+0.02)or(_nv==2 and _nC.y<=_nz-0.15)or(_nv==3 and _nC.y<=_nt+0.25)if _nA and _nD then
 keyState.right,keyState.left=_ns>0,_ns<0 else
 _ml(_nC,_nu,0.03)
end
if _nA and _nC.grounded then
 _nB=_iN(_nC.y-0.475)break
end
if not _nA and os.clock()-_nw>0.35 then
 break end
task.wait()end
clearKeys()if _nB==_nq.y then
 return walkToX(_nq.x,_nq.y,_nr)
end
if _nB~=nil and _nB~=_nq.fy then
 return false
end
if not walkToX(_nq.fx,_nq.fy,_nr)then
 return false
end
end
return false
end
local function _nE(_nF,_nG)if not walkToX(_nF.fx,_nF.fy,_nG)then
 return false
end
if tileGetLocal(_nF.fx,_nF.fy)~=0 then
 return false end
keyState.active=true clearKeys()task.wait()keyState.jump=true
local _nH=os.clock()
local _nI,_nJ=false,false while os.clock()-_nH<=1.8 and isAlive()do
 if _nG and _nG()then
 clearKeys();return false
end
local _nK=getPlayerState()if not _nK or _nK.dead then
 clearKeys();return false
end
if not _nK.grounded then
 _nJ=true end
_ml(_nK,_nF.fx+0.5,0.12)if keyState.jump and(_nK.y<_nF.fy-0.9 or(_nJ and(_nK.vy or 0)>=0))then
 keyState.jump=false
end
if not _nI and _nJ and _nK.y<_nF.fy-0.25 and((_nK.vy or 0)>-6 or _nK.y<_nF.fy-0.8)then
 _nI=_jR(_nF.fx,_nF.fy)if not _nI then
 clearKeys();return false
end
end
if _nK.grounded and _nJ then
 clearKeys()
local _nL,_nM=_iN(_nK.x),_iN(_nK.y-0.475)return _nI and _nL==_nF.x and _nM==_nF.y
end
if not _nJ and os.clock()-_nH>0.38 then
 break end
task.wait()end
clearKeys()return false end
ClickTP.ExecWalk=walkToX ClickTP.ExecPillar=_nE function ClickTP.FollowPath(_nN,_nO)
local _nP={}for _nQ,_nR in pairs(_iz)do
 _nP[_nQ]=_nR end
table.clear(_iz)
local _nS=_iy _iy=false _iE()keyState.active=true
local _nT={}
local function _nU()if#_nT==0 then
 return
end
for _nV=#_nT,1,-1 do

local _nW=_nT[_nV]
local _nX,_nY=getPlayerTile()if not(_nX==_nW.x and _nY==_nW.y-1)then

local _nZ=getPlayerState()if _nZ and _jy(_nZ,_nW.x,_nW.y,getPunchRange()-0.1)and tileGetLocal(_nW.x,_nW.y)~=0 and isBreakable(tileGetLocal(_nW.x,_nW.y))then
 waitCooldown(_nW.x,_nW.y)
local _oa=os.clock()while tileGetLocal(_nW.x,_nW.y)~=0 and os.clock()-_oa<3.0 and isAlive()do
 if _nO and _nO()then
 break end
punchTile(_nW.x,_nW.y,false)task.wait(0.15)
end
end
if tileGetLocal(_nW.x,_nW.y)==0 then
 table.remove(_nT,_nV)
end
end
end
end
local function _ob(_oc)_nU()clearKeys()keyState.active=false _iy=_nS for _od,_oe in pairs(_nP)do
 _iz[_od]=_oe end
_iE()return _oc
end
local _of=1 while _of<=#_nN and isAlive()do
 if _nO and _nO()then
 return _ob(false)
end
local _og=_nN[_of]
local _oh,_oi=_of,false if _og.kind=="walk"then

local _oj=_og.x-_og.fx while _nN[_oh+1]and _nN[_oh+1].kind=="walk"and(_nN[_oh+1].x-_nN[_oh+1].fx)==_oj do
 _oh+=1
end
local _ok=false for _ol=_of,_oh do
 if _nN[_ol].build then
 _ok=true;break
end
end
if _ok then
 _oi=true for _om=_of,_oh do
 if _nO and _nO()then
 return _ob(false)
end
local _on=_nN[_om]if _on.build and not _jv(_on.x,_on.y)then
 if not _jR(_on.x,_on.y+1)then
 _oi=false;break end
table.insert(_nT,{x=_on.x,y=_on.y+1})task.wait(0.14)
end
if not walkToX(_on.x,_on.y,_nO)then
 _oi=false;break end
_nU()end
else
 _oi=walkToX(_nN[_oh].x,_nN[_oh].y,_nO)_nU()end
elseif _og.kind=="pillar"then
 _oi=_nE(_og,_nO)if _oi then
 table.insert(_nT,{x=_og.fx,y=_og.fy})task.wait(0.08)_nU()end
elseif _og.kind=="fall"then
 _oi=executeStep(_og,_nO)_nU()elseif _og.kind=="jump"then
 _oi=executePillar(_og,_nO)_nU()elseif _og.kind=="gap"then
 _oi=_na(_og,_nO)_nU()elseif _og.kind=="stair"then
 _oi=_np(_og,_nO)_nU()end
clearKeys()if not _oi then
 ClickTP.BadEdge[_og.key]=os.clock()+20 return _ob(false)end
_of=_oh+1 end
return _ob(true)
end
function ClickTP.ClimbUpWithDirt(dropEntry,_op,_oq,_or,_os,_ot)
local _ou=getWorld()if not _ou then
 return false
end
if _or==nil then
 _or=true
end
if _ot==nil then
 _ot=false
end
local _ov=math.max(0.24,tonumber(_os)or tonumber(config.moveStepDelay)or 0.28)
local _ow={}for _ox,_oy in pairs(_iz)do
 _ow[_ox]=_oy end
table.clear(_iz)
local _oz=_iy
local _oA=DropRefs.collecting _iy=false DropRefs.collecting=true _ou.speedScale=1 _iE()keyState.active=true clearKeys()
local _oB={}
local function _oC(_oD)if not _or then
 return
end
local _oE={}for _oF in pairs(_oB)do
 if _oF>=_oD then
 table.insert(_oE,_oF)
end
end
table.sort(_oE,function(_oG,_oH)return _oG>_oH
end)for _oI,_oJ in ipairs(_oE)do
 if _oq and _oq()then
 return
end
local _oK=tileGetLocal(dropEntry,_oJ)if _oK~=0 and isBreakable(_oK,dropEntry,_oJ)then
 waitCooldown(dropEntry,_oJ)
local _oL=os.clock()while tileGetLocal(dropEntry,_oJ)~=0 and(os.clock()-_oL)<3.5 and isAlive()do
 if _oq and _oq()then
 break
end
local _oM=getPlayerState()if _oM and math.abs((_oJ+0.5)-(_oM.y-0.475))>getPunchRange()-0.1 then
 _ou.ghost=true pcall(_ou.goTo,dropEntry,math.max(0,_oJ-2))task.wait(0.06)end
punchTile(dropEntry,_oJ,false)task.wait(0.14)
end
end
if tileGetLocal(dropEntry,_oJ)==0 then
 _oB[_oJ]=nil
end
end
end
local function _oN()if not _or or next(_oB)==nil then
 return
end
local _oO=(dropEntry<=2)and{dropEntry+1,dropEntry+2}or((dropEntry>=_ou.w-3)and{dropEntry-1,dropEntry-2}or{dropEntry+1,dropEntry-1})for _oP,_oQ in ipairs(_oO)do
 if inBounds(_ou,_oQ,_op)and _js(_oQ,_op)and _jv(_oQ,_op)then
 walkToX(_oQ,_op,_oq)task.wait(0.12)break
end
end
_ou.ghost=true
local _oR={}for _oS in pairs(_oB)do
 table.insert(_oR,_oS)end
table.sort(_oR)for _oT,_oU in ipairs(_oR)do
 if _oq and _oq()then
 break
end
if tileGetLocal(dropEntry,_oU)~=0 and isBreakable(tileGetLocal(dropEntry,_oU),dropEntry,_oU)then

local _oV=math.max(0,_oU-1)
local _oW,_oX=getPlayerTile()if _oW and _oX and(math.abs(_oW-dropEntry)>2 or math.abs(_oX-_oU)>2)then
 _ou.ghost=true pcall(_ou.goTo,dropEntry,_oV)task.wait(0.08)end
waitCooldown(dropEntry,_oU)
local _oY=os.clock()while tileGetLocal(dropEntry,_oU)~=0 and(os.clock()-_oY)<3.5 and isAlive()do
 if _oq and _oq()then
 break end
_ou.ghost=true punchTile(dropEntry,_oU,false)task.wait(0.14)
end
end
if tileGetLocal(dropEntry,_oU)==0 then
 _oB[_oU]=nil
end
end
end
local function _oZ(_pa)pcall(_oN)clearKeys()keyState.active=false DropRefs.collecting=_oA if config.walkSpeed~=100 and GameRefs.World and not _oA then
 GameRefs.World.speedScale=config.walkSpeed/100 end
_iy=_oz for _pb,_pc in pairs(_ow)do
 _iz[_pb]=_pc end
_iE()return _pa
end
local _pd,pe_helper=getPlayerTile()if not _pd then
 return _oZ(false)
end
if _pd~=dropEntry then
 if not walkToX(dropEntry,pe_helper,_oq)then
 pcall(_ou.goTo,dropEntry,pe_helper)task.wait(_ov)end
_pd,pe_helper=getPlayerTile()if not _pd then
 return _oZ(false)
end
end
local _pf=_jJ()if inBounds(_ou,dropEntry,pe_helper+1)and not _jv(dropEntry,pe_helper)then
 if tileGetLocal(dropEntry,pe_helper+1)==0 and _jR(dropEntry,pe_helper+1)then
 _oB[pe_helper+1]=_pf task.wait(cooldownTime)
end
end
local _pg=0 while pe_helper>_op and isAlive()do
 if _oq and _oq()then
 return _oZ(false)
end
local _ph=pe_helper-1 if not _ot and tileGetLocal(dropEntry,_ph)~=0 and _iY(dropEntry,_ph)then
 return _oZ(false)
end
if _ot then
 for _pi=_ph,math.max(0,_ph-2),-1 do

local _pj=tileGetLocal(dropEntry,_pi)if _pj~=0 and isBreakable(_pj,dropEntry,_pi)then

local _pk=os.clock()while tileGetLocal(dropEntry,_pi)~=0 and(os.clock()-_pk)<4 and isAlive()do
 if _oq and _oq()then
 return _oZ(false)end
punchTile(dropEntry,_pi,false)task.wait(0.15)
end
end
end
end
if DropRefs.walkToX then
 DropRefs.walkToX(dropEntry+0.5,0.6)
end
local _pl=pe_helper
local _pm=(tileGetLocal(dropEntry,pe_helper)==0)
local _pn=_nE({fx=dropEntry,fy=pe_helper,x=dropEntry,y=_ph},_oq)if _pn or(_pm and tileGetLocal(dropEntry,pe_helper)~=0)then
 _oB[pe_helper]=_pf elseif tileGetLocal(dropEntry,pe_helper)==0 then
 if _jR(dropEntry,pe_helper)then
 _oB[pe_helper]=_pf end
task.wait(0.14)pcall(_ou.goTo,dropEntry,_ph)end
task.wait(math.max(cooldownTime,_ov))
local _po,_pp=getPlayerTile()if _pp and _pp<_pl then
 pe_helper=_pp _pg=0 else if tileGetLocal(dropEntry,_pl)~=0 and _js(dropEntry,_ph)then
 pcall(_ou.goTo,dropEntry,_ph)task.wait(0.18)_po,_pp=getPlayerTile()
end
if _pp and _pp<_pl then
 pe_helper=_pp _pg=0 else
 _pg=_pg+1 if _pg>=3 then
 return _oZ(false)
end
end
end
_oC(pe_helper+2)end
return _oZ(true)
end
local function _pq(_pr,_ps,_pt,_pu,_pv)
local _pw,_px=_pr.w,_pr.h
local _py=_pt*_pw+_ps
local _pz=_pv*_pw+_pu if _py==_pz then
 return{}
end
local _pA={_py}
local _pB={[_py]=-1}
local _pC=1
local _pD={{0,-1},{1,0},{-1,0},{0,1}}while _pC<=#_pA and _pC<=3500 do

local _pE=_pA[_pC]_pC=_pC+1 if _pE==_pz then

local _pF={}
local _pG=_pE while _pG~=_py do
 table.insert(_pF,1,{x=_pG%_pw,y=math.floor(_pG/_pw)})_pG=_pB[_pG]end
return _pF
end
local _pH,_pI=_pE%_pw,math.floor(_pE/_pw)for _pJ,_pK in ipairs(_pD)do

local _pL,_pM=_pH+_pK[1],_pI+_pK[2]if _pL>=0 and _pL<_pw and _pM>=0 and _pM<_px then

local _pN=_pM*_pw+_pL if _pB[_pN]==nil and(_pN==_pz or _js(_pL,_pM))then
 _pB[_pN]=_pE table.insert(_pA,_pN)
end
end
end
end
return nil
end
function ClickTP.FlyTo(_pO,_pP,_pQ,_pR,_pS)
local _pT=getWorld()if not _pT or type(_pT.goTo)~="function"then
 return false
end
local _pU=math.max(0.16,tonumber(_pR)or tonumber(config.moveStepDelay)or 0.22)for _pV=1,3 do
 if _pQ and _pQ()then
 return false
end
local pabrikToken,pabrikPhase=getPlayerTile()if not pabrikToken then
 return false
end
if pabrikToken==_pO and pabrikPhase==_pP then
 return true end
_pT.ghost=true
local _pY=_pq(_pT,pabrikToken,pabrikPhase,_pO,_pP)if _pY and#_pY>0 then

local _pZ=false for _qa,_qb in ipairs(_pY)do
 if _pQ and _pQ()then
 return false end
_pT.ghost=true pcall(_pT.goTo,_qb.x,_qb.y)task.wait(_pU)
local _qc,_qd=getPlayerTile()if not _qc or(math.abs(_qc-_qb.x)>2 or math.abs(_qd-_qb.y)>2)then
 _pZ=true break
end
end
local _qe,_qf=getPlayerTile()if not _pZ and _qe==_pO and _qf==_pP then
 return true
end
end
local _qg=0
local _qh=160 while(pabrikToken~=_pO or pabrikPhase~=_pP)and _qh>0 and isAlive()do
 _qh=_qh-1 if _pQ and _pQ()then
 return false end
_pT.ghost=true
local _qi,_qj=getPlayerTile()if not _qi then
 return false end
pabrikToken,pabrikPhase=_qi,_qj if pabrikToken==_pO and pabrikPhase==_pP then
 return true
end
local _qk=(_pO>pabrikToken and 1)or(_pO<pabrikToken and-1)or 0
local _ql=(_pP>pabrikPhase and 1)or(_pP<pabrikPhase and-1)or 0
local _qm,_qn=pabrikToken,pabrikPhase if _ql<0 and _js(pabrikToken,pabrikPhase-1)then
 _qm,_qn=pabrikToken,pabrikPhase-1 elseif _qk~=0 and _js(pabrikToken+_qk,pabrikPhase)then
 _qm,_qn=pabrikToken+_qk,pabrikPhase elseif _ql~=0 and _js(pabrikToken,pabrikPhase+_ql)then
 _qm,_qn=pabrikToken,pabrikPhase+_ql elseif pabrikPhase>0 and _js(pabrikToken,pabrikPhase-1)then
 _qm,_qn=pabrikToken,pabrikPhase-1 elseif _pS then
 _qm,_qn=pabrikToken+_qk,pabrikPhase+_ql else
 break end
pcall(_pT.goTo,_qm,_qn)task.wait(_pU)
local _qo,_qp=getPlayerTile()if _qo==pabrikToken and _qp==pabrikPhase then
 _qg=_qg+1 if _qg>=3 then
 break end
else
 _qg=0
end
end
local _qq,_qr=getPlayerTile()if _qq==_pO and _qr==_pP then
 return true
end
end
return false
end
function ClickTP.LegitTo(_qs,_qt,_qu,_qv,_qw)
local _qx=os.clock()
local _qy=getWorld()if not _qy then
 return false,"world"
end
if _qw==nil then
 _qw=false
end
local _qz=_qv or 0.4 for _qA=1,3 do
 if _qu and _qu()then
 return false,"cancel"
end
local _qB,_qC=getPlayerTile()if not _qB then
 return false,"pos"
end
if _qB==_qs and _qC==_qt then
 return true,os.clock()-_qx
end
local _qD=getPlayerState()if _qD and _qz>=1 and _jy(_qD,_qs,_qt,_qz)then
 return true,os.clock()-_qx
end
local _qE={[_qt*_qy.w+_qs]=true}
local _qF=ClickTP.AStar(_qB,_qC,_qE,_qs,_qt,_qz,_qw,_qu)if _qF and#_qF>0 then
 if ClickTP.FollowPath(_qF,_qu)then

local _qG,_qH=getPlayerTile()
local _qI=getPlayerState()if(_qG==_qs and _qH==_qt)or(_qI and _jy(_qI,_qs,_qt,_qz+0.35))then
 return true,os.clock()-_qx
end
end
else if _qC~=_qt then

local _qJ=(math.abs(_qB-1)<=math.abs(_qB-(_qy.w-2)))and 1 or(_qy.w-2)
local _qK={[_qt*_qy.w+_qJ]=true}
local _qL=ClickTP.AStar(_qB,_qC,_qK,_qJ,_qt,0.5,_qw,_qu)if _qL and#_qL>0 then
 ClickTP.FollowPath(_qL,_qu)
end
end
end
task.wait(0.15)end
return false,"nopath"
end
function ClickTP.StepGoTo(_qM,_qN,_qO,_qP)
local _qQ=ClickTP.FlyTo(_qM,_qN,_qO,config.moveStepDelay,_qP==true)_iE()return _qQ,_qQ and 0 or "stuck"
end
function ClickTP.Go(_qR,_qS,_qT,_qU,_qV)
local _qW=(config.moveMethod=="Teleport Mode")or(config.moveMode=="fly")or(config.moveMode=="teleport")if not _qW then

local _qX=getWorld()if _qX and not _iy then
 _qX.ghost=false
end
local _qY,_qZ=ClickTP.LegitTo(_qR,_qS,_qT,_qU,_qV)return _qY,_qZ end
return ClickTP.StepGoTo(_qR,_qS,_qT,false)
end
function ClickTP.To(_ra,_rb,_rc,_rd,_re)
local _rf=ClickTP.Go(_ra,_rb,_rc,_rd,_re)return _rf
end
local _rg=nil
local function _rh()if not _rg and getGC and debug and debug.info then
 for _ri,_rj in ipairs(getGC(true))do
 if type(_rj)=="function"then

local _rk,_rl=pcall(debug.info,_rj,"n")if _rk and _rl=="act"and getUpvalue then

local _rm,_rn=pcall(getUpvalue,_rj,1)
local _ro,_rp=pcall(getUpvalue,_rj,2)
local _rq,_rr=pcall(getUpvalue,_rj,4)
local _rs,_rt=pcall(getUpvalue,_rj,5)if _rm and typeof(_rn)=="Instance"and _rn.ClassName=="Players"and _ro and type(_rp)=="number"and _rq and type(_rr)=="number"and _rs and type(_rt)=="number"then
 _rg=_rj break
end
end
end
end
end
if _rg and getUpvalue then

local _ru,_rv=pcall(getUpvalue,_rg,2)
local _rw,_rx=pcall(getUpvalue,_rg,4)
local _ry,_rz=pcall(getUpvalue,_rg,5)if _ru and _rw and _ry and type(_rv)=="number"and type(_rx)=="number"and type(_rz)=="number"and _rx>0 then
 return _rv,_rz,_rx
end
end
local _rA=PlayerGui:FindFirstChild("GameGui")
local _rB=_rA and _rA:FindFirstChild("World")
local _rC=_rB and _rB:FindFirstChild("Camera")
local _rD=_rC and _rC:FindFirstChild("Tiles")if _rD and _rD:IsA("GuiObject")then

local _rE=64
local _rF=-_rD.Position.X.Offset/_rE
local _rG=-_rD.Position.Y.Offset/_rE return _rF,_rG,_rE end
return nil
end
function ClickTP.ScreenToTile(_rH)
local _rI,_rJ,_rK=_rh()if not _rI then
 return nil
end
local _rL=PlayerGui:FindFirstChild("GameGui")
local _rM=(_rL and _rL:FindFirstChild("World"))or PlayerGui:FindFirstChild("World",true)if not _rM or not _rM:IsA("GuiObject")then
 return nil
end
local _rN=_rM:FindFirstChildWhichIsA("UIScale",true)
local _rO=_rN and _rN.Scale or 1
local _rP=(Vector2.new(_rH.X,_rH.Y)-_rM.AbsolutePosition)/_rO return _iN(_rI+_rP.X/_rK),_iN(_rJ+_rP.Y/_rK)
end
local function _rQ(_rR,_rS)if _rS or not ClickTP.clickOn then
 return
end
if _rR.UserInputType~=Enum.UserInputType.MouseButton1 and _rR.UserInputType~=Enum.UserInputType.Touch then
 return
end
if config.clickTpShift and not(UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)or UserInputService:IsKeyDown(Enum.KeyCode.RightShift))then
 return
end
local _rT,_rU=ClickTP.ScreenToTile(_rR.Position)if not _rT then
 notify("Click TP: posisi klik tidak terbaca.")return end
ClickTP.token+=1
local _rV=ClickTP.token task.spawn(function()
local _rW=os.clock()
local _rX,_rY=ClickTP.Go(_rT,_rU,function()return ClickTP.token~=_rV or not ClickTP.clickOn or not isAlive()end,0.4,true)if _rX then
 ClickTP.last=string.format("Sampai (%d,%d) dalam %.2fs",_rT,_rU,os.clock()-_rW)notify(ClickTP.last)elseif _rY~="cancel"then
 ClickTP.last="Gagal ("..tostring(_rY)..")"notify("Click TP gagal: "..tostring(_rY))
end
end)
end
function ClickTP.StartClick()if ClickTP.clickOn then
 return true
end
if not _rh()then
 notify("Click TP: data kamera game tidak ditemukan.")return false end
ClickTP.clickOn=true ClickTP.conn=trackConn(UserInputService.InputBegan:Connect(_rQ))return true
end
function ClickTP.StopClick()if not ClickTP.clickOn then
 return false end
ClickTP.clickOn=false ClickTP.token+=1 if ClickTP.conn then
 ClickTP.conn:Disconnect()ClickTP.conn=nil end
clearKeys()return true
end
end)()
end
local _rZ=0
local function _sa(_sb)_sb=math.floor(tonumber(_sb)or 0)if _sb<1 or _sb>maxItems then
 notify("Jumlah WL tidak valid!")return false
end
local _sc=os.clock()if _sc-_rZ<tileDelay then
 task.wait(tileDelay-(_sc-_rZ))end
_rZ=os.clock()
local _sd=config.dropId or 242 if DropItem then
 pcall(function()DropItem:FireServer(_sd,_sb)end)notify(string.format("Drop %d %s dikirim!",_sb,getItemName(_sd)))return true elseif netOk and type(Net)=="table"and Net.drop then
 pcall(Net.drop.send,{id=_sd,n=_sb})notify(string.format("Drop %d %s dikirim!",_sb,getItemName(_sd)))return true end
notify("Remote DropItem tidak ditemukan!")return false
end
local _se
local function _sf(_sg)_sg=trim(_sg):upper()if _sg==""then
 notify("Nama world tidak boleh kosong!")return false end
config.lastWorld=_sg saveConfig()if _se then
 pcall(_se)
end
local _sh=GameRefs.Menu if _sh and type(rawget(_sh,"enter"))=="function"then
 pcall(_sh.enter,_sg)notify("Memasuki world: ".._sg)return true
end
local _si=getWorld()if _si and type(rawget(_si,"enter"))=="function"then
 pcall(_si.enter,_sg)notify("Memasuki world: ".._sg)return true end
notify("Fungsi enter world tidak ditemukan.")return false
end
local function _sj()
local _sk=getWorldName()if _sk~=""then
 config.lastWorld=_sk saveConfig()
end
if _se then
 pcall(_se)end
pcall(function()TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId,LocalPlayer)
end)end
local function _sl(_sm)
local _sn,_so=getPlayerTile()if not _sn then
 notify("Posisi karakter belum terbaca!")return false
end
local _sp="pos"..tostring(_sm)config[_sp]={x=_sn,y=_so,world=getWorldName()}saveConfig()notify(string.format("Pos %d disimpan di (%d, %d) [%s]",_sm,_sn,_so,getWorldName()))return true
end
local function _sq()
local _sr,_ss=getPlayerTile()
local _st,_su=config.pos1 or{},config.pos2 or{}
local _sv=string.format("Sekarang: (%s, %s) | Pos1: (%s, %s) | Pos2: (%s, %s)",_sr and tostring(_sr)or "-",_ss and tostring(_ss)or "-",_st.x and tostring(_st.x)or "-",_st.y and tostring(_st.y)or "-",_su.x and tostring(_su.x)or "-",_su.y and tostring(_su.y)or "-")notify(_sv,"Info Posisi")
end
local function _sw(_sx,_sy)
local _sz="pos"..tostring(_sx)
local _sA=config[_sz]if type(_sA)~="table"or type(_sA.x)~="number"or type(_sA.y)~="number"then
 notify("Pos "..tostring(_sx).." belum disimpan!")return false
end
local _sB=ClickTP.To(_sA.x,_sA.y,nil,0.3,true)if _sB then

local _sC=tonumber(_sy)or tonumber(config.winDrop)or 0 if _sC>=1 then
 task.wait(0.15)_sa(_sC)
end
end
return _sB
end
local spliceSetup
local _sE=nil
local _sF="farm"
local _sG=nil
local _sH=nil
local autoFarm={on=false,token=0,Override=nil,Quiet=false,stats={status="Mati",placed=0,broken=0,picked=0,fail=0,cycles=0},}
local autoClear={on=false,token=0,status="Mati",stats={scanned=0,broken=0,picked=0,skipped=0,left=0,pass=0,row=-1},}
local autoHarvest={on=false,token=0,status="Mati",stats={totalTrees=0,ready=0,harvested=0,planted=0,skipped=0,picked=0},}
local autoDF={on=false,token=0,status="Mati",stats={topDirtY=0,bedrockY=0,broken=0,placed=0,picked=0,step="-"},}
local autoSplice={on=false,roaming=false,token=0,status="Mati",made=0,planted=0,fail={},skip={},}
local autoPabrik={on=false,token=0,phase="-",status="Mati",harvested=0,planted=0,dropped=0,traveling=false,home="",Zone=nil,skip={},}
local autoGuard={on=false,token=0,phase="-",status="Mati",collected=0,dropped=0,traveling=false,pauseCollect=false,}
local _sP={recycled=0,converted=0,status="-",}
local guardModule={on=false,mode="idle",allow={},alerted={},saved=nil,token=0,backAt=0,calmAt=nil,leftFg=nil,status="Mati",detected=0,hereText="tidak ada",staffServerText="tidak ada",}
local bonusModule={busy=false,leaving=false,last=nil,lastAt=0,count=0,status="-",}
local autoChat={on=false,sent=0,last="-",nextAt=0}
local function _sT(_sU)
local _sV=ItemDB and ItemDB[_sU]return type(_sV)=="table"and(_sV.kind=="seed"or type(_sV.tree)=="table"or type(_sV.grow)=="number")
end
local function _sW(_sX,_sY,_sZ,_ta)_sX=_sX or getWorld()if not _sX then
 return nil
end
local _tb=ItemDB[_ta]if not _tb then
 return nil
end
local _tc=tonumber(_tb.grow)or tonumber(_tb.baseGrow)or 31
local _td=_sZ*_sX.w+_sY if type(_sX.treeLook)=="function"then
 pcall(_sX.treeLook,_sY,_sZ)
end
if not GameRefs.Trees then
 GameRefs.Scan()
end
local _te=GameRefs.Trees and GameRefs.Trees[_td]if type(_te)=="table"then
 if _te.ripe==true or _te.fruitMade==true or _te.step==1 then
 return 0
end
if type(_te.tree)=="table"and type(_te.tree.p)=="number"then
 return _te.tree.p+_tc
end
if type(_te.p)=="number"then
 return _te.p+_tc
end
end
local _tf=_sX.placedAt and _sX.placedAt.fg if _tf and type(_tf[_td])=="number"then
 return workspace:GetServerTimeNow()-(os.clock()-_tf[_td])+_tc end
return nil
end
local function _tg(_th,_ti,_tj,_tk)
local _tl=_sW(_th,_ti,_tj,_tk)if not _tl then
 return false end
return workspace:GetServerTimeNow()>=_tl
end
local function _tm(_tn,_to,_tp,_tq)_tn=_tn or getWorld()if not inBounds(_tn,_to,_tp)or _tp+1>=_tn.h then
 return false
end
if(getTileAt(_tn,"fg",_to,_tp)or 0)~=0 then
 return false
end
local _tr=getTileAt(_tn,"fg",_to,_tp+1)or 0 if _tr==0 then
 return false
end
local _ts=ItemDB[_tr]if not _ts or _ts.kind=="seed"then
 return false
end
if not(ClickTP.SolidAt(_to,_tp+1)or _ts.platform)then
 return false
end
local _tu,_tv=pcall(function()if _tn.areas and type(_tn.areas.canEdit)=="function"and not _tn.areas.canEdit(_to,_tp)then
 return false
end
if type(_tn.builderOk)=="function"and not _tn.builderOk(_to,_tp,true)then
 return false
end
local _tt=_tq and ItemDB[_tq]if _tt and type(_tn.needsWay)=="function"and _tn.needsWay(_tt)and type(_tn.wayBlocked)=="function"and _tn.wayBlocked(_to,_tp)then
 return false end
return true end)return(not _tu)or _tv end
do
(function()
local function _tw(_tx,_ty,_tz)return _ty>=_tx.x-0.15 and _ty<_tx.x+1.15 and _tz>=_tx.y-0.15 and _tz<_tx.y+1.15
end
local function _tA(_tB,_tC)if type(_tB)~="table"or _tB.taking or _tB.pending or _tB.display or(_tB.n or 0)<=0 or type(_tB.x)~="number"then
 return false
end
if _tB.armed==false and _tB.id~=112 then
 return false
end
local _tD=_tB.uid and _cb[_tB.uid]return not(_tD and _tC<_tD)
end
function DropRefs.applyTaken(_tE,_tF)
local _tG=DropRefs.list if not _tG or not table.find(_tG,_tE)then
 return
end
if not DropRefs.update and DropRefs.findUpdate then
 DropRefs.findUpdate()
end
if DropRefs.update then

local _tH=pcall(DropRefs.update,_tE,_tF)if _tH then
 if _tF>0 then
 _tE.flown=nil if typeof(_tE.frame)=="Instance"then
 pcall(function()_tE.frame.Visible=not _tE.culled
end)end
end
return
end
end
_tE.n=_tF if _tF>0 then
 _tE.flown=nil if typeof(_tE.frame)=="Instance"then
 pcall(function()_tE.frame.Visible=not _tE.culled
end)end
else

local _tI=table.find(_tG,_tE)if _tI then
 table.remove(_tG,_tI)
end
if typeof(_tE.frame)=="Instance"then
 pcall(function()_tE.frame:Destroy()
end)end
end
end
function DropRefs.waitNearDrops(_tJ)
local _tK=DropRefs.list if not _tK then
 return end
task.wait(0.15)
local _tL=os.clock()while os.clock()-_tL<(_tJ or 0.45)and isAlive()do

local _tM=getPlayerState()if not _tM or not _tM.x then
 return
end
local _tN=false for _tO,_tP in ipairs(_tK)do
 if type(_tP)=="table"and type(_tP.x)=="number"and(_tP.n or 0)>0 and _tP.armed~=false and math.abs(_tP.x-_tM.x)<0.6 and _tP.y+0.3>_tM.y-0.95 and _tP.y-0.3<_tM.y then

local _tQ=true if _tP.id~=112 and GameRefs.Inv and type(GameRefs.Inv.room)=="function"then

local _tR,_tS=pcall(function()return GameRefs.Inv:room(_tP.id)
end)if _tR and type(_tS)=="number"and _tS<=0 then
 _tQ=false
end
end
if _tQ then
 _tN=true;break
end
end
end
if not _tN then
 return end
task.wait()
end
end
function DropRefs.waitSpawn(_tT)if not DropRefs.list and DropRefs.findRefs then
 DropRefs.findRefs()
end
local _tU=0.1 pcall(function()_tU=LocalPlayer:GetNetworkPing()
end)
local _tV=math.clamp(0.15+2.5*_tU,0.25,0.85)
local _tW=nil for _tX,_tY in ipairs(_tT)do

local _tZ=DropRefs.brokeAt[_tY.x..",".._tY.y]if _tZ and os.clock()-_tZ<_tV and(not _tW or _tZ>_tW)then
 _tW=_tZ
end
end
if not _tW then
 return
end
local _ua=DropRefs.list while os.clock()-_tW<_tV and isAlive()do
 if _ua then
 for _ub,_uc in ipairs(_ua)do
 if type(_uc)=="table"and type(_uc.x)=="number"and(_uc.born or 0)>=_tW-0.2 then
 for _ud,_ue in ipairs(_tT)do
 if _tw(_ue,_uc.x,_uc.y)then
 task.wait(0.05)return
end
end
end
end
end
task.wait()
end
end
local function _uf(ug_spliceVar)
local _uh=getWorld()
local _ui=_uh and rawget(_uh,"takeDrop")if type(_ui)~="function"and not TakeDrop then
 return false
end
local _uj=os.clock()if not _tA(ug_spliceVar,_uj)then
 return false
end
local _uk=ug_spliceVar.n if ug_spliceVar.id~=112 and GameRefs.Inv and type(GameRefs.Inv.room)=="function"then

local _ul,_um=pcall(function()return GameRefs.Inv:room(ug_spliceVar.id)
end)if _ul and type(_um)=="number"then
 _uk=math.min(_uk,_um)
end
end
if _uk<=0 then
 if ug_spliceVar.uid then
 _cb[ug_spliceVar.uid]=_uj+1
end
local _un=webhook.LastFull[ug_spliceVar.id]if not _un or _uj-_un>120 then
 webhook.LastFull[ug_spliceVar.id]=_uj webhook.Send("full","Inventori penuh: "..getItemName(ug_spliceVar.id).." tidak bisa diambil lagi")end
return false end
ug_spliceVar.taking=true if typeof(ug_spliceVar.frame)=="Instance"then
 pcall(function()ug_spliceVar.frame.Visible=false
end)end
local _uo,_up if type(_ui)=="function"then
 _uo,_up=pcall(_ui,ug_spliceVar.uid,_uk)else
 _uo,_up=pcall(TakeDrop.InvokeServer,TakeDrop,ug_spliceVar.uid,_uk)end
ug_spliceVar.taking=false if not(_uo and type(_up)=="number"and _up>0)then
 autoFarm.stats.fail=autoFarm.stats.fail+1 ug_spliceVar.refused=os.clock()ug_spliceVar.failN=(ug_spliceVar.failN or 0)+1 if ug_spliceVar.uid then
 _cb[ug_spliceVar.uid]=os.clock()+math.min(8,ug_spliceVar.failN)end
ug_spliceVar.flown=nil if typeof(ug_spliceVar.frame)=="Instance"then
 pcall(function()ug_spliceVar.frame.Visible=not ug_spliceVar.culled
end)end
return false
end
if ug_spliceVar.uid then
 _cb[ug_spliceVar.uid]=nil
end
if ug_spliceVar.id==112 then
 if GameRefs.Gems and type(GameRefs.Gems.addGems)=="function"then
 pcall(GameRefs.Gems.addGems,_up)end
elseif GameRefs.Inv and type(GameRefs.Inv.add)=="function"then
 pcall(function()GameRefs.Inv:add(ug_spliceVar.id,_up)
end)end
DropRefs.applyTaken(ug_spliceVar,math.max(0,(ug_spliceVar.n or 0)-_up))stats.Collected=stats.Collected+_up stats.Items[ug_spliceVar.id]=(stats.Items[ug_spliceVar.id]or 0)+_up autoFarm.stats.picked=autoFarm.stats.picked+_up if autoClear.on then
 autoClear.stats.picked=autoClear.stats.picked+_up
end
if autoHarvest.on then
 autoHarvest.stats.picked=autoHarvest.stats.picked+_up
end
if autoDF.on then
 autoDF.stats.picked=autoDF.stats.picked+_up end
return true
end
function DropRefs.walkToX(_uq,_ur)
local _us=getPlayerState()if not _us or _us.dead then
 return false
end
if math.abs(_uq-_us.x)<=0.18 and math.abs(_us.vx or 0)<2.0 then
 clearKeys()return true end
keyState.active=true
local _ut=0.14
local _uu=os.clock()while isAlive()and(autoFarm.on or autoFarm.Override~=nil)and(os.clock()-_uu)<(_ur or 1.6)do

local _uv=getPlayerState()if not _uv or _uv.dead then
 break
end
local _uw=_uq-_uv.x
local _ux=_uv.vx or 0
local _uy=_uv.grounded and 48 or 17
local _uz=0 if math.abs(_uw)>_ut then
 _uz=(_uw>0)and 1 or-1 if _ux*_uz>0 and(_ux*_ux)/(2*_uy)>=math.abs(_uw)-_ut*0.5 then
 _uz=0
end
end
keyState.left=(_uz<0)keyState.right=(_uz>0)if math.abs(_uw)<=0.18 and _uv.grounded and math.abs(_ux)<2.2 then
 clearKeys()return true end
task.wait()end
clearKeys()return false
end
function DropRefs.touchAll(_uA,_uB,_uC)if type(_uA)~="table"or#_uA==0 then
 return false
end
local _uD=getWorld()if not _uD then
 return false
end
local _uE,_uF=_uB,_uB
local _uG={}for _uH,_uI in ipairs(_uA)do
 if not ClickTP.SolidAt(_uI.x,_uI.y)then
 if _uI.y==_uC and math.abs(_uI.x-_uB)<=3 then
 if _uI.x<_uE then
 _uE=_uI.x
end
if _uI.x>_uF then
 _uF=_uI.x end
elseif _uI.y<_uC and math.abs(_uI.x-_uB)<=2 then
 if not _uG[_uI.x]or _uI.y<_uG[_uI.x]then
 _uG[_uI.x]=_uI.y
end
end
end
end
local _uJ=keyState.active keyState.active=true DropRefs.collecting=true _uD.speedScale=1
local function _uK(_uL)clearKeys()
local _uM=(_uL<=_uC-2)keyState.jump=true
local _uN=os.clock()
local _uO=false while isAlive()and(autoFarm.on or autoFarm.Override~=nil)and(os.clock()-_uN)<1.1 do

local _uP=getPlayerState()if not _uP or _uP.dead then
 break
end
if not _uP.grounded then
 _uO=true if not _uM or _uP.y<=(_uL+0.6)or(_uP.vy or 0)>=0 then
 keyState.jump=false
end
end
if _uO and _uP.grounded then
 break
end
if not _uO and(os.clock()-_uN)>0.32 then
 break end
task.wait()end
clearKeys()end
pcall(function()if _uE<_uB then
 DropRefs.walkToX(_uE+0.5,1.5)if _uG[_uE]then
 _uK(_uG[_uE])_uG[_uE]=nil else
 task.wait(0.06)
end
end
if _uF>_uB then
 DropRefs.walkToX(_uF+0.5,1.8)if _uG[_uF]then
 _uK(_uG[_uF])_uG[_uF]=nil else
 task.wait(0.06)
end
end
for _uQ,_uR in pairs(_uG)do
 if not isAlive()or not(autoFarm.on or autoFarm.Override~=nil)then
 break end
DropRefs.walkToX(_uQ+0.5,1.4)_uK(_uR)
end
if isAlive()and(autoFarm.on or autoFarm.Override~=nil)then
 DropRefs.walkToX(_uB+0.5,1.6)
end
end)clearKeys()DropRefs.collecting=false if config.walkSpeed~=100 and GameRefs.World then
 GameRefs.World.speedScale=config.walkSpeed/100 end
keyState.active=_uJ return true
end
local _uS=0 trackConn(RunService.Heartbeat:Connect(function()if not isAlive()then
 return
end
if autoGuard and autoGuard.pauseCollect then
 return
end
local _uT=(autoFarm.Override and autoFarm.Override.offsets)or config.farmGrid
local _uU=(autoFarm.on and config.farmTake)or(autoFarm.Override~=nil)
local _uV=config.collectAround or(autoClear.on and config.clearTake)or(autoHarvest.on and config.harvestTake)or(autoDF.on and config.dfTake)or autoSplice.on or autoPabrik.on if not _uU and not _uV then
 return
end
local _uW=os.clock()if _uW<(DropRefs.nextTick or 0)then
 return end
DropRefs.nextTick=_uW+((config.collectMode=="Remote")and 0.1 or 0.2)
local _uX=DropRefs.list if not _uX then
 if _uW>=_uS then
 _uS=_uW+5 if DropRefs.findRefs then
 DropRefs.findRefs()else
 GameRefs.Scan()
end
end
return
end
local _uY=getPlayerState()if not _uY or type(_uY.x)~="number"then
 return
end
local _uZ,_va=_uY.x,_uY.y-0.475 if config.collectMode~="Remote"then

local _vb={}for _vc,_vd in ipairs(_uX)do
 if type(_vd)=="table"and type(_vd.x)=="number"and math.abs(_vd.x-_uZ)<=1.5 and math.abs(_vd.y-_va)<=1.5 then
 _vb[_vd]=_vd.n or 0
end
end
for _ve,_vf in pairs(DropRefs.seen or{})do
 if _vb[_ve]==nil and not table.find(_uX,_ve)and _ve.id and _vf>0 then
 stats.Collected=stats.Collected+_vf stats.Items[_ve.id]=(stats.Items[_ve.id]or 0)+_vf autoFarm.stats.picked=autoFarm.stats.picked+_vf if autoClear.on then
 autoClear.stats.picked=autoClear.stats.picked+_vf
end
if autoHarvest.on then
 autoHarvest.stats.picked=autoHarvest.stats.picked+_vf
end
if autoDF.on then
 autoDF.stats.picked=autoDF.stats.picked+_vf
end
end
end
DropRefs.seen=_vb return
end
if#_uX==0 then
 return
end
local _vg,_vh=math.floor(_uZ),math.floor(_va)
local _vi=(tonumber(config.collectRadius)or 3)+0.25
local _vj=autoPabrik.Zone if _vj and _vj.world~=getWorldName()then
 _vj=nil
end
for _vk=#_uX,1,-1 do

local _vl=_uX[_vk]if _tA(_vl,_uW)and not(_vj and math.abs(_vl.x-_vj.x)<=2.5 and math.abs(_vl.y-_vj.y)<=2.5)then

local _vm=_uV and math.abs(_vl.x-_uZ)<=_vi and math.abs(_vl.y-_va)<=_vi if not _vm and _uU then
 for _vn,_vo in pairs(_uT)do
 if _vo then

local _vp,_vq=tostring(_vn):match("^(-?%d+),(-?%d+)$")if _vp and _vq then

local _vr,_vs=_vg+tonumber(_vp),_vh+tonumber(_vq)if _tw({x=_vr,y=_vs},_vl.x,_vl.y)then
 _vm=true break
end
end
end
end
end
if _vm then
 task.spawn(_uf,_vl)
end
end
end
end))end)()
end
local _vt,_vu,_vv do
(function()
local _vw={{1,0},{-1,0},{0,1},{0,-1},{1,1},{1,-1},{-1,1},{-1,-1}}
local function _vx()
local _vy=getWorld()
local _vz=_vy and rawget(_vy,"raymanOn")if type(_vz)~="function"then
 return false
end
local _vA,_vB=pcall(_vz)return _vA and _vB==true
end
local function _vC(_vD,_vE,_vF)
local _vG={}for _vH,_vI in ipairs(_vF)do
 _vG[_vI.x..",".._vI.y]=_vI
end
local _vJ,_vK=nil,nil for _vL,_vM in ipairs(_vw)do

local _vN={}for _vO=1,3 do

local _vP=_vG[(_vD+_vM[1]*_vO)..","..(_vE+_vM[2]*_vO)]if _vP then
 _vN[#_vN+1]=_vP
end
end
if#_vN>=2 and#_vN>(_vJ and#_vJ or 0)then
 _vJ,_vK=_vN,_vM
end
end
return _vJ,_vK
end
local function _vQ(_vR)
local _vS=getPlayerState()if not _vS or not _vS.x then
 return
end
if netOk and type(Net)=="table"and Net.act then
 pcall(Net.act.send,{kind=4,x=_vS.x+_vR[1],y=_vS.y-0.475+_vR[2]})
end
end
local function _vT()
local _vU=(autoFarm.Override and autoFarm.Override.offsets)or config.farmGrid
local _vV={}for _vW,_vX in pairs(_vU)do
 if _vX then

local _vY,_vZ=tostring(_vW):match("^(-?%d+),(-?%d+)$")_vY,_vZ=tonumber(_vY),tonumber(_vZ)if _vY and _vZ and not(_vY==0 and _vZ==0)then
 table.insert(_vV,{dx=_vY,dy=_vZ})
end
end
end
table.sort(_vV,function(_wa,_wb)if _wa.dy~=_wb.dy then
 return _wa.dy<_wb.dy end
return _wa.dx<_wb.dx end)return _vV
end
local function _wc(_wd,_we,_wf)
local _wg=getTileAt(_wd,"fg",_we,_wf)if _wg==nil then
 return false
end
if _wg~=0 then
 return isBreakable(_wg)
end
local _wh=getTileAt(_wd,"bg",_we,_wf)return config.farmBreakBg and _wh~=nil and _wh~=0 and isBreakable(_wh)
end
local function _wi(_wj,wk_helper)while autoFarm.on and autoFarm.token==_wj and isAlive()do

local _wl=getWorld()if not _wl or getWorldName()~=wk_helper.world then
 autoFarm.stats.status="World berubah, berhenti"break
end
local _wm=(autoFarm.Override and autoFarm.Override.mode)or config.farmMode
local _wn=_wm~="Break saja"
local _wo=_wm~="Place saja"
local _wp=(autoFarm.Override and autoFarm.Override.block)or config.farmPlaceId if not autoFarm.Override and config.farmAutoDropSeed then

local _wq=_sT(_wp)and _wp or getSeedForBlock(_wp)
local _wr=tonumber(config.farmSeedDropAt)or 200 if _wq and countInv(_wq)>=_wr then

local _ws=tonumber(config.farmSeedKeep)or 0
local _wt=countInv(_wq)-_ws if _wt>0 and autoPabrik and type(autoPabrik.ExternalDropSeed)=="function"then
 autoFarm.stats.status=string.format("Auto Drop Seed %s x%d...",getItemName(_wq),_wt)autoPabrik.ExternalDropSeed(_wq,_wt,config.farmDropWorld,config.farmDropX,config.farmDropY,wk_helper.world,wk_helper.x,wk_helper.y,function()return autoFarm.on and autoFarm.token==_wj and isAlive()end)_wl=getWorld()
end
end
end
local _wu=_vT()if#_wu==0 then
 autoFarm.stats.status="Pilih kotak di Grid 5x5 dulu"if not autoFarm.Quiet then
 notify("Auto Farm: pilih minimal 1 kotak di Grid 5x5.")end
break
end
local _wv=getPlayerState()
local _ww,_wx=getPlayerTile()if not _ww then
 break
end
local _wy=(_wx~=wk_helper.y)or(not _wv)or(math.abs(_wv.x-(wk_helper.x+0.5))>0.38)if not autoFarm.Override and _wy then
 if _wx==wk_helper.y and math.abs(_ww-wk_helper.x)<=4 and DropRefs.walkToX then

local _wz=keyState.active keyState.active=true DropRefs.collecting=true DropRefs.walkToX(wk_helper.x+0.5,1.5)DropRefs.collecting=false keyState.active=_wz else
 ClickTP.To(wk_helper.x,wk_helper.y,function()return autoFarm.token~=_wj end,0.2,false)end
_ww,_wx=wk_helper.x,wk_helper.y
end
local _wA={}for _wB,_wC in ipairs(_wu)do

local _wD,_wE=wk_helper.x+_wC.dx,wk_helper.y+_wC.dy if inBounds(_wl,_wD,_wE)then
 table.insert(_wA,{x=_wD,y=_wE})
end
end
local _wF,_wG=false,false if _wn then
 autoFarm.stats.status="Place "..getItemName(_wp)
local _wH=getItemLayer(_wp)for _wI,_wJ in ipairs(_wA)do
 if not autoFarm.on or autoFarm.token~=_wj then
 break
end
local _wK=getTileAt(_wl,"fg",_wJ.x,_wJ.y)
local _wL=getTileAt(_wl,_wH,_wJ.x,_wJ.y)if _wL==0 and(_wH=="bg"or _wK==0)then
 if countInv(_wp)<=0 then
 _wG=true break
end
if placeTile(_wp,_wJ,wk_helper.facing)then
 autoFarm.stats.placed+=1 _wF=true task.wait(math.max(0.05,config.farmPlaceMs/1000))
end
end
end
end
if not autoFarm.on or autoFarm.token~=_wj then
 break
end
local _wM={}
local _wN={}if _wo then
 autoFarm.stats.status="Break ("..(_vx()and "Rayman"or("Multi "..config.farmMultiTarget))..")"
local _wO=math.clamp(math.floor(config.farmMultiTarget or 1),1,5)
local _wP,_wQ=1,{}while autoFarm.on and autoFarm.token==_wj and isAlive()do
 while#_wQ<_wO and _wP<=#_wA do

local _wR=_wA[_wP]_wP+=1 if _wc(_wl,_wR.x,_wR.y)then
 _wQ[#_wQ+1]={x=_wR.x,y=_wR.y,n=0}
local _wS=_wR.x..",".._wR.y if not _wN[_wS]then
 _wN[_wS]=true table.insert(_wM,{x=_wR.x,y=_wR.y})
end
end
end
if#_wQ==0 then
 break
end
local _wT,_wU=nil,nil if _wO>1 and _vx()then
 _wT,_wU=_vC(wk_helper.x,wk_helper.y,_wQ)
end
if not _wU then
 _wT={_wQ[1]}
end
local _wV=os.clock()if _wU then
 _vQ(_wU)
end
local _wW,_wX=false,false for _wY,_wZ in ipairs(_wT)do
 if not autoFarm.on or autoFarm.token~=_wj then
 break
end
if _wY>1 then
 task.wait(0.05)
end
local _xa=punchTile(_wZ.x,_wZ.y,config.farmBreakBg)_wZ.n+=1 if _xa then
 _wW,_wF=true,true
end
if _xa=="broke"then
 autoFarm.stats.broken+=1 _wX=true
end
if _xa==nil or _wZ.n>80 or not _wc(_wl,_wZ.x,_wZ.y)then
 _wZ.done=true end
_wZ.used=true
end
local _xb={}for _xc,_xd in ipairs(_wQ)do
 if not _xd.done and not _xd.used then
 _xb[#_xb+1]=_xd
end
end
for _xe,_xf in ipairs(_wT)do
 _xf.used=nil if not _xf.done then
 _xb[#_xb+1]=_xf
end
end
_wQ=_xb if _wW then

local _xg=math.max(0.04,config.farmDelay)if _wU then
 _xg=math.max(_xg,0.35)
end
local _xh=_xg-(os.clock()-_wV)if _xh>0.005 then
 task.wait(_xh)
end
end
if _wX and#_wQ>0 and config.farmAfterBreakMs>0 then
 task.wait(config.farmAfterBreakMs/1000)
end
end
end
if#_wM>0 and(config.farmTake or autoFarm.Override)and config.collectMode=="Legit"then
 autoFarm.stats.status="Bergerak ambil drop..."task.wait(0.18)if DropRefs.touchAll then
 DropRefs.touchAll(_wM,wk_helper.x,wk_helper.y)
end
end
if not _wF then
 if _wG then
 autoFarm.stats.status="Item "..getItemName(_wp).." habis"if not autoFarm.Quiet then
 notify("Auto Farm berhenti: "..getItemName(_wp).." habis di inventori.")webhook.Send("stop","Auto Farm berhenti: "..getItemName(_wp).." habis")end
break end
task.wait(math.max(0.1,config.farmDelay))end
autoFarm.stats.cycles+=1
end
end
_vv=_wi _vu=function()if not autoFarm.on then
 return false end
autoFarm.token=autoFarm.token+1 autoFarm.on=false clearKeys()keyState.active=false autoFarm.stats.status="Mati"if _sG then
 pcall(_sG)end
return true end
_vt=function()if autoFarm.on then
 return true
end
if autoClear.on then
 autoClear.Stop()
end
if autoHarvest.on then
 autoHarvest.Stop()
end
if autoDF.on then
 autoDF.Stop()
end
if autoSplice.on then
 autoSplice.Stop()
end
if autoPabrik.on then
 autoPabrik.Stop()
end
local _xi=config.farmMode~="Break saja"if _xi and(type(config.farmPlaceId)~="number"or config.farmPlaceId<=0)then
 notify("Pilih block dulu di tab Auto Farm.")return false
end
local _xj,_xk,_xl=getPlayerPos()if not _xj then
 notify("Posisi karakter belum terdeteksi.")return false
end
local _xm={x=math.floor(_xj),y=math.floor(_xk-0.475),facing=_xl,world=getWorldName(),}autoFarm.Override=nil autoFarm.Quiet=false autoFarm.token+=1
local _xn=autoFarm.token autoFarm.on=true autoFarm.stats.status="Berjalan"if _sG then
 pcall(_sG)end
task.spawn(function()
local _xo,_xp=pcall(_wi,_xn,_xm)clearKeys()keyState.active=false if not _xo then
 warn("[ANCHHub] Auto Farm error: "..tostring(_xp))
end
if autoFarm.token==_xn then
 autoFarm.on=false if autoFarm.stats.status=="Berjalan"then
 autoFarm.stats.status="Mati"
end
if _sG then
 pcall(_sG)
end
if spliceSetup then
 spliceSetup()
end
end
end)return true
end
end)()end
do
(function()
local _xq=3.5
local function _xr(_xs,_xt,_xu)
local _xv=getTileAt(_xs,"fg",_xt,_xu)if _xv==nil then
 return nil
end
if _xv~=0 then
 if isBreakable(_xv,_xt,_xu)then
 return "fg",_xv end
return nil
end
if config.clearIncludeBg then

local _xw=getTileAt(_xs,"bg",_xt,_xu)if _xw and _xw~=0 and isBreakable(_xw,_xt,_xu)then
 return "bg",_xw
end
end
return nil
end
local function _xx(_xy,_xz)
local _xA={}
local _xB=1 for _xC=0,_xy.h-1 do

local _xD={}for _xE=0,_xy.w-1 do

local _xF,_xG=_xr(_xy,_xE,_xC)if _xF then

local _xH=_xE..",".._xC if not _xz[_xH]then
 table.insert(_xD,{x=_xE,y=_xC,id=_xG,layer=_xF,key=_xH})
end
end
end
if#_xD>0 then
 if config.clearSweep=="Zig-zag"and _xB==-1 then
 table.sort(_xD,function(_xI,_xJ)return _xI.x>_xJ.x end)else
 table.sort(_xD,function(_xK,_xL)return _xK.x<_xL.x
end)end
for _xM,_xN in ipairs(_xD)do
 table.insert(_xA,_xN)
end
if config.clearSweep=="Zig-zag"then
 _xB=-_xB
end
end
end
return _xA
end
local function _xO(_xP,_xQ,_xR)
local _xS=_xR-1 if _xS>=0 and ClickTP.OpenAt(_xQ,_xS)then
 return _xQ,_xS,0.45
end
local _xT=math.max(1.8,getPunchRange()-0.35)return _xQ,_xR,_xT
end
local function _xU(_xV,_xW)setFlyModule("autoclear",false)clearKeys()keyState.active=false
local _xX={}
local _xY=0 while autoClear.on and autoClear.token==_xV and isAlive()do
 _xY+=1
local _xZ=getWorld()if not _xZ or getWorldName()~=_xW.world then
 autoClear.status="World berubah, berhenti"break end
autoClear.status="Scan objek di world..."autoClear.stats.pass=_xY
local _ya=_xx(_xZ,_xX)autoClear.stats.scanned=#_ya autoClear.stats.left=#_ya if#_ya==0 then
 break
end
if _xY==1 then

local _yb=_ya[1]notify(string.format("Auto Clear: %d blok ditemukan. Mulai dari (%d, %d).",#_ya,_yb.x,_yb.y))
end
local _yc=false
local _yd=getPunchRange()-0.15 for _ye,farmToken in ipairs(_ya)do
 if not autoClear.on or autoClear.token~=_xV or not isAlive()then
 return end
_xZ=getWorld()if not _xZ or getWorldName()~=_xW.world then
 return
end
local _yg,_yh=_xr(_xZ,farmToken.x,farmToken.y)if _yg then
 autoClear.stats.row=farmToken.y
local _yi=function()return not autoClear.on or autoClear.token~=_xV or not isAlive()
end
local _yj=getPlayerState()
local _yk,_yl=getPlayerTile()
local _ym=(_yk==farmToken.x and _yl==farmToken.y-1)or(_yj and ClickTP.StateReaches(_yj,farmToken.x,farmToken.y,_yd))
local _yn=true if not _ym then
 setFlyModule("autoclear",false)if _xZ and not _iy then
 _xZ.ghost=false
end
local _yo=os.clock()while isAlive()and not _yi()and(os.clock()-_yo)<0.45 do

local _yp=getPlayerState()if _yp and _yp.grounded then
 break end
task.wait(0.03)
end
local _yq,_yr,_ys=_xO(_xZ,farmToken.x,farmToken.y)autoClear.status=string.format("Jalan ke (%d,%d) [%d/%d]",farmToken.x,farmToken.y,_ye,#_ya)_yk,_yl=getPlayerTile()if _yl and _yr<_yl and _yk and math.abs(_yk-_yq)<=2 then
 ClickTP.ClimbUpWithDirt(_yq,_yr,_yi,true,config.clearTpDelay,true)end
_yj=getPlayerState()_yk,_yl=getPlayerTile()_ym=(_yk==farmToken.x and _yl==farmToken.y-1)or(_yj and ClickTP.StateReaches(_yj,farmToken.x,farmToken.y,_yd))if not _ym then
 _yn=ClickTP.LegitTo(_yq,_yr,_yi,_ys,true)if not _yn and _ys<1.5 then
 _yn=ClickTP.LegitTo(farmToken.x,farmToken.y,_yi,math.max(1.8,_yd),true)
end
end
end
local _yt=getPlayerState()
local _yu,_yv=getPlayerTile()
local _yw=_yn and((_yu==farmToken.x and _yv==farmToken.y-1)or(_yt and ClickTP.StateReaches(_yt,farmToken.x,farmToken.y,_yd+0.35)))if not _yw then
 _xX[farmToken.key]=true autoClear.stats.skipped+=1 autoClear.stats.left=math.max(0,autoClear.stats.left-1)autoClear.status=string.format("Skip (%d,%d) belum terjangkau",farmToken.x,farmToken.y)else
 setFlyModule("autoclear",true)_xZ.ghost=true clearKeys()
local _yx=os.clock()
local _yy=false while autoClear.on and autoClear.token==_xV and isAlive()do
 _xZ.ghost=true
local _yz,_yA=_xr(_xZ,farmToken.x,farmToken.y)if not _yz then
 break
end
if os.clock()-_yx>=_xq then
 _yy=true break end
autoClear.status=string.format("Break %s (%d,%d) [%d/%d]",getItemName(_yA),farmToken.x,farmToken.y,_ye,#_ya)
local _yB=punchTile(farmToken.x,farmToken.y,config.clearIncludeBg)if _yB==nil then
 _yy=true break elseif _yB=="broke"then
 _yc=true autoClear.stats.broken+=1 _yx=os.clock()end
task.wait(math.max(0.04,config.clearBreakDelay))
end
if not _xr(_xZ,farmToken.x,farmToken.y)then
 autoClear.stats.left=math.max(0,autoClear.stats.left-1)elseif _yy then
 _xX[farmToken.key]=true autoClear.stats.skipped+=1 autoClear.stats.left=math.max(0,autoClear.stats.left-1)autoClear.status=string.format("Skip (%d,%d) tidak bisa hancur",farmToken.x,farmToken.y)
end
end
else
 autoClear.stats.left=math.max(0,autoClear.stats.left-1)
end
end
if not _yc then
 break end
table.clear(_xX)end
setFlyModule("autoclear",false)clearKeys()keyState.active=false autoClear.status="Selesai"
local _yC=string.format("Auto Clear selesai! Hancur: %d | Diambil: %d | Skip: %d",autoClear.stats.broken,autoClear.stats.picked,autoClear.stats.skipped)notify(_yC)webhook.Send("stop",_yC)
end
function autoClear.Stop()if not autoClear.on then
 return false end
autoClear.token+=1 autoClear.on=false setFlyModule("autoclear",false)clearKeys()keyState.active=false autoClear.status="Mati"return true
end
function autoClear.Start()if autoClear.on then
 return true
end
if autoFarm.on then
 _vu()
end
if autoHarvest.on then
 autoHarvest.Stop()
end
if autoDF.on then
 autoDF.Stop()
end
if autoSplice.on then
 autoSplice.Stop()
end
if autoPabrik.on then
 autoPabrik.Stop()
end
local _yD,_yE=getPlayerPos()if not _yD then
 notify("Posisi belum terdeteksi.");return false
end
local _yF={x=math.floor(_yD),y=math.floor(_yE-0.475),world=getWorldName()}autoClear.token+=1
local _yG=autoClear.token autoClear.on=true autoClear.status="Mulai"autoClear.stats={scanned=0,broken=0,picked=0,skipped=0,left=0,pass=0,row=-1}task.spawn(function()
local _yH,_yI=pcall(_xU,_yG,_yF)if not _yH then
 warn("[ANCHHub] Auto Clear error: "..tostring(_yI))end
setFlyModule("autoclear",false)clearKeys()keyState.active=false if autoClear.token==_yG then
 autoClear.on=false if autoClear.status~="Selesai"then
 autoClear.status="Mati"
end
if spliceSetup then
 spliceSetup()
end
end
end)return true
end
end)()end
do
(function()
local function _yJ(_yK,_yL)if config.harvestModFly then
 setFlyModule("autoharvest",true)
end
local _yM={}
local _yN=0 while autoHarvest.on and autoHarvest.token==_yK and isAlive()do
 _yN+=1
local _yO=getWorld()if not _yO or getWorldName()~=_yL.world then
 autoHarvest.status="World berubah, berhenti"break end
autoHarvest.status="Scan pohon & lahan tanam..."
local _yP={}
local _yQ={}
local _yR=0
local _yS=0
local _yT=config.harvestDoPlant and config.harvestSeedId and countInv(config.harvestSeedId)>0
local _yU=1 for _yV=0,_yO.h-1 do

local _yW,_yX={},{}for _yY=0,_yO.w-1 do

local _yZ=getTileAt(_yO,"fg",_yY,_yV)or 0 if _yZ~=0 and _sT(_yZ)then
 _yR=_yR+1 if config.harvestDoHarvest and not _yM[_yY..",".._yV]then
 if _tg(_yO,_yY,_yV,_yZ)then
 table.insert(_yW,{x=_yY,y=_yV,id=_yZ})else
 _yS=_yS+1
end
end
elseif _yT and _yZ==0 and _tm(_yO,_yY,_yV,config.harvestSeedId)then
 table.insert(_yX,{x=_yY,y=_yV})
end
end
if#_yW>0 or#_yX>0 then
 if _yU==-1 then
 table.sort(_yW,function(_za,_zb)return _za.x>_zb.x end)table.sort(_yX,function(_zc,_zd)return _zc.x>_zd.x end)else
 table.sort(_yW,function(_ze,_zf)return _ze.x<_zf.x end)table.sort(_yX,function(_zg,_zh)return _zg.x<_zh.x
end)end
for _zi,_zj in ipairs(_yW)do
 table.insert(_yP,_zj)
end
for _zk,_zl in ipairs(_yX)do
 table.insert(_yQ,_zl)end
_yU=-_yU
end
end
autoHarvest.stats.totalTrees=_yR autoHarvest.stats.ready=#_yP if _yN==1 then
 autoHarvest.stats.skipped=_yS notify(string.format(("Farmer Scan: %d pohon (%d siap panen, %d belum siap) | %d lahan kosong."),_yR,#_yP,_yS,#_yQ))
end
if#_yP==0 and#_yQ==0 then
 break
end
local _zm=false
local _zn=math.min(getPunchRange(),getBuildRange())-0.15 for _zo,zp_farmVar in ipairs(_yP)do
 if not autoHarvest.on or autoHarvest.token~=_yK or not isAlive()then
 return end
_yO=getWorld()if not _yO or getWorldName()~=_yL.world then
 return
end
if getTileAt(_yO,"fg",zp_farmVar.x,zp_farmVar.y)==zp_farmVar.id then

local _zq=getPlayerState()if not(_zq and ClickTP.StateReaches(_zq,zp_farmVar.x,zp_farmVar.y,_zn))then
 autoHarvest.status=string.format("Jalan Zig-Zag ke pohon (%d,%d) [%d/%d]",zp_farmVar.x,zp_farmVar.y,_zo,#_yP)
local _zr=ClickTP.To(zp_farmVar.x,zp_farmVar.y,function()return autoHarvest.token~=_yK or not autoHarvest.on end,_zn,config.harvestUseBlock)if not _zr then
 _yM[zp_farmVar.x..","..zp_farmVar.y]=true autoHarvest.stats.skipped=autoHarvest.stats.skipped+1 end
task.wait(math.max(0.10,config.harvestTpDelay))
end
local _zs=getPlayerState()if _zs and ClickTP.StateReaches(_zs,zp_farmVar.x,zp_farmVar.y,_zn+0.5)then
 autoHarvest.status=string.format("Panen %s (%d,%d) [%d/%d]",getItemName(zp_farmVar.id),zp_farmVar.x,zp_farmVar.y,_zo,#_yP)
local _zt=os.clock()while autoHarvest.on and autoHarvest.token==_yK and getTileAt(_yO,"fg",zp_farmVar.x,zp_farmVar.y)==zp_farmVar.id and os.clock()-_zt<3.5 do
 punchTile(zp_farmVar.x,zp_farmVar.y,false)task.wait(math.max(0.05,config.harvestDelay))
end
if getTileAt(_yO,"fg",zp_farmVar.x,zp_farmVar.y)~=zp_farmVar.id then
 _zm=true autoHarvest.stats.harvested=autoHarvest.stats.harvested+1 stats.Harvested=stats.Harvested+1 autoHarvest.stats.ready=math.max(0,autoHarvest.stats.ready-1)if config.harvestDoPlant and config.harvestSeedId and countInv(config.harvestSeedId)>0 and _tm(_yO,zp_farmVar.x,zp_farmVar.y,config.harvestSeedId)then
 task.wait(0.08)if placeTile(config.harvestSeedId,{x=zp_farmVar.x,y=zp_farmVar.y},1)then
 autoHarvest.stats.planted=autoHarvest.stats.planted+1 stats.Planted=stats.Planted+1 task.wait(math.max(0.05,config.harvestPlantDelay))
end
end
else
 _yM[zp_farmVar.x..","..zp_farmVar.y]=true autoHarvest.stats.skipped=autoHarvest.stats.skipped+1
end
end
end
end
if config.harvestDoPlant and config.harvestSeedId and countInv(config.harvestSeedId)>0 then
 for _zu,_zv in ipairs(_yQ)do
 if not autoHarvest.on or autoHarvest.token~=_yK or not isAlive()then
 return
end
if countInv(config.harvestSeedId)<=0 then
 break end
_yO=getWorld()if not _yO or getWorldName()~=_yL.world then
 return
end
if _tm(_yO,_zv.x,_zv.y,config.harvestSeedId)then

local _zw=getPlayerState()if not(_zw and ClickTP.StateReaches(_zw,_zv.x,_zv.y,_zn))then
 autoHarvest.status=string.format("Jalan Zig-Zag ke tanam (%d,%d) [%d/%d]",_zv.x,_zv.y,_zu,#_yQ)ClickTP.To(_zv.x,_zv.y,function()return autoHarvest.token~=_yK or not autoHarvest.on end,_zn,config.harvestUseBlock)task.wait(math.max(0.10,config.harvestTpDelay))
end
local _zx=getPlayerState()if _zx and ClickTP.StateReaches(_zx,_zv.x,_zv.y,_zn+0.5)and _tm(_yO,_zv.x,_zv.y,config.harvestSeedId)then
 if placeTile(config.harvestSeedId,_zv,1)then
 _zm=true autoHarvest.stats.planted=autoHarvest.stats.planted+1 stats.Planted=stats.Planted+1 autoHarvest.status=string.format("Tanam %s (%d,%d)",getItemName(config.harvestSeedId),_zv.x,_zv.y)task.wait(math.max(0.05,config.harvestPlantDelay))
end
end
end
end
end
if not _zm then
 break
end
end
setFlyModule("autoharvest",false)clearKeys()keyState.active=false autoHarvest.status="Selesai"
local _zy=string.format("Farmer selesai! Panen: %d | Tanam: %d | Drop: %d",autoHarvest.stats.harvested,autoHarvest.stats.planted,autoHarvest.stats.picked)notify(_zy)webhook.Send("stop",_zy)
end
function autoHarvest.Stop()if not autoHarvest.on then
 return false end
autoHarvest.token+=1 autoHarvest.on=false setFlyModule("autoharvest",false)clearKeys()keyState.active=false autoHarvest.status="Mati"return true
end
function autoHarvest.Start()if autoHarvest.on then
 return true
end
if autoFarm.on then
 _vu()
end
if autoClear.on then
 autoClear.Stop()
end
if autoDF.on then
 autoDF.Stop()
end
if autoSplice.on then
 autoSplice.Stop()
end
if autoPabrik.on then
 autoPabrik.Stop()
end
local _zz,_zA=getPlayerPos()if not _zz then
 notify("Posisi belum terdeteksi.");return false
end
local _zB={x=math.floor(_zz),y=math.floor(_zA-0.475),world=getWorldName()}autoHarvest.token+=1
local _zC=autoHarvest.token autoHarvest.on=true autoHarvest.status="Mulai"autoHarvest.stats={totalTrees=0,ready=0,harvested=0,planted=0,skipped=0,picked=0}task.spawn(function()
local _zD,_zE=pcall(_yJ,_zC,_zB)if not _zD then
 warn("[ANCHHub] Farmer error: "..tostring(_zE))end
setFlyModule("autoharvest",false)clearKeys()keyState.active=false if autoHarvest.token==_zC then
 autoHarvest.on=false if autoHarvest.status~="Selesai"then
 autoHarvest.status="Mati"
end
if spliceSetup then
 spliceSetup()
end
end
end)return true
end
end)()end
do
(function()
local _zF=5.0
local function _zG(_zH)
local _zI=ItemDB and ItemDB[_zH]return type(_zI)=="table"and type(_zI.name)=="string"and _zI.name:lower():find("bedrock",1,true)~=nil
end
local function _zJ(_zK)
local _zL=getDirtId()
local _zM,_zN=nil,nil for _zO=0,_zK.h-1 do

local _zP,_zQ=0,0 for _zR=0,_zK.w-1 do

local _zS=getTileAt(_zK,"fg",_zR,_zO)or 0 if _zS~=0 then
 if _zG(_zS)then
 _zQ+=1 elseif _zS==_zL or isBreakable(_zS)then
 _zP+=1
end
end
end
if not _zM and _zP>=math.floor(_zK.w*0.25)then
 _zM=_zO
end
if _zM and _zO>_zM and _zQ>=math.floor(_zK.w*0.4)then
 _zN=_zO break
end
end
if not _zM then
 _zM=(typeof(_zK.spawn)=="Vector2")and(math.floor(_zK.spawn.Y)+1)or 37
end
if not _zN then
 _zN=_zK.h-6 end
return _zM,_zN
end
local function _zT(_zU,_zV,_zW)
local _zX=function()return autoDF.token~=_zW or not autoDF.on or not isAlive()
end
local _zY,_zZ=getPlayerTile()if not _zY or(_zY==_zU and _zZ==_zV)then
 return true
end
if config.moveMethod=="Teleport Mode"then
 return ClickTP.FlyTo(_zU,_zV,_zX,config.dfTpDelay,false)
end
if _zZ==_zV and math.abs(_zY-_zU)<=2 then
 if ClickTP.ExecWalk(_zU,_zV,_zX)then
 return true end
elseif _zZ and _zV<_zZ and math.abs(_zY-_zU)<=1 then
 if ClickTP.ClimbUpWithDirt(_zU,_zV,_zX,true,config.dfTpDelay,true)then
 return true
end
end
if ClickTP.To(_zU,_zV,_zX,0.3,true)then
 return true end
return ClickTP.FlyTo(_zU,_zV,_zX,config.dfTpDelay,false)
end
local function _Aa(_Ab,_Ac,_Ad,_Ae,_Af,_Ag)if not inBounds(_Ab,_Ac,_Ad)then
 return false
end
local _Ah=getTileAt(_Ab,"fg",_Ac,_Ad)or 0
local _Ai=getTileAt(_Ab,"bg",_Ac,_Ad)or 0 if(_Ah==0 or not isBreakable(_Ah))and(_Ai==0 or not isBreakable(_Ai))then
 return true end
_zT(_Ae,_Af,_Ag)
local _Aj=os.clock()while autoDF.on and autoDF.token==_Ag and isAlive()do

local _Ak=getTileAt(_Ab,"fg",_Ac,_Ad)or 0
local _Al=getTileAt(_Ab,"bg",_Ac,_Ad)or 0
local _Am=_Ak~=0 and isBreakable(_Ak)
local _An=_Al~=0 and isBreakable(_Al)if config.dfModFly then
 _Ab.ghost=true
end
if not _Am and not _An then
 break
end
if os.clock()-_Aj>=_zF then
 break
end
local _Ao=punchTile(_Ac,_Ad,true)if _Ao=="broke"then
 autoDF.stats.broken+=1 _Aj=os.clock()end
task.wait(math.max(0.04,config.dfBreakDelay))end
return true
end
local function _Ap(_Aq,_Ar)
local _As=DropRefs.list if not _As then
 GameRefs.Scan();_As=DropRefs.list
end
if type(_As)~="table"then
 return nil
end
local _At,_Au=getPlayerTile()_At,_Au=_At or 50,_Au or 30
local _Av,_Aw=nil,math.huge for _Ax,_Ay in ipairs(_As)do
 if type(_Ay)=="table"and(_Ay.id==_Aq or _Ay.id==_Ar)and(_Ay.n or 0)>0 and type(_Ay.x)=="number"then

local _Az=math.abs(_Ay.x-_At)+math.abs(_Ay.y-_Au)if _Az<_Aw then
 _Av,_Aw=_Ay,_Az
end
end
end
return _Av
end
local function _AA(_AB,_AC,_AD,_AE)
local _AF=getDirtId()
local _AG=getDirtSeedId()
local _AH=_AC-1 if _AH<0 then
 return false
end
local _AI={}
local _AJ=0 for _AK=3,_AB.w-4 do
 if not autoDF.on or autoDF.token~=_AD then
 break
end
if countInv(_AG)<=0 or _AJ>=(_AE or 20)then
 break
end
if(getTileAt(_AB,"fg",_AK,_AC)or 0)==_AF and(getTileAt(_AB,"fg",_AK,_AH)or 0)==0 then
 _zT(_AK,_AH,_AD)if placeTile(_AG,{x=_AK,y=_AH},1)then
 stats.Planted+=1 table.insert(_AI,{x=_AK,y=_AH,plantedTime=os.clock()})_AJ+=1 task.wait(0.18)
end
end
end
for _AL=2,_AB.w-3 do
 if(getTileAt(_AB,"fg",_AL,_AH)or 0)==_AG then

local _AM=false for _AN,_AO in ipairs(_AI)do
 if _AO.x==_AL and _AO.y==_AH then
 _AM=true;break
end
end
if not _AM then
 table.insert(_AI,{x=_AL,y=_AH,plantedTime=os.clock()-25})
end
end
end
if#_AI==0 then
 return false
end
local _AP=ItemDB[_AG]
local _AQ=(_AP and(tonumber(_AP.grow)or tonumber(_AP.baseGrow)))or 31 for _AR,_AS in ipairs(_AI)do
 if not autoDF.on or autoDF.token~=_AD then
 return false
end
while autoDF.on and autoDF.token==_AD and isAlive()do
 if(getTileAt(_AB,"fg",_AS.x,_AS.y)or 0)~=_AG then
 break
end
local _AT=os.clock()-_AS.plantedTime if _tg(_AB,_AS.x,_AS.y,_AG)or _AT>=(_AQ+1.5)then
 break
end
local _AU=math.max(0,math.ceil(_AQ-_AT))autoDF.status=string.format("Menunggu Dirt Tree matang (%ds) [%d/%d]...",_AU,_AR,#_AI)task.wait(0.5)
end
if(getTileAt(_AB,"fg",_AS.x,_AS.y)or 0)==_AG then
 autoDF.status=string.format("Harvest Dirt Tree (%d,%d) [%d/%d]",_AS.x,_AS.y,_AR,#_AI)_zT(_AS.x,_AS.y,_AD)
local _AV=os.clock()while autoDF.on and autoDF.token==_AD and(getTileAt(_AB,"fg",_AS.x,_AS.y)or 0)==_AG and os.clock()-_AV<3.5 do

local _AW=punchTile(_AS.x,_AS.y,false)if _AW=="broke"then
 stats.Harvested+=1 end
task.wait(math.max(0.05,config.dfBreakDelay))end
task.wait(0.25)
end
end
return true
end
local function _AX(_AY,_AZ,_Ba)
local _Bb=getDirtId()for _Bc=_AZ,_Ba-1,2 do

local _Bd=0 for _Be=3,_AY.w-4 do
 if(getTileAt(_AY,"fg",_Be,_Bc)or 0)==_Bb and(getTileAt(_AY,"fg",_Be,_Bc-1)or 0)==0 then
 _Bd+=1 if _Bd>=12 then
 return _Bc
end
end
end
end
return _AZ
end
local function _Bf(_Bg,_Bh,_Bi,_Bj,_Bk,_Bl,_Bm)
local _Bn=getDirtId()
local _Bo=getDirtSeedId()if countInv(_Bn)>0 then
 return true end
autoDF.stats.step="Restock Dirt"
local _Bp=_AX(_Bg,_Bk,_Bl)while autoDF.on and autoDF.token==_Bm and isAlive()and countInv(_Bn)<15 do
 if countInv(_Bo)>0 then
 autoDF.status="Stok Dirt habis! Menanam & memanen Dirt Seed..."_AA(_Bg,_Bp,_Bm,20)if countInv(_Bn)>=15 then
 break
end
end
local _Bq=_Ap(_Bn,_Bo)if _Bq then

local _Br,_Bs=math.floor(_Bq.x),math.floor(_Bq.y)autoDF.status=string.format("Mengambil drop Dirt/Seed di (%d, %d)...",_Br,_Bs)_zT(_Br,_Bs,_Bm)task.wait(0.5)if countInv(_Bn)>=15 then
 break
end
if countInv(_Bo)>0 then
 _AA(_Bg,_Bp,_Bm,20)if countInv(_Bn)>=15 then
 break
end
end
end
if countInv(_Bn)==0 and countInv(_Bo)==0 then
 autoDF.status="Break Dirt di world untuk mencari Seed..."
local _Bt={}for _Bu=4,_Bg.w-5 do
 if not autoDF.on or autoDF.token~=_Bm then
 break
end
if#_Bt>=14 or countInv(_Bo)>=6 then
 break
end
if(getTileAt(_Bg,"fg",_Bu,_Bp)or 0)==_Bn and(getTileAt(_Bg,"fg",_Bu-1,_Bp)or 0)==_Bn then

local _Bv,_Bw=_Bu-1,_Bp-1 _zT(_Bv,_Bw,_Bm)_Aa(_Bg,_Bu,_Bp,_Bv,_Bw,_Bm)if(getTileAt(_Bg,"fg",_Bu,_Bp)or 0)==0 then
 table.insert(_Bt,{x=_Bu,y=_Bp,standX=_Bv,standY=_Bw})end
task.wait(0.2)
end
end
if countInv(_Bo)>0 then
 _AA(_Bg,_Bp,_Bm,20)
end
for _Bx,_By in ipairs(_Bt)do
 if not autoDF.on or autoDF.token~=_Bm then
 break
end
while autoDF.on and autoDF.token==_Bm and countInv(_Bn)==0 and countInv(_Bo)>0 do
 _AA(_Bg,_Bp,_Bm,15)
end
if(getTileAt(_Bg,"fg",_By.x,_By.y)or 0)==0 and countInv(_Bn)>0 then
 _zT(_By.standX,_By.standY,_Bm)if placeTile(_Bn,{x=_By.x,y=_By.y},1)then
 autoDF.stats.placed+=1 task.wait(0.14)
end
end
end
elseif countInv(_Bn)>0 and countInv(_Bn)<15 and countInv(_Bo)==0 then

local _Bz=5
local _BA,_BB=4,_Bp-1 _zT(_BA,_BB,_Bm)while autoDF.on and autoDF.token==_Bm and countInv(_Bo)<4 and countInv(_Bn)>0 do
 if(getTileAt(_Bg,"fg",_Bz,_BB)or 0)==0 then
 placeTile(_Bn,{x=_Bz,y=_BB},1)task.wait(cooldownTime)end
_Aa(_Bg,_Bz,_BB,_BA,_BB,_Bm)task.wait(0.2)end
else
 break
end
end
if _Bh and _Bi then
 _zT(_Bh,_Bi,_Bm)end
return countInv(_Bn)>0
end
local function _BC(_BD,_BE,_BF,_BG,_BH,_BI,_BJ,_BK)if not inBounds(_BD,_BE,_BF)then
 return
end
local _BL=getDirtId()
local _BM=getTileAt(_BD,"fg",_BE,_BF)or 0 if _BM==_BL then
 return
end
if _BM~=0 and not isBreakable(_BM)then
 return end
_zT(_BG,_BH,_BK)if _BM~=0 and _BM~=_BL then

local _BN=os.clock()while autoDF.on and autoDF.token==_BK and(getTileAt(_BD,"fg",_BE,_BF)or 0)~=0 and os.clock()-_BN<_zF do

local _BO=punchTile(_BE,_BF,false)if _BO=="broke"then
 autoDF.stats.broken+=1 end
task.wait(math.max(0.04,config.dfBreakDelay))
end
end
if autoDF.on and autoDF.token==_BK and(getTileAt(_BD,"fg",_BE,_BF)or 0)==0 then
 if countInv(_BL)<=0 then
 _Bf(_BD,_BG,_BH,_BF,_BI,_BJ,_BK)
end
if countInv(_BL)>0 then
 if placeTile(_BL,{x=_BE,y=_BF},(_BE>=_BG)and 1 or-1)then
 autoDF.stats.placed+=1 task.wait(0.14)
end
end
end
end
local function _BP(_BQ,_BR,_BS,_BT,_BU)for _BV=_BT,_BU-1 do

local _BW,_BX=getTileAt(_BQ,"fg",_BR,_BV)or 0,getTileAt(_BQ,"bg",_BR,_BV)or 0
local _BY,_BZ=getTileAt(_BQ,"fg",_BS,_BV)or 0,getTileAt(_BQ,"bg",_BS,_BV)or 0 if _zG(_BW)and _zG(_BY)then
 break
end
if(_BW~=0 and isBreakable(_BW))or(_BX~=0 and isBreakable(_BX))or(_BY~=0 and isBreakable(_BY))or(_BZ~=0 and isBreakable(_BZ))then
 return _BV
end
end
return nil
end
local function _Ca(_Cb,_Cc,_Cd,_Ce,_Cf,_Cg,_Ch)
local _Ci=_BP(_Cb,_Cc,_Cd,_Ce,_Cf)if not _Ci then
 autoDF.status="Kolom vertikal ".._Cg.." sudah bersih, lanjut..."return true end
autoDF.stats.step="Clear Vertikal ".._Cg
local _Cj=math.max(0,_Ci-1)autoDF.status=string.format("Lanjut vertikal %s dari Y=%d...",_Cg,_Ci)_zT(_Cd,_Cj,_Ch)task.wait(math.max(0.20,config.dfTpDelay))
local _Ck=_Cj for _Cl=_Ci,_Cf-1 do
 if not autoDF.on or autoDF.token~=_Ch or not isAlive()then
 return false end
_Cb=getWorld()if not _Cb then
 return false
end
if _zG(getTileAt(_Cb,"fg",_Cc,_Cl))and _zG(getTileAt(_Cb,"fg",_Cd,_Cl))then
 break
end
local _Cm=math.max(0,_Cl-1)autoDF.status=string.format("Vertikal %s: Break Y=%d",_Cg,_Cl)_Aa(_Cb,_Cc,_Cl,_Cd,_Cm,_Ch)if not autoDF.on or autoDF.token~=_Ch then
 return false end
_Aa(_Cb,_Cd,_Cl,_Cd,_Cm,_Ch)_Ck=_Cm
end
if autoDF.on and autoDF.token==_Ch and _Ck>math.max(0,_Ce-1)then
 autoDF.status=string.format("Naik kembali dari ujung %s...",_Cg)ClickTP.ClimbUpWithDirt(_Cd,math.max(0,_Ce-1),function()return autoDF.token~=_Ch end,true,config.dfTpDelay,true)end
return true
end
local function _Cn(_Co,_Cp,_Cq,_Cr)
local _Cs=getDirtId()
local _Ct=_Cp-1
local _Cu=_Cp+1 for _Cv=2,_Co.w-3 do

local _Cw=getTileAt(_Co,"fg",_Cv,_Cp)or 0
local _Cx=getTileAt(_Co,"bg",_Cv,_Cp)or 0 if(_Cw~=0 and isBreakable(_Cw))or(_Cx~=0 and isBreakable(_Cx))then
 return false
end
if config.dfReplacePlatform then
 if _Ct>=_Cq and(getTileAt(_Co,"fg",_Cv,_Ct)or 0)~=_Cs then
 return false
end
if _Cu<_Cr and(getTileAt(_Co,"fg",_Cv,_Cu)or 0)~=_Cs then
 return false
end
end
end
return true
end
local function _Cy(_Cz,_CA)
local _CB=getDirtId()
local _CC=_CA-1 for _CD=2,_Cz.w-3 do
 if(getTileAt(_Cz,"fg",_CD,_CA)or 0)~=_CB then
 return false
end
if(getTileAt(_Cz,"fg",_CD,_CC)or 0)~=0 then
 return false
end
end
return true
end
local function _CE(cf_module,_CG)
local _CH=godOn if not _CH and StartGod then
 pcall(StartGod)end
setFlyModule("autodf",config.dfModFly)
local ci_module=getWorld()if not ci_module then
 return
end
local cj_module,_CK=_zJ(ci_module)autoDF.stats.topDirtY=cj_module autoDF.stats.bedrockY=_CK notify(string.format(("Auto DF Scan: Melanjutkan progres Dirt Farm (Dirt Y=%d, Bedrock Y=%d)."),cj_module,_CK))
local _CL=ci_module.w if not _Ca(ci_module,0,1,cj_module,_CK,"Kiri (1-2)",cf_module)then
 return
end
if not autoDF.on or autoDF.token~=cf_module then
 return
end
if not _Ca(ci_module,_CL-2,_CL-1,cj_module,_CK,"Kanan (99-100)",cf_module)then
 return
end
if not autoDF.on or autoDF.token~=cf_module then
 return
end
local _CM=false for _CN=cj_module+1,_CK-1,2 do
 if not autoDF.on or autoDF.token~=cf_module or not isAlive()then
 return end
ci_module=getWorld()if not ci_module or getWorldName()~=_CG.world then
 return
end
if _Cn(ci_module,_CN,cj_module,_CK)then
 autoDF.status=string.format("Baris Y=%d sudah selesai, lanjut ke baris berikutnya...",_CN)else

local _CO=_CN-1
local _CP=_CN+1 autoDF.stats.step=string.format("Bawah: Baris Y=%d",_CN)
local _CQ=_CM and 2 or(_CL-3)
local _CR=_CM and(_CL-3)or 2
local _CS=_CM and 1 or-1
local _CT=_CM and 1 or(_CL-2)_zT(_CT,_CN,cf_module)for _CU=_CQ,_CR,_CS do
 if not autoDF.on or autoDF.token~=cf_module or not isAlive()then
 return end
ci_module=getWorld()if not ci_module or getWorldName()~=_CG.world then
 return
end
local _CV=_CU-_CS
local _CW=_CN if config.dfReplacePlatform and _CP<_CK then
 _BC(ci_module,_CV,_CP,_CV,_CW,cj_module,_CK,cf_module)
end
if config.dfReplacePlatform and _CO>=cj_module then
 _BC(ci_module,_CV,_CO,_CV,_CW,cj_module,_CK,cf_module)end
autoDF.status=string.format("Bawah Y=%d | Break (%d,%d)",_CN,_CU,_CN)_Aa(ci_module,_CU,_CN,_CV,_CW,cf_module)if config.dfReplacePlatform then
 if _CO>=cj_module then
 _BC(ci_module,_CU,_CO,_CV,_CW,cj_module,_CK,cf_module)
end
if _CP<_CK then
 _BC(ci_module,_CU,_CP,_CV,_CW,cj_module,_CK,cf_module)
end
end
_zT(_CU,_CN,cf_module)end
_CM=not _CM
end
end
for _CX=2,_CL-3 do
 if not autoDF.on or autoDF.token~=cf_module then
 return
end
if(getTileAt(ci_module,"fg",_CX,cj_module)or 0)~=getDirtId()then
 _BC(ci_module,_CX,cj_module,_CX,cj_module-1,cj_module,_CK,cf_module)
end
end
local _CY=true for _CZ=cj_module-2,2,-2 do
 if not autoDF.on or autoDF.token~=cf_module or not isAlive()then
 return end
ci_module=getWorld()if not ci_module or getWorldName()~=_CG.world then
 return
end
if _Cy(ci_module,_CZ)then
 autoDF.status=string.format("Platform Atas Y=%d sudah selesai, skip...",_CZ)else

local _Da=_CZ-1 autoDF.stats.step=string.format("Atas: Platform Y=%d",_CZ)
local _Db=_CY and 2 or(_CL-3)
local _Dc=_CY and(_CL-3)or 2
local _Dd=_CY and 1 or-1
local _De=_CZ+1 _zT(_Db,_De,cf_module)_BC(ci_module,_Db,_CZ,_Db,_De,cj_module,_CK,cf_module)
local _Df=_CY and 1 or(_CL-2)ClickTP.ClimbUpWithDirt(_Df,_Da,function()return autoDF.token~=cf_module end,true,config.dfTpDelay,true)_zT(_Db,_Da,cf_module)for _Dg=_Db+_Dd,_Dc,_Dd do
 if not autoDF.on or autoDF.token~=cf_module or not isAlive()then
 return end
ci_module=getWorld()if not ci_module or getWorldName()~=_CG.world then
 return
end
local _Dh=_Dg-_Dd if(getTileAt(ci_module,"fg",_Dg,_Da)or 0)~=0 or(getTileAt(ci_module,"bg",_Dg,_Da)or 0)~=0 then
 _Aa(ci_module,_Dg,_Da,_Dh,_Da,cf_module)end
autoDF.status=string.format("Atas Y=%d | Pasang Dirt (%d,%d)",_CZ,_Dg,_CZ)_BC(ci_module,_Dg,_CZ,_Dh,_Da,cj_module,_CK,cf_module)_zT(_Dg,_Da,cf_module)end
_CY=not _CY
end
end
if not _CH and StopGod then
 pcall(StopGod)end
setFlyModule("autodf",false)clearKeys()keyState.active=false autoDF.stats.step="Selesai"autoDF.status="Selesai"
local _Di=string.format(("Full World Dirt Farm selesai! Hancur: %d | Dirt dipasang: %d | Drop: %d"),autoDF.stats.broken,autoDF.stats.placed,autoDF.stats.picked)notify(_Di)webhook.Send("pabrik",_Di)
end
function autoDF.Stop()if not autoDF.on then
 return false end
autoDF.token+=1 autoDF.on=false setFlyModule("autodf",false)clearKeys()keyState.active=false autoDF.status="Mati"autoDF.stats.step="-"return true
end
function autoDF.Start()if autoDF.on then
 return true
end
if autoFarm.on then
 _vu()
end
if autoClear.on then
 autoClear.Stop()
end
if autoHarvest.on then
 autoHarvest.Stop()
end
if autoSplice.on then
 autoSplice.Stop()
end
if autoPabrik.on then
 autoPabrik.Stop()
end
local _Dj,_Dk=getPlayerPos()if not _Dj then
 notify("Posisi belum terdeteksi.");return false
end
local _Dl={x=math.floor(_Dj),y=math.floor(_Dk-0.475),world=getWorldName()}autoDF.token+=1
local _Dm=autoDF.token autoDF.on=true autoDF.status="Mulai"autoDF.stats={topDirtY=0,bedrockY=0,broken=0,placed=0,picked=0,step="Inisialisasi"}task.spawn(function()
local _Dn,_Do=pcall(_CE,_Dm,_Dl)if not _Dn then
 warn("[ANCHHub] Auto DF error: "..tostring(_Do))end
setFlyModule("autodf",false)clearKeys()keyState.active=false if autoDF.token==_Dm then
 autoDF.on=false if autoDF.status~="Selesai"then
 autoDF.status="Mati"
end
if spliceSetup then
 spliceSetup()
end
end
end)return true
end
end)()end
do
(function()function autoSplice.Result(_Dp,_Dq)if not(_bh and type(_bi)=="table"and type(_bi.result)=="function")then
 return nil
end
if not(_Dp and _Dq)then
 return nil
end
local _Dr,_Ds=pcall(_bi.result,_Dp,_Dq)return _Dr and _Ds or nil
end
function autoSplice.ResultText()
local _Dt,_Du=config.spliceA,config.spliceB if not(_Dt and _Du)then
 return "Pilih Seed A dan Seed B"
end
local _Dv=autoSplice.Result(_Dt,_Du)if not _Dv then
 return "Hasil: Kombinasi ini tidak bisa di-splice"end
return "Hasil Splice: "..getItemName(_Dv).." ["..tostring(_Dv).."]"
end
local function _Dw(_Dx,_Dy,_Dz)if not GameRefs.Trees then
 GameRefs.Scan()
end
local _DA=GameRefs.Trees and GameRefs.Trees[_Dz*_Dx.w+_Dy]return type(_DA)=="table"and _DA.s==true
end
local function _DB(_DC,_DD,_DE,_DF)
local _DG=_DC and rawget(_DC,"spliceSeed")if type(_DG)~="function"then
 return false,"fungsi spliceSeed tidak ditemukan"
end
local _DH,_DI=pcall(_DG,_DD,_DE,_DF)if _DH and _DI and ItemDB[_DI]then
 if GameRefs.Inv and type(GameRefs.Inv.remove)=="function"then
 pcall(function()GameRefs.Inv:remove(_DF,1)
end)end
if GameRefs.SetTile then
 pcall(GameRefs.SetTile,"fg",_DD,_DE,_DI,true)end
autoSplice.made+=1 autoSplice.status=string.format("Splice jadi %s (%d,%d)",getItemName(_DI),_DD,_DE)return true end
return false,"ditolak server"
end
local function _DJ(_DK,_DL)
local _DM=math.min(getPunchRange(),getBuildRange())-0.15 while autoSplice.on and autoSplice.token==_DK and isAlive()do

local _DN=getWorld()if not _DN or getWorldName()~=_DL.world then
 autoSplice.status="World berubah, berhenti"break
end
local _DO,_DP=config.spliceA,config.spliceB
local _DQ,_DR=countInv(_DO),countInv(_DP)if _DR<=0 then
 autoSplice.status="Seed B habis!"notify("Auto Splice berhenti: "..getItemName(_DP).." habis.")break
end
local _DS=false if config.spliceRoam then

local _DT={}
local _DU=os.clock()for _DV=0,_DN.h-1 do
 for _DW=0,_DN.w-1 do

local _DX=_DW..",".._DV if not(autoSplice.skip[_DX]and autoSplice.skip[_DX]>_DU)then

local _DY=getTileAt(_DN,"fg",_DW,_DV)or 0 if _DY==0 and _DQ>0 and _tm(_DN,_DW,_DV,_DO)then
 table.insert(_DT,{x=_DW,y=_DV,key=_DX})elseif _DY==_DO and not _Dw(_DN,_DW,_DV)and not _tg(_DN,_DW,_DV,_DO)then
 table.insert(_DT,{x=_DW,y=_DV,key=_DX})
end
end
end
end
if#_DT==0 then
 autoSplice.status=(_DQ<=0)and "Seed A habis & tidak ada pohon A"or "Tidak ada lahan kosong untuk tanam/splice"break
end
for _DZ,ea_helper in ipairs(_DT)do
 if not autoSplice.on or autoSplice.token~=_DK or not isAlive()then
 break
end
if countInv(_DP)<=0 then
 break
end
local _Eb=getPlayerState()
local _Ec,_Ed=getPlayerTile()if not(_Eb and ClickTP.StateReaches(_Eb,ea_helper.x,ea_helper.y,_DM))then
 autoSplice.status=string.format("Menuju (%d,%d) [%d/%d]",ea_helper.x,ea_helper.y,_DZ,#_DT)if _Ed and ea_helper.y<_Ed then
 ClickTP.ClimbUpWithDirt(_Ec,ea_helper.y,function()return autoSplice.token~=_DK end,true,config.moveStepDelay)end
ClickTP.To(ea_helper.x,ea_helper.y,function()return autoSplice.token~=_DK end,_DM,true)task.wait(0.2)
end
if(getTileAt(_DN,"fg",ea_helper.x,ea_helper.y)or 0)==0 and countInv(_DO)>0 then
 if placeTile(_DO,{x=ea_helper.x,y=ea_helper.y},1)then
 autoSplice.planted+=1 stats.Planted+=1 _DS=true task.wait(math.max(0.14,config.spliceMs/1000))
end
end
if(getTileAt(_DN,"fg",ea_helper.x,ea_helper.y)or 0)==_DO and countInv(_DP)>0 and not _Dw(_DN,ea_helper.x,ea_helper.y)then

local _Ee,_Ef=_DB(_DN,ea_helper.x,ea_helper.y,_DP)if not _Ee then
 autoSplice.skip[ea_helper.key]=os.clock()+45 autoSplice.status=string.format("Gagal splice (%d,%d): %s",ea_helper.x,ea_helper.y,tostring(_Ef))else
 _DS=true end
task.wait(math.max(0.14,config.spliceMs/1000))
end
end
else

local _Eg,_Eh=getPlayerTile()if not _Eg then
 break
end
local _Ei=os.clock()for _Ej,_Ek in pairs(config.farmGrid)do
 if _Ek then

local _El,_Em=tostring(_Ej):match("^(-?%d+),(-?%d+)$")if _El and _Em then

local _En,_Eo=_Eg+tonumber(_El),_Eh+tonumber(_Em)
local _Ep=_En..",".._Eo if inBounds(_DN,_En,_Eo)and not(autoSplice.fail[_Ep]and autoSplice.fail[_Ep]>_Ei)then

local _Eq=getTileAt(_DN,"fg",_En,_Eo)or 0 if _Eq==0 and countInv(_DO)>0 and countInv(_DP)>0 and _tm(_DN,_En,_Eo,_DO)then
 if placeTile(_DO,{x=_En,y=_Eo},1)then
 autoSplice.planted+=1 stats.Planted+=1 _DS=true task.wait(math.max(0.14,config.spliceMs/1000))
end
end
if(getTileAt(_DN,"fg",_En,_Eo)or 0)==_DO and countInv(_DP)>0 and not _Dw(_DN,_En,_Eo)then

local _Er,_Es=_DB(_DN,_En,_Eo,_DP)if not _Er then
 autoSplice.fail[_Ep]=os.clock()+30 autoSplice.status=string.format("Gagal splice (%d,%d): %s",_En,_Eo,tostring(_Es))end
_DS=true task.wait(math.max(0.14,config.spliceMs/1000))
end
end
end
end
end
if not _DS then
 if countInv(_DO)<=0 or countInv(_DP)<=0 then
 autoSplice.status="Seed habis"break end
autoSplice.status="Menunggu tile Grid kosong..."task.wait(1)
end
end
if not _DS and config.spliceRoam then
 break end
task.wait(0.2)
end
end
function autoSplice.Stop()if not autoSplice.on then
 return false end
autoSplice.token+=1 autoSplice.on=false autoSplice.roaming=false clearKeys()keyState.active=false autoSplice.status="Mati"return true
end
function autoSplice.Start()if autoSplice.on then
 return true
end
if not(config.spliceA and config.spliceB)or config.spliceA==config.spliceB then
 notify("Auto Splice: Pilih Seed A dan Seed B yang berbeda!")return false
end
if _bh and type(_bi)=="table"and not autoSplice.Result(config.spliceA,config.spliceB)then
 notify("Kombinasi Seed A & Seed B ini tidak bisa di-splice!")return false
end
if autoFarm.on then
 _vu()
end
if autoClear.on then
 autoClear.Stop()
end
if autoHarvest.on then
 autoHarvest.Stop()
end
if autoDF.on then
 autoDF.Stop()
end
if autoPabrik.on then
 autoPabrik.Stop()
end
local _Et,_Eu=getPlayerPos()if not _Et then
 notify("Posisi belum terdeteksi.");return false
end
local _Ev={x=math.floor(_Et),y=math.floor(_Eu-0.475),world=getWorldName()}table.clear(autoSplice.fail)table.clear(autoSplice.skip)autoSplice.token+=1
local _Ew=autoSplice.token autoSplice.on=true autoSplice.roaming=config.spliceRoam autoSplice.status="Mulai..."task.spawn(function()
local _Ex,_Ey=pcall(_DJ,_Ew,_Ev)if not _Ex then
 warn("[ANCHHub] Auto Splice error: "..tostring(_Ey))end
clearKeys()keyState.active=false if autoSplice.token==_Ew then
 autoSplice.on=false autoSplice.roaming=false if autoSplice.status=="Mulai..."then
 autoSplice.status="Mati"
end
if spliceSetup then
 spliceSetup()
end
end
end)return true
end
end)()end
do
(function()
local function _Ez(_EA)if writefile then
 _EA.updatedAt=os.time()pcall(writefile,pabrikFile,HttpService:JSONEncode(_EA))
end
end
local function _EB()if isfile and delfile and isfile(pabrikFile)then
 pcall(delfile,pabrikFile)
end
end
function autoPabrik.ParseDropTarget()
local _EC=tostring(config.pabrikDropWorld or""):gsub("%s","")
local _ED,_EE=string.match(_EC,"^([^:]*):(.+)$")if not _ED then
 _ED=_EC end
_ED=string.upper(_ED):gsub("[^A-Z0-9]","")if _EE==""then
 _EE=nil end
return _ED,_EE
end
local function _EF()
local _EG=GameRefs.Menu if _EG and type(rawget(_EG,"openPicker"))=="function"and pcall(_EG.openPicker)then
 return true
end
local _EH=getWorld()if _EH and type(rawget(_EH,"call"))=="function"then
 return pcall(_EH.call,"LeaveWorld")end
return false
end
local function _EI(_EJ,_EK)_EJ=trim(_EJ):upper()if _EJ==""then
 return false,"nama world kosong"
end
if getWorldName():upper()==_EJ then
 return true
end
if _se then
 pcall(_se)
end
local _EL=getWorld()if getWorldName()~=""then
 _EF()task.wait(1.8)end
_EL=getWorld()if _EK and _EL then
 rawset(_EL,"arriveDoor",_EK)
end
local _EM=_EL and rawget(_EL,"fg")
local _EN=GameRefs.Menu if _EN and type(rawget(_EN,"enter"))=="function"then
 pcall(_EN.enter,_EJ)elseif _EL and type(rawget(_EL,"enter"))=="function"then
 pcall(_EL.enter,_EJ)else
 return false,"fungsi enter tidak ditemukan"
end
local _EO=os.clock()while isAlive()and os.clock()-_EO<10 do

local _EP=getWorld()if _EP and rawget(_EP,"fg")~=_EM and getWorldName():upper()==_EJ then
 GameRefs.Scan()task.wait(1.2)return true end
task.wait(0.25)end
return false,"sedang teleport / terkunci"
end
local function _EQ(_ER)
local _ES=DropRefs.list if not _ES then
 GameRefs.Scan();_ES=DropRefs.list
end
if type(_ES)~="table"then
 return nil
end
local _ET,_EU=getPlayerTile()_ET,_EU=_ET or 50,_EU or 30
local _EV=autoPabrik.Zone if _EV and _EV.world~=getWorldName()then
 _EV=nil
end
local _EW,_EX=nil,math.huge for _EY,_EZ in ipairs(_ES)do
 if type(_EZ)=="table"and _EZ.id==_ER and(_EZ.n or 0)>0 and type(_EZ.x)=="number"then
 if not(_EV and math.abs(_EZ.x-_EV.x)<=2.5 and math.abs(_EZ.y-_EV.y)<=2.5)then

local _Fa=math.abs(_EZ.x-_ET)+math.abs(_EZ.y-_EU)if _Fa<_EX then
 _EW,_EX=_EZ,_Fa
end
end
end
end
return _EW
end
local function _Fb(_Fc,_Fd)
local _Fe=false while _Fd()and countInv(_Fc)<200 do

local _Ff=_EQ(_Fc)if not _Ff then
 break
end
local _Fg,_Fh=math.floor(_Ff.x),math.floor(_Ff.y)autoPabrik.phase="COLLECT BLOCK"autoPabrik.status=string.format("Mengambil drop %s di (%d,%d)...",getItemName(_Fc),_Fg,_Fh)ClickTP.To(_Fg,_Fh,function()return not _Fd()end,0.5,false)_Fe=true task.wait(0.45)end
return _Fe
end
local function _Fi(_Fj,_Fk,_Fl)
local _Fm=GameRefs.Hud or getInvTable()
local _Fn=_Fm and rawget(_Fm,"onDrop")
local _Fo=_Fk
local _Fp=false while _Fo>0 and _Fl()and countInv(_Fj)>0 do

local _Fq=countInv(_Fj)
local _Fr=math.min(_Fo,_Fq,200)if type(_Fn)=="function"then
 pcall(_Fn,_Fj,_Fr)elseif DropItem then
 pcall(function()DropItem:FireServer(_Fj,_Fr)
end)end
task.wait(0.8)
local _Fs=_Fq-countInv(_Fj)if _Fs>0 then
 _Fo=_Fo-_Fs autoPabrik.dropped=autoPabrik.dropped+_Fs elseif not _Fp then
 _Fp=true
local _Ft=getPlayerState()
local _Fu=_Ft and(_Ft.facing or 1)<0 keyState.active=true keyState.right,keyState.left=_Fu,not _Fu task.wait(0.08)clearKeys()keyState.active=false task.wait(0.35)else
 return _Fk-_Fo,"tile drop penuh"
end
end
return _Fk-_Fo,nil
end
local function _Fv(_Fw,_Fx,_Fy)
local _Fz,_FA=autoPabrik.ParseDropTarget()
local _FB=autoPabrik.home~=""and autoPabrik.home or getWorldName()if _Fz==""then
 _Fz=_FB
end
if config.pabrikDropX<0 and not _FA and _Fz==_FB then
 autoPabrik.status="Posisi drop belum diatur (drop dilewati)"autoPabrik.dropOffUntil=os.clock()+60 return end
autoPabrik.traveling=true
local _FC=_Fz:upper()~=getWorldName():upper()_Ez({active=true,stage="dropping",homeWorld=_FB,targetWorld=_Fz,doorId=_FA,seedId=_Fw,dropAmount=_Fx,})
local _FD,_FE=true,nil if _FC or _FA then
 autoPabrik.status="Menuju world penyimpanan ".._Fz..(_FA and(":".._FA)or"").."..."
local _FF,_FG=_EI(_Fz,_FA)if not _FF then
 _FD,_FE=false,"Gagal masuk ".._Fz.." ("..tostring(_FG)..")"
end
end
if _FD and _Fy()and config.pabrikDropX>=0 and config.pabrikDropY>=0 then
 autoPabrik.status=string.format("Jalan A* ke posisi drop (%d,%d)...",config.pabrikDropX,config.pabrikDropY)
local _FH=false for _FI=1,3 do
 if not _Fy()then
 break
end
if ClickTP.To(config.pabrikDropX,config.pabrikDropY,function()return not _Fy()end,0.5,false)then
 _FH=true break end
task.wait(0.3)
end
if not _FH then
 _FD,_FE=false,("Tidak bisa jalan ke posisi drop (pastikan tidak terhalang tembok)")
end
end
if _FD and _Fy()then

local _FJ=getPlayerState()if _FJ then
 autoPabrik.Zone={world=getWorldName(),x=_FJ.x,y=_FJ.y-0.475}
end
local _FK,_FL=_Fi(_Fw,_Fx,_Fy)if _FK>0 then

local _FM=string.format("Berhasil Drop %s x%d di %s",getItemName(_Fw),_FK,getWorldName())autoPabrik.status=_FM notify(_FM,"Pabrik ANCH")webhook.Send("pabrik",_FM)
end
if _FL then
 _FD,_FE=false,_FL
end
end
if not _FD then
 autoPabrik.dropOffUntil=os.clock()+90 autoPabrik.status="Drop gagal: "..tostring(_FE)end
_Ez({active=true,stage="farming",homeWorld=_FB,targetWorld=_Fz,seedId=_Fw,})if _FB~=""and getWorldName():upper()~=_FB:upper()and _Fy()then
 autoPabrik.status="Kembali ke world pabrik ".._FB.."..."if not _EI(_FB,nil)and _Fy()then
 task.wait(4)_EI(_FB,nil)
end
end
autoPabrik.traveling=false
end
function autoPabrik.ExternalDropSeed(_FN,_FO,_FP,_FQ,_FR,_FS,_FT,_FU,_FV)
local _FW,_FX,_FY,_FZ=config.pabrikDropWorld,config.pabrikDropX,config.pabrikDropY,autoPabrik.home config.pabrikDropWorld=_FP or""config.pabrikDropX=_FQ or-1 config.pabrikDropY=_FR or-1 autoPabrik.home=_FS or getWorldName()_Fv(_FN,_FO,_FV)config.pabrikDropWorld,config.pabrikDropX,config.pabrikDropY,autoPabrik.home=_FW,_FX,_FY,_FZ if _FT and _FU and _FV()then
 ClickTP.To(_FT,_FU,function()return not _FV()end,0.3,false)
end
end
local function _Ga(_Gb,_Gc)if not config.pabrikDrop then
 return false
end
local _Gd=countInv(_Gb)
local _Ge=math.max(1,tonumber(config.pabrikMaxSeed)or 100)if _Gd>_Ge and os.clock()>=(autoPabrik.dropOffUntil or 0)then

local _Gf=_Gd-_Ge if _Gf>0 then
 autoPabrik.phase="DROP KELEBIHAN SEED"autoPabrik.status=string.format("Seed %d > Max (%d)! Drop %d seed...",_Gd,_Ge,_Gf)_Fv(_Gb,_Gf,_Gc)return true
end
end
return false
end
local function _Gg(_Gh,_Gi,_Gj)if config.pabrikBreakX<0 or config.pabrikBreakY<0 then
 autoPabrik.status="Posisi Break belum diatur! Tekan tombol SetPos Break dulu."notify(("Pabrik: Tekan tombol 'SetPos Break' di tab Pabrik terlebih dahulu!"))task.wait(2.5)return false
end
if next(config.pabrikTiles)==nil then
 config.pabrikTiles={["1,0"]=true}
end
while _Gj()do
 _Ga(_Gh,_Gj)if not _Gj()then
 break
end
if countInv(_Gi)<=0 then
 if not _Fb(_Gi,_Gj)or countInv(_Gi)<=0 then
 break
end
end
autoPabrik.phase="BREAK BLOCK"
local _Gk,_Gl=getPlayerTile()if _Gk~=config.pabrikBreakX or _Gl~=config.pabrikBreakY then
 autoPabrik.status=string.format("Menuju Posisi Break (%d,%d)...",config.pabrikBreakX,config.pabrikBreakY)if not ClickTP.To(config.pabrikBreakX,config.pabrikBreakY,function()return not _Gj()end,0.5,false)then
 autoPabrik.status="Gagal jalan ke Posisi Break, mencoba ulang..."task.wait(2)break
end
end
if not _Gj()then
 break
end
local _Gm,_Gn,_Go=getPlayerPos()if not _Gm then
 break
end
local _Gp={x=config.pabrikBreakX,y=config.pabrikBreakY,facing=_Go,world=getWorldName(),}autoFarm.Override={offsets=config.pabrikTiles,block=_Gi,mode="Place + Break"}autoFarm.Quiet=true autoFarm.token=autoFarm.token+1
local _Gq=autoFarm.token autoFarm.on=true
local _Gr=stats.Placed+stats.Broken
local _Gs=os.clock()task.spawn(function()while autoFarm.on and autoFarm.token==_Gq do
 task.wait(0.4)
local _Gt=stats.Placed+stats.Broken if _Gt~=_Gr then
 _Gr,_Gs=_Gt,os.clock()
end
local _Gu=countInv(_Gh)
local _Gv=countInv(_Gi)
local _Gw=math.max(1,tonumber(config.pabrikMaxSeed)or 100)if not _Gj()or _Gv<=0 or(config.pabrikDrop and _Gu>_Gw and _Gu>=180)or(os.clock()-_Gs>8)then
 autoFarm.on=false
end
end
end)autoPabrik.status=string.format("Break %s di (%d,%d) [Sisa: %d]...",getItemName(_Gi),_Gp.x,_Gp.y,countInv(_Gi))pcall(_vv,_Gq,_Gp)autoFarm.on=false autoFarm.Override=nil autoFarm.Quiet=false task.wait(0.3)end
return true
end
local function _Gx(_Gy,_Gz)if config.pabrikBreakX<0 or config.pabrikBreakY<0 then
 return false
end
if _Gy==config.pabrikBreakX and _Gz==config.pabrikBreakY then
 return true
end
for _GA,_GB in pairs(config.pabrikTiles)do
 if _GB then

local _GC,_GD=tostring(_GA):match("^(-?%d+),(-?%d+)$")if _GC and _GD then
 if _Gy==(config.pabrikBreakX+tonumber(_GC))and _Gz==(config.pabrikBreakY+tonumber(_GD))then
 return true
end
end
end
end
return false
end
local function _GE(_GF,_GG)
local _GH={}
local _GI=0
local _GJ=nil
local _GK=workspace:GetServerTimeNow()
local _GL=ItemDB[_GG]
local _GM=(_GL and(tonumber(_GL.grow)or tonumber(_GL.baseGrow)))or 31
local _GN=1 for _GO=0,_GF.h-1 do

local _GP={}for _GQ=0,_GF.w-1 do

local _GR=getTileAt(_GF,"fg",_GQ,_GO)or 0 if _GR==_GG then

local _GS=_sW(_GF,_GQ,_GO,_GR)if _GS then
 if _GK>=_GS then
 table.insert(_GP,{x=_GQ,y=_GO})else
 _GI=_GI+1
local _GT=_GS-_GK if not _GJ or _GT<_GJ then
 _GJ=_GT
end
end
else
 _GI=_GI+1 if not _GJ or _GM<_GJ then
 _GJ=_GM
end
end
end
end
if#_GP>0 then
 if _GN==-1 then
 table.sort(_GP,function(_GU,_GV)return _GU.x>_GV.x end)else
 table.sort(_GP,function(_GW,_GX)return _GW.x<_GX.x
end)end
for _GY,_GZ in ipairs(_GP)do
 table.insert(_GH,_GZ)end
_GN=-_GN
end
end
return _GH,_GI,_GJ
end
local function _Ha(_Hb,_Hc)
local function hd_helper()return autoPabrik.on and autoPabrik.token==_Hb and isAlive()
end
local _He=math.min(getPunchRange(),getBuildRange())-0.15 while hd_helper()do

local hf_helper=getWorld()while not hf_helper and hd_helper()do
 task.wait(1)hf_helper=getWorld()
end
if not hd_helper()then
 break
end
local hg_helper=config.pabrikSeedId
local _Hh=math.max(1,tonumber(config.pabrikMaxSeed)or 100)if countInv(_Hc)>0 or _EQ(_Hc)~=nil then
 _Gg(hg_helper,_Hc,hd_helper)if not hd_helper()then
 break end
hf_helper=getWorld()end
_Ga(hg_helper,hd_helper)if not hd_helper()then
 break end
hf_helper=getWorld()
local _Hi,_Hj=_GE(hf_helper,hg_helper)
local _Hk=#_Hi+_Hj
local _Hl=math.max(0,_Hh-_Hk)if countInv(hg_helper)>0 and _Hl>0 then
 autoPabrik.phase="TANAM SEED"
local _Hm={}
local _Hn=1 for _Ho=0,hf_helper.h-1 do

local _Hp={}for _Hq=0,hf_helper.w-1 do
 if(getTileAt(hf_helper,"fg",_Hq,_Ho)or 0)==0 and _tm(hf_helper,_Hq,_Ho,hg_helper)and not _Gx(_Hq,_Ho)then
 table.insert(_Hp,{x=_Hq,y=_Ho})
end
end
if#_Hp>0 then
 if _Hn==-1 then
 table.sort(_Hp,function(_Hr,_Hs)return _Hr.x>_Hs.x end)else
 table.sort(_Hp,function(_Ht,_Hu)return _Ht.x<_Hu.x
end)end
for _Hv,_Hw in ipairs(_Hp)do
 table.insert(_Hm,_Hw)end
_Hn=-_Hn
end
end
local _Hx=0 for _Hy,_Hz in ipairs(_Hm)do
 if not hd_helper()or countInv(hg_helper)<=0 or _Hx>=_Hl then
 break
end
if _tm(hf_helper,_Hz.x,_Hz.y,hg_helper)then

local _HA=getPlayerState()if not(_HA and ClickTP.StateReaches(_HA,_Hz.x,_Hz.y,_He))then
 autoPabrik.status=string.format("Jalan Zig-Zag tanam (%d,%d) [%d/%d]",_Hz.x,_Hz.y,_Hx+1,_Hl)ClickTP.To(_Hz.x,_Hz.y,function()return not hd_helper()end,_He,false)
end
local _HB=getPlayerState()if _HB and ClickTP.StateReaches(_HB,_Hz.x,_Hz.y,_He+0.5)and _tm(hf_helper,_Hz.x,_Hz.y,hg_helper)and placeTile(hg_helper,_Hz,1)then
 _Hx=_Hx+1 autoPabrik.planted=autoPabrik.planted+1 stats.Planted=stats.Planted+1 autoPabrik.status=string.format("Menanam %s (%d/%d Max Seed)",getItemName(hg_helper),_Hk+_Hx,_Hh)task.wait(math.max(0.05,config.harvestPlantDelay))
end
end
end
end
if not hd_helper()then
 break end
hf_helper=getWorld()
local _HC,_HD,_HE=_GE(hf_helper,hg_helper)if#_HC==0 and _HD>0 then
 autoPabrik.phase="TUNGGU TUMBUH"while hd_helper()do
 hf_helper=getWorld()if not hf_helper then
 break end
_HC,_HD,_HE=_GE(hf_helper,hg_helper)if#_HC>0 or _HD==0 then
 break
end
local _HF=math.max(1,math.ceil(_HE or 15))autoPabrik.status=string.format("Menunggu %d pohon siap panen (Â±%ds)...",_HD,_HF)task.wait(1)
end
end
if not hd_helper()then
 break
end
if#_HC>0 then
 autoPabrik.phase="PANEN ZIG-ZAG"for _HG,_HH in ipairs(_HC)do
 if not hd_helper()then
 break
end
if countInv(_Hc)>=200 then
 autoPabrik.status="Blok mencapai 200! Menuju Posisi Break..."_Gg(hg_helper,_Hc,hd_helper)if not hd_helper()then
 break end
_Ga(hg_helper,hd_helper)if not hd_helper()then
 break
end
end
hf_helper=getWorld()if hf_helper and(getTileAt(hf_helper,"fg",_HH.x,_HH.y)or 0)==hg_helper then

local _HI=getPlayerState()if not(_HI and ClickTP.StateReaches(_HI,_HH.x,_HH.y,_He))then
 autoPabrik.status=string.format("Panen Zig-Zag (%d,%d) [%d/%d]",_HH.x,_HH.y,_HG,#_HC)ClickTP.To(_HH.x,_HH.y,function()return not hd_helper()end,_He,false)
end
local _HJ=getPlayerState()if _HJ and ClickTP.StateReaches(_HJ,_HH.x,_HH.y,_He+0.5)then

local _HK=os.clock()while hd_helper()and(getTileAt(hf_helper,"fg",_HH.x,_HH.y)or 0)==hg_helper and os.clock()-_HK<3.5 do

local _HL=punchTile(_HH.x,_HH.y,false)if _HL=="broke"then
 autoPabrik.harvested=autoPabrik.harvested+1 stats.Harvested=stats.Harvested+1 end
task.wait(math.max(0.05,config.harvestDelay))end
task.wait(0.20)
end
end
end
_Fb(_Hc,hd_helper)if countInv(_Hc)>0 then
 _Gg(hg_helper,_Hc,hd_helper)end
_Ga(hg_helper,hd_helper)else if countInv(hg_helper)<=0 and countInv(_Hc)<=0 and _EQ(_Hc)==nil then
 autoPabrik.status="Selesai: Seed, blok, dan pohon sudah habis."_EB()break
end
end
task.wait(0.3)
end
end
function autoPabrik.Stop()_EB()if not autoPabrik.on then
 return false end
autoPabrik.token=autoPabrik.token+1 autoPabrik.on=false autoPabrik.traveling=false if autoFarm.Override then
 autoFarm.on=false autoFarm.Override=nil autoFarm.Quiet=false end
clearKeys()keyState.active=false autoPabrik.phase="-"autoPabrik.status="Mati"if _sG then
 pcall(_sG)end
return true
end
function autoPabrik.Start(_HM)if autoPabrik.on then
 return true
end
local _HN=config.pabrikSeedId
local _HO=getBlockForSeed(_HN)if not _HN or not _HO then
 notify("Pabrik: Pilih seed pabrik yang valid terlebih dahulu!")return false
end
if autoFarm.on then
 _vu()
end
if autoClear.on then
 autoClear.Stop()
end
if autoHarvest.on then
 autoHarvest.Stop()
end
if autoDF.on then
 autoDF.Stop()
end
if autoSplice.on then
 autoSplice.Stop()end
autoPabrik.home=_HM or getWorldName()autoPabrik.dropOffUntil=0 autoPabrik.token=autoPabrik.token+1
local _HP=autoPabrik.token autoPabrik.on=true autoPabrik.phase="MULAI"autoPabrik.status="Inisialisasi Pabrik..."_Ez({active=true,stage="farming",homeWorld=autoPabrik.home,seedId=_HN,})if _sG then
 pcall(_sG)
end
if spliceSetup then
 spliceSetup()end
task.spawn(function()
local _HQ,_HR=pcall(_Ha,_HP,_HO)if not _HQ then
 warn("[ANCHHub] Pabrik error: "..tostring(_HR))end
clearKeys()keyState.active=false if autoPabrik.token==_HP then
 autoPabrik.on=false autoPabrik.traveling=false autoPabrik.phase="-"if autoPabrik.status=="Inisialisasi Pabrik..."then
 autoPabrik.status="Mati"
end
if _sG then
 pcall(_sG)
end
if spliceSetup then
 spliceSetup()
end
end
end)return true
end
function autoPabrik.CheckStartup()pcall(function()if not(isfile and readfile and isfile(pabrikFile))then
 return
end
local _HS=readfile(pabrikFile)
local _HT=HttpService:JSONDecode(_HS)if type(_HT)~="table"or not _HT.active then
 return
end
if os.time()-(tonumber(_HT.updatedAt)or 0)>1800 then
 _EB()return
end
local _HU=os.clock()while isAlive()and os.clock()-_HU<30 do
 if getWorldName()~=""and getPlayerTile()then
 break end
task.wait(1)
end
if not isAlive()or getWorldName()==""then
 return end
GameRefs.Scan()task.wait(1.2)
local _HV=getWorldName():upper()
local _HW=tostring(_HT.homeWorld or""):upper()
local _HX=tostring(_HT.targetWorld or""):upper()if _HT.stage=="dropping"and _HX~=""and _HV==_HX then
 notify("Melanjutkan proses Drop Seed Pabrik di ".._HV.."...","Pabrik ANCH")autoPabrik.home=_HT.homeWorld autoPabrik.on=true autoPabrik.token=autoPabrik.token+1
local _HY=autoPabrik.token _Fv(_HT.seedId or config.pabrikSeedId,_HT.dropAmount or config.pabrikDropAmount or 100,function()return autoPabrik.on and autoPabrik.token==_HY and isAlive()end)autoPabrik.on=false if getWorldName():upper()==_HW then
 autoPabrik.Start(_HT.homeWorld)end
elseif _HW~=""and _HV==_HW then
 notify("Melanjutkan siklus Pabrik otomatis di ".._HV.."!","Pabrik ANCH")autoPabrik.Start(_HT.homeWorld)elseif _HW~=""and _HV~=_HW then
 notify("Kembali ke world Pabrik: ".._HW.."...","Pabrik ANCH")if _EI(_HW,nil)then
 autoPabrik.Start(_HT.homeWorld)
end
end
end)end
end)()end
do
(function()
local function _HZ(_Ia)if writefile then
 _Ia.updatedAt=os.time()pcall(writefile,autoMoveFile,HttpService:JSONEncode(_Ia))
end
end
local function _Ib()if isfile and delfile and isfile(autoMoveFile)then
 pcall(delfile,autoMoveFile)
end
end
function autoGuard.ParseWorld(_Ic)
local _Id=tostring(_Ic or""):gsub("%s","")
local _Ie,_If=string.match(_Id,"^([^:]*):(.+)$")if not _Ie then
 _Ie=_Id end
_Ie=string.upper(_Ie):gsub("[^A-Z0-9]","")if _If==""then
 _If=nil end
return _Ie,_If
end
local function _Ig()
local _Ih=GameRefs.Menu if _Ih and type(rawget(_Ih,"openPicker"))=="function"and pcall(_Ih.openPicker)then
 return true
end
local _Ii=getWorld()if _Ii and type(rawget(_Ii,"call"))=="function"then
 return pcall(_Ii.call,"LeaveWorld")end
return false
end
local function _Ij(_Ik,_Il)_Ik=trim(_Ik):upper()if _Ik==""then
 return false,"nama world kosong"
end
if getWorldName():upper()==_Ik and not _Il then
 return true
end
if _se then
 pcall(_se)
end
if getWorldName()~=""then
 _Ig()task.wait(1.8)
end
local _Im=getWorld()if _Il and _Im then
 rawset(_Im,"arriveDoor",_Il)
end
local _In=_Im and rawget(_Im,"fg")
local _Io=GameRefs.Menu if _Io and type(rawget(_Io,"enter"))=="function"then
 pcall(_Io.enter,_Ik)elseif _Im and type(rawget(_Im,"enter"))=="function"then
 pcall(_Im.enter,_Ik)else
 return false,"fungsi enter world tidak ditemukan"
end
local _Ip=os.clock()while isAlive()and(os.clock()-_Ip)<12 do

local _Iq=getWorld()if _Iq and rawget(_Iq,"fg")~=_In and getWorldName():upper()==_Ik then
 GameRefs.Scan()task.wait(1.2)return true end
task.wait(0.25)end
return false,"timeout masuk world ".._Ik
end
local function _Ir(_Is)if not DropRefs.list and DropRefs.findRefs then
 DropRefs.findRefs()
end
local _It=DropRefs.list if type(_It)~="table"then
 return nil,0
end
local _Iu,_Iv=getPlayerTile()_Iu,_Iv=_Iu or 50,_Iv or 30
local _Iw,_Ix=nil,math.huge
local _Iy=0 for _Iz,_IA in ipairs(_It)do
 if type(_IA)=="table"and _IA.id==_Is and(_IA.n or 0)>0 and not _IA.display and type(_IA.x)=="number"then
 _Iy=_Iy+(_IA.n or 0)
local _IB=math.abs(_IA.x-_Iu)+math.abs(_IA.y-_Iv)if _IB<_Ix then
 _Iw,_Ix=_IA,_IB
end
end
end
return _Iw,_Iy
end
local function _IC(_ID,_IE,_IF,_IG)
local _IH=GameRefs.Hud or getInvTable()
local _II=_IH and rawget(_IH,"onDrop")
local _IJ,_IK=_IE,_IF
local _IL=0 while _IG()and countInv(_ID)>0 and _IL<25 do

local _IM=countInv(_ID)
local _IN=math.min(_IM,200)autoGuard.status=string.format("Drop %s x%d di (%d,%d)...",getItemName(_ID),_IN,_IJ,_IK)if type(_II)=="function"then
 pcall(_II,_ID,_IN)elseif DropItem then
 pcall(function()DropItem:FireServer(_ID,_IN)end)elseif netOk and type(Net)=="table"and Net.drop then
 pcall(Net.drop.send,{id=_ID,n=_IN})end
task.wait(0.85)
local _IO=countInv(_ID)
local _IP=_IM-_IO if _IP>0 then
 autoGuard.dropped=autoGuard.dropped+_IP
end
if countInv(_ID)>0 and _IG()then
 _IL=_IL+1 _IJ=_IJ+1
local _IQ=getWorld()if _IQ and _IJ>=_IQ.w-1 then
 return false,"Mentok ujung kanan world!"end
autoGuard.status=string.format("Tile penuh! Geser kanan 1 langkah ke (%d,%d)...",_IJ,_IK)if not ClickTP.SolidAt(_IJ,_IK)and DropRefs.walkToX then

local _IR=keyState.active keyState.active=true DropRefs.collecting=true DropRefs.walkToX(_IJ+0.5,1.5)DropRefs.collecting=false keyState.active=_IR else
 ClickTP.To(_IJ,_IK,function()return not _IG()end,0.3,false)end
task.wait(0.25)
end
end
return countInv(_ID)==0,nil
end
local function _IS(_IT)
local function _IU()return autoGuard.on and autoGuard.token==_IT and isAlive()
end
local _IV=tonumber(config.moveItemId)or 0
local _IW,_IX=autoGuard.ParseWorld(config.moveWorld1)
local _IY,_IZ=autoGuard.ParseWorld(config.moveWorld2)while _IU()do

local _Ja=countInv(_IV)if _Ja<200 then
 autoGuard.pauseCollect=false autoGuard.phase="TAKE (WORLD 1)"_HZ({active=true,stage="taking",w1=config.moveWorld1,w2=config.moveWorld2,dropX=config.moveDropX,dropY=config.moveDropY,itemId=_IV,})if getWorldName():upper()~=_IW then
 autoGuard.traveling=true autoGuard.status="Pindah ke World 1: ".._IW..(_IX and(":".._IX)or"").."..."
local _Jb,_Jc=_Ij(_IW,_IX)autoGuard.traveling=false if not _Jb then
 autoGuard.status="Gagal masuk World 1 ("..tostring(_Jc).."), coba lagi..."task.wait(4)continue
end
end
if not _IU()then
 break end
GameRefs.Scan()if DropRefs.findRefs then
 DropRefs.findRefs()end
task.wait(0.8)
local _Jd,_Je=_Ir(_IV)if not _Jd then
 if countInv(_IV)>0 then
 autoGuard.status="Drop di World 1 habis, mengantar sisa tas ke World 2..."else
 _Ib()autoGuard.pauseCollect=false autoGuard.phase="SELESAI"
local _Jf=string.format("Auto Move Selesai! %s habis di %s. Total dipindahkan: %d",getItemName(_IV),_IW,autoGuard.dropped)autoGuard.status=_Jf notify(_Jf,"Auto Move Selesai",6)webhook.Send("pabrik",_Jf)break end
else
 while _IU()and countInv(_IV)<200 do

local _Jg=_Ir(_IV)if not _Jg then
 break
end
local _Jh,_Ji=math.floor(_Jg.x),math.floor(_Jg.y)autoGuard.status=string.format("Ambil %s di (%d,%d) [Tas: %d/200]...",getItemName(_IV),_Jh,_Ji,countInv(_IV))
local _Jj=countInv(_IV)ClickTP.To(_Jh,_Ji,function()return not _IU()end,0.35,false)if DropRefs.walkToX then

local _Jk=keyState.active keyState.active=true DropRefs.collecting=true DropRefs.walkToX(_Jg.x,1.0)DropRefs.collecting=false keyState.active=_Jk
end
local _Jl=getWorld()
local _Jm=_Jl and rawget(_Jl,"takeDrop")if type(_Jm)=="function"and _Jg.uid then

local _Jn=200-countInv(_IV)if _Jn>0 then
 pcall(_Jm,_Jg.uid,math.min(_Jg.n or 1,_Jn))
end
end
task.wait(0.35)
local _Jo=countInv(_IV)if _Jo>_Jj then
 autoGuard.collected=autoGuard.collected+(_Jo-_Jj)
end
end
end
end
if not _IU()then
 break
end
if countInv(_IV)>0 then
 autoGuard.phase="DROP (WORLD 2)"autoGuard.pauseCollect=true _HZ({active=true,stage="dropping",w1=config.moveWorld1,w2=config.moveWorld2,dropX=config.moveDropX,dropY=config.moveDropY,itemId=_IV,})if getWorldName():upper()~=_IY or _IZ then
 autoGuard.traveling=true autoGuard.status="Pindah ke World 2: ".._IY..(_IZ and(":".._IZ)or"").."..."
local _Jp,_Jq=_Ij(_IY,_IZ)autoGuard.traveling=false if not _Jp then
 autoGuard.status="Gagal masuk World 2 ("..tostring(_Jq).."), coba lagi..."task.wait(4)continue
end
end
if not _IU()then
 break
end
local _Jr,_Js=tonumber(config.moveDropX)or-1,tonumber(config.moveDropY)or-1 if _Jr>=0 and _Js>=0 then
 autoGuard.status=string.format("Menuju Pos Drop (%d,%d) di %s...",_Jr,_Js,_IY)
local _Jt=false for _Ju=1,3 do
 if not _IU()then
 break
end
if ClickTP.To(_Jr,_Js,function()return not _IU()end,0.35,false)then
 _Jt=true break end
task.wait(0.3)
end
if not _Jt then
 autoGuard.status="Gagal jalan ke Pos Drop di World 2, coba ulang..."task.wait(2)continue end
else

local _Jv,_Jw=getPlayerTile()_Jr,_Js=_Jv or 50,_Jw or 30
end
local _Jx=getPlayerState()if _Jx and(_Jx.facing or 1)<0 then
 keyState.active=true keyState.right=true task.wait(0.06)clearKeys()keyState.active=false
end
local _Jy,_Jz=_IC(_IV,_Jr,_Js,_IU)if not _Jy and _Jz then
 autoGuard.status="Peringatan Drop: "..tostring(_Jz)task.wait(2)end
_HZ({active=true,stage="taking",w1=config.moveWorld1,w2=config.moveWorld2,dropX=config.moveDropX,dropY=config.moveDropY,itemId=_IV,})end
task.wait(0.3)end
autoGuard.pauseCollect=false
end
function autoGuard.Stop()_Ib()if not autoGuard.on then
 return false end
autoGuard.token=autoGuard.token+1 autoGuard.on=false autoGuard.traveling=false autoGuard.pauseCollect=false clearKeys()keyState.active=false autoGuard.phase="-"autoGuard.status="Mati"if spliceSetup then
 spliceSetup()end
return true
end
function autoGuard.Start()if autoGuard.on then
 return true
end
local _JA=autoGuard.ParseWorld(config.moveWorld1)
local _JB=autoGuard.ParseWorld(config.moveWorld2)
local _JC=tonumber(config.moveItemId)or 0 if _JA==""or _JB==""then
 notify("Auto Move: Isi nama World 1 dan World 2 terlebih dahulu!")return false
end
if config.moveDropX<0 or config.moveDropY<0 then
 notify("Auto Move: SetPos Drop di World 2 terlebih dahulu!")return false
end
if _JC<=0 or not ItemDB[_JC]then
 notify("Auto Move: ID Item tidak valid!")return false
end
if autoFarm.on then
 _vu()
end
if autoClear.on then
 autoClear.Stop()
end
if autoHarvest.on then
 autoHarvest.Stop()
end
if autoDF.on then
 autoDF.Stop()
end
if autoSplice.on then
 autoSplice.Stop()
end
if autoPabrik.on then
 autoPabrik.Stop()end
autoGuard.token=autoGuard.token+1
local _JD=autoGuard.token autoGuard.on=true autoGuard.phase="MULAI"autoGuard.status="Inisialisasi Auto Move..."if spliceSetup then
 spliceSetup()end
task.spawn(function()
local _JE,_JF=pcall(_IS,_JD)if not _JE then
 warn("[ANCHHub] AutoMove error: "..tostring(_JF))end
autoGuard.pauseCollect=false clearKeys()keyState.active=false if autoGuard.token==_JD then
 autoGuard.on=false autoGuard.traveling=false if autoGuard.phase~="SELESAI"then
 autoGuard.status="Mati"
end
if spliceSetup then
 spliceSetup()
end
end
end)return true
end
function autoGuard.CheckStartup()pcall(function()if not(isfile and readfile and isfile(autoMoveFile))then
 return
end
local _JG=readfile(autoMoveFile)
local _JH=HttpService:JSONDecode(_JG)if type(_JH)~="table"or not _JH.active then
 return
end
if os.time()-(tonumber(_JH.updatedAt)or 0)>1800 then
 _Ib()return
end
local _JI=os.clock()while isAlive()and(os.clock()-_JI)<30 do
 if getWorldName()~=""and getPlayerTile()then
 break end
task.wait(1)
end
if not isAlive()or getWorldName()==""then
 return end
GameRefs.Scan()task.wait(1.2)if _JH.w1 then
 config.moveWorld1=_JH.w1
end
if _JH.w2 then
 config.moveWorld2=_JH.w2
end
if _JH.dropX then
 config.moveDropX=_JH.dropX
end
if _JH.dropY then
 config.moveDropY=_JH.dropY
end
if _JH.itemId then
 config.moveItemId=_JH.itemId end
notify("Melanjutkan progres Auto Move ("..tostring(_JH.stage or "aktif")..")...","Auto Move ANCH")autoGuard.Start()
end)end
end)()end
do
(function()
local _JJ={[242]=true,[1796]=true,[7188]=true}
local _JK={{from=242,to=1796,name="Diamond Lock"},{from=1796,to=7188,name="Blue Gem Lock"},}
local function _JL(...)
local _JM=getWorld()
local _JN=_JM and rawget(_JM,"call")if type(_JN)~="function"then
 return false end
return pcall(_JN,...)
end
local function _JO(_JP)
local _JQ=ItemDB[_JP]return _JQ~=nil and _JQ.kind~="tool"and not _JQ.lock and not _JJ[_JP]
end
function _sP.Recycle(_JR,_JS)if not GameRefs.Inv or _JS<=0 or not _JO(_JR)then
 return false end
_JS=math.min(_JS,countInv(_JR))if _JS<=0 then
 return false end
pcall(function()GameRefs.Inv:remove(_JR,_JS)
end)
local _JT=_JL("Recycle",_JR,_JS)if _JT then
 _sP.recycled+=_JS _sP.status=string.format("Recycle %s x%d",getItemName(_JR),_JS)end
return _JT
end
local function _JU(_JV)
local _JW=GameRefs.Inv if not _JW or countInv(_JV.from)<100 then
 return false
end
if countInv(_JV.to)+1>200 then
 return false end
pcall(function()_JW:remove(_JV.from,100)_JW:add(_JV.to,1)
end)
local _JX=_JL("ConvertLock",_JV.from,_JV.to)if _JX then
 _sP.converted+=1 _sP.status="Convert ke ".._JV.name end
return _JX end
task.spawn(function()while isAlive()do
 pcall(function()if config.trashOn and type(config.trashList)=="table"then
 for _JY,_JZ in ipairs(config.trashList)do

local _Ka=countInv(_JZ)if _Ka>=config.trashAt and _Ka>config.trashKeep then
 _sP.Recycle(_JZ,_Ka-config.trashKeep)task.wait(0.5)
end
end
end
if config.convertLockOn then
 for _Kb,_Kc in ipairs(_JK)do
 if _JU(_Kc)then
 task.wait(0.5)
end
end
end
end)task.wait(2.5)
end
end)end)()
end
local guardTimer={on=false,token=0,status="Mati",stocked=0,taken=0,dropped=0,picked={},carry={}}do
(function()function guardTimer.ParsePoint()
local _Ke=tostring(config.vendPoint or""):gsub("%s","")
local _Kf,_Kg=string.match(_Ke,"^([^:|]*)[:|](.+)$")if not _Kf then
 _Kf=_Ke end
_Kf=string.upper(_Kf):gsub("[^A-Z0-9]","")if _Kg==""then
 _Kg=nil end
return _Kf,_Kg
end
function guardTimer.Sellable(_Kh)if type(_Kh)~="number"or _Kh==112 then
 return false
end
local _Ki=ItemDB[_Kh]if not _Ki or _Ki.kind=="tool"then
 return false
end
if _Ki.lock or _Ki.area or _Ki.guildLock or _Ki.untradeable or _Ki.vend or _Ki.hub then
 return false end
return true
end
function guardTimer.Allow(_Kj)if not guardTimer.Sellable(_Kj)then
 return false
end
if type(config.vendItems)=="table"and#config.vendItems>0 and not table.find(config.vendItems,_Kj)then
 return false end
return true
end
function guardTimer.Machines()
local _Kk=getWorld()
local _Kl={}if not _Kk then
 return _Kl
end
local _Km=rawget(_Kk,"vends")
local _Kn=rawget(_Kk,"vendOwner")for _Ko=0,_Kk.h-1 do

local _Kp=_Kk.fg[_Ko]if _Kp then
 for _Kq=0,_Kk.w-1 do

local _Kr=_Kp[_Kq]or 0
local _Ks=_Kr~=0 and ItemDB[_Kr]if _Ks and _Ks.vend then

local _Kt,_Ku=true,true if type(_Kn)=="function"then
 _Kt,_Ku=pcall(_Kn,_Kq,_Ko)
end
if _Kt and _Ku then

local _Kv=nil if type(_Km)=="table"and type(_Km.get)=="function"then

local _Kw,_Kx=pcall(_Km.get,_Kq,_Ko)if _Kw and type(_Kx)=="table"then
 _Kv=_Kx
end
end
_Kv=_Kv or{}if not _Kv.shop then
 table.insert(_Kl,{x=_Kq,y=_Ko,fg=_Kr,id=_Kv.id,stock=tonumber(_Kv.stock)or 0,cap=(_Kr==9268)and 10398 or 5199,})
end
end
end
end
end
end
return _Kl
end
function guardTimer.Call(...)
local _Ky=getWorld()
local _Kz=_Ky and rawget(_Ky,"vendCall")if type(_Kz)~="function"then
 return false
end
local _KA,_KB=pcall(_Kz,...)return _KA and _KB==true
end
local function _KC(_KD,_KE)
local function _KF()return guardTimer.on and guardTimer.token==_KD and isAlive()
end
while _KF()do

local _KG=guardTimer.Machines()if#_KG==0 then
 guardTimer.status="Tidak ada Vending milikmu di world ini!"break
end
if config.vendMode=="Kosongkan sampai habis"then

local _KH=false for _KI,_KJ in ipairs(_KG)do
 if not _KF()then
 break
end
if _KJ.id and _KJ.stock>0 and guardTimer.Allow(_KJ.id)then
 guardTimer.status=string.format("Mengambil %s dari Vending (%d,%d)...",getItemName(_KJ.id),_KJ.x,_KJ.y)ClickTP.To(_KJ.x,_KJ.y,function()return not _KF()end,0.4,false)
local _KK=countInv(_KJ.id)guardTimer.Call("empty",_KJ.x,_KJ.y)task.wait(0.45)
local _KL=countInv(_KJ.id)-_KK if _KL>0 then
 guardTimer.taken=guardTimer.taken+_KL _KH=true
end
if countInv(_KJ.id)>=190 and autoPabrik and autoPabrik.ExternalDropSeed then
 autoPabrik.ExternalDropSeed(_KJ.id,countInv(_KJ.id),config.vendPoint,config.vendDropX,config.vendDropY,_KE,_KJ.x,_KJ.y,_KF)
end
end
end
if not _KH then
 guardTimer.status="Semua Vending sudah kosong!"break end
else

local _KM=false for _KN,_KO in ipairs(_KG)do
 if not _KF()then
 break
end
local _KP=(_KO.id and _KO.stock>0)and _KO.id or nil if _KP and guardTimer.Allow(_KP)then

local _KQ=math.min(countInv(_KP),_KO.cap-_KO.stock)if _KQ>0 then
 guardTimer.status=string.format("Mengisi %s +%d ke Vending (%d,%d)...",getItemName(_KP),_KQ,_KO.x,_KO.y)ClickTP.To(_KO.x,_KO.y,function()return not _KF()end,0.4,false)if guardTimer.Call("stock",_KO.x,_KO.y,_KP,_KQ)then
 guardTimer.stocked=guardTimer.stocked+_KQ _KM=true task.wait(0.35)
end
end
end
end
if not _KM then
 guardTimer.status="Menunggu item di tas / drop untuk dimasukkan ke Vending..."task.wait(2)
end
end
task.wait(0.5)
end
end
function guardTimer.Stop()if not guardTimer.on then
 return false end
guardTimer.token=guardTimer.token+1 guardTimer.on=false guardTimer.status="Mati"return true
end
function guardTimer.Start()if guardTimer.on then
 return true end
guardTimer.token=guardTimer.token+1
local _KR=guardTimer.token guardTimer.on=true guardTimer.status="Mulai..."
local _KS=getWorldName()task.spawn(function()pcall(_KC,_KR,_KS)if guardTimer.token==_KR then
 guardTimer.on=false if spliceSetup then
 spliceSetup()
end
end
end)return true
end
end)()end
do
(function()
local function _KT(_KU)return(tostring(_KU or""):gsub("`.",""))
end
local function _KV(_KW)if not(_bd and type(_be)=="table")then
 return nil
end
local _KX,_KY=pcall(_be.isDeveloper,_KW)if _KX and _KY then
 return "Developer"
end
local _KZ,_La=pcall(_be.isModerator,_KW)if _KZ and _La then
 return "Moderator"end
return nil
end
local function _Lb()
local _Lc={}
local _Ld=GameRefs.Others if not _Ld or type(rawget(_Ld,"list"))~="function"then
 return _Lc
end
local _Le,_Lf=pcall(_Ld.list)if not _Le or type(_Lf)~="table"then
 return _Lc
end
for _Lg,_Lh in ipairs(_Lf)do

local _Li=type(_Lh)=="table"and tonumber(_Lh[1]or _Lh.userId)if _Li and _Li~=LocalPlayer.UserId then
 _Lc[#_Lc+1]={id=_Li,name=_KT(_Lh[2]or _Lh.name or _Li),role=_KV(_Li)}
end
end
return _Lc
end
local function _Lj(_Lk)
local _Ll={}for _Lm,_Ln in ipairs(_Lk)do
 if _Ln.role or(config.guardWho=="Semua pemain"and not guardModule.allow[_Ln.id])then
 _Ll[#_Ll+1]=_Ln
end
end
return _Ll
end
local function _Lo(_Lp)
local _Lq=false if _Lp.role and _bd and type(_be.isUndercover)=="function"then

local _Lr,_Ls=pcall(_be.isUndercover,_Lp.id)_Lq=_Lr and _Ls==true end
return _Lp.name.." ("..(_Lp.role or "Pemain")..(_Lq and ", undercover"or"")..")"
end
local function _Lt(_Lu)
local _Lv={}for _Lw,_Lx in ipairs(_Lu)do
 if _Lw>5 then
 _Lv[#_Lv+1]="+"..(#_Lu-_Lw+1).." lagi"break end
_Lv[#_Lv+1]=_Lo(_Lx)end
return#_Lv>0 and table.concat(_Lv,", ")or "tidak ada"
end
local function _Ly()return(autoFarm.on and not autoFarm.Override)or autoClear.on or autoHarvest.on or autoDF.on or autoSplice.on or autoPabrik.on or autoChat.on
end
local function _Lz()
local _LA,_LB=getPlayerTile()return{farm=autoFarm.on and not autoFarm.Override,clear=autoClear.on,farmer=autoHarvest.on,df=autoDF.on,splice=autoSplice.on,pabrik=autoPabrik.on,spam=autoChat.on,world=getWorldName(),tx=_LA,ty=_LB,}
end
local function _LC()if autoPabrik.on then
 autoPabrik.Stop()
end
if autoSplice.on then
 autoSplice.Stop()
end
if autoFarm.on then
 _vu()
end
if autoClear.on then
 autoClear.Stop();autoClear.status="Dijeda Penjaga"
end
if autoHarvest.on then
 autoHarvest.Stop();autoHarvest.status="Dijeda Penjaga"
end
if autoDF.on then
 autoDF.Stop();autoDF.status="Dijeda Penjaga"
end
if autoChat.on then
 autoChat.on=false end
clearKeys()if spliceSetup then
 spliceSetup()
end
end
local function _LD()
local _LE=GameRefs.Menu if _LE and type(rawget(_LE,"openPicker"))=="function"and pcall(_LE.openPicker)then
 return true
end
local _LF=getWorld()if _LF and type(rawget(_LF,"call"))=="function"then
 return pcall(_LF.call,"LeaveWorld")end
return false
end
local function _LG(_LH)
local _LI=getWorld()if not _LI or _LH==""then
 return false
end
local _LJ=rawget(_LI,"fg")
local _LK=GameRefs.Menu if _LK and type(rawget(_LK,"enter"))=="function"then
 pcall(_LK.enter,_LH)elseif type(rawget(_LI,"enter"))=="function"then
 pcall(_LI.enter,_LH)else
 return false
end
local _LL=os.clock()while isAlive()and os.clock()-_LL<8 do

local _LM=getWorld()if _LM and rawget(_LM,"fg")~=_LJ then
 return true end
task.wait(0.25)end
return false
end
local function _LN(_LO,_LP)if not _LO then
 return
end
if _LO.world~=""and getWorldName()~=_LO.world then
 return
end
if _LO.spam then
 autoChat.on=true
end
if _LO.tx and _LO.ty then

local _LQ,_LR=getPlayerTile()if _LQ and(_LQ~=_LO.tx or _LR~=_LO.ty)then
 guardModule.status=string.format("Jalan balik ke (%d,%d)...",_LO.tx,_LO.ty)ClickTP.To(_LO.tx,_LO.ty,function()return(_LP and guardModule.token~=_LP)or not isAlive()end,0.3,true)
end
end
if _LP and guardModule.token~=_LP then
 return
end
if _LO.farm then
 _vt()elseif _LO.clear then
 autoClear.Start()elseif _LO.farmer then
 autoHarvest.Start()elseif _LO.df then
 autoDF.Start()elseif _LO.splice then
 autoSplice.Start()elseif _LO.pabrik then
 autoPabrik.Start()
end
if spliceSetup then
 spliceSetup()
end
end
guardModule.Snapshot=_Lz guardModule.StopAllBots=_LC guardModule.LeaveWorld=_LD guardModule.EnterWorld=_LG guardModule.ResumeSaved=_LN guardModule.AnyRunning=_Ly function guardModule.AllowCurrentPlayers()
local _LS=0 for _LT,_LU in ipairs(_Lb())do
 if not _LU.role then
 guardModule.allow[_LU.id]=true _LS+=1
end
end
return _LS
end
function guardModule.Set(_LV)guardModule.on=_LV guardModule.token+=1 guardModule.mode,guardModule.saved,guardModule.calmAt="idle",nil,nil table.clear(guardModule.alerted)table.clear(guardModule.allow)if _LV then
 guardModule.AllowCurrentPlayers()guardModule.status="Aman (Memantau)"else
 guardModule.status="Mati"
end
end
task.spawn(function()while isAlive()do
 pcall(function()
local _LW={}for _LX,_LY in ipairs(Players:GetPlayers())do
 if _LY~=LocalPlayer then

local _LZ=_KV(_LY.UserId)if _LZ then
 table.insert(_LW,(_LY.DisplayName or _LY.Name).." (".._LZ..")")
end
end
end
guardModule.staffServerText=#_LW>0 and table.concat(_LW,", ")or "tidak ada"
local _Ma=(guardModule.mode~="away"and guardModule.mode~="out")and _Lb()or{}guardModule.hereText=_Lt(_Ma)if not guardModule.on then
 guardModule.status="Mati"return
end
local _Mb=os.clock()if guardModule.mode=="away"or guardModule.mode=="out"then

local _Mc=guardModule.saved and guardModule.saved.world or""if guardModule.mode=="out"or _Mc==""then
 guardModule.status="Sudah keluar world"return
end
local _Md=guardModule.backAt-_Mb if _Md>0 then
 guardModule.status=string.format("Di luar world. Masuk %s dlm %ds",_Mc,math.ceil(_Md))return end
guardModule.status="Masuk kembali ke ".._Mc.."..."if _LG(_Mc)then
 GameRefs.Scan()task.wait(1.5)
local _Me=_Lj(_Lb())if#_Me>0 then
 notify("Masih ada ".._Lt(_Me).."! Keluar lagi.","Penjaga ANCH")_LD()guardModule.backAt=os.clock()+config.guardBackSec else
 notify("World sudah aman, melanjutkan aktivitas!","Penjaga ANCH")webhook.Send("penjaga","World ".._Mc.." aman, lanjut aktivitas")
local _Mf=guardModule.saved guardModule.mode,guardModule.saved="idle",nil guardModule.token+=1
local _Mg=guardModule.token task.spawn(_LN,_Mf,_Mg)end
else
 guardModule.backAt=os.clock()+math.max(15,config.guardBackSec)end
return
end
local _Mh={}for _Mi,_Mj in ipairs(_Ma)do
 _Mh[_Mj.id]=true
end
for _Mk in pairs(guardModule.alerted)do
 if not _Mh[_Mk]then
 guardModule.alerted[_Mk]=nil
end
end
local _Ml=_Lj(_Ma)
local _Mm={}for _Mn,_Mo in ipairs(_Ml)do
 if not guardModule.alerted[_Mo.id]then
 guardModule.alerted[_Mo.id]=true _Mm[#_Mm+1]=_Mo
end
end
if#_Mm>0 then
 guardModule.detected+=#_Mm
local _Mp="Terdeteksi masuk world "..getWorldName()..": ".._Lt(_Mm)notify(_Mp,"PERINGATAN PENJAGA",6)webhook.Send("penjaga",_Mp)if config.guardStopAll or config.guardLeave then
 if not guardModule.saved then
 guardModule.saved=_Lz()end
guardModule.token+=1 _LC()guardModule.calmAt=nil if config.guardLeave then
 if _LD()then
 guardModule.backAt=os.clock()+config.guardBackSec guardModule.mode=config.guardAutoBack and "away"or "out"guardModule.status="Keluar world"return
end
end
guardModule.mode="pause"
end
end
if#_Ml>0 then
 guardModule.calmAt=nil guardModule.status=(guardModule.mode=="pause"and "Dijeda! Ada: "or "Waspada! Ada: ").._Lt(_Ml)elseif guardModule.mode=="pause"then
 guardModule.calmAt=guardModule.calmAt or _Mb
local _Mq=config.guardCalmSec-(_Mb-guardModule.calmAt)if _Mq>0 then
 guardModule.status=string.format("Sudah sepi. Lanjut dlm %ds...",math.ceil(_Mq))else
 guardModule.calmAt=nil
local _Mr=guardModule.saved guardModule.mode,guardModule.saved="idle",nil if config.guardAutoBack and _Mr then
 notify("World aman, melanjutkan aktivitas!","Penjaga ANCH")guardModule.token+=1
local _Ms=guardModule.token task.spawn(_LN,_Mr,_Ms)
end
end
else
 guardModule.status="Aman (Memantau)"
end
end)task.wait(0.5)
end
end)function bonusModule.TargetWorld()
local _Mt=tostring(config.targetWorld or""):upper():gsub("[^A-Z0-9]","")if _Mt~=""then
 return _Mt end
return config.lastWorld or""end
task.spawn(function()while isAlive()do

local _Mu=getWorldName()if _Mu~=""and not autoPabrik.traveling then
 config.lastWorld=_Mu
end
if _Ly()and guardModule.mode=="idle"then
 bonusModule.last=_Lz()bonusModule.lastAt=os.clock()end
task.wait(1)
end
end)
local function _Mv(_Mw)if not(config.reconnectOn and config.reconnectWorld)or bonusModule.busy or autoPabrik.traveling then
 return
end
if guardModule.mode=="away"or guardModule.mode=="out"then
 return
end
local _Mx=bonusModule.last if not _Mx or _Mx.world==""or os.clock()-bonusModule.lastAt>15 then
 return end
bonusModule.busy=true task.spawn(function()_LC()bonusModule.status="Terlempar dari ".._Mx.world..". Masuk lagi..."webhook.Send("rejoin","Terlempar dari world ".._Mx.world.." (".._KT(_Mw)..")")task.wait(config.reconnectDelay+1.5)for _My=1,3 do
 if not isAlive()or not config.reconnectOn then
 break
end
if _LG(_Mx.world)then
 GameRefs.Scan()task.wait(1.5)bonusModule.count+=1 bonusModule.status="Berhasil masuk lagi ke ".._Mx.world webhook.Send("rejoin","Berhasil masuk kembali ke ".._Mx.world)_LN(_Mx,nil)bonusModule.busy=false return end
bonusModule.status=string.format("Gagal masuk (%d/3), coba lagi...",_My)task.wait(8)end
bonusModule.busy=false
end)end
if WorldClosed and WorldClosed:IsA("RemoteEvent")then
 trackConn(WorldClosed.OnClientEvent:Connect(function(_Mz)if isAlive()then
 _Mv(_Mz)
end
end))end
task.spawn(function()
local _MA=nil while isAlive()do
 task.wait(2)
local _MB=getWorldName()==""
local _MC=config.reconnectOn and config.reconnectKeep and not bonusModule.busy and not bonusModule.leaving and not autoPabrik.traveling and guardModule.mode=="idle"if not(_MB and _MC)then
 _MA=nil else
 _MA=_MA or os.clock()
local _MD=bonusModule.TargetWorld()if _MD~=""and os.clock()-_MA>=config.reconnectDelay then
 _MA=nil bonusModule.busy=true bonusModule.status="Di luar world, masuk ke ".._MD.."..."if _LG(_MD)then
 GameRefs.Scan()task.wait(1.5)bonusModule.count+=1 bonusModule.status="Kembali otomatis ke ".._MD if bonusModule.last and bonusModule.last.world==_MD then
 _LN(bonusModule.last,nil)
end
end
bonusModule.busy=false
end
end
end
end)pcall(function()trackConn(GuiService.ErrorMessageChanged:Connect(function(_ME)if not isAlive()or type(_ME)~="string"or _ME==""then
 return
end
if not(config.reconnectOn and config.reconnectServer)or bonusModule.leaving then
 return end
bonusModule.leaving=true
local _MF=bonusModule.last or(_Ly()and _Lz())or nil
local _MG=(_MF and _MF.world)or getWorldName()if writefile and _MF then
 _MF.at=os.time()pcall(writefile,rejoinFile,HttpService:JSONEncode(_MF))
end
if _se then
 pcall(_se)end
webhook.Send("rejoin","Disconnect dari server (".._ME.."). Rejoin otomatis...")task.spawn(function()task.wait(config.reconnectDelay)while isAlive()do
 pcall(function()TeleportService:Teleport(game.PlaceId,LocalPlayer,(_MG~="")and{world=_MG}or nil)end)task.wait(12)
end
end)end))
end)function bonusModule.CheckStartup()pcall(function()if not(isfile and readfile and isfile(rejoinFile))then
 return
end
local _MH=readfile(rejoinFile)if delfile then
 pcall(delfile,rejoinFile)
end
local _MI=HttpService:JSONDecode(_MH)if type(_MI)~="table"or type(_MI.world)~="string"or _MI.world==""then
 return
end
if os.time()-(tonumber(_MI.at)or 0)>900 then
 return end
bonusModule.busy=true bonusModule.status="Pulihkan sesi setelah Rejoin Server: ".._MI.world
local _MJ=os.clock()
local _MK=false while isAlive()and os.clock()-_MJ<50 do
 if getWorldName()==_MI.world and getPlayerTile()then
 break
end
if getWorldName()==""and not _MK and os.clock()-_MJ>8 then
 _MK=true _LG(_MI.world)end
task.wait(2)
end
if isAlive()and getWorldName()==_MI.world then
 GameRefs.Scan()task.wait(1.5)bonusModule.count+=1 webhook.Send("rejoin","Berhasil rejoin server ke world ".._MI.world..", melanjutkan bot!")_LN(_MI,nil)end
bonusModule.busy=false
end)end
end)()
end
local ml_module={claimed=0,redeemed=0,tried={},questFail={},questText="-",codeText="-",nextQuest=0,nextCode=0,}
local liteModeModule={saved={}}do
(function()
local function _MN(_MO)
local _MP=tostring(math.floor(tonumber(_MO)or 0))
local _MQ=_MP:sub(1,1)=="-"if _MQ then
 _MP=_MP:sub(2)
end
local _MR=_MP:reverse():gsub("(%d%d%d)","%1."):reverse():gsub("^%.","")return(_MQ and "-"or"").._MR
end
local function _MS(_MT)_MT=math.max(0,math.floor(_MT or 0))return string.format("%dj %dm %dd",_MT//3600,(_MT%3600)//60,_MT%60)
end
function stats.GemsNow()
local _MU=GameRefs.Gems
local _MV=_MU and rawget(_MU,"addGems")if type(_MV)~="function"then
 return nil
end
for _MW,_MX in pairs(getUpvalues(_MV))do
 if type(_MX)=="number"then
 return _MX
end
end
return nil
end
function stats.Reset()stats.T0=os.clock()stats.Gems0=stats.GemsNow()stats.Placed=0 stats.Broken=0 stats.Collected=0 stats.Harvested=0 stats.Planted=0 table.clear(stats.Items)
end
function stats.Text()
local _MY=math.max((os.clock()-stats.T0)/3600,1/3600)
local function _MZ(_Na,_Nb)return string.format("%s: %s (%s/hr)",_Na,_MN(_Nb),_MN(_Nb/_MY))
end
local _Nc=stats.GemsNow()if _Nc and not stats.Gems0 then
 stats.Gems0=_Nc
end
local _Nd="Gems: -"if _Nc and stats.Gems0 then

local _Ne=_Nc-stats.Gems0 _Nd=string.format("Gems: %s (%s%s, %s/hr)",_MN(_Nc),_Ne>=0 and "+"or"",_MN(_Ne),_MN(_Ne/_MY))
end
local _Nf={}for _Ng,_Nh in pairs(stats.Items)do
 table.insert(_Nf,{id=_Ng,n=_Nh})end
table.sort(_Nf,function(_Ni,_Nj)return _Ni.n>_Nj.n
end)
local _Nk={}for _Nl=1,math.min(5,#_Nf)do
 _Nk[_Nl]=getItemName(_Nf[_Nl].id).." x".._MN(_Nf[_Nl].n)end
return table.concat({"Session Time: ".._MS(os.clock()-stats.T0),_Nd,_MZ("Blocks Broken",stats.Broken),_MZ("Blocks Placed",stats.Placed),_MZ("Drops Collected",stats.Collected),_MZ("Trees Harvested",stats.Harvested),_MZ("Seeds Planted",stats.Planted),"Top Collected: "..(#_Nk>0 and table.concat(_Nk,", ")or "-"),},"\n")end
task.spawn(function()
local _Nm=os.clock()while isAlive()do
 if config.webhookReportMin>0 and(os.clock()-_Nm)>=config.webhookReportMin*60 then
 _Nm=os.clock()
local _Nn,_No=pcall(stats.Text)if _Nn then
 webhook.Send("report","Laporan Statistik Sesi\n```\n".._No.."\n```")end
elseif config.webhookReportMin<=0 then
 _Nm=os.clock()end
task.wait(2)
end
end)
local function _Np()
local _Nq=TextChatService:FindFirstChild("WorldChannels")if not _Nq then
 return nil
end
local _Nr=getWorldName()if _Nr~=""and _Nq:FindFirstChild(_Nr)then
 return _Nq:FindFirstChild(_Nr)
end
for _Ns,_Nt in ipairs(_Nq:GetChildren())do
 if _Nt:IsA("TextChannel")then
 for _Nu,_Nv in ipairs(_Nt:GetChildren())do
 if _Nv:IsA("TextSource")and _Nv.UserId==LocalPlayer.UserId then
 return _Nt
end
end
end
end
return nil
end
function autoChat.SendNext()
local _Nw=trim(config.chatText)if _Nw==""then
 autoChat.last="Pesan chat belum diisi"return false
end
local _Nx=_Np()if not _Nx then
 autoChat.last="Channel chat belum ada"return false
end
local _Ny,_Nz=pcall(_Nx.SendAsync,_Nx,_Nw)if _Ny then
 autoChat.sent+=1 autoChat.last=_Nw else
 autoChat.last="Gagal: "..tostring(_Nz)end
return _Ny end
task.spawn(function()while isAlive()do
 if autoChat.on and os.clock()>=autoChat.nextAt then
 autoChat.SendNext()autoChat.nextAt=os.clock()+math.max(3,config.chatInterval)end
task.wait(0.3)
end
end)
local function _NA(_NB)return(tostring(_NB or""):gsub("`.",""))
end
local function _NC(...)if netOk and type(Net)=="table"and type(Net.call)=="function"then
 return pcall(Net.call,...)end
return false,"Net.call tidak tersedia"
end
function ml_module.CheckQuests()
local _ND,_NE,_NF=_NC("Quests","list")if not _ND or not _NE or type(_NF)~="table"or type(_NF.quests)~="table"then
 ml_module.questText="Quest belum terbaca dari server"return
end
local _NG,_NH=0,0
local _NI=os.clock()for _NJ,_NK in ipairs(_NF.quests)do
 _NG+=1
local _NL,_NM=tonumber(_NK.have)or 0,tonumber(_NK.need)or math.huge if _NK.claimed then
 _NH+=1 elseif _NL>=_NM and not((ml_module.questFail[_NK.id]or 0)>_NI)then

local _NN,_NO,_NP,_NQ,_NR=_NC("Quests","claim",_NK.id)if _NN and _NO then
 _NH+=1 ml_module.claimed+=1
local _NS=_NA(_NK.text or _NK.id)notify("Quest diklaim: ".._NS,"Bonus ANCH")webhook.Send("bonus","Quest diklaim: ".._NS)if type(_NR)=="number"and GameRefs.Gems and type(GameRefs.Gems.setGems)=="function"then
 pcall(GameRefs.Gems.setGems,_NR)end
else
 ml_module.questFail[_NK.id]=_NI+120 end
task.wait(0.5)
end
end
ml_module.questText=string.format("Selesai: %d/%d | Diklaim script: %d",_NH,_NG,ml_module.claimed)
end
function ml_module.RedeemSingle(_NT)
local _NU,_NV=_NC("ModCommand","redeemcode",_NT)if not _NU then
 return nil,"Gagal menghubungi server"
end
local _NW=type(_NV)=="table"and type(_NV.lines)=="table"and _NV.lines or nil if not _NW then
 return false,"Balasan kosong"
end
local _NX=tostring(_NW[1]or"")
local _NY={}for _NZ,_Oa in ipairs(_NW)do
 table.insert(_NY,_NA(_Oa))end
return string.sub(_NX,1,2)=="`2",table.concat(_NY," ")
end
function ml_module.CheckCodes()
local _Ob,_Oc=_NC("ActiveCodes")if not _Ob or type(_Oc)~="table"then
 ml_module.codeText="Gagal mengambil ActiveCodes"return
end
if _Oc.note~=nil then
 ml_module.codeText="Redeem ditutup: ".._NA(_Oc.note)return
end
local _Od,_Oe=0,0 for _Of,_Og in ipairs(_Oc)do
 _Od+=1
local _Oh=_Og.code and tostring(_Og.code)if _Og.done then
 _Oe+=1 elseif _Oh and not ml_module.tried[_Oh]and not(type(_Og.uses)=="number"and _Og.uses==0)then

local _Oi,_Oj=ml_module.RedeemSingle(_Oh)if _Oi~=nil then
 ml_module.tried[_Oh]=true
end
if _Oi then
 _Oe+=1 ml_module.redeemed+=1 notify(_Oh.." -> "..tostring(_Oj),"Redeem Berhasil!")webhook.Send("bonus","Redeem berhasil ".._Oh..": "..tostring(_Oj))end
task.wait(0.8)
end
end
ml_module.codeText=string.format("Code aktif: %d | Sudah ditukar: %d | Baru: %d",_Od,_Oe,ml_module.redeemed)end
task.spawn(function()while isAlive()do

local _Ok=os.clock()if config.bonusAutoQuest and _Ok>=ml_module.nextQuest then
 ml_module.nextQuest=_Ok+30 pcall(ml_module.CheckQuests)
end
if config.bonusAutoRedeem and _Ok>=ml_module.nextCode then
 ml_module.nextCode=_Ok+300 pcall(ml_module.CheckCodes)end
task.wait(1)
end
end)
local _Ol=setmetatable({},{__index=function()return 0 end,__newindex=function()end
})
local _Om=setmetatable({l=_Ol,k={}},{__index=function()return 0 end,__newindex=function()end
})local _On _On=setmetatable({},{__index=function()return _On end,__newindex=function()end,__call=function()return _On end,})
local function _Oo(_Op,_Oq,_Or)if type(_Op)=="table"and type(rawget(_Op,_Oq))=="function"then
 table.insert(liteModeModule.saved,{_Op,_Oq,rawget(_Op,_Oq)})_Op[_Oq]=_Or
end
end
function liteModeModule.Set(_Os)config.liteMode=_Os if _Os then
 if#liteModeModule.saved==0 then
 if _bk and _bl then
 _Oo(_bl,"spawn",function()return _Om
end)end
if _bf and _bg then
 _Oo(_bg,"play",function()return _On end)_Oo(_bg,"playAt",function()return _On
end)end
end
for _Ot,_Ou in ipairs(GameRefs.Particles)do
 pcall(function()for _Ov,_Ow in ipairs(_Ou.live)do
 if typeof(_Ow.l)=="Instance"then
 _Ow.l.Visible=false
end
end
end)end
else
 for _Ox,_Oy in ipairs(liteModeModule.saved)do
 pcall(function()_Oy[1][_Oy[2]]=_Oy[3]
end)end
table.clear(liteModeModule.saved)
end
end
local _Oz={t0=os.clock(),tag=nil,panel=nil}
local _OA=ColorSequence.new({ColorSequenceKeypoint.new(0.00,Color3.fromRGB(48,255,106)),ColorSequenceKeypoint.new(0.25,Color3.fromRGB(60,205,255)),ColorSequenceKeypoint.new(0.50,Color3.fromRGB(231,255,47)),ColorSequenceKeypoint.new(0.75,Color3.fromRGB(60,205,255)),ColorSequenceKeypoint.new(1.00,Color3.fromRGB(48,255,106)),})
local _OB=Enum.Font.FredokaOne
local function _OC()
local _OD=PlayerGui:FindFirstChild("GameGui")
local _OE=_OD and _OD:FindFirstChild("World")
local _OF=_OE and _OE:FindFirstChild("Camera")
local _OG=PlayerGui:FindFirstChild("ChatGui")
local _OH=_OG and _OG:FindFirstChild("HUD")
local _OI=_OH and _OH:FindFirstChild("PlayerPanel")return _OF and _OF:FindFirstChild("NameTag"),_OI and _OI:FindFirstChild("Name")
end
local function _OJ(_OK,_OL)
local _OM,_ON=pcall(TextService.GetTextSize,TextService,_OK,_OL,_OB,Vector2.new(2000,200))return(_OM and _ON.X or#_OK*_OL*0.55)+6
end
local function _OO(_OP,_OQ,_OR)
local _OS=Instance.new("TextLabel")_OS.Name="ANCHWatermark"_OS.BackgroundTransparency=1 _OS.Font=_OB _OS.TextSize=_OQ _OS.TextColor3=Color3.new(1,1,1)_OS.Text=config.watermarkText _OS.ZIndex=_OR and 1017 or 10 if _OR then
 _OS.AnchorPoint=Vector2.new(0.5,0.5)_OS.Position=UDim2.fromScale(0.5,0.5)else
 _OS.AnchorPoint=Vector2.new(0,0.5)_OS.Position=UDim2.new(0,3,0.5,0)_OS.TextXAlignment=Enum.TextXAlignment.Left
end
local _OT=Instance.new("UIStroke",_OS)_OT.Thickness=2 _OT.Color=Color3.fromRGB(18,28,20)
local _OU=Instance.new("UIGradient",_OS)_OU.Color=_OA _OU.Rotation=12
local _OV=Instance.new("UIScale",_OS)_OS.Parent=_OP return{holder=_OP,bitmap=_OP:FindFirstChild("BitmapText"),label=_OS,gr=_OU,sc=_OV,size=_OQ,isTag=_OR,text=nil,w=0}
end
local function _OW(_OX)if not _OX then
 return end
pcall(function()_OX.label:Destroy()
end)if _OX.bitmap then
 pcall(function()_OX.bitmap.Visible=true
end)end
end
function session.RestoreWatermark()_OW(_Oz.tag)_OW(_Oz.panel)_Oz.tag,_Oz.panel=nil,nil
end
local function _OY(_OZ,_Pa,_Pb,_Pc)if not _Pa then
 _OW(_OZ);return nil
end
if not _OZ or _OZ.holder~=_Pa or not _OZ.label.Parent then
 _OW(_OZ)_OZ=_OO(_Pa,_Pb,_Pc)
end
if _OZ.text~=config.watermarkText then
 _OZ.text=config.watermarkText _OZ.label.Text=config.watermarkText _OZ.w=_OJ(config.watermarkText,_Pb)
end
if _OZ.bitmap and _OZ.bitmap.Visible then
 _OZ.bitmap.Visible=false
end
if _Pc then

local _Pd=math.max(_Pa.Size.Y.Offset,_Pb+6)_OZ.label.Size=UDim2.fromOffset(_OZ.w,_Pd)_Pa.Size=UDim2.fromOffset(_OZ.w,_Pa.Size.Y.Offset)else
 _OZ.label.Size=UDim2.new(1,-6,1,0)end
return _OZ end
trackConn(RunService.RenderStepped:Connect(function()if not isAlive()then
 return
end
if not config.customWatermark then
 if _Oz.tag or _Oz.panel then
 session.RestoreWatermark()end
return
end
local _Pe,_Pf=_OC()_Oz.tag=_OY(_Oz.tag,_Pe,22,true)_Oz.panel=_OY(_Oz.panel,_Pf,21,false)
local _Pg=os.clock()-_Oz.t0
local _Ph=Vector2.new(((_Pg*0.45)%2)-1,0)
local _Pi=1+0.045*math.sin(_Pg*3.2)if _Oz.tag then
 _Oz.tag.gr.Offset=_Ph;_Oz.tag.sc.Scale=_Pi
end
if _Oz.panel then
 _Oz.panel.gr.Offset=_Ph;_Oz.panel.sc.Scale=_Pi
end
end))end)()
end
local _Pj,_Pk,_Pl,_Pm,_Pn,_Po,_Pp=false,false,false,false,false,false,false
local _Pq,_Pr,_Ps,_Pt,_Pu,_Pv
local _Pw,_Px,_Py,_Pz,_PA,_PB
local _PC,_PD,_PE,_PF,_PG,_PH
local _PI,_PJ,_PK,_PL,_PM,_PN do
(function()
local _PO={}
local function _PP()
local _PQ={}
local _PR=getRigs()if not _PR then
 return _PQ
end
for _PS,_PT in ipairs({1,-1,0})do

local _PU=rawget(_PR,_PT)if type(_PU)=="table"then
 for _PV,_PW in ipairs({"body","head","eyelids","blink","forearm","fist"})do

local _PX=_PU[_PW]if typeof(_PX)=="Instance"then
 table.insert(_PQ,{part=_PX,face=false})
end
end
for _PY,_PZ in ipairs({"armBack","armFront"})do

local _Qa=_PU[_PZ]
local _Qb=(typeof(_Qa)=="Instance"and _Qa:FindFirstChild("Sprite"))or(type(_Qa)=="table"and _Qa.Sprite)if typeof(_Qb)=="Instance"then
 table.insert(_PQ,{part=_Qb,face=false})
end
end
if typeof(_PU.face)=="Instance"then
 table.insert(_PQ,{part=_PU.face,face=true})
end
end
end
return _PQ
end
function _Pr()if not _Pj then
 return false end
_Pj=false for _Qc,_Qd in pairs(_PO)do
 pcall(function()_Qc.ImageColor3=_Qd
end)end
table.clear(_PO)return true
end
function _Pq()if _Pj then
 return true
end
if not getRigs()then
 notify("Rig karakter tidak ditemukan!");return false end
_Pj=true table.clear(_PO)for _Qe,_Qf in ipairs(_PP())do
 _PO[_Qf.part]=_Qf.part.ImageColor3 end
task.spawn(function()while _Pj and isAlive()do

local _Qg=Color3.fromHSV(math.random(),0.55+math.random()*0.4,1)
local _Qh=Color3.new(_Qg.R*0.38,_Qg.G*0.35,_Qg.B*0.3)for _Qi,_Qj in ipairs(_PP())do
 if _PO[_Qj.part]==nil then
 _PO[_Qj.part]=_Qj.part.ImageColor3 end
pcall(function()_Qj.part.ImageColor3=_Qj.face and _Qh or _Qg
end)end
local _Qk=math.min(config.blinkMin,config.blinkMax)
local _Ql=math.max(config.blinkMin,config.blinkMax)task.wait(_Qk+math.random()*(_Ql-_Qk))
end
end)return true
end
local _Qm=nil function _Ps()
local _Qn=getInvTable()if not _Qn then
 notify("Inventory belum ditemukan!");return false
end
if not _Qm then
 _Qm={build=_Qn.buildRange,punch=_Qn.punchRange}
end
local _Qo=2.5+config.longhandRange _Qn.buildRange=function()return math.max(_Qm.build(),_Qo)end
_Qn.punchRange=function()return math.max(_Qm.punch(),_Qo)end
_Pk=true return true
end
function _Pt()if not _Pk then
 return false
end
local _Qp=getInvTable()if _Qp and _Qm then
 _Qp.buildRange=_Qm.build _Qp.punchRange=_Qm.punch end
_Pk=false return true
end
local _Qq=nil
local function _Qr(_Qs,...)if _Pl and _Qs==4992 and not keyState.active then
 return true
end
if _Qq then
 return _Qq(_Qs,...)end
return false
end
function _Pu()if _Pl then
 return true end
_Pl=true
local _Qt=getWorld()if _Qt and type(rawget(_Qt,"jammerOn"))=="function"and rawget(_Qt,"jammerOn")~=_Qr then
 _Qq=rawget(_Qt,"jammerOn")_Qt.jammerOn=_Qr end
return true
end
function _Pv()if not _Pl then
 return false end
_Pl=false
local _Qu=getWorld()if _Qu and _Qq and rawget(_Qu,"jammerOn")==_Qr then
 _Qu.jammerOn=_Qq end
return true
end
local _Qv=nil
local _Qw=clonerefFn and clonerefFn(game:GetService("VirtualInputManager"))or game:GetService("VirtualInputManager")
local function _Qx()if getconnections then
 pcall(function()for _Qy,_Qz in ipairs(getconnections(LocalPlayer.Idled))do
 if _Qz.Function==nil then
 if _Qz.Disable then
 _Qz:Disable()elseif _Qz.Disconnect then
 _Qz:Disconnect()
end
end
end
end)
end
end
local function _QA()pcall(function()VirtualUser:CaptureController()
local _QB=workspace.CurrentCamera
local _QC=_QB and _QB.CFrame or CFrame.new()VirtualUser:Button2Down(Vector2.new(0,0),_QC)task.wait(0.08)VirtualUser:Button2Up(Vector2.new(0,0),_QC)VirtualUser:ClickButton2(Vector2.new(0,0))
end)end
function _Pw()if _Pm then
 return true end
_Pm=true _Qx()_Qv=trackConn(LocalPlayer.Idled:Connect(function()if _Pm and isAlive()then
 _Qx()_QA()
end
end))task.spawn(function()while _Pm and isAlive()do
 _Qx()_QA()task.wait(60)
end
end)return true
end
function _Px()if not _Pm then
 return false end
_Pm=false if _Qv then
 _Qv:Disconnect();_Qv=nil end
return true
end
local _QD,_QE=nil,nil
local _QF=nil trackConn(UserInputService.InputBegan:Connect(function(_QG)if not isAlive()then
 return
end
if _QG.UserInputType==Enum.UserInputType.MouseButton1 or _QG.UserInputType==Enum.UserInputType.Touch then

local _QH,_QI=ClickTP.ScreenToTile(_QG.Position)if _QH and _QI then
 _QD,_QE=_QH,_QI
end
end
end))
local function _QJ()if config.fastPull then
 return "pull","Fast Pull"
end
if config.fastKick then
 return "kick","Fast Kick"
end
if config.fastBan then
 return "ban","Fast Ban"end
return nil,nil
end
local function _QK(_QL)
local _QM=_QL or _QF if type(_QM)=="table"then
 _QF=_QM
local _QN=rawget(_QM,"close")if type(_QN)=="function"then
 pcall(_QN)
end
local _QO=rawget(_QM,"box")if typeof(_QO)=="Instance"and _QO:IsA("GuiObject")then
 pcall(function()_QO.Visible=false
end)end
end
pcall(function()
local _QP=PlayerGui:FindFirstChild("MenuGui")
local _QQ=_QP and _QP:FindFirstChild("Player")if _QQ and _QQ:IsA("GuiObject")then
 _QQ.Visible=false
end
end)
end
local function _QR(_QS)
local _QT,_QU,_QV=nil,nil,nil if not(debug and debug.info and getUpvalue)then
 return nil,nil,nil
end
for _QW=2,10 do

local _QX,_QY=pcall(debug.info,_QW,"f")if not _QX or type(_QY)~="function"then
 break
end
for _QZ=1,20 do

local _Ra,_Rb=pcall(getUpvalue,_QY,_QZ)if not _Ra then
 break
end
if type(_Rb)=="table"then
 if not _QV and type(rawget(_Rb,"close"))=="function"and type(rawget(_Rb,"isOpen"))=="function"and rawget(_Rb,"box")~=nil then
 _QV=_Rb _QF=_Rb
end
local _Rc=tonumber(rawget(_Rb,"userId"))
local _Rd=tonumber(rawget(_Rb,"id"))
local _Re=rawget(_Rb,"name")if _Rc and _Rc>1000 and _Rc~=LocalPlayer.UserId then
 if not _QT or(_QS~=nil and _Rd==tonumber(_QS))then
 _QT=_Rc _QU=type(_Re)=="string"and _Re:gsub("`.","")or tostring(_Rc)
end
end
end
end
end
return _QT,_QU,_QV
end
local function _Rf(_Rg)
local _Rh,_Ri,_Rj=_QR(_Rg)if _Rh then
 return _Rh,_Ri,_Rj
end
local _Rk=GameRefs.Others if not _Rk then
 GameRefs.Scan();_Rk=GameRefs.Others
end
local _Rl={}if _Rk and type(rawget(_Rk,"list"))=="function"then

local _Rm,_Rn=pcall(_Rk.list)if _Rm and type(_Rn)=="table"then
 for _Ro,_Rp in pairs(_Rn)do
 if type(_Rp)=="table"then

local _Rq=tonumber(_Rp[1]or _Rp.userId)
local _Rr=tostring(_Rp[2]or _Rp.name or _Rq or""):gsub("`.","")if _Rq and _Rq~=LocalPlayer.UserId then
 if _Rg~=nil and(_Ro==_Rg or _Rp.id==_Rg or _Rp.pid==_Rg)then
 return _Rq,_Rr,_Rj end
table.insert(_Rl,{uid=_Rq,name=_Rr})
end
end
end
end
end
if _Rk and _QD and _QE and type(rawget(_Rk,"where"))=="function"and#_Rl>0 then

local _Rs,_Rt,_Ru=nil,nil,math.huge for _Rv,_Rw in ipairs(_Rl)do

local _Rx,_Ry,_Rz=pcall(_Rk.where,_Rw.uid)if _Rx and type(_Ry)=="table"then
 _Ry,_Rz=_Ry.x or _Ry[1],_Ry.y or _Ry[2]
end
if _Rx and type(_Ry)=="number"and type(_Rz)=="number"then

local _RA=math.abs(_Ry-_QD)+math.abs(_Rz-_QE)if _RA<_Ru then
 _Rs,_Rt,_Ru=_Rw.uid,_Rw.name,_RA
end
end
end
if _Rs and _Ru<=6 then
 return _Rs,_Rt,_Rj
end
end
if#_Rl>=1 then
 return _Rl[1].uid,_Rl[1].name,_Rj
end
for _RB,_RC in ipairs(Players:GetPlayers())do
 if _RC~=LocalPlayer then
 return _RC.UserId,_RC.DisplayName or _RC.Name,_Rj
end
end
return nil,nil,_Rj end
pcall(function()
local _RD=PlayerGui:FindFirstChild("MenuGui")
local _RE=_RD and _RD:FindFirstChild("Player")if _RE and _RE:IsA("GuiObject")then
 trackConn(_RE:GetPropertyChangedSignal("Visible"):Connect(function()if isAlive()and _RE.Visible and _QJ()then
 if os.clock()-(genv.__ANCH_LastFastWrench or 0)<0.8 then
 _QK(_QF)
end
end
end))
end
end)if not genv.__ANCH_TrueOrigNetCall and netOk and type(Net)=="table"and type(Net.call)=="function"then

local _RF=Net.call if isexecutorclosure and pcall(isexecutorclosure,_RF)and isexecutorclosure(_RF)then
 for _RG,_RH in pairs(getUpvalues(_RF))do
 if type(_RH)=="function"and not(pcall(isexecutorclosure,_RH)and isexecutorclosure(_RH))then
 genv.__ANCH_TrueOrigNetCall=_RH break
end
end
else
 genv.__ANCH_TrueOrigNetCall=_RF
end
end
local _RI=genv.__ANCH_TrueOrigNetCall or(netOk and type(Net)=="table"and Net.call)or nil
local _RJ={}
local _RK=0 local _RL
local function _RM(_RN,_RO,_RP,_RQ,_RR,_RS)_RK=os.clock()genv.__ANCH_LastFastWrench=_RK _QK(_RS)task.defer(function()_QK(_RS)end)task.spawn(function()pcall(_RN,"WorldCommand",_RO,"#"..tostring(_RQ))pcall(_RN,"SetBusy",0)task.wait(0.04)_QK(_RS)notify(string.format("%s -> %s (#%s)",_RP,tostring(_RR or "Player"),tostring(_RQ)),_RP,2)
end)end
local function _RT(_RU,_RV,_RW,...)
local _RX,_RY=_QJ()if _RX then
 if _RV=="GetPlayerLevel"or _RV=="WrenchPlayer"or _RV=="PlayerInfo"then

local _RZ,_Sa,_Sb=_Rf(_RW)if _RZ then
 if os.clock()-_RK>0.15 then
 _RM(_RU,_RX,_RY,_RZ,_Sa,_Sb)else
 _QK(_Sb)end
return nil end
elseif _RV=="SetBusy"and _RW==2 then
 if os.clock()-_RK<1.0 then
 _QK(_QF)return false
end
end
end
return _RU(_RV,_RW,...)
end
if _RI then
 _RL=function(_Sc,_Sd,...)if not isAlive()then
 return _RI(_Sc,_Sd,...)end
return _RT(_RI,_Sc,_Sd,...)end
Net.call=_RL if GameRefs.World and type(rawget(GameRefs.World,"call"))=="function"then
 rawset(GameRefs.World,"call",_RL)
end
if getGC and getUpvalue and setUpvalue then
 task.spawn(function()for _Se,_Sf in ipairs(getGC(false))do
 if type(_Sf)=="function"and _Sf~=_RL and _Sf~=_RT then
 if not(isexecutorclosure and pcall(isexecutorclosure,_Sf)and isexecutorclosure(_Sf))then
 for _Sg=1,30 do

local _Sh,_Si=pcall(getUpvalue,_Sf,_Sg)if not _Sh then
 break
end
if type(_Si)=="function"then

local _Sj=false if isexecutorclosure and pcall(isexecutorclosure,_Si)and isexecutorclosure(_Si)then
 for _Sk,_Sl in pairs(getUpvalues(_Si))do
 if _Sl==_RI then
 _Sj=true break
end
end
end
if _Si==_RI or _Sj then
 pcall(setUpvalue,_Sf,_Sg,_RL)table.insert(_RJ,{fn=_Sf,idx=_Sg,orig=_RI})
end
end
end
end
end
end
end)end
end
function session.RestoreFastWrench()if _RI and netOk and type(Net)=="table"then
 Net.call=_RI
end
if _RI and GameRefs.World and rawget(GameRefs.World,"call")==_RL then
 pcall(rawset,GameRefs.World,"call",_RI)
end
if setUpvalue then
 for _Sm,_Sn in ipairs(_RJ)do
 pcall(setUpvalue,_Sn.fn,_Sn.idx,_Sn.orig)
end
end
table.clear(_RJ)
end
local _So=nil
local _Sp=nil
local _Sq={}
local function _Sr()pcall(function()
local _Ss=PlayerGui:FindFirstChild("InventoryGui")
local _St=_Ss and _Ss:FindFirstChild("InfoDialog")if _St and _St:IsA("GuiObject")then
 _St.Visible=false
end
end)
end
local function _Su()
local _Sv=_So or GameRefs.Inv if _Sv then

local _Sw=rawget(_Sv,"selected")if type(_Sw)=="number"and _Sw>0 then
 if countInv(_Sw)>0 then
 return _Sw
end
local _Sx=rawget(_Sv,"slots")if type(_Sx)=="table"and type(_Sx[_Sw])=="table"and tonumber(_Sx[_Sw].id)then
 return tonumber(_Sx[_Sw].id)
end
if ItemDB[_Sw]then
 return _Sw
end
end
end
if type(_Sp)=="table"then
 for _Sy,_Sz in pairs(_Sp)do
 if type(_Sz)=="table"and typeof(_Sz.sel)=="Instance"and _Sz.sel.Visible and tonumber(_Sz.id)then
 return tonumber(_Sz.id)
end
end
end
return nil
end
local function _SA()_Sr()
local _SB=_Su()if not _SB then
 notify("Pilih item di Backpack terlebih dahulu!","Fast Drop",2)return
end
local _SC=countInv(_SB)if _SC<=0 then
 notify("Item sudah habis di tas!","Fast Drop",2)return
end
local _SD=math.floor(tonumber(config.fastDropCount)or 0)
local _SE=(_SD<=0)and _SC or math.min(_SD,_SC)task.spawn(function()
local _SF=GameRefs.Hud or getInvTable()
local _SG=_SF and rawget(_SF,"onDrop")if type(_SG)=="function"then
 pcall(_SG,_SB,_SE)elseif DropItem then
 pcall(function()DropItem:FireServer(_SB,_SE)end)elseif netOk and type(Net)=="table"and Net.drop then
 pcall(Net.drop.send,{id=_SB,n=_SE})end
_Sr()notify(string.format("Fast Drop: %s x%d",getItemName(_SB),_SE),"Fast Drop",2)
end)end
local function _SH()_Sr()
local _SI=_Su()if not _SI then
 notify("Pilih item di Backpack terlebih dahulu!","Fast Recycle",2)return
end
local _SJ=countInv(_SI)if _SJ<=0 then
 notify("Item sudah habis di tas!","Fast Recycle",2)return
end
local _SK=math.floor(tonumber(config.fastRecycleCount)or 0)
local _SL=(_SK<=0)and _SJ or math.min(_SK,_SJ)task.spawn(function()if _sP and type(_sP.Recycle)=="function"then

local _SM=_sP.Recycle(_SI,_SL)_Sr()if _SM then

local _SN=getInvTable()if _SN and type(rawget(_SN,"refresh"))=="function"then
 pcall(_SN.refresh)end
notify(string.format("Fast Recycle: %s x%d",getItemName(_SI),_SL),"Fast Recycle",2)else
 notify(getItemName(_SI).." tidak bisa di-recycle!","Fast Recycle",2)
end
end
end)end
local _SO=nil
local _SP=nil
local _SQ=nil
local _SR=0
local function _SS()
local _ST=PlayerGui:FindFirstChild("InventoryGui")
local _SU=_ST and _ST:FindFirstChild("Holder")
local _SV=_SU and _SU:FindFirstChild("Backpack")
local _SW=_SV and _SV:FindFirstChild("Actions")if not _SW or not getconnections or not getUpvalue or not setUpvalue then
 return
end
for _SX,_SY in ipairs(_SW:GetChildren())do
 if _SY:IsA("GuiButton")then
 for _SZ,_Ta in ipairs({_SY.Activated,_SY.MouseButton1Click})do

local _Tb,_Tc=pcall(getconnections,_Ta)if _Tb and type(_Tc)=="table"then
 for _Td,_Te in ipairs(_Tc)do

local _Tf=_Te.Function if type(_Tf)=="function"and not(isexecutorclosure and pcall(isexecutorclosure,_Tf)and isexecutorclosure(_Tf))then

local _Tg,_Th=pcall(getUpvalue,_Tf,1)
local _Ti,_Tj=pcall(getUpvalue,_Tf,2)
local _Tk,_Tl=pcall(getUpvalue,_Tf,3)
local _Tm,_Tn=pcall(getUpvalue,_Tf,5)if _Ti and type(_Tj)=="table"and rawget(_Tj,"drop")and rawget(_Tj,"recycle")and _Tm and type(_Tn)=="function"then
 _So=(_Tg and type(_Th)=="table")and _Th or _So _Sp=(_Tk and type(_Tl)=="table")and _Tl or _Sp
local _To=rawget(_Tj,"drop")
local _Tp=rawget(_Tj,"recycle")if _SY==_To then
 _SO=_Tf if not _To:GetAttribute("ANCHDropHook")then
 _To:SetAttribute("ANCHDropHook",true)trackConn(_To.InputBegan:Connect(function(_Tq)if _Tq.UserInputType==Enum.UserInputType.MouseButton1 or _Tq.UserInputType==Enum.UserInputType.Touch then
 _SQ="drop"_SR=os.clock()
end
end))end
elseif _SY==_Tp then
 _SP=_Tf if not _Tp:GetAttribute("ANCHRecHook")then
 _Tp:SetAttribute("ANCHRecHook",true)trackConn(_Tp.InputBegan:Connect(function(_Tr)if _Tr.UserInputType==Enum.UserInputType.MouseButton1 or _Tr.UserInputType==Enum.UserInputType.Touch then
 _SQ="recycle"_SR=os.clock()
end
end))
end
end
if not genv.__ANCH_TrueOrigOpenDialog then
 if isexecutorclosure and pcall(isexecutorclosure,_Tn)and isexecutorclosure(_Tn)then
 for _Ts,_Tt in pairs(getUpvalues(_Tn))do
 if type(_Tt)=="function"and not(pcall(isexecutorclosure,_Tt)and isexecutorclosure(_Tt))then
 genv.__ANCH_TrueOrigOpenDialog=_Tt break
end
end
else
 genv.__ANCH_TrueOrigOpenDialog=_Tn
end
end
local _Tu=genv.__ANCH_TrueOrigOpenDialog if _Tu and _Tn~=session.SharedDialogWrapper then
 session.SharedDialogWrapper=function(...)if isAlive()then

local _Tv=(debug and debug.info and debug.info(2,"f"))or nil
local _Tw=(_Tv and _SO and _Tv==_SO)or(_SQ=="drop"and(os.clock()-_SR)<0.5)
local _Tx=(_Tv and _SP and _Tv==_SP)or(_SQ=="recycle"and(os.clock()-_SR)<0.5)if _Tw and not _Tx then
 _SQ=nil if config.fastDrop then
 _SA()return end
elseif _Tx and not _Tw then
 _SQ=nil if config.fastRecycle then
 _SH()return
end
end
end
return _Tu(...)end
pcall(setUpvalue,_Tf,5,session.SharedDialogWrapper)table.insert(_Sq,{fn=_Tf,idx=5,orig=_Tu})
end
end
end
end
end
end
end
end
end
task.spawn(function()while isAlive()do
 pcall(_SS)task.wait(1.5)
end
end)function session.RestoreFastBackpack()if setUpvalue then
 for _Ty,_Tz in ipairs(_Sq)do
 pcall(setUpvalue,_Tz.fn,_Tz.idx,_Tz.orig)
end
end
table.clear(_Sq)
end
function _Py()_Pn=true config.reconnectOn=true saveConfig()return true
end
function _Pz()_Pn=false config.reconnectOn=false saveConfig()return true
end
local _TA,_TB={},{}function _PA()if _Po then
 return true end
_TA={}for _TC,_TD in pairs(ItemDB)do
 if type(_TD)=="table"then
 for _TE,_TF in ipairs({"hurts","deadly"})do
 if _TD[_TF]then
 table.insert(_TA,{item=_TD,key=_TF,value=rawget(_TD,_TF)})pcall(function()if setreadonly then
 setreadonly(_TD,false)end
rawset(_TD,_TF,false)
end)end
end
end
end
local _TG=WorldRemotes and WorldRemotes:FindFirstChild("Burned")if _TG and getconnections then

local _TH,_TI=pcall(getconnections,_TG.OnClientEvent)if _TH and type(_TI)=="table"then
 for _TJ,_TK in ipairs(_TI)do
 if pcall(function()_TK:Disable()end)then
 table.insert(_TB,_TK)
end
end
end
end
_Po=true return true
end
function _PB()if not _Po then
 return false
end
for _TL,_TM in ipairs(_TA)do
 pcall(function()rawset(_TM.item,_TM.key,_TM.value)
end)end
_TA={}for _TN,_TO in ipairs(_TB)do
 pcall(function()_TO:Enable()
end)end
_TB={}_Po=false return true
end
local _TP={}
local _TQ=nil
local function _TR()
local _TS=getInvTable()if not _TS then
 return nil
end
local _TT=getUpvalues(_TS.isWorn)[1]return type(_TT)=="table"and _TT or nil
end
function _PI(_TU)
local _TV=_TR()return _TV and ItemDB[_TU]and _TV[ItemDB[_TU].slot]==_TU or false
end
function _PJ(_TW)
local _TX,_TY=getInvTable(),_TR()if not _TX or not _TY or not ItemDB[_TW]then
 return false
end
local _TZ=ItemDB[_TW].slot if type(_TZ)~="string"then
 return false
end
if _TY[_TZ]==_TW then
 _TY[_TZ]=_TP[_TZ]or nil else if _TP[_TZ]==nil then
 _TP[_TZ]=_TY[_TZ]or false end
_TY[_TZ]=_TW end
pcall(_TX.refresh)return true
end
function _PK()
local _Ua,_Ub=getInvTable(),_TR()if not _Ua or not _Ub then
 return
end
for _Uc,_Ud in pairs(_TP)do
 _Ub[_Uc]=_Ud or nil end
table.clear(_TP)pcall(_Ua.refresh)notify("Item visual dikembalikan.")
end
function _PL()if _TQ then
 return _TQ
end
local _Ue={}for _Uf,_Ug in pairs(ItemDB)do
 if type(_Uf)=="number"and type(_Ug)=="table"and type(_Ug.slot)=="string"and type(_Ug.name)=="string"then

local _Uh={}
local _Ui=_Ug.name:lower()if _Ug.kuyang then
 table.insert(_Uh,"Kuyang")
end
if _Ug.bot then
 table.insert(_Uh,"LegendBot")
end
if _Uf==5480 or _Ui:find("rayman",1,true)then
 table.insert(_Uh,"Rayman")end
table.insert(_Ue,{id=_Uf,name=_Ug.name,lower=_Ui,slot=_Ug.slot,tags=_Uh})
end
end
table.sort(_Ue,function(_Uj,_Uk)return _Uj.name<_Uk.name end)_TQ=_Ue return _Ue
end
local _Ul=nil
local function _Um()if _Ul then
 return _Ul
end
local _Un={}for _Uo,_Up in pairs(ItemDB)do
 if type(_Uo)=="number"and type(_Up)=="table"and type(_Up.name)=="string"and type(_Up.slot)~="string"then
 table.insert(_Un,{id=_Uo,name=_Up.name,lower=_Up.name:lower(),kind=_Up.kind or "block"})
end
end
table.sort(_Un,function(_Uq,_Ur)return _Uq.name<_Ur.name end)_Ul=_Un return _Un
end
function _PH(_Us,_Ut)
local _Uu=_Um()_Us=trim(_Us):lower()if _Us==""then
 return{}
end
local _Uv=tonumber(_Us)
local _Uw={}for _Ux,_Uy in ipairs(_Uu)do

local _Uz=nil if _Uv and _Uy.id==_Uv then
 _Uz=0 elseif _Uy.lower==_Us then
 _Uz=1 elseif _Uy.lower:sub(1,#_Us)==_Us then
 _Uz=2 elseif _Uy.lower:find(_Us,1,true)then
 _Uz=3
end
if _Uz then
 table.insert(_Uw,{entry=_Uy,rank=_Uz})
end
end
table.sort(_Uw,function(_UA,_UB)if _UA.rank~=_UB.rank then
 return _UA.rank<_UB.rank end
return _UA.entry.name<_UB.entry.name
end)
local _UC={}for _UD=1,math.min(_Ut or 25,#_Uw)do
 _UC[_UD]=_Uw[_UD].entry end
return _UC
end
function _PF()
local _UE=getWorld()
local _UF=_UE and rawget(_UE,"growScan")if type(_UF)~="table"or type(_UF.open)~="function"then
 return false
end
local _UG=0 for _UH,_UI in pairs(ItemDB)do
 if type(_UH)=="number"and type(_UI)=="table"and _UI.growscan then
 _UG=_UH;break
end
end
local _UJ=pcall(_UF.open,{item=_UG,owner=true,blocksPublic=false,floatingPublic=false},function()end)return _UJ
end
function _PG()
local _UK=getWorld()if not _UK or type(rawget(_UK,"w"))~="number"then
 return nil
end
local _UL={fg={},bg={},drops={},trees={},w=_UK.w,h=_UK.h,totalFg=0,totalBg=0,totalDrops=0,piles=0,readyTrees=0,growingTrees=0,}
local _UM=workspace:GetServerTimeNow()for _UN=0,_UK.h-1 do

local _UO,_UP=_UK.fg[_UN],_UK.bg and _UK.bg[_UN]for _UQ=0,_UK.w-1 do

local _UR=_UO and _UO[_UQ]or 0 if _UR~=0 then
 _UL.fg[_UR]=(_UL.fg[_UR]or 0)+1 _UL.totalFg+=1 if _sT(_UR)then

local _US=_sW(_UK,_UQ,_UN,_UR)
local _UT=_UL.trees[_UR]if not _UT then
 _UT={ready=0,growing=0,nextIn=nil}_UL.trees[_UR]=_UT
end
if _US and _UM>=_US then
 _UT.ready+=1 _UL.readyTrees+=1 else
 _UT.growing+=1 _UL.growingTrees+=1 if _US then

local _UU=_US-_UM if not _UT.nextIn or _UU<_UT.nextIn then
 _UT.nextIn=_UU
end
end
end
end
end
local _UV=_UP and _UP[_UQ]or 0 if _UV~=0 then
 _UL.bg[_UV]=(_UL.bg[_UV]or 0)+1;_UL.totalBg+=1
end
end
end
local _UW=DropRefs.list if not _UW and type(_UK.dropList)=="function"then

local _UX,_UY=pcall(_UK.dropList)if _UX then
 _UW=_UY
end
end
if type(_UW)=="table"then
 for _UZ,_Va in pairs(_UW)do
 if type(_Va)=="table"and type(_Va.id)=="number"and(_Va.n or 0)>0 then
 _UL.drops[_Va.id]=(_UL.drops[_Va.id]or 0)+(_Va.n or 1)_UL.totalDrops+=(_Va.n or 1)_UL.piles+=1
end
end
end
return _UL
end
function _PM()
local _Vb,_Vc={"none"},{none=true}if _bd and type(_be)=="table"and type(_be.titlesOf)=="function"then

local _Vd,_Ve=pcall(_be.titlesOf,LocalPlayer.UserId)if _Vd and type(_Ve)=="table"then
 for _Vf,_Vg in ipairs(_Ve)do
 if type(_Vg)=="string"and not _Vc[_Vg]then
 _Vc[_Vg]=true
local _Vh=_Vg if type(_be.titleName)=="function"then

local _Vi,_Vj=pcall(_be.titleName,_Vg)if _Vi and type(_Vj)=="string"and _Vj~=""and _Vj~=_Vg then
 _Vh=_Vj.." [".._Vg.."]"
end
end
table.insert(_Vb,_Vh)
end
end
end
end
return _Vb
end
function _PN(_Vk)
local _Vl=string.match(_Vk or"","%[(.-)%]$")or _Vk or "none"if _Vl==""then
 _Vl="none"
end
if netOk and type(Net)=="table"and type(Net.call)=="function"then
 task.spawn(function()
local _Vm,_Vn=pcall(Net.call,"PickTitle",_Vl)notify(_Vm and("Role dipasang: ".._Vl)or("Gagal pasang role: "..tostring(_Vn)))end)elseif PickTitle then
 pcall(function()PickTitle:FireServer(_Vl)end)notify("Role dikirim: ".._Vl)else
 notify("Fungsi PickTitle tidak ditemukan.")
end
end
function _PE()ml_module.CheckQuests()notify(ml_module.questText,"Info Quest")
end
function _PC()if _Pp then
 return true end
_Pp=true config.bonusAutoQuest=true ml_module.nextQuest=0 return true
end
function _PD()if not _Pp then
 return false end
_Pp=false config.bonusAutoQuest=false return true
end
end)()
end
local featureMap={blink={label="Skin Blink",get=function()return _Pj end,set=function(_Vo)return _Vo and _Pq()or _Pr()end
},longhand={label="Longhand Reach",get=function()return _Pk end,set=function(_Vp)return _Vp and _Ps()or _Pt()end
},noclip={label="Noclip / ModFly",get=function()return _iy end,set=function(_Vq)return _Vq and enableFly()or disableFly()end
},ujump={label="Unlimited Jump",get=function()return _Pl end,set=function(_Vr)return _Vr and _Pu()or _Pv()end
},antiafk={label="Anti-AFK",get=function()return _Pm end,set=function(_Vs)return _Vs and _Pw()or _Px()end
},autorejoin={label="Auto Reconnect",get=function()return config.reconnectOn end,set=function(_Vt)return _Vt and _Py()or _Pz()end
},god={label="God Mode",get=function()return _Po end,set=function(_Vu)return _Vu and _PA()or _PB()end
},clicktp={label="Click TP",get=function()return ClickTP.clickOn end,set=function(_Vv)return _Vv and ClickTP.StartClick()or ClickTP.StopClick()end
},lite={label="Lite Mode (FPS Boost)",get=function()return config.liteMode end,set=function(_Vw)liteModeModule.Set(_Vw);return true end
},guard={label="Anti-Mod Guard",get=function()return guardModule.on end,set=function(_Vx)guardModule.Set(_Vx);return true end
},autochat={label="Auto Chat",noSession=true,get=function()return autoChat.on end,set=function(_Vy)autoChat.on=_Vy;if _Vy then
 autoChat.nextAt=0 end
;return true end
},autoclear={label="Auto Clear World",noSession=true,get=function()return autoClear.on end,set=function(_Vz)return _Vz and autoClear.Start()or autoClear.Stop()end
},autoharvest={label="Farmer (Harvest/Plant)",noSession=true,get=function()return autoHarvest.on end,set=function(_VA)return _VA and autoHarvest.Start()or autoHarvest.Stop()end
},automove={label="Auto Move Item",noSession=true,get=function()return autoGuard.on end,set=function(_VB)return _VB and autoGuard.Start()or autoGuard.Stop()end
},autodf={label="Auto Dirt Farm",noSession=true,get=function()return autoDF.on end,set=function(_VC)return _VC and autoDF.Start()or autoDF.Stop()end
},autosplice={label="Auto Splice",noSession=true,get=function()return autoSplice.on end,set=function(_VD)return _VD and autoSplice.Start()or autoSplice.Stop()end
},pabrik={label="Seed Factory",noSession=true,get=function()return autoPabrik.on end,set=function(_VE)return _VE and autoPabrik.Start()or autoPabrik.Stop()end
},autofarm={label="Auto Farm",noSession=true,get=function()return autoFarm.on and not autoFarm.Override end,set=function(_VF)return _VF and _vt()or _vu()end
},autoquest={label="Auto Quest",get=function()return _Pp end,set=function(_VG)return _VG and _PC()or _PD()end
},}
local function toggleFeature(_VJ,_VK)
local _VL=featureMap[_VJ]if not _VL then
 return end
_VL.set(_VK)if _VL.get()==_VK then
 notify(_VL.label..(_VK and " enabled."or " disabled."))if not _VL.noSession then
 config.session[_VJ]=_VK or nil end
saveConfig()
end
if spliceSetup then
 spliceSetup()
end
end
local _VM=0
local function _VN()if type(genv.ANCHHub_ReloadCode)=="string"and genv.ANCHHub_ReloadCode~=""then
 return genv.ANCHHub_ReloadCode
end
local _VO=config.scriptUrl if type(_VO)~="string"or _VO==""then
 _VO=genv.ANCHHubURL
end
if type(_VO)=="string"and _VO~=""then
 return string.format("loadstring(game:HttpGet(%q))()",_VO)
end
if isfile and readfile then
 for _VP,_VQ in ipairs({growboxLua,"ANCHHub-Test.lua","ANCHHub.lua","ANCHHub_Loader.lua"})do

local _VR,_VS=pcall(isfile,_VQ)if _VR and _VS then
 return string.format("loadstring(readfile(%q))()",_VQ)
end
end
end
return nil
end
local function _VT()return queue_on_teleport or(syn and syn.queue_on_teleport)or(fluxus and fluxus.queue_on_teleport)or(getgenv and getgenv().queue_on_teleport)end
_se=function()if not config.autoReload or genv.__ANCHHub_TeleportQueued then
 return false
end
local _VU,_VV=_VT(),_VN()if not _VU or not _VV then
 return false
end
local _VW=("
local g=(getgenv and getgenv()) or _G; if g.__ANCH_TpLock and (os.clock()-g.__ANCH_TpLock)<6 then
 return end
; g.__ANCH_TpLock=os.clock(); ").._VV
local _VX=pcall(_VU,_VW)if _VX then
 genv.__ANCHHub_TeleportQueued=true end
return _VX
end
local function _VY()if not writefile then
 notify("Executor tidak punya writefile.");return
end
local _VZ=_VN()if not _VZ then
 notify("Simpan skrip sebagai "..growboxLua.." di workspace atau isi URL dulu.");return
end
local _Wa="-- ANCH HUB | GrowBlox auto-loader\n".._VZ.."\n"pcall(writefile,"ANCHHub_Loader.lua",_Wa)for _Wb,_Wc in ipairs({"../autoexec/ANCHHub_Loader.lua","../Autoexec/ANCHHub_Loader.lua"})do

local _Wd=pcall(writefile,_Wc,_Wa)
local _We,_Wf=pcall(function()return isfile and isfile(_Wc)
end)if _Wd and _We and _Wf then
 notify("Auto-execute berhasil dipasang!")return
end
end
notify(("Salin ANCHHub_Loader.lua dari workspace ke folder autoexec executor."))end
do
(function()
local _Wg=(gethui and gethui())or game:GetService("CoreGui")
local function _Wh(_Wi)
local _Wj=Instance.new("ScreenGui")_Wj.Name=_Wi _Wj.ResetOnSpawn=false _Wj.IgnoreGuiInset=true _Wj.ZIndexBehavior=Enum.ZIndexBehavior.Sibling _Wj.DisplayOrder=999 _Wj.Enabled=false _Wj.Parent=_Wg return _Wj end
_sE=_Wh("ANCHGridGui")
local _Wk,_Wl,_Wm=38,4,2
local _Wn=_Wm*2+1
local _Wo=_Wn*_Wk+(_Wn-1)*_Wl
local _Wp=Instance.new("Frame",_sE)_Wp.Size=UDim2.fromOffset(_Wo+20,_Wo+96)_Wp.Position=UDim2.fromOffset(24,90)_Wp.BackgroundColor3=Color3.fromRGB(22,22,28)_Wp.BorderSizePixel=0 Instance.new("UICorner",_Wp).CornerRadius=UDim.new(0,10)
local _Wq=Instance.new("UIStroke",_Wp)_Wq.Color=Color3.fromRGB(48,255,106)
local _Wr=Instance.new("TextLabel",_Wp)_Wr.Size=UDim2.new(1,-106,0,28)_Wr.Position=UDim2.fromOffset(10,4)_Wr.BackgroundTransparency=1 _Wr.Font=Enum.Font.GothamBold _Wr.TextSize=12 _Wr.TextXAlignment=Enum.TextXAlignment.Left _Wr.TextColor3=Color3.fromRGB(235,235,245)_Wr.Text="ANCH Grid (Farm)"_Wr.Active=true
local _Ws=Instance.new("TextButton",_Wp)_Ws.Size=UDim2.fromOffset(62,22)_Ws.Position=UDim2.new(1,-98,0,7)_Ws.BackgroundColor3=Color3.fromRGB(60,60,75)_Ws.Text="Farm"_Ws.Font=Enum.Font.GothamBold _Ws.TextSize=11 _Ws.TextColor3=Color3.new(1,1,1)Instance.new("UICorner",_Ws).CornerRadius=UDim.new(0,6)
local _Wt=Instance.new("TextButton",_Wp)_Wt.Size=UDim2.fromOffset(24,24)_Wt.Position=UDim2.new(1,-30,0,6)_Wt.BackgroundColor3=Color3.fromRGB(60,60,75)_Wt.Text="X"_Wt.Font=Enum.Font.GothamBold _Wt.TextSize=12 _Wt.TextColor3=Color3.new(1,1,1)Instance.new("UICorner",_Wt).CornerRadius=UDim.new(0,6)_Wt.MouseButton1Click:Connect(function()_sE.Enabled=false
end)
local _Wu=Instance.new("Frame",_Wp)_Wu.Size=UDim2.fromOffset(_Wo,_Wo)_Wu.Position=UDim2.fromOffset(10,36)_Wu.BackgroundTransparency=1
local _Wv=Color3.fromRGB(48,48,60)
local _Ww=Color3.fromRGB(46,160,90)
local _Wx=Color3.fromRGB(60,110,220)
local _Wy={}
local function _Wz()return(_sF=="pabrik")and config.pabrikTiles or config.farmGrid
end
local _WA=Instance.new("TextButton",_Wp)_WA.Size=UDim2.new(1,-20,0,30)_WA.Position=UDim2.new(0,10,1,-54)_WA.BackgroundColor3=_Ww _WA.Font=Enum.Font.GothamBold _WA.TextSize=13 _WA.TextColor3=Color3.new(1,1,1)_WA.Text="START FARM"Instance.new("UICorner",_WA).CornerRadius=UDim.new(0,8)_WA.MouseButton1Click:Connect(function()if _sF=="pabrik"then
 toggleFeature("pabrik",not autoPabrik.on)else
 toggleFeature("autofarm",not(autoFarm.on and not autoFarm.Override))
end
end)_sG=function()
local _WB=_Wz()
local _WC=_sF=="pabrik"_Ws.Text=_WC and "Factory"or "Farm"_Ws.BackgroundColor3=_WC and Color3.fromRGB(200,120,40)or Color3.fromRGB(60,60,75)_Wr.Text=_WC and "Factory Break Tiles"or "ANCH Grid (Farm)"for _WD,_WE in pairs(_Wy)do
 _WE.BackgroundColor3=_WB[_WD]and _Ww or _Wv
end
if _WC then
 _WA.Text=autoPabrik.on and "STOP FACTORY"or "START FACTORY"_WA.BackgroundColor3=autoPabrik.on and Color3.fromRGB(200,60,60)or _Ww else

local _WF=autoFarm.on and not autoFarm.Override _WA.Text=_WF and "STOP FARM"or "START FARM"_WA.BackgroundColor3=_WF and Color3.fromRGB(200,60,60)or _Ww
end
end
_sH=function(_WG)_sF=_WG _sG()end
_Ws.MouseButton1Click:Connect(function()_sH(_sF=="pabrik"and "farm"or "pabrik")
end)for _WH=0,_Wn-1 do
 for _WI=0,_Wn-1 do

local _WJ,_WK=_WI-_Wm,_WH-_Wm
local _WL=_WJ..",".._WK
local _WM=Instance.new("TextButton",_Wu)_WM.Size=UDim2.fromOffset(_Wk,_Wk)_WM.Position=UDim2.fromOffset(_WI*(_Wk+_Wl),_WH*(_Wk+_Wl))_WM.Font=Enum.Font.GothamBold _WM.TextSize=11 _WM.TextColor3=Color3.new(1,1,1)Instance.new("UICorner",_WM).CornerRadius=UDim.new(0,6)if _WJ==0 and _WK==0 then
 _WM.Text="ME"_WM.BackgroundColor3=_Wx _WM.AutoButtonColor=false else
 _WM.Text=""_WM.BackgroundColor3=_Wz()[_WL]and _Ww or _Wv _Wy[_WL]=_WM _WM.MouseButton1Click:Connect(function()
local _WN=_Wz()_WN[_WL]=(not _WN[_WL])or nil saveConfig()_sG()
end)end
end
end
local _WO=Instance.new("TextButton",_Wp)_WO.Size=UDim2.new(1,-20,0,18)_WO.Position=UDim2.new(0,10,1,-22)_WO.BackgroundTransparency=1 _WO.Font=Enum.Font.Gotham _WO.TextSize=12 _WO.TextColor3=Color3.fromRGB(180,180,195)_WO.Text="Clear Selection"_WO.MouseButton1Click:Connect(function()if _sF=="pabrik"then
 config.pabrikTiles={}else
 config.farmGrid={}end
saveConfig()_sG()
end)
local _WP,_WQ,_WR _Wr.InputBegan:Connect(function(_WS)if _WS.UserInputType==Enum.UserInputType.MouseButton1 or _WS.UserInputType==Enum.UserInputType.Touch then
 _WP,_WQ,_WR=true,_WS.Position,_Wp.Position _WS.Changed:Connect(function()if _WS.UserInputState==Enum.UserInputState.End then
 _WP=false
end
end)
end
end)trackConn(UserInputService.InputChanged:Connect(function(_WT)if _WP and(_WT.UserInputType==Enum.UserInputType.MouseMovement or _WT.UserInputType==Enum.UserInputType.Touch)then

local _WU=_WT.Position-_WQ _Wp.Position=UDim2.new(_WR.X.Scale,_WR.X.Offset+_WU.X,_WR.Y.Scale,_WR.Y.Offset+_WU.Y)
end
end))_iA=_Wh("ANCHFlyPad")
local function _WV(_WW,_WX,_WY)
local _WZ=Instance.new("TextButton",_iA)_WZ.Size=UDim2.fromOffset(60,60)_WZ.AnchorPoint=Vector2.new(1,0.5)_WZ.Position=UDim2.new(1,-24,0.5,_WX)_WZ.BackgroundColor3=Color3.fromRGB(30,30,40)_WZ.BackgroundTransparency=0.2 _WZ.Text=_WW _WZ.Font=Enum.Font.GothamBold _WZ.TextSize=26 _WZ.TextColor3=Color3.new(1,1,1)Instance.new("UICorner",_WZ).CornerRadius=UDim.new(1,0)
local _Xa=Instance.new("UIStroke",_WZ)_Xa.Color=Color3.fromRGB(48,255,106)_Xa.Thickness=2
local _Xb=nil _WZ.InputBegan:Connect(function(_Xc)if _Xc.UserInputType==Enum.UserInputType.Touch or _Xc.UserInputType==Enum.UserInputType.MouseButton1 then
 _Xb=_Xc _WY(true)
end
end)trackConn(UserInputService.InputEnded:Connect(function(_Xd)if _Xb and(_Xd==_Xb or _Xd.UserInputType==Enum.UserInputType.MouseButton1)then
 _Xb=nil _WY(false)
end
end))end
_WV("â²",-38,function(_Xe)flyState.up=_Xe end)_WV("â¼",38,function(_Xf)flyState.down=_Xf
end)end)()
end
local hubUI do
(function()local _Xh do

local _Xi="ANCHHub_WindUI_Cache.lua"
local _Xj=genv.__ANCH_WindUISource if type(_Xj)~="string"or#_Xj<1000 then
 if isfile and readfile then

local _Xk,_Xl=pcall(isfile,_Xi)if _Xk and _Xl then

local _Xm,_Xn=pcall(readfile,_Xi)if _Xm and type(_Xn)=="string"and#_Xn>1000 then
 _Xj=_Xn
end
end
end
end
if type(_Xj)~="string"or#_Xj<1000 then

local _Xo,_Xp=pcall(function()return game:HttpGet(("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))
end)if _Xo and type(_Xp)=="string"and#_Xp>1000 then
 _Xj=_Xp genv.__ANCH_WindUISource=_Xj if writefile then
 pcall(writefile,_Xi,_Xj)
end
end
end
if type(_Xj)=="string"and#_Xj>1000 then
 genv.__ANCH_WindUISource=_Xj _Xh=loadstring(_Xj)()else
 _Xh=loadstring(game:HttpGet(("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua")))()
end
end
notifyFn=function(_Xq,_Xr,_Xs)_Xh:Notify({Title=_Xr or "ANCH HUB | GrowBlox",Content=tostring(_Xq),Icon="solar:bell-bold",Duration=_Xs or 4,})
end
local _Xt=Color3.fromHex("#7775F2")
local _Xu=Color3.fromHex("#ECA201")
local _Xv=Color3.fromHex("#10C550")
local _Xw=Color3.fromHex("#257AF7")
local _Xx=Color3.fromHex("#EF4F1D")hubUI=_Xh:CreateWindow({Title="ANCH Hub  |  GrowBlox Beta",Folder="ANCHHub_GrowBlox",Icon="solar:folder-2-bold-duotone",NewElements=true,HideSearchBar=false,Theme="Indigo",OpenButton={Title="ANCH Hub",CornerRadius=UDim.new(1,0),StrokeThickness=3,Enabled=config.launcher,Draggable=true,OnlyMobile=false,Scale=0.5,Color=ColorSequence.new(Color3.fromHex("#30FF6A"),Color3.fromHex("#e7ff2f")),},})hubUI:DisableTopbarButtons({"Fullscreen"})pcall(function()hubUI:Tag({Title="V1.3 EN",Icon="github",Color=Color3.fromHex("#1c1c1c"),Border=true,})
end)
local xy_scanHelper={tabs={},refreshers={},syncing=false,active="features",}spliceSetup=function()xy_scanHelper.syncing=true for _Xz,_XA in ipairs(xy_scanHelper.refreshers)do
 pcall(_XA)end
xy_scanHelper.syncing=false
end
local function xb_helper(_XC,_XD)
local _XE,_XF=pcall(_XD)if not _XE then
 warn("[ANCHHub UI] Error in "..tostring(_XC)..": "..tostring(_XF))
end
end
local function xg_helper(_XH,_XI,_XJ)if not _XH then
 return end
pcall(function()if _XI and _XH.SetTitle then
 _XH:SetTitle(_XI)
end
if _XJ and _XH.SetDesc then
 _XH:SetDesc(_XJ)elseif _XJ and _XH.SetContent then
 _XH:SetContent(_XJ)
end
end)
end
local function xk_helper(_XL,_XM,_XN,_XO)
local _XP=featureMap[_XO]if not _XP then
 return nil
end
local _XQ xb_helper("Toggle:"..tostring(_XO),function()_XQ=_XL:Toggle({Title=_XM,Desc=_XN,Value=_XP.get(),Callback=function(_XR)if xy_scanHelper.syncing then
 return
end
if _XP.get()~=_XR then
 toggleFeature(_XO,_XR)
end
end,})table.insert(xy_scanHelper.refreshers,function()if _XQ and _XQ.Set then
 _XQ:Set(_XP.get())
end
end)end)return _XQ
end
local _XS=hubUI:Section({Title="Main Section",Opened=true})
local _XT=hubUI:Section({Title="Automation",Opened=true})
local _XU=hubUI:Section({Title="Fast Helpers",Opened=true})
local _XV=hubUI:Section({Title="Inventory & World",Opened=true})
local _XW=hubUI:Section({Title="Safety & Utility",Opened=true})
local _XX=hubUI:Section({Title="System & Settings",Opened=true})xb_helper("Tab:Dashboard",function()
local _XY=_XS:Tab({Title="Dashboard & Stats",Icon="solar:home-2-bold",IconColor=_Xv,IconShape="Square",Border=true,})xy_scanHelper.tabs.features=_XY
local _XZ=_XY:Paragraph({Title="Character & Game Connection Status",Desc="Detecting position...",})
local _Ya=_XY:Paragraph({Title="Real-Time Session Statistics",Desc="Loading stats...",})task.spawn(function()while isAlive()and task.wait(0.6)do
 pcall(function()
local _Yb,_Yc=getPlayerTile()
local _Yd=getWorldName()
local _Ye=string.format(("World: %s | Inv: %s | State: %s | Punch: %s | Drop: %s | Trees: %s"),GameRefs.World and "OK"or "-",GameRefs.Inv and "OK"or "-",GameRefs.State and "OK"or "-",GameRefs.Punch and "OK"or "-",DropRefs.list and "OK"or "-",GameRefs.Trees and "OK"or "-")if _Yb then
 xg_helper(_XZ,string.format("World: %s  |  Tile Position: (%d, %d)",_Yd~=""and _Yd or "-",_Yb,_Yc),_Ye)else
 xg_helper(_XZ,"Character Status: Outside World",_Ye)end
xg_helper(_Ya,"Real-Time Session Statistics",stats.Text())
end)end
end)_XY:Button({Title="Rescan Game References (Reconnect Refs)",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()GameRefs.Scan(true)notify("Game references refreshed!")end,})
local _Yf=_XY:Group({})_Yf:Button({Title="Reset Stats",Justify="Center",Callback=function()stats.Reset();notify("Session statistics reset.")end,})_Yf:Button({Title="Send Stats to Discord",Justify="Center",Callback=function()if not(config.webhookOn and webhook.Valid(config.webhookUrl))then
 notify(("Enable & set your Discord Webhook URL in System & Settings first!"))else
 webhook.Send("report","Session Statistics Report\n```\n"..stats.Text().."\n```")notify("Statistics report queued for Discord!")
end
end,})end)xb_helper("Tab:Character",function()
local _Yg=_XS:Tab({Title="Character & Movement",Icon="solar:square-transfer-horizontal-bold",IconColor=_Xw,IconShape="Square",Border=true,})xy_scanHelper.tabs.nav=_Yg
local _Yh=_Yg:Paragraph({Title="Universal Navigation Status",Desc="Last: -"})_Yg:Dropdown({Title="Universal Movement Method (DF / Farmer / Factory / Clear)",Desc=("Legit Walking = Physical A* pathfinding | Teleport Mode = Tile-by-tile real-time stepper."),Values={"Legit Walking","Teleport Mode"},Value=config.moveMethod or "Legit Walking",Callback=function(_Yi)config.moveMethod=_Yi or "Legit Walking"config.moveMode=(config.moveMethod=="Teleport Mode")and "fly"or "legit"saveConfig()notify("Movement method set to: "..config.moveMethod)end,})_Yg:Space()task.spawn(function()while isAlive()and task.wait(0.6)do
 pcall(function()xg_helper(_Yh,"Movement Mode: "..config.moveMode:upper(),"Click TP Status: "..tostring(ClickTP.last).." | Scaffolds Placed: "..ClickTP.PlacedScaffolds)
end)end
end)xk_helper(_Yg,"Click TP (Legit A* Pathfinding)",("Tap/click anywhere on screen to automatically walk & climb to that tile."),"clicktp")xk_helper(_Yg,"Noclip + FlyPad (â²/â¼)","Fly through blocks and display on-screen Up/Down buttons.","noclip")xk_helper(_Yg,"Unlimited Jump (Air Jump)","Jump infinitely in mid-air.","ujump")xk_helper(_Yg,"God Mode (Hazard Immunity)","Immune to lava, spikes, fire, and deadly obstacles.","god")xk_helper(_Yg,"Longhand (Extended Reach)","Extend your punch and build range.","longhand")xk_helper(_Yg,"Lite Mode (FPS Boost)","Disable particles & punch sound effects for higher FPS.","lite")xk_helper(_Yg,"Skin Blink","Automatically cycle character skin colors.","blink")xk_helper(_Yg,"Anti-AFK","Prevent idle disconnection.","antiafk")_Yg:Space()_Yg:Section({Title="Speed & Auto Collect Radius"})_Yg:Slider({Title="Character Walkspeed (%)",Desc="100% = normal game speed.",IsTooltip=true,Step=10,Value={Min=50,Max=400,Default=math.clamp(config.walkSpeed,50,400)},Callback=function(_Yj)config.walkSpeed=tonumber(_Yj)or 100 if config.walkSpeed==100 and GameRefs.World then
 GameRefs.World.speedScale=1 end
saveConfig()end,})_Yg:Toggle({Title="Always Collect Nearby Drops",Value=config.collectAround,Callback=function(_Yk)config.collectAround=_Yk;saveConfig()end,})_Yg:Slider({Title="Auto Collect Radius (Tiles)",IsTooltip=true,Step=1,Value={Min=1,Max=8,Default=math.clamp(config.collectRadius,1,8)},Callback=function(_Yl)config.collectRadius=math.floor(tonumber(_Yl)or 3);saveConfig()end,})_Yg:Toggle({Title="Require Holding Shift for Click TP (PC)",Value=config.clickTpShift,Callback=function(_Ym)config.clickTpShift=_Ym;saveConfig()end,})end)xb_helper("Tab:AutoFarm",function()
local yn_helper=_XT:Tab({Title="Auto Farm",Icon="solar:check-square-bold",IconColor=_Xu,IconShape="Square",Border=true,})xy_scanHelper.tabs.farm=yn_helper
local _Yo=yn_helper:Paragraph({Title="Auto Farm Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.5)do
 pcall(function()
local _Yp=config.farmPlaceId xg_helper(_Yo,"Status: "..autoFarm.stats.status.." ("..config.farmMode..")",string.format(("Block: %s [ID %d] (In Bag: %d)\nPlaced: %d | Broken: %d | Collected: %d | Cycles: %d"),getItemName(_Yp),_Yp,countInv(_Yp),autoFarm.stats.placed,autoFarm.stats.broken,autoFarm.stats.picked,autoFarm.stats.cycles))
end)end
end)xk_helper(yn_helper,"Enable Auto Farm","Automatically place & break blocks based on the 5x5 Grid.","autofarm")yn_helper:Dropdown({Title="Auto Collect Mode (Legit Physical / Remote)",Desc=("Legit = Physical sweep & small jump (anti-reject). Remote = Collect from range."),Values={"Legit","Remote"},Value=(config.collectMode=="Remote")and "Remote"or "Legit",Callback=function(_Yq)config.collectMode=(_Yq=="Remote")and "Remote"or "Legit"saveConfig()notify("Auto Collect Mode: "..config.collectMode)end,})yn_helper:Toggle({Title="Hand Swing & Place Visual Effects",Desc="Show arm swing animation and particle effects locally.",Value=config.visualAnim,Callback=function(_Yr)config.visualAnim=_Yr;saveConfig()end,})yn_helper:Button({Title="Open 5x5 Floating Grid (Farm Mode)",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()if _sH then
 _sH("farm")
end
if _sE then
 _sE.Enabled=not _sE.Enabled
end
end,})yn_helper:Space()yn_helper:Section({Title="Farm Mode & Speed"})
local _Ys={["Place + Break"]="Place + Break",["Break Only"]="Break saja",["Place Only"]="Place saja",}
local _Yt={["Place + Break"]="Place + Break",["Break saja"]="Break Only",["Place saja"]="Place Only",}yn_helper:Dropdown({Title="Auto Farm Mode",Values={"Place + Break","Break Only","Place Only"},Value=_Yt[config.farmMode]or "Place + Break",Callback=function(_Yu)config.farmMode=_Ys[_Yu]or "Place + Break"saveConfig()end,})yn_helper:Slider({Title="Multi-Target Break (1 - 5 Tiles)",Desc=("Hit multiple tiles in rotation. Automatically uses Rayman Fist if equipped!"),IsTooltip=true,Step=1,Value={Min=1,Max=5,Default=math.clamp(config.farmMultiTarget,1,5)},Callback=function(_Yv)config.farmMultiTarget=math.clamp(math.floor(tonumber(_Yv)or 1),1,5);saveConfig()end,})yn_helper:Input({Title="Farm Block ID",Value=tostring(config.farmPlaceId),Placeholder="e.g. 2 (Dirt)",Callback=function(_Yw)
local _Yx=tonumber(_Yw)if _Yx and _Yx>0 then
 config.farmPlaceId=math.floor(_Yx)saveConfig()notify("Farm Block: "..getItemName(config.farmPlaceId).." ["..config.farmPlaceId.."]")
end
end,})
local _Yy={}local _Yz yn_helper:Input({Title="Search Block in Database",Placeholder="Type block name...",Callback=function(_YA)_Yy={}
local _YB={}if trim(_YA)~=""then
 for _YC,_YD in ipairs(_PH(_YA,25))do

local _YE=string.format("%s [%d]",_YD.name,_YD.id)_Yy[_YE]=_YD.id table.insert(_YB,_YE)
end
end
if#_YB==0 then
 _YB={"No results"}
end
if _Yz and _Yz.Refresh then
 pcall(function()_Yz:Refresh(_YB)
end)end
end,})_Yz=yn_helper:Dropdown({Title="Select Search Result",Values={"Type a block name above..."},Callback=function(_YF)
local _YG=_Yy[_YF]if _YG then
 config.farmPlaceId=_YG saveConfig()notify("Block set to: "..getItemName(_YG).." [".._YG.."]")
end
end,})yn_helper:Slider({Title="Place Delay (ms)",IsTooltip=true,Step=10,Value={Min=50,Max=1000,Default=math.clamp(config.farmPlaceMs,50,1000)},Callback=function(_YH)config.farmPlaceMs=tonumber(_YH)or 250;saveConfig()end,})yn_helper:Input({Title="Break Delay (seconds)",Value=tostring(config.farmDelay),Placeholder="0.22",Callback=function(_YI)
local _YJ=tonumber(_YI)if _YJ and _YJ>=0.03 and _YJ<=5 then
 config.farmDelay=_YJ;saveConfig()
end
end,})yn_helper:Toggle({Title="Auto Collect Drops",Value=config.farmTake,Callback=function(_YK)config.farmTake=_YK;saveConfig()end,})yn_helper:Space()yn_helper:Section({Title="Auto Save / Drop Seeds (When Seeds >= Threshold)"})yn_helper:Toggle({Title="Enable Auto Drop Seeds When Full",Desc=("Automatically pause farming, drop seeds at target world/pos, and return to resume Auto Farm."),Value=config.farmAutoDropSeed,Callback=function(_YL)config.farmAutoDropSeed=_YL;saveConfig()end,})yn_helper:Slider({Title="Drop When Seed Count Reaches >=",IsTooltip=true,Step=5,Value={Min=20,Max=200,Default=math.clamp(config.farmSeedDropAt or 200,20,200)},Callback=function(_YM)config.farmSeedDropAt=math.floor(tonumber(_YM)or 200);saveConfig()end,})yn_helper:Slider({Title="Keep Seeds in Backpack",IsTooltip=true,Step=5,Value={Min=0,Max=190,Default=math.clamp(config.farmSeedKeep or 0,0,190)},Callback=function(_YN)config.farmSeedKeep=math.floor(tonumber(_YN)or 0);saveConfig()end,})yn_helper:Input({Title="Seed Drop World (Empty = Current World | WORLD | WORLD:DOOR)",Value=config.farmDropWorld,Placeholder="e.g. STORAGE or STORAGE:1",Callback=function(_YO)config.farmDropWorld=trim(_YO or"");saveConfig()end,})yn_helper:Button({Title="SetPos Seed Drop (Save Current Position)",Color=Color3.fromHex("#10C550"),Justify="Center",Callback=function()
local _YP,_YQ=getPlayerTile()if not _YP then
 notify("Character position not detected!");return end
config.farmDropX,config.farmDropY=_YP,_YQ saveConfig()notify(string.format("Auto Farm Seed Drop position saved at (%d, %d)!",_YP,_YQ))end,})end)xb_helper("Tab:AutoClear",function()
local _YR=_XT:Tab({Title="Auto Clear",Icon="solar:cursor-square-bold",IconColor=_Xx,IconShape="Square",Border=true,})xy_scanHelper.tabs.clear=_YR
local _YS=_YR:Paragraph({Title="Auto Clear World Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.5)do
 pcall(function()
local _YT=autoClear.stats xg_helper(_YS,string.format("Status: %s (Pass %d | Row Y=%s)",autoClear.status,_YT.pass,_YT.row>=0 and tostring(_YT.row)or "-"),string.format(("Targets: %d | Remaining: %d | Skipped: %d\nBroken: %d | Drops Picked: %d"),_YT.scanned,_YT.left,_YT.skipped,_YT.broken,_YT.picked))
end)end
end)xk_helper(_YR,"Auto Clear World (Legit Walk + Hover Break)",("Walks via A* pathfinding between blocks and enables ModFly hover while breaking blocks underneath."),"autoclear")_YR:Dropdown({Title="Sweep Direction",Values={"Zig-zag","Left -> Right"},Value=(config.clearSweep=="Zig-zag")and "Zig-zag"or "Left -> Right",Callback=function(_YU)config.clearSweep=(_YU=="Zig-zag")and "Zig-zag"or "Kiri â Kanan"saveConfig()end,})_YR:Toggle({Title="Include Background Blocks",Value=config.clearIncludeBg,Callback=function(_YV)config.clearIncludeBg=_YV;saveConfig()end,})_YR:Input({Title="Break Punch Delay (seconds)",Value=tostring(config.clearBreakDelay),Callback=function(_YW)
local _YX=tonumber(_YW)if _YX and _YX>=0.03 and _YX<=5 then
 config.clearBreakDelay=_YX;saveConfig()
end
end,})_YR:Input({Title="Move Step Delay (seconds)",Value=tostring(config.clearTpDelay),Callback=function(_YY)
local _YZ=tonumber(_YY)if _YZ and _YZ>=0.05 and _YZ<=5 then
 config.clearTpDelay=_YZ;saveConfig()
end
end,})_YR:Toggle({Title="Auto Collect Drops",Value=config.clearTake,Callback=function(_Za)config.clearTake=_Za;saveConfig()end,})end)xb_helper("Tab:Farmer",function()
local _Zb=_XT:Tab({Title="Farmer (Harvest/Plant)",Icon="solar:check-square-bold",IconColor=_Xv,IconShape="Square",Border=true,})xy_scanHelper.tabs.harvest=_Zb
local _Zc=_Zb:Paragraph({Title="Farmer Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.5)do
 pcall(function()
local _Zd=autoHarvest.stats xg_helper(_Zc,"Status: "..autoHarvest.status,string.format(("Total Trees: %d | Ready: %d | Growing: %d\nHarvested: %d | Planted: %d | Drops Picked: %d\nPlant Seed: %s [ID %d] (In Bag: %d)"),_Zd.totalTrees,_Zd.ready,_Zd.skipped,_Zd.harvested,_Zd.planted,_Zd.picked,getItemName(config.harvestSeedId),config.harvestSeedId,countInv(config.harvestSeedId)))
end)end
end)xk_helper(_Zb,"Enable Farmer",("Automatically harvest ready trees & plant seeds using Zig-Zag A* walking."),"autoharvest")_Zb:Toggle({Title="Auto Harvest (Break Ready Trees)",Value=config.harvestDoHarvest,Callback=function(_Ze)config.harvestDoHarvest=_Ze;saveConfig()end,})_Zb:Toggle({Title="Auto Plant Seeds",Value=config.harvestDoPlant,Callback=function(_Zf)config.harvestDoPlant=_Zf;saveConfig()end,})_Zb:Input({Title="Seed ID for Auto Plant",Desc="e.g. 3 = Dirt Seed, 5 = Lava Seed",Value=tostring(config.harvestSeedId),Placeholder="3",Callback=function(_Zg)
local _Zh=tonumber(_Zg)if _Zh and _Zh>0 then
 config.harvestSeedId=math.floor(_Zh)saveConfig()notify("Plant Seed set to: "..getItemName(config.harvestSeedId))
end
end,})_Zb:Toggle({Title="Use Scaffold Blocks When Climbing",Value=config.harvestUseBlock,Callback=function(_Zi)config.harvestUseBlock=_Zi;saveConfig()end,})_Zb:Toggle({Title="Auto Collect Harvest Drops",Value=config.harvestTake,Callback=function(_Zj)config.harvestTake=_Zj;saveConfig()end,})end)xb_helper("Tab:AutoDF",function()
local _Zk=_XT:Tab({Title="Auto DF (Full World)",Icon="solar:hamburger-menu-bold",IconColor=_Xu,IconShape="Square",Border=true,})xy_scanHelper.tabs.df=_Zk
local _Zl=_Zk:Paragraph({Title="Auto Dirt Farm Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.5)do
 pcall(function()
local _Zm=autoDF.stats
local _Zn=getDirtId()
local _Zo=getDirtSeedId()xg_helper(_Zl,"Status: "..autoDF.status.." ("..tostring(_Zm.step)..")",string.format(("Top Dirt Row: Y=%d | Bedrock: Y=%d\nDirt in Bag: %d | Dirt Seeds: %d\nBroken: %d | Dirt Placed: %d | Drops Picked: %d"),_Zm.topDirtY,_Zm.bedrockY,countInv(_Zn),countInv(_Zo),_Zm.broken,_Zm.placed,_Zm.picked))
end)end
end)xk_helper(_Zk,"Enable Auto Dirt Farm (Full World)",("Automatically build lower & upper Dirt Farm platforms + Smart Dirt Restock."),"autodf")_Zk:Toggle({Title="Replace Lava/Rock with Dirt on Platforms",Value=config.dfReplacePlatform,Callback=function(_Zp)config.dfReplacePlatform=_Zp;saveConfig()end,})_Zk:Toggle({Title="Auto Collect Drops",Value=config.dfTake,Callback=function(_Zq)config.dfTake=_Zq;saveConfig()end,})_Zk:Toggle({Title="Enable ModFly During Auto DF (Anti-Lava)",Desc="Hover & stay immune to lava while breaking blocks.",Value=config.dfModFly,Callback=function(_Zr)config.dfModFly=_Zr saveConfig()if autoDF.on then
 setFlyModule("autodf",_Zr)
end
end,})_Zk:Input({Title="Break Punch Delay (seconds)",Value=tostring(config.dfBreakDelay),Callback=function(_Zs)
local _Zt=tonumber(_Zs)if _Zt and _Zt>=0.03 and _Zt<=5 then
 config.dfBreakDelay=_Zt;saveConfig()
end
end,})_Zk:Input({Title="Move Step Delay (seconds)",Value=tostring(config.dfTpDelay),Callback=function(_Zu)
local _Zv=tonumber(_Zu)if _Zv and _Zv>=0.05 and _Zv<=5 then
 config.dfTpDelay=_Zv;saveConfig()
end
end,})end)xb_helper("Tab:AutoSplice",function()
local _Zw=_XT:Tab({Title="Auto Splice",Icon="solar:square-transfer-horizontal-bold",IconColor=_Xt,IconShape="Square",Border=true,})xy_scanHelper.tabs.splice=_Zw
local _Zx=_Zw:Paragraph({Title="Auto Splice Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.6)do
 pcall(function()xg_helper(_Zx,"Status: "..autoSplice.status,string.format(("%s\nSeed A: %s [%d] (x%d) | Seed B: %s [%d] (x%d)\nPlanted: %d | Spliced: %d"),autoSplice.ResultText(),getItemName(config.spliceA),config.spliceA,countInv(config.spliceA),getItemName(config.spliceB),config.spliceB,countInv(config.spliceB),autoSplice.planted,autoSplice.made))
end)end
end)xk_helper(_Zw,"Enable Auto Splice","Plant Seed A and splice it with Seed B.","autosplice")_Zw:Input({Title="Seed A ID (Planted First)",Value=tostring(config.spliceA),Placeholder="3 (Dirt Seed)",Callback=function(_Zy)
local _Zz=tonumber(_Zy)if _Zz and _Zz>0 then
 config.spliceA=math.floor(_Zz);saveConfig()
end
end,})_Zw:Input({Title="Seed B ID (Spliced onto Seed A)",Value=tostring(config.spliceB),Placeholder="5 (Lava Seed)",Callback=function(_ZA)
local _ZB=tonumber(_ZA)if _ZB and _ZB>0 then
 config.spliceB=math.floor(_ZB);saveConfig()
end
end,})_Zw:Toggle({Title="Roam Entire World (A*)",Desc=("ON = Find empty tiles across the world. OFF = Only splice within 5x5 Grid."),Value=config.spliceRoam,Callback=function(_ZC)config.spliceRoam=_ZC;saveConfig()end,})_Zw:Slider({Title="Plant / Splice Delay (ms)",IsTooltip=true,Step=10,Value={Min=140,Max=2000,Default=math.clamp(config.spliceMs,140,2000)},Callback=function(_ZD)config.spliceMs=math.floor(tonumber(_ZD)or 300);saveConfig()end,})end)xb_helper("Tab:Pabrik",function()
local _ZE=_XT:Tab({Title="Seed Factory",Icon="solar:folder-with-files-bold",IconColor=_Xw,IconShape="Square",Border=true,})xy_scanHelper.tabs.pabrik=_ZE
local _ZF=_ZE:Paragraph({Title="Seed Factory Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.6)do
 pcall(function()
local _ZG=config.pabrikSeedId
local _ZH=getBlockForSeed(_ZG)
local _ZI,_ZJ=autoPabrik.ParseDropTarget()
local _ZK=(_ZI~=""and _ZI or "Current World")..(_ZJ and(" Door:".._ZJ)or"")..(config.pabrikDropX>=0 and string.format(" (%d,%d)",config.pabrikDropX,config.pabrikDropY)or"")xg_helper(_ZF,string.format("Status: %s (Phase: %s)",autoPabrik.status,autoPabrik.phase),string.format(("Seed: %s [%d] x%d | Block: %s x%d\nBreak Pos: %s\nDrop Target: %s (Max Seed Cap: %d)\nTotals: Harvested %d | Planted %d | Dropped %d"),getItemName(_ZG),_ZG,countInv(_ZG),_ZH and getItemName(_ZH)or "-",_ZH and countInv(_ZH)or 0,config.pabrikBreakX>=0 and string.format("Tile (%d, %d)",config.pabrikBreakX,config.pabrikBreakY)or "Not set!",config.pabrikDrop and _ZK or "Disabled",config.pabrikMaxSeed or 100,autoPabrik.harvested,autoPabrik.planted,autoPabrik.dropped))
end)end
end)xk_helper(_ZE,"Enable Seed Factory",("Full Cycle: Break Blocks -> Drop Excess Seeds -> Plant -> Wait -> Harvest -> Repeat."),"pabrik")_ZE:Input({Title="Factory Seed ID",Desc=("Block ID is detected automatically (e.g. 3 = Dirt Seed -> Block ID 2 = Dirt)."),Value=tostring(config.pabrikSeedId),Callback=function(_ZL)
local _ZM=tonumber(_ZL)if _ZM and _ZM>0 then
 config.pabrikSeedId=math.floor(_ZM);saveConfig()
end
end,})_ZE:Input({Title="Max Seed Cap (Plant & Rotation Limit)",Desc=("e.g. 100 = Only plant up to 100 seeds. Any extra seeds above 100 after breaking are automatically dropped at storage."),Value=tostring(config.pabrikMaxSeed or 100),Placeholder="100",Callback=function(_ZN)
local _ZO=tonumber(_ZN)if _ZO and _ZO>=1 then
 config.pabrikMaxSeed=math.floor(_ZO)saveConfig()notify("Factory Max Seed set to: "..tostring(config.pabrikMaxSeed))
end
end,})_ZE:Space()_ZE:Section({Title="Factory Break Position (SetPos Break)"})
local _ZP=_ZE:Group({})_ZP:Button({Title="SetPos Break (Save Position)",Color=Color3.fromHex("#10C550"),Justify="Center",Callback=function()
local _ZQ,_ZR=getPlayerTile()if not _ZQ then
 notify("Character position not detected!");return end
config.pabrikBreakX,config.pabrikBreakY=_ZQ,_ZR saveConfig()notify(string.format("Factory Break Position saved at (%d, %d)!",_ZQ,_ZR))end,})_ZP:Button({Title="Go to Break Pos",Justify="Center",Callback=function()if config.pabrikBreakX<0 or config.pabrikBreakY<0 then
 notify("Break Position is not set yet!")return end
task.spawn(function()ClickTP.To(config.pabrikBreakX,config.pabrikBreakY,nil,0.3,true)
end)end,})_ZE:Button({Title="Select Break Tiles (Open 5x5 Grid in Factory Mode)",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()if _sH then
 _sH("pabrik")
end
if _sE then
 _sE.Enabled=true
end
end,})_ZE:Space()_ZE:Section({Title="Seed Storage / Auto Drop Settings"})_ZE:Toggle({Title="Enable Auto Drop Excess Seeds to Storage",Value=config.pabrikDrop,Callback=function(_ZS)config.pabrikDrop=_ZS;saveConfig()end,})_ZE:Input({Title="Seed Storage World (WORLD or WORLD:DOOR_ID)",Value=config.pabrikDropWorld,Placeholder="e.g. STORAGE or STORAGE:1",Callback=function(_ZT)config.pabrikDropWorld=trim(_ZT or"");saveConfig()end,})_ZE:Button({Title="SetPos Seed Drop (Save Current Tile)",Justify="Center",Callback=function()
local _ZU,_ZV=getPlayerTile()if not _ZU then
 notify("Position not detected!");return end
config.pabrikDropX,config.pabrikDropY=_ZU,_ZV saveConfig()notify(string.format("Seed Drop Position saved at (%d, %d)",_ZU,_ZV))end,})end)xb_helper("Tab:AutoMove",function()
local _ZW=_XT:Tab({Title="Auto Move Item",Icon="solar:square-transfer-horizontal-bold",IconColor=_Xv,IconShape="Square",Border=true,})xy_scanHelper.tabs.automove=_ZW
local _ZX=_ZW:Paragraph({Title="Auto Move Item Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.6)do
 pcall(function()
local _ZY=tonumber(config.moveItemId)or 0 xg_helper(_ZX,string.format("Status: %s (Phase: %s)",autoGuard.status,autoGuard.phase),string.format(("Item: %s [ID %d] (In Bag: %d)\nWorld 1 (Take): %s  ->  World 2 (Drop): %s\nWorld 2 Drop Pos: %s\nTotal Picked: %d | Total Dropped: %d"),getItemName(_ZY),_ZY,countInv(_ZY),config.moveWorld1~=""and config.moveWorld1 or "(Not set)",config.moveWorld2~=""and config.moveWorld2 or "(Not set)",(config.moveDropX>=0 and config.moveDropY>=0)and string.format("(%d, %d)",config.moveDropX,config.moveDropY)or "(Not set)",autoGuard.collected,autoGuard.dropped))
end)end
end)xk_helper(_ZW,"Enable Auto Move (World 1 -> World 2)",("Take dropped items in World 1 -> Warp & Drop in World 2 (steps right 1 tile if full) -> Loop until empty."),"automove")_ZW:Input({Title="World 1 - Source World (WORLD or WORLD:DOOR_ID)",Value=config.moveWorld1,Placeholder="e.g. FARM1 or FARM1:DOOR1",Callback=function(_ZZ)config.moveWorld1=trim(_ZZ or"");saveConfig()end,})_ZW:Input({Title="World 2 - Drop World (WORLD or WORLD:DOOR_ID)",Value=config.moveWorld2,Placeholder="e.g. STORAGE1 or STORAGE1:DOOR2",Callback=function(_baa)config.moveWorld2=trim(_baa or"");saveConfig()end,})_ZW:Button({Title="SetPos Drop in World 2 (Save Current Position)",Color=Color3.fromHex("#10C550"),Justify="Center",Callback=function()
local _bab,_bac=getPlayerTile()if not _bab then
 notify("Position not detected!");return end
config.moveDropX,config.moveDropY=_bab,_bac saveConfig()notify(string.format("World 2 Drop Position saved at (%d, %d)!",_bab,_bac))end,})_ZW:Input({Title="Item ID to Move",Value=tostring(config.moveItemId),Placeholder="e.g. 2 (Dirt) or 3 (Dirt Seed)",Callback=function(_bad)
local _bae=tonumber(_bad)if _bae and _bae>0 then
 config.moveItemId=math.floor(_bae)saveConfig()notify("Auto Move Item set to: "..getItemName(config.moveItemId).." ["..config.moveItemId.."]")
end
end,})end)xb_helper("Tab:FastWrench",function()
local _baf=_XU:Tab({Title="Fast Wrench",Icon="solar:square-transfer-horizontal-bold",IconColor=_Xt,IconShape="Square",Border=true,})xy_scanHelper.tabs.fastwrench=_baf _baf:Section({Title="Fast Wrench Actions (0ms Modal Bypass)"})
local _bag,_bah,_bai _bag=_baf:Toggle({Title="Fast Pull (Wrench Player = Instant Pull)",Desc=("Bypass the wrench dialog and immediately pull the wrenched player."),Value=config.fastPull,Callback=function(_baj)config.fastPull=_baj if _baj then
 config.fastKick,config.fastBan=false,false if _bah and _bah.Set then
 pcall(function()_bah:Set(false)
end)end
if _bai and _bai.Set then
 pcall(function()_bai:Set(false)
end)end
notify("Fast Pull ENABLED! Wrench a player to pull them instantly.")end
saveConfig()end,})_bah=_baf:Toggle({Title="Fast Kick (Wrench Player = Instant Kick)",Desc=("Bypass the wrench dialog and immediately kick the wrenched player."),Value=config.fastKick,Callback=function(_bak)config.fastKick=_bak if _bak then
 config.fastPull,config.fastBan=false,false if _bag and _bag.Set then
 pcall(function()_bag:Set(false)
end)end
if _bai and _bai.Set then
 pcall(function()_bai:Set(false)
end)end
notify("Fast Kick ENABLED! Wrench a player to kick them instantly.")end
saveConfig()end,})_bai=_baf:Toggle({Title="Fast Ban (Wrench Player = Instant Ban)",Desc=("Bypass the wrench dialog and immediately ban the wrenched player."),Value=config.fastBan,Callback=function(_bal)config.fastBan=_bal if _bal then
 config.fastPull,config.fastKick=false,false if _bag and _bag.Set then
 pcall(function()_bag:Set(false)
end)end
if _bah and _bah.Set then
 pcall(function()_bah:Set(false)
end)end
notify("Fast Ban ENABLED! Wrench a player to ban them instantly.")end
saveConfig()end,})end)xb_helper("Tab:FastDropRecycle",function()
local _bam=_XU:Tab({Title="Fast Drop & Recycle",Icon="solar:square-transfer-horizontal-bold",IconColor=_Xt,IconShape="Square",Border=true,})xy_scanHelper.tabs.fastdroprecycle=_bam _bam:Section({Title="Fast Drop & Fast Recycle / Trash (0ms Dialog Bypass)"})_bam:Toggle({Title="Fast Drop (Click Drop = Instant Drop Without Dialog)",Desc=("Automatically bypass the quantity popup when clicking Drop in your Backpack."),Value=config.fastDrop,Callback=function(_ban)config.fastDrop=_ban saveConfig()notify("Fast Drop "..(_ban and "ENABLED!"or "DISABLED."))end,})_bam:Input({Title="Fast Drop Amount (0 = Drop All)",Desc=("Set to 0 to instantly drop the entire stack of the selected item."),Value=tostring(config.fastDropCount or 0),Placeholder="0 = All",Callback=function(_bao)
local _bap=tonumber(_bao)config.fastDropCount=(_bap and _bap>=0)and math.floor(_bap)or 0 saveConfig()notify("Fast Drop Amount set to: "..(config.fastDropCount==0 and "ALL"or tostring(config.fastDropCount)))end,})_bam:Space()_bam:Toggle({Title="Fast Recycle / Trash (Click Recycle = Instant Trash)",Desc=("Automatically bypass the confirmation popup when clicking Recycle in your Backpack."),Value=config.fastRecycle,Callback=function(_baq)config.fastRecycle=_baq saveConfig()notify("Fast Recycle "..(_baq and "ENABLED!"or "DISABLED."))end,})_bam:Input({Title="Fast Recycle Amount (0 = Recycle All)",Desc=("Set to 0 to instantly recycle the entire stack of the selected item."),Value=tostring(config.fastRecycleCount or 0),Placeholder="0 = All",Callback=function(_bar)
local _bas=tonumber(_bar)config.fastRecycleCount=(_bas and _bas>=0)and math.floor(_bas)or 0 saveConfig()notify("Fast Recycle Amount set to: "..(config.fastRecycleCount==0 and "ALL"or tostring(config.fastRecycleCount)))end,})end)xb_helper("Tab:Bag",function()
local _bat=_XV:Tab({Title="Backpack (Recycle & Locks)",Icon="solar:check-square-bold",IconColor=_Xv,IconShape="Square",Border=true,})xy_scanHelper.tabs.bag=_bat
local _bau=_bat:Paragraph({Title="Backpack Management Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.8)do
 pcall(function()
local _bav={}for _baw,_bax in ipairs(config.trashList or{})do
 table.insert(_bav,getItemName(_bax).." [".._bax.."]")end
xg_helper(_bau,"Last Action: ".._sP.status,string.format(("Total Recycled: %d items | Locks Converted: %d times\nAuto-Recycle List: %s"),_sP.recycled,_sP.converted,#_bav>0 and table.concat(_bav,", ")or "(None)"))
end)end
end)_bat:Toggle({Title="Enable Auto Recycle (Auto Trash Items)",Value=config.trashOn,Callback=function(_bay)config.trashOn=_bay;saveConfig()end,})_bat:Input({Title="Add / Remove Item ID from Auto-Recycle",Desc=("Enter an Item ID (e.g. 2 for Dirt) to toggle it in the Auto-Recycle list."),Placeholder="Enter Item ID...",Callback=function(_baz)
local _baA=tonumber(_baz)if not _baA or _baA<=0 then
 return end
_baA=math.floor(_baA)
local _baB=table.find(config.trashList,_baA)if _baB then
 table.remove(config.trashList,_baB)notify(getItemName(_baA).." removed from Auto-Recycle list.")else
 table.insert(config.trashList,_baA)notify(getItemName(_baA).." added to Auto-Recycle list.")end
saveConfig()end,})_bat:Slider({Title="Recycle When Count >=",IsTooltip=true,Step=5,Value={Min=5,Max=200,Default=math.clamp(config.trashAt,5,200)},Callback=function(_baC)config.trashAt=math.floor(tonumber(_baC)or 150);saveConfig()end,})_bat:Slider({Title="Keep Amount in Backpack",IsTooltip=true,Step=5,Value={Min=0,Max=195,Default=math.clamp(config.trashKeep,0,195)},Callback=function(_baD)config.trashKeep=math.floor(tonumber(_baD)or 0);saveConfig()end,})_bat:Space()_bat:Section({Title="Locks & Quick Drop"})_bat:Toggle({Title="Auto Convert Locks (100 WL -> 1 DL, 100 DL -> 1 BGL)",Value=config.convertLockOn,Callback=function(_baE)config.convertLockOn=_baE;saveConfig()end,})
local _baF="100"_bat:Input({Title="World Lock Drop Amount",Value="100",Placeholder="Amount (1-10000)",Callback=function(_baG)_baF=_baG end,})_bat:Button({Title="Drop World Locks Now",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()
local _baH=tonumber(_baF)if _baH and _baH>=1 and _baH<=maxItems then
 task.spawn(_sa,math.floor(_baH))else
 notify("Invalid WL amount!")
end
end,})end)xb_helper("Tab:GrowScan",function()
local _baI=_XV:Tab({Title="GrowScan 9000",Icon="solar:info-square-bold",IconColor=_Xw,IconShape="Square",Border=true,})xy_scanHelper.tabs.scan=_baI
local _baJ=_baI:Paragraph({Title="GrowScan 9000",Desc=("Click the button below to scan all blocks, trees, and floating drops in the world.")})
local function _baK()
local _baL=_PG()if not _baL then
 xg_helper(_baJ,"GrowScan","World not detected.")return
end
local function _baM(_baN,_baO)
local _baP={}for _baQ,_baR in pairs(_baN)do
 table.insert(_baP,{id=_baQ,n=_baR})end
table.sort(_baP,function(_baS,_baT)return _baS.n>_baT.n
end)
local _baU={}for _baV=1,math.min(_baO or 12,#_baP)do
 table.insert(_baU,string.format("â¢ %s [%d] x%d",getItemName(_baP[_baV].id),_baP[_baV].id,_baP[_baV].n))end
return#_baU>0 and table.concat(_baU,"\n")or "Empty"
end
local _baW={}for _baX,_baY in pairs(_baL.trees)do

local _baZ=_baY.nextIn and string.format(" (ready in %ds)",math.max(0,math.ceil(_baY.nextIn)))or""table.insert(_baW,string.format("â¢ %s: %d ready | %d growing%s",getItemName(_baX),_baY.ready,_baY.growing,_baZ))
end
local _bba=table.concat({string.format("World: %s (%dx%d)",getWorldName(),_baL.w,_baL.h),string.format("FG: %d | BG: %d | Floating: %d (%d stacks)",_baL.totalFg,_baL.totalBg,_baL.totalDrops,_baL.piles),string.format("Trees: %d ready | %d growing",_baL.readyTrees,_baL.growingTrees),"\n[TREES IN WORLD]:\n"..(#_baW>0 and table.concat(_baW,"\n")or "No trees"),"\n[FLOATING DROPS]:\n".._baM(_baL.drops,10),"\n[WORLD BLOCKS]:\n".._baM(_baL.fg,12),},"\n")xg_helper(_baJ,"GrowScan Results ("..os.date("%H:%M:%S")..")",_bba)end
_baI:Button({Title="Scan World Now",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=_baK,})_baI:Button({Title="Open Native In-Game GrowScan UI",Justify="Center",Callback=function()if not _PF()then
 notify("Native GrowScan UI is unavailable.")
end
end,})end)xb_helper("Tab:Pos",function()
local _bbb=_XV:Tab({Title="Teleport & Positions",Icon="solar:hamburger-menu-bold",IconColor=_Xu,IconShape="Square",Border=true,})xy_scanHelper.tabs.pos=_bbb
local _bbc=""_bbb:Input({Title="Target World Name",Placeholder="Enter world name...",Callback=function(_bbd)_bbc=trim(_bbd or"")end,})_bbb:Button({Title="Warp to World",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()if _bbc~=""then
 task.spawn(_sf,_bbc)else
 notify("Enter a world name first!")
end
end,})_bbb:Space()_bbb:Section({Title="Saved Positions (Pos 1 / Pos 2)"})for _bbe=1,2 do

local _bbf=_bbb:Paragraph({Title="Position ".._bbe,Desc="Not set"})
local function _bbg()
local _bbh=config["pos".._bbe]if type(_bbh)=="table"and type(_bbh.x)=="number"then
 xg_helper(_bbf,"Saved Pos ".._bbe,string.format("Tile (%d, %d) in World %s",_bbh.x,_bbh.y,_bbh.world or "-"))else
 xg_helper(_bbf,"Position ".._bbe,"Not set")
end
end
table.insert(xy_scanHelper.refreshers,_bbg)_bbg()
local _bbi=_bbb:Group({})_bbi:Button({Title="Save Pos ".._bbe,Justify="Center",Callback=function()_sl(_bbe);spliceSetup()end
})_bbi:Button({Title="Teleport (win".._bbe..")",Justify="Center",Callback=function()task.spawn(_sw,_bbe)end
})
end
end)xb_helper("Tab:Vending",function()
local _bbj=_XV:Tab({Title="Vending Machine",Icon="solar:folder-with-files-bold",IconColor=_Xt,IconShape="Square",Border=true,})xy_scanHelper.tabs.vending=_bbj
local _bbk=_bbj:Paragraph({Title="Vending Bot Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.8)do
 pcall(function()xg_helper(_bbk,"Status: "..guardTimer.status,string.format("Mode: %s\nStocked: %d | Emptied: %d",config.vendMode,guardTimer.stocked,guardTimer.taken))
end)end
end)_bbj:Toggle({Title="Enable Vending Machine Bot",Value=guardTimer.on,Callback=function(_bbl)if _bbl then
 guardTimer.Start()else
 guardTimer.Stop()
end
end,})
local _bbm={["Restock from Backpack/Drops"]="Isi stock dari drop",["Empty Until Depleted"]="Kosongkan sampai habis",}
local _bbn={["Isi stock dari drop"]="Restock from Backpack/Drops",["Kosongkan sampai habis"]="Empty Until Depleted",}_bbj:Dropdown({Title="Vending Mode",Values={"Restock from Backpack/Drops","Empty Until Depleted"},Value=_bbn[config.vendMode]or "Restock from Backpack/Drops",Callback=function(_bbo)config.vendMode=_bbm[_bbo]or "Isi stock dari drop"saveConfig()end,})_bbj:Input({Title="Drop World When Emptying (WORLD or WORLD:DOOR)",Value=config.vendPoint,Placeholder="e.g. STORAGE or STORAGE:1",Callback=function(_bbp)config.vendPoint=trim(_bbp or"");saveConfig()end,})_bbj:Button({Title="SetPos Drop for Emptied Vending Items",Justify="Center",Callback=function()
local _bbq,_bbr=getPlayerTile()if not _bbq then
 notify("Position not detected!");return end
config.vendDropX,config.vendDropY=_bbq,_bbr saveConfig()notify(string.format("Vending Drop Position saved at (%d, %d)",_bbq,_bbr))end,})end)xb_helper("Tab:Guard",function()
local _bbs=_XW:Tab({Title="Guard & Reconnect",Icon="solar:info-square-bold",IconColor=_Xx,IconShape="Square",Border=true,})xy_scanHelper.tabs.guard=_bbs
local _bbt=_bbs:Paragraph({Title="Guard & Reconnect Status",Desc="Idle"})task.spawn(function()while isAlive()and task.wait(0.6)do
 pcall(function()xg_helper(_bbt,"Guard: "..guardModule.status.." | Reconnect: "..bonusModule.status,string.format(("Players in World: %s\nStaff in Server: %s\nDetections: %d | Rejoins: %d"),guardModule.hereText,guardModule.staffServerText,guardModule.detected,bonusModule.count))
end)end
end)xk_helper(_bbs,"Enable Anti-Mod Guard",("Monitor Moderators / Developers (including undercover) or other players entering the world."),"guard")
local _bbu={["Staff Only (Mod/Dev)"]="Staff (Mod/Dev)",["All Players"]="Semua pemain",}
local _bbv={["Staff (Mod/Dev)"]="Staff Only (Mod/Dev)",["Semua pemain"]="All Players",}_bbs:Dropdown({Title="Detection Target",Values={"Staff Only (Mod/Dev)","All Players"},Value=_bbv[config.guardWho]or "Staff Only (Mod/Dev)",Callback=function(_bbw)config.guardWho=_bbu[_bbw]or "Staff (Mod/Dev)"saveConfig()end,})_bbs:Toggle({Title="Pause All Active Bots on Detection",Value=config.guardStopAll,Callback=function(_bbx)config.guardStopAll=_bbx;saveConfig()end,})_bbs:Toggle({Title="Immediately Leave World on Detection",Value=config.guardLeave,Callback=function(_bby)config.guardLeave=_bby;saveConfig()end,})_bbs:Toggle({Title="Auto Resume When Safe",Value=config.guardAutoBack,Callback=function(_bbz)config.guardAutoBack=_bbz;saveConfig()end,})_bbs:Slider({Title="Return Wait Time (seconds)",IsTooltip=true,Step=5,Value={Min=15,Max=300,Default=math.clamp(config.guardBackSec,15,300)},Callback=function(_bbA)config.guardBackSec=tonumber(_bbA)or 60;saveConfig()end,})_bbs:Button({Title="Whitelist Players Currently in World",Justify="Center",Callback=function()
local _bbB=guardModule.AllowCurrentPlayers()notify(_bbB.." players in this world added to whitelist.")end,})_bbs:Space()_bbs:Section({Title="Auto Reconnect (World Closed & Server Disconnect)"})xk_helper(_bbs,"Enable Auto Reconnect",("Re-enter the world & resume bot activities if kicked or disconnected."),"autorejoin")_bbs:Toggle({Title="Re-Enter When World Closes / Kicked",Value=config.reconnectWorld,Callback=function(_bbC)config.reconnectWorld=_bbC;saveConfig()end,})_bbs:Toggle({Title="Always Stay in World (Auto Enter from Menu)",Value=config.reconnectKeep,Callback=function(_bbD)config.reconnectKeep=_bbD;saveConfig()end,})_bbs:Toggle({Title="Auto Teleport on Server Disconnect",Value=config.reconnectServer,Callback=function(_bbE)config.reconnectServer=_bbE;saveConfig()end,})_bbs:Input({Title="Reconnect Target World (Empty = Last World)",Placeholder="WORLDNAME",Callback=function(_bbF)config.targetWorld=trim(_bbF or"");saveConfig()end,})end)xb_helper("Tab:Bonus",function()
local _bbG=_XW:Tab({Title="Auto Chat & Bonus",Icon="solar:file-text-bold",IconColor=_Xt,IconShape="Square",Border=true,})xy_scanHelper.tabs.bonus=_bbG
local _bbH=_bbG:Paragraph({Title="Auto Chat & Bonus Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.8)do
 pcall(function()xg_helper(_bbH,string.format("Auto Chat: %s (Sent: %d)",autoChat.on and "ACTIVE"or "OFF",autoChat.sent),string.format("Configured Message: %s\nLast Sent: %s\nQuests: %s\nRedeem: %s",config.chatText~=""and config.chatText or "(Not set)",autoChat.last,ml_module.questText,ml_module.codeText))
end)end
end)_bbG:Section({Title="Auto Chat / Spammer (Single Message)"})xk_helper(_bbG,"Enable Auto Chat",("Automatically send your configured message to the world chat channel."),"autochat")_bbG:Input({Title="Auto Chat Message",Value=config.chatText,Placeholder="Type the message to send...",Callback=function(_bbI)config.chatText=trim(_bbI or"")saveConfig()end,})_bbG:Slider({Title="Chat Interval (seconds)",IsTooltip=true,Step=1,Value={Min=3,Max=120,Default=math.clamp(config.chatInterval,3,120)},Callback=function(_bbJ)config.chatInterval=tonumber(_bbJ)or 6;saveConfig()end,})_bbG:Button({Title="Send Chat Message Once Now",Justify="Center",Callback=function()autoChat.SendNext()end,})_bbG:Space()_bbG:Section({Title="Quests & Promo Codes"})xk_helper(_bbG,"Auto Claim Completed Quests","Automatically check and claim finished quests every 30s.","autoquest")_bbG:Toggle({Title="Auto Redeem Active Promo Codes",Value=config.bonusAutoRedeem,Callback=function(_bbK)config.bonusAutoRedeem=_bbK if _bbK then
 ml_module.nextCode=0 end
saveConfig()end,})
local _bbL=_bbG:Group({})_bbL:Button({Title="Check Quests Now",Justify="Center",Callback=function()task.spawn(_PE)end,})_bbL:Button({Title="Redeem All Active Codes",Justify="Center",Callback=function()task.spawn(function()ml_module.CheckCodes()notify(ml_module.codeText,"Promo Codes")
end)end,})end)xb_helper("Tab:Visual",function()
local _bbM=_XW:Tab({Title="Cosmetics & Roles",Icon="solar:check-square-bold",IconColor=_Xw,IconShape="Square",Border=true,})xy_scanHelper.tabs.visual=_bbM _bbM:Section({Title="Client-Side Visual Wearables"})
local _bbN={}local _bbO _bbM:Input({Title="Search Wearable / Cosmetic",Placeholder="e.g. Rayman, Wings,Katana...",Callback=function(_bbP)_bbN={}
local _bbQ={}
local _bbR=trim(_bbP):lower()for _bbS,_bbT in ipairs(_PL())do
 if _bbR==""or _bbT.lower:find(_bbR,1,true)then

local _bbU=string.format("%s [%d] (%s)",_bbT.name,_bbT.id,_bbT.slot)_bbN[_bbU]=_bbT.id table.insert(_bbQ,_bbU)if#_bbQ>=30 then
 break
end
end
end
if#_bbQ==0 then
 _bbQ={"No matching items"}
end
if _bbO and _bbO.Refresh then
 pcall(function()_bbO:Refresh(_bbQ)
end)end
end,})_bbO=_bbM:Dropdown({Title="Equip / Unequip Visual Item",Values={"Search for an item above..."},Callback=function(_bbV)
local _bbW=_bbN[_bbV]if _bbW then
 _PJ(_bbW)notify("Toggled visual item: "..getItemName(_bbW))
end
end,})_bbM:Button({Title="Reset All Visual Wearables",Justify="Center",Callback=_PK,})_bbM:Space()_bbM:Section({Title="Watermark & Title Role"})_bbM:Toggle({Title="Custom Animated NameTag Watermark",Value=config.customWatermark,Callback=function(_bbX)config.customWatermark=_bbX;saveConfig()end,})_bbM:Input({Title="Custom Watermark Text",Value=config.watermarkText,Placeholder="ANCH HUB",Callback=function(_bbY)
local _bbZ=trim(_bbY or"")if _bbZ~=""then
 config.watermarkText=_bbZ;saveConfig()
end
end,})
local _bcb=_bbM:Dropdown({Title="Select Owned Title / Role",Values=_PM(),Value=config.selectedRole or "none",Callback=function(_bca)config.selectedRole=_bca or "none"saveConfig()_PN(config.selectedRole)end,})_bbM:Button({Title="Refresh Owned Roles",Justify="Center",Callback=function()if _bcb and _bcb.Refresh then
 pcall(function()_bcb:Refresh(_PM())end)notify("Owned roles list refreshed!")
end
end,})end)xb_helper("Tab:Settings",function()
local _bcc=_XX:Tab({Title="Webhook & Settings",Icon="solar:folder-with-files-bold",IconColor=_Xv,IconShape="Square",Border=true,})xy_scanHelper.tabs.settings=_bcc
local _bcd=_bcc:Paragraph({Title="Discord Webhook Status",Desc="Last Status: -"})task.spawn(function()while isAlive()and task.wait(1)do
 pcall(function()xg_helper(_bcd,"Discord Webhook: "..(config.webhookOn and "ENABLED"or "DISABLED"),"Delivery Status: "..tostring(webhook.Status))
end)end
end)_bcc:Toggle({Title="Enable Discord Webhook Notifications",Value=config.webhookOn,Callback=function(_bce)config.webhookOn=_bce;saveConfig()end,})_bcc:Input({Title="Discord Webhook URL",Value=config.webhookUrl,Placeholder="https://discord.com/api/webhooks/...",Callback=function(_bcf)config.webhookUrl=trim(_bcf or"");saveConfig()end,})_bcc:Slider({Title="Periodic Session Report Interval (minutes, 0 = Off)",IsTooltip=true,Step=5,Value={Min=0,Max=120,Default=math.clamp(config.webhookReportMin,0,120)},Callback=function(_bcg)config.webhookReportMin=tonumber(_bcg)or 0;saveConfig()end,})_bcc:Button({Title="Send Test Webhook",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()if not webhook.Valid(config.webhookUrl)then
 notify("Invalid Discord Webhook URL!")else

local _bch=config.webhookOn config.webhookOn=true webhook.Send("test","Test connection from **ANCH Hub | GrowBlox**! World: `"..getWorldName().."`")config.webhookOn=_bch notify("Test message queued!")
end
end,})_bcc:Space()_bcc:Section({Title="Session & Auto-Execute on Teleport"})_bcc:Toggle({Title="Auto-Restore Enabled Features on Startup",Value=config.autoRestore,Callback=function(_bci)config.autoRestore=_bci;saveConfig()end,})_bcc:Toggle({Title="Auto-Reload Script on World Teleport",Value=config.autoReload,Callback=function(_bcj)config.autoReload=_bcj;saveConfig()end,})_bcc:Input({Title="Script Reload URL (Optional for queue_on_teleport)",Value=config.scriptUrl,Placeholder="https://raw.githubusercontent.com/...",Callback=function(_bck)config.scriptUrl=trim(_bck or"");saveConfig()end,})
local _bcl=_bcc:Group({})_bcl:Button({Title="Install Loader to Autoexec",Justify="Center",Callback=_VY,})_bcl:Button({Title="Rejoin Current Server",Justify="Center",Callback=_sj,})end)pcall(function()hubUI:SetToggleKey(Enum.KeyCode.RightControl)end)do
(function()
local function _bcm(_bcn,_bco)if not _bcn or _bcn==""then
 return not _bco end
_bcn=_bcn:lower()if _bcn=="on"or _bcn=="1"or _bcn=="true"then
 return true
end
if _bcn=="off"or _bcn=="0"or _bcn=="false"then
 return false end
return not _bco
end
local function _bcp(_bcq)if type(_bcq)~="string"then
 return false
end
local _bcr=config.prefix or "/"if _bcq:sub(1,#_bcr)~=_bcr then
 return false
end
local cmdBody=trim(_bcq:sub(#_bcr+1))if cmdBody==""then
 return false
end
local cmdName,cmdArg=cmdBody:match("^(%S+)%s*(.*)$")if not cmdName then
 return false end
cmdName=cmdName:lower()if cmdName=="wld"or cmdName=="wd"then
 task.spawn(_sa,tonumber(cmdArg))return true elseif cmdName=="tp"or cmdName=="warp"then
 task.spawn(_sf,cmdArg)return true elseif cmdName=="pos1"then
 _sl(1);return true elseif cmdName=="pos2"then
 _sl(2);return true elseif cmdName=="win1"or cmdName=="w1"then
 task.spawn(_sw,1,tonumber(cmdArg));return true elseif cmdName=="win2"or cmdName=="w2"then
 task.spawn(_sw,2,tonumber(cmdArg));return true elseif cmdName=="pos"then
 _sq();return true elseif cmdName=="rejoin"or cmdName=="rj"then
 _sj();return true elseif cmdName=="noclip"then
 toggleFeature("noclip",_bcm(cmdArg,_iy));return true elseif cmdName=="unlimitedjump"or cmdName=="uj"then
 toggleFeature("ujump",_bcm(cmdArg,_Pl));return true elseif cmdName=="blink"then
 toggleFeature("blink",_bcm(cmdArg,_Pj));return true elseif cmdName=="longhand"or cmdName=="lh"then

local _bcv=tonumber(cmdArg)if _bcv then
 config.longhandRange=_bcv;saveConfig();toggleFeature("longhand",true)else
 toggleFeature("longhand",_bcm(cmdArg,_Pk))end
return true elseif cmdName=="afk"then
 toggleFeature("antiafk",_bcm(cmdArg,_Pm));return true elseif cmdName=="autorejoin"or cmdName=="arj"then
 toggleFeature("autorejoin",_bcm(cmdArg,config.reconnectOn));return true elseif cmdName=="af"or cmdName=="autofarm"then
 toggleFeature("autofarm",_bcm(cmdArg,autoFarm.on));return true elseif cmdName=="ac"or cmdName=="autoclear"then
 toggleFeature("autoclear",_bcm(cmdArg,autoClear.on));return true elseif cmdName=="ah"or cmdName=="autoharvest"then
 toggleFeature("autoharvest",_bcm(cmdArg,autoHarvest.on));return true elseif cmdName=="adf"or cmdName=="autodf"then
 toggleFeature("autodf",_bcm(cmdArg,autoDF.on));return true elseif cmdName=="as"or cmdName=="autosplice"then
 toggleFeature("autosplice",_bcm(cmdArg,autoSplice.on));return true elseif cmdName=="pabrik"or cmdName=="factory"then
 toggleFeature("pabrik",_bcm(cmdArg,autoPabrik.on));return true elseif cmdName=="guard"or cmdName=="penjaga"then
 toggleFeature("guard",_bcm(cmdArg,guardModule.on));return true elseif cmdName=="chat"or cmdName=="autochat"then
 toggleFeature("autochat",_bcm(cmdArg,autoChat.on));return true elseif cmdName=="ctp"or cmdName=="clicktp"then
 toggleFeature("clicktp",_bcm(cmdArg,ClickTP.clickOn));return true elseif cmdName=="god"then
 toggleFeature("god",_bcm(cmdArg,_Po));return true elseif cmdName=="lite"then
 toggleFeature("lite",_bcm(cmdArg,config.liteMode));return true elseif cmdName=="gs"or cmdName=="growscan"then
 _PF();return true elseif cmdName=="blockid"or cmdName=="bid"then

local _bcw=_PH(cmdArg,5)if#_bcw==0 then
 notify("No blocks matching: "..tostring(cmdArg))else

local _bcx={}for _bcy,_bcz in ipairs(_bcw)do
 table.insert(_bcx,_bcz.name.." [".._bcz.id.."]")end
notify(table.concat(_bcx,", "),"Block ID Search")end
return true end
return false
end
local textBoxRegistry={}
local function registerTextBox(textBoxInst)if textBoxInst:IsA("TextBox")and not textBoxRegistry[textBoxInst]then
 textBoxRegistry[textBoxInst]=true trackConn(textBoxInst.FocusLost:Connect(function(focusLost)if focusLost and isAlive()then
 _bcp(textBoxInst.Text)
end
end))
end
end
for _bcE,_bcF in ipairs(PlayerGui:GetDescendants())do
 registerTextBox(_bcF)end
trackConn(PlayerGui.DescendantAdded:Connect(registerTextBox))trackConn(LocalPlayer.Chatted:Connect(_bcp))end)()
end
end)()end
session.Cleanup=function()session.Alive=false clearKeys()keyState.active=false if autoFarm.on then
 pcall(_vu)
end
if autoClear.on then
 pcall(autoClear.Stop)
end
if autoHarvest.on then
 pcall(autoHarvest.Stop)
end
if autoDF.on then
 pcall(autoDF.Stop)
end
if autoSplice.on then
 pcall(autoSplice.Stop)
end
if autoPabrik.on then
 pcall(autoPabrik.Stop)
end
if autoGuard and autoGuard.Stop then
 pcall(autoGuard.Stop)
end
if guardTimer and guardTimer.Stop then
 pcall(guardTimer.Stop)
end
if ClickTP.clickOn then
 pcall(ClickTP.StopClick)
end
if _Pj then
 pcall(_Pr)
end
if _Pk then
 pcall(_Pt)
end
if _iy then
 pcall(disableFly)
end
if _Pl then
 pcall(_Pv)
end
if _Po then
 pcall(_PB)
end
if _Pm then
 pcall(_Px)
end
if config.liteMode then
 pcall(liteModeModule.Set,false)
end
if session.RestoreWatermark then
 pcall(session.RestoreWatermark)
end
if session.RestoreFastWrench then
 pcall(session.RestoreFastWrench)
end
if session.RestoreFastBackpack then
 pcall(session.RestoreFastBackpack)
end
for _bcG,_bcH in ipairs(session.Connections)do
 pcall(function()_bcH:Disconnect()
end)end
table.clear(session.Connections)if _sE then
 pcall(function()_sE:Destroy()
end)end
if _iA then
 pcall(function()_iA:Destroy()
end)end
if hubUI and hubUI.Destroy then
 pcall(function()hubUI:Destroy()
end)end
end
task.spawn(function()genv.__ANCHHub_LoadingAt=nil isLoading=false notify("ANCH HUB V1.3 Loaded! All features are ready.","ANCH HUB",4,true)_Pw()GameRefs.Scan(true)stats.Reset()if config.liteMode then
 liteModeModule.Set(true)end
trackConn(LocalPlayer.OnTeleport:Connect(function()isLoading=false saveConfig()pcall(_se)end))if config.autoRestore then
 for _bcI,_bcJ in pairs(featureMap)do
 if config.session[_bcI]and not _bcJ.noSession and not _bcJ.get()then
 pcall(_bcJ.set,true)
end
end
if spliceSetup then
 spliceSetup()
end
end
task.spawn(bonusModule.CheckStartup)task.spawn(autoPabrik.CheckStartup)task.spawn(autoGuard.CheckStartup)
local _bcK=getWorldName()while isAlive()do
 task.wait(1.5)
local _bcL=getWorldName()if _bcL~=""and _bcL~=_bcK then
 _bcK=_bcL GameRefs.Scan(true)
end
end
end)
