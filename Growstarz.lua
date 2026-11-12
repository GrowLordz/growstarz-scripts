local genv=(getgenv and getgenv())or _G
if genv.__ANCHHub_LoadingAt and(os.clock()-genv.__ANCHHub_LoadingAt)<4.5 then
    return
end genv.__ANCHHub_LoadingAt=os.clock()for k_b,v_c in ipairs({"__ANCHHubSession","__Tadonoki","__Alfian","__GTFarm"})do
if genv[v_c]then genv[v_c].Alive=false
    if genv[v_c].Cleanup then pcall(genv[v_c].Cleanup)end
end genv[v_c]=nil
end
local session={Alive=true,Connections={}}session.Cleanup=function()session.Alive=false
end genv.__ANCHHubSession=session genv.ANCHHubGB_Loaded=os.clock()local function isAlive()return session.Alive and genv.__ANCHHubSession==session
end
local function trackConn(_g)if _g then table.insert(session.Connections,_g)end
    return _g
end
do
    local getThreadId=getthreadidentity or get_thread_identity or getidentity or(syn and syn.get_thread_identity)if type(getThreadId)=="function"then pcall(function()session.Ident=getThreadId()end)end session.Exec=coroutine.create(function(_i)while true
        do
            local _j,_k=pcall(_i)_i=coroutine.yield(_j,_k)end end)end
local function safeExec(_m)local setThreadId=setthreadidentity or set_thread_identity or setidentity or(syn and syn.set_thread_identity)local function _o()if _d.Ident and type(setThreadId)=="function"then pcall(setThreadId,session.Ident)end
    end
local execFn=session.Exec
if execFn and coroutine.status(execFn)=="suspended"then
    local _q,_r=coroutine.resume(execFn,function()_o()_m()end)if _q and _r~=false then
        return true
    end
end _o()return pcall(_m)end
local cloneref=(cloneref or clonereference or function(_s)return _s end)local svc_Players=_t(game:GetService("Players"))local svc_ReplicatedStore=cloneref(game:GetService("ReplicatedStorage"))local svc_StarterGui=cloneref(game:GetService("StarterGui"))local svc_GuiSvc=cloneref(game:GetService("GuiService"))local svc_UserInputSvc=cloneref(game:GetService("UserInputService"))local svc_HttpSvc=cloneref(game:GetService("HttpService"))local svc_RunSvc=cloneref(game:GetService("RunService"))local svc_TeleportSvc=cloneref(game:GetService("TeleportService"))local svc_VirtualUser=cloneref(game:GetService("VirtualUser"))local svc_TextChatSvc=_t(game:GetService("TextChatService"))local svc_TextSvc=_t(game:GetService("TextService"))local localPlayer=svc_Players.LocalPlayer
local obj_PlayerGui=localPlayer:WaitForChild("PlayerGui",5)local obj_Shared=_v:FindFirstChild("Shared")or _v:WaitForChild("Shared",3)local obj_WorldRemotes=_v:FindFirstChild("WorldRemotes")or _v:WaitForChild("WorldRemotes",1)local remote_DropItem=obj_WorldRemotes and obj_WorldRemotes:FindFirstChild("DropItem")local remote_SetTile=obj_WorldRemotes and obj_WorldRemotes:FindFirstChild("SetTile")local remote_TakeDrop=obj_WorldRemotes and obj_WorldRemotes:FindFirstChild("TakeDrop")local remote_PickTitle=obj_WorldRemotes and obj_WorldRemotes:FindFirstChild("PickTitle")local remote_WorldClosed=obj_WorldRemotes and obj_WorldRemotes:FindFirstChild("WorldClosed")local itemDB=genv.__ANCH_ItemDBCache or{}local function _Q()if next(_P)~=nil then
        return itemDB
    end pcall(function()local svc_ReplicatedStore=game:GetService("ReplicatedStorage")local obj_Shared=svc_ReplicatedStore:FindFirstChild("Shared")or obj_Shared
    local obj_ItemDB=_S and obj_Shared:FindFirstChild("ItemDB")if obj_ItemDB then
        local _U,_V=pcall(require,obj_ItemDB)if _U and type(_V)=="table"then
            if type(rawget(_V,2))=="table"or type(_V[2])=="table"then itemDB=_V else
                for k_W,v_X in ipairs({"items","Items","list","byId","data","db"})do
                    local _Y=rawget(_V,v_X)if type(_Y)=="table"and(type(_Y[2])=="table"or type(_Y["2"])=="table")then itemDB=_Y break
                    end
            end
        if next(itemDB)==nil then itemDB=_V
        end
end genv.__ANCH_ItemDBCache=itemDB
end
end end)return _P
end getItemDB()local _Z,_ba=pcall(function()return obj_Shared and require(obj_Shared:FindFirstChild("Inventory"))end)local _bb,_bc=pcall(function()return obj_Shared and require(obj_Shared:FindFirstChild("Net"))end)local _bd,_be=pcall(function()return obj_Shared and require(obj_Shared:FindFirstChild("Roles"))end)local _bf,_bg=pcall(function()return obj_Shared and require(obj_Shared:FindFirstChild("Sfx"))end)local _bh,_bi=pcall(function()return obj_Shared and require(obj_Shared:FindFirstChild("Splice"))end)local obj_GameGui=obj_PlayerGui and(_H:FindFirstChild("GameGui")or obj_PlayerGui:WaitForChild("GameGui",2))local _bk,_bl=pcall(function()return obj_GameGui and require(obj_GameGui:FindFirstChild("Particles"))end)local _bm,_bn=pcall(function()return obj_GameGui and require(obj_GameGui:FindFirstChild("WorldMenu"))end)do(function()if(_bb and _Z and next(itemDB)~=nil)or type(getloadedmodules)~="function"then
        return
    end
local _bo,_bp=pcall(getloadedmodules)if not _bo or type(_bp)~="table"then
    return
end
local function _bq(_br,_bs)local _bt,_bu=pcall(function()return _br[_bs]end);return _bt and _bu or nil
end
local function _bv(_bw,_bx)return type(_bq(_bw,_bx))=="function"end
for k_by,v_bz in ipairs(_bp)do
    local constEntry,_bB=pcall(require,v_bz)if constEntry and type(_bB)=="table"then
        if not _bb and _bv(_bB,"call")and type(_bq(_bB,"act"))=="table"and type(_bq(_bB,"tile"))=="table"then _bb,_bc=true,_bB elseif not _bd and _bv(_bB,"titlesOf")and _bv(_bB,"isModerator")then _bd,_be=true,_bB elseif not _bf and _bv(_bB,"play")and _bv(_bB,"playAt")then _bf,_bg=true,_bB elseif not _Z and _bv(_bB,"room")and _bv(_bB,"count")and _bv(_bB,"add")then _Z,_ba=true,_bB elseif not _bh and _bv(_bB,"result")and _bq(_bB,"SETS")~=nil then _bh,_bi=true,_bB elseif not _bm and _bv(_bB,"isDown")and _bq(_bB,"KEYS")~=nil then _bm,_bn=true,_bB elseif not _bk and _bv(_bB,"spawn")and not _bv(_bB,"play")then _bk,_bl=true,_bB elseif next(itemDB)==nil then
                                        local protoInfo=_bq(_bB,2)or _bq(_bB,1)if type(protoInfo)=="table"and type(_bq(protoInfo,"name"))=="string"and _bq(protoInfo,"hits")~=nil then itemDB=_bB genv.__ANCH_ItemDBCache=_bB
                                        end
                                end
                        end
                end end)()end
    local file_ANCHHub_GrowBlox="ANCHHub_GrowBlox.json"local file_ANCHHub_Rejoin="ANCHHub_Rejoin_"..tostring(localPlayer.UserId)..".json"local file_ANCHHub_Pabrik="ANCHHub_Pabrik_"..tostring(localPlayer.UserId)..".json"local file_ANCHHub_AutoMove="ANCHHub_AutoMove_"..tostring(localPlayer.UserId)..".json"session.ROTATION_STATE_FILE="ANCHHub_Rotation_"..tostring(localPlayer.UserId)..".json"local file_ANCHHub_GrowBlox="ANCHHub_GrowBlox.lua"local MAX_ITEM_ID=10000
    local WALK_SPEED_DEFAULT=0.3
    local WALK_SPEED_FAST=0.34
    local config={prefix="/",dropId=242,longhandRange=3,blinkMin=0.2,blinkMax=0.5,winDrop=0,pos1={},pos2={},fastPull=false,fastKick=false,fastBan=false,fastDrop=false,fastDropCount=0,fastRecycle=false,fastRecycleCount=0,autoRestore=true,autoReload=true,autoWarp=false,launcher=true,lastWorld="",scriptUrl="",session={},reconnectOn=false,reconnectWorld=true,reconnectServer=true,reconnectKeep=false,reconnectDelay=5,targetWorld="",walkSpeed=100,mutePunch=true,visualAnim=true,liteMode=false,customWatermark=true,watermarkText="GSZ HUB",selectedRole="none",calibX=0,calibY=0,collectMode="Legit",collectAround=false,collectRadius=3,vendMode="Isi stock dari drop",vendPoint="",vendDropX=-1,vendDropY=-1,vendItems={},farmMode="Place + Break",farmPlaceMs=250,farmDelay=0.22,farmAfterBreakMs=300,farmMultiTarget=1,farmHitsOverride=0,farmBreakBg=true,farmPlaceId=2,farmGrid={["1,0"]=true},farmTake=true,farmFastBreak=true,farmDynamicDelay=true,farmDynamicJitterMs=45,farmAutoRefill=false,farmRefillWorld="",farmAutoDropSeed=false,farmSeedDropAt=200,farmSeedKeep=0,farmDropWorld="",farmDropX=-1,farmDropY=-1,rotWorlds="",rotSeedId=3,rotLoop=true,rotBreakX=-1,rotBreakY=-1,rotDropExcess=false,rotKeepSeed=100,rotSaveWorld="",rotSaveX=-1,rotSaveY=-1,clearSweep="Zig-zag",clearIncludeBg=true,clearBreakDelay=0.16,clearTpDelay=0.22,clearTake=true,clearModFly=true,harvestDoHarvest=true,harvestDoPlant=false,harvestSeedId=3,harvestUseBlock=false,harvestScaffoldId=2,harvestDelay=0.22,harvestPlantDelay=0.25,harvestTpDelay=0.30,harvestTake=true,harvestModFly=false,harvestAutoSaveBlock=true,harvestSaveWorld="",harvestSaveX=-1,harvestSaveY=-1,harvestAutoTakeSeed=true,dfBreakDelay=0.15,dfTpDelay=0.28,dfTake=true,dfModFly=true,dfReplacePlatform=true,dfUsePlatform=false,dfPlatformId=102,fastRoulette=false,spliceA=3,spliceB=5,spliceRoam=true,spliceMs=300,pabrikSeedId=3,pabrikMaxSeed=100,pabrikWholeWorld=true,pabrikTiles={["1,0"]=true},pabrikBreakX=-1,pabrikBreakY=-1,pabrikBreakSec=120,pabrikDrop=true,pabrikDropWorld="",pabrikDropX=-1,pabrikDropY=-1,trashOn=false,trashList={},trashAt=150,trashKeep=0,convertLockOn=false,moveMode="legit",moveMethod="Legit Walking",navSpeed=1,moveStepDelay=0.28,clickTpShift=false,guardWho="Staff (Mod/Dev)",guardStopAll=true,guardLeave=false,guardAutoBack=true,guardBackSec=60,guardCalmSec=5,chatText="",chatInterval=6,bonusAutoQuest=false,bonusAutoRedeem=false,scanAuto=false,scanLayer="Semua",scanFilter="",moveWorld1="",moveWorld2="",moveDropX=-1,moveDropY=-1,moveItemId=2,webhookOn=false,webhookUrl="",webhookReportMin=0,whPenjaga=true,whStop=true,whFull=true,whBonus=true,whRejoin=true,whPabrik=true,}local function loadConfig()pcall(function()if isfile and readfile and isfile(file_ANCHHub_GrowBlox)then
                local cfgDecoded=svc_HttpSvc:JSONDecode(readfile(file_ANCHHub_GrowBlox))for k,v in pairs(cfgDecoded)do
                    if config[k_bO]~=nil and type(v_bP)==type(config[k_bO])then config[k_bO]=v_bP
                    end
            end
    end end)end
local configDirty=true
local function saveConfig()if configDirty then
        return
    end pcall(function()if writefile then writefile(file_ANCHHub_GrowBlox,svc_HttpSvc:JSONEncode(config))end end)end loadConfig()local getgcFn=getgc or(debug and debug.getgc)local getupvalue=(debug and debug.getupvalue)or getupvalue
local setupvalue=(debug and debug.setupvalue)or setupvalue
local getconstants=(debug and debug.getconstants)or getconstants
local function getUpvalues(_bX)if debug and debug.getupvalues then
        local upvalEntry,_bZ=pcall(debug.getupvalues,_bX)if upvalEntry and type(_bZ)=="table"then
            return _bZ
        end
end
local upvalTable={}if getupvalue then
    for _cb=1,255
    do
        local _cc,_cd=pcall(getupvalue,_bX,_cb)if not _cc then break
        end upvalTable[_cb]=_cd
end
end
return upvalTable
end
local function trim(_cf)return(tostring(_cf or""):gsub("^%s+",""):gsub("%s+$",""))end
local customNotifyFn=nil
local function notify(_ci,_cj,_ck,_cl)if configDirty and not _cl then
        return
    end
if customNotifyFn then
    local notifyOk=pcall(customNotifyFn,tostring(_ci),_cj,_ck)if notifyOk then
        return
    end
end pcall(function()svc_StarterGui:SetCore("SendNotification",{Title=_cj or "GSZ HUB | GrowBlox",Text=tostring(_ci),Duration=_ck or 4,})end)end
local modules={World=nil,Inv=nil,InvTable=nil,SetTile=nil,Punch=nil,State=nil,Menu=nil,Gems=nil,Hud=nil,Trees=nil,Others=nil,Rigs=nil,Particles={},}local tileCache={list=nil,update=nil,brokeAt={},seen={},nextTick=0}local hooks={fn=nil,idx=nil,set=nil,Particles=nil}local inputHooks={}local keyDownCallbacks={}local keyUpCallbacks={}local activeInputConn=nil
local currentChar=nil
local sessionStats={T0=os.clock(),Gems0=nil,Placed=0,Broken=0,Collected=0,Harvested=0,Planted=0,Items={},}local webhookSvc={Queue={},LastFull={},Status="-",}do(function()local function _cx()return(syn and syn.request)or(http and http.request)or http_request or request or(fluxus and fluxus.request)end
        function webhookSvc.Valid(_cy)_cy=tostring(_cy or"")for i,domain in ipairs({"discord.com","discordapp.com","ptb.discord.com","canary.discord.com"})do
                if string.sub(_cy,1,#_cA+22)=="https://".._cA.."/api/webhooks/"then
                    return true
                end
        end
    return false
end
function webhookSvc.Send(_cB,_cC)if not config.webhookOn or not webhookSvc.Valid(config.webhookUrl)then
        return
    end
local shouldSend=_cB=="test"or _cB=="report"or(_cB=="penjaga"and config.whPenjaga)or(_cB=="stop"and config.whStop)or(_cB=="full"and config.whFull)or(_cB=="bonus"and config.whBonus)or(_cB=="rejoin"and config.whRejoin)or(_cB=="pabrik"and config.whPabrik)if not shouldSend or#webhookSvc.Queue>=20 then
    return
end table.insert(webhookSvc.Queue,tostring(_cC))end task.spawn(function()while isAlive()do
local webhookMsg=table.remove(webhookSvc.Queue,1)if not webhookMsg then task.wait(0.5)else
    local httpFn=_cx()if not httpFn then webhookSvc.Status="Executor tidak mendukung request HTTP"else
        local httpPayload=svc_HttpSvc:JSONEncode({username="GSZ HUB | GrowBlox",content=string.format("**[%s]** %s",localPlayer.Name,webhookMsg),})local httpResp,_cI=pcall(httpFn,{Url=config.webhookUrl,Method="POST",Headers={["Content-Type"]="application/json"},Body=httpPayload,})local httpStatus=httpResp and type(_cI)=="table"and tonumber(_cI.StatusCode or _cI.Status)or nil
        if httpResp and(httpStatus==nil or httpStatus<300)then webhookSvc.Status="Terkirim "..os.date("%H:%M:%S")else webhookSvc.Status="Gagal kirim ("..tostring(httpStatus or _cI)..")"end
    end task.wait(2.5)end
end end)end)()end
local inputState={active=false,left=false,right=false,jump=false,down=false}local inputAxis={up=false,down=false}local _cM=_a.__ANCH_TrueOrigIsDown
local _cN,_cO do(function()local svc_VirtualInputManager=cloneref(game:GetService("VirtualInputManager"))local _cQ={left=false,right=false,jump=false}local function _cR(_cS,_cT,_cU)if _cQ[_cS]==_cU then
                return
            end _cQ[_cS]=_cU pcall(function()if svc_VirtualInputManager and svc_VirtualInputManager.SendKeyEvent then svc_VirtualInputManager:SendKeyEvent(_cU,_cT,false,game)end end)end _cN=function()if not inputState.active then _cR("left",Enum.KeyCode.A,false)_cR("right",Enum.KeyCode.D,false)_cR("jump",Enum.KeyCode.Space,false)return
        end _cR("left",Enum.KeyCode.A,inputState.left==true)_cR("right",Enum.KeyCode.D,inputState.right==true)_cR("jump",Enum.KeyCode.Space,inputState.jump==true)end _cO=function()inputState.left,inputState.right,inputState.jump,inputState.down=false,false,false,false _cR("left",Enum.KeyCode.A,false)_cR("right",Enum.KeyCode.D,false)_cR("jump",Enum.KeyCode.Space,false)end
local function _cV(_cW,_cX,...)if isAlive()then
        if inputState.active then
            if _cX=="keyLeft"then
                return inputState.left
            end
        if _cX=="keyRight"then
            return inputState.right
        end
    if _cX=="keyJump"then
        return inputState.jump
    end
if _cX=="keyDown"then
    return inputState.down
end
end
if inputAxis.up and _cX=="keyJump"then
    return true
end
if inputAxis.down and _cX=="keyDown"then
    return true
end
end
if _cM then
    return _cM(_cW,_cX,...)end
return false
end
local function _cY()if _bm and type(_bn)=="table"and type(rawget(_bn,"isDown"))=="function"then
        local _cZ=rawget(_bn,"isDown")if not _cM and not(isexecutorclosure and pcall(isexecutorclosure,_cZ)and isexecutorclosure(_cZ))then _cM=_cZ genv.__ANCH_TrueOrigIsDown=_cZ
        end rawset(_bn,"isDown",_cV)return
end
if getgcFn then task.spawn(function()for k_da,v_db in ipairs(getgcFn(true))do
            if type(v_db)=="table"then
                local _dc=rawget(v_db,"isDown")if type(_dc)=="function"then
                    if not _cM and not(isexecutorclosure and pcall(isexecutorclosure,_dc)and isexecutorclosure(_dc))then _cM=_dc genv.__ANCH_TrueOrigIsDown=_dc
                    end rawset(v_db,"isDown",_cV)end
        end
end end)end
end _cY()end)()end do(function()local function _dd(_de)if not getconstants or(islclosure and not islclosure(_de))then
        return false
    end
local _df,_dg=pcall(getconstants,_de)if not _df or type(_dg)~="table"then
    return false
end
local _dh,_di,_dj=false,false,false
for k_dk,v_dl in pairs(_dg)do
    if v_dl=="tile"or v_dl=="SetTile"then _dh=true elseif v_dl=="placedAt"then _di=true elseif v_dl=="flips"then _dj=true
            end
    end
return _dh and _di and _dj
end
local function _dm(_dn)if not getconstants or(islclosure and not islclosure(_dn))then
        return false
    end
local _do,_dp=pcall(getconstants,_dn)if not _do or type(_dp)~="table"then
            return false
        end
    local _dq,_dr=false,false
    for k_ds,v_dt in pairs(_dp)do
        if v_dt=="Empty the Vending Machine first!"then _dq=true elseif v_dt=="newCrack"or v_dt=="HarvestProvider"then _dr=true
            end
    end
return _dq and _dr
end
local function _du(_dv)local _dw=rawget(_dv,"state")if type(_dw)~="function"then
        return false
    end
local _dx,_dy=pcall(_dw)return _dx and type(_dy)=="table"and type(_dy.x)=="number"and type(_dy.y)=="number"and _dy.facing~=nil and _dy.vx~=nil
end
local function _dz(_dA)if _dA==_dd or _dA==_dm then
        return false
    end
if isexecutorclosure then
    local _dB,_dC=pcall(isexecutorclosure,_dA)if _dB and _dC then
        return false
    end
end
return true
end
local function _dD(_dE)if type(_dE)~="table"or _dE==modules.World then
        return false
    end
local _dF=rawget(_dE,1)if _dF==nil then
    return next(_dE)==nil
end
return type(_dF)=="table"and rawget(_dF,"uid")~=nil and rawget(_dF,"frame")~=nil
end
function hooks.isArmFn(_dG)if not getconstants or(islclosure and not islclosure(_dG))then
        return false
    end
local _dH,_dI=pcall(getconstants,_dG)if not _dH or type(_dI)~="table"then
    return false
end
local _dJ,_dK,_dL=false,false,false
for _dM,_dN in pairs(_dI)do
    if v_dN=="forearm"then _dJ=true elseif v_dN=="heldReach"then _dK=true elseif v_dN=="punchReach"then _dL=true
            end
    end
return _dJ and _dK and _dL
end
function hooks.bind(_dO)if not(getupvalue and setupvalue)then
        return false
    end
local _dP,_dQ={},0
for _dR=1,16
do
    local _dS,_dT=pcall(getupvalue,_dO,_dR)if not _dS then break
    end _dP[_dR]=_dT
if _dT~=nil then _dQ=_dR
end
end
for _dU=1,_dQ-1
do
    local _dV=_dP[_dU]if _dV==nil or(type(_dV)=="table"and rawget(_dV,"t")~=nil and rawget(_dV,"facing")~=nil)then hooks.fn,hooks.idx,hooks.set=_dO,_dU,setupvalue
        return true
    end
end
return false
end
local function _dW()if not getconnections then
        return
    end
local _dX,_dY,_dZ={},{},0
for k_ea,v_eb in ipairs({"RenderStepped","Heartbeat","Stepped"})do
    local _ec,_ed=pcall(function()return svc_RunSvc[v_eb]end)if _ec and _ed then
        local _ee,_ef=pcall(getconnections,_ed)if _ee and type(_ef)=="table"then
            for k_eg,v_eh in ipairs(_ef)do
                local _ei,_ej=pcall(function()return v_eh.Function end)if _ei and type(_ej)=="function"then table.insert(_dX,_ej)end
            end
    end
end
end
local _ek=1
while _ek<=#_dX and _dZ<450
do
    local _el=_dX[_ek]_ek=_ek+1
    if not _dY[_el]then _dY[_el]=true _dZ=_dZ+1
        if not hooks.fn and hooks.isArmFn(_el)then hooks.bind(_el)end
        for k_em,v_en in pairs(getUpvalues(_el))do
            local _eo=type(v_en)if _eo=="table"then
                if not modules.World then
                    local _ep,_eq=pcall(function()return type(rawget(v_en,"fg"))=="table"and type(rawget(v_en,"bg"))=="table"and type(rawget(v_en,"w"))=="number"and rawget(v_en,"w")>0 and rawget(v_en,"spawn")~=nil end)if _ep and _eq then modules.World=v_en
                    end
            end
        if not modules.Inv and _Z and _ba then
            local _er,_es=pcall(function()return getmetatable(v_en)==_ba and type(rawget(v_en,"slots"))=="table"end)if _er and _es then modules.Inv=v_en
            end
    end
if not modules.State then
    local _et,_eu=pcall(_du,v_en)if _et and _eu then modules.State=rawget(v_en,"state")end
end elseif _eo=="function"and not _dY[v_en]then
if not hooks.fn and hooks.isArmFn(v_en)then hooks.bind(v_en)end table.insert(_dX,v_en)end
end
end
end
end
local function _ev()local _ew=modules.World
    if not _ew then
        return false
    end
for k_ex,v_ey in ipairs({"tileChanged","treeChanged","setTree"})do
    local _ez=rawget(_ew,v_ey)if type(_ez)=="function"then
        local _eA=getUpvalues(_ez)local _eB={}for k_eC,v_eD in pairs(_eA)do
            if type(v_eD)=="table"and v_eD~=_ew then _eB[v_eD]=true
            end
    end
for k_eE,v_eF in pairs(_eA)do
    if type(v_eF)=="function"then
        local _eG=getUpvalues(v_eF)local _eH,_eI,_eJ=false,0,{}for k_eK,v_eL in pairs(_eG)do
            if rawequal(v_eL,_ew)then _eH=true elseif type(v_eL)=="table"then _eI=_eI+1
                    if _eB[v_eL]then table.insert(_eJ,v_eL)end
                end
        end
    if _eH and _eI<=3 and#_eJ==1 then modules.Trees=_eJ[1]return true
    end
end
end
end
end
return false
end
local _eM=0
function modules.Scan(_eN)local _eO=os.clock()if not _eN and(_eO-_eM)<2.5 and modules.World then
        return true
    end _eM=_eO getItemDB()modules.World,modules.Inv,modules.InvTable,modules.SetTile,modules.Punch,modules.State,modules.Menu,modules.Gems,modules.Hud,modules.Others=nil,nil,nil,nil,nil,nil,nil,nil,nil,nil modules.Particles={}_dW()if getgcFn then
    for k_eP,v_eQ in ipairs(getgcFn(true))do
        if k_eP%3000==0 then task.wait()end
        local _eR=type(v_eQ)if _eR=="table"then
            if next(itemDB)==nil or type(itemDB[2])~="table"then
                local _eU,_eV=pcall(function()local _eS=rawget(v_eQ,2)local _eT=rawget(v_eQ,242)return type(_eS)=="table"and type(_eT)=="table"and(type(rawget(_eS,"name"))=="string"or type(rawget(_eS,"hits"))=="number")end)if _eU and _eV then itemDB=v_eQ
                end
        end
    if not modules.World then
        local _eW,_eX=pcall(function()return type(rawget(v_eQ,"fg"))=="table"and type(rawget(v_eQ,"bg"))=="table"and type(rawget(v_eQ,"w"))=="number"and type(rawget(v_eQ,"h"))=="number"and rawget(_eQ,"spawn")~=nil end)if _eW and _eX then modules.World=v_eQ
        end
end
if not modules.InvTable then
    local _eY,_eZ=pcall(function()return type(rawget(v_eQ,"onDrop"))=="function"and type(rawget(v_eQ,"canDrop"))=="function"and type(rawget(v_eQ,"isWorn"))=="function"end)if _eY and _eZ then modules.InvTable=_eQ modules.Hud=modules.Hud or v_eQ
    end
end
if not modules.Inv and _Z and _ba then
    local _fa,_fb=pcall(function()return getmetatable(v_eQ)==_ba and type(rawget(v_eQ,"slots"))=="table"end)if _fa and _fb then modules.Inv=v_eQ
    end
end
if not modules.State then
    local _fc,_fd=pcall(_du,_eQ)if _fc and _fd then modules.State=rawget(_eQ,"state")end
end
if not modules.Menu then
    local _fe,_ff=pcall(function()return type(rawget(v_eQ,"openBackpack"))=="function"and type(rawget(_eQ,"ui"))=="table"end)if _fe and _ff then modules.Menu=v_eQ
    end
end
if not modules.Gems then
    local _fg,_fh=pcall(function()return type(rawget(_eQ,"addGems"))=="function"end)if _fg and _fh then modules.Gems=_eQ
    end
end
if not modules.Hud then
    local _fi,_fj=pcall(function()return type(rawget(v_eQ,"punchRange"))=="function"and type(rawget(_eQ,"buildRange"))=="function"end)if _fi and _fj then modules.Hud=v_eQ
    end
end
if not modules.Others then
    local _fk,_fl=pcall(function()return type(rawget(v_eQ,"list"))=="function"and type(rawget(v_eQ,"where"))=="function"and type(rawget(v_eQ,"playerAt"))=="function"end)if _fk and _fl then modules.Others=v_eQ
    end
end
if not modules.Rigs then
    local _fo,_fp=pcall(function()local _fm,_fn=rawget(v_eQ,1),rawget(v_eQ,-1)return type(_fm)=="table"and type(_fn)=="table"and typeof(rawget(_fm,"body"))=="Instance"and typeof(rawget(_fn,"head"))=="Instance"end)if _fo and _fp then modules.Rigs=v_eQ
    end
end
if _bk and _bl then
    local _fq,_fr=pcall(function()return getmetatable(v_eQ)==_bl and type(rawget(v_eQ,"live"))=="table"end)if _fq and _fr then table.insert(modules.Particles,v_eQ)end
end elseif _eR=="function"and _dz(v_eQ)then
if not modules.SetTile and _dd(v_eQ)then modules.SetTile=v_eQ elseif not modules.Punch and _dm(v_eQ)then modules.Punch=v_eQ
    end
end
end
end
if modules.World and(not modules.SetTile or not modules.Punch)and debug and debug.info then
    for k_fs,v_ft in ipairs(getgcFn(true))do
        if k_fs%3000==0 then task.wait()end
        if type(v_ft)=="function"then
            local _fu,_fv=pcall(debug.info,v_ft,"n")if _fu and(_fv=="setTile"or _fv=="hit")then
                for k_fw,v_fx in pairs(getUpvalues(v_ft))do
                    if v_fx==modules.World then
                        if _fv=="setTile"and not modules.SetTile then modules.SetTile=v_ft
                        end
                    if _fv=="hit"and not modules.Punch then modules.Punch=v_ft
                    end
            end
    end
end
end
end
end
if not modules.Inv and modules.World and type(rawget(modules.World,"backpackNow"))=="function"then
    for k_fy,v_fz in pairs(getUpvalues(modules.World.backpackNow))do
        if type(v_fz)=="table"and type(v_fz.slots)=="table"then modules.Inv=v_fz break
        end
end
end
if activeInputConn then pcall(function()activeInputConn:Disconnect()end);activeInputConn=nil
end
if modules.Inv and typeof(modules.Inv.changed)=="Instance"then activeInputConn=trackConn(modules.Inv.changed.Event:Connect(function()if isAlive()and currentChar then pcall(currentChar)end end))end
function tileCache.findUpdate()local _fA,_fB=modules.World,tileCache.list
    local _fC=_fA and rawget(_fA,"dropTaken")if type(_fC)~="function"or not _fB then
        return false
    end
for k_fD,v_fE in pairs(getUpvalues(_fC))do
    if type(v_fE)=="function"then
        for k_fF,_fG in pairs(getUpvalues(v_fE))do
            if rawequal(v_fG,_fB)then tileCache.update=v_fE
                return true
            end
    end
end
end
return false
end
function tileCache.findRefs()local _fH=modules.World
    local _fI=_fH and rawget(_fH,"dropList")if type(_fI)=="function"then
        local _fJ,_fK=pcall(_fI)if _fJ and _dD(_fK)then
            if tileCache.list~=_fK then tileCache.update=nil
            end tileCache.list=_fK
        if not tileCache.update then tileCache.findUpdate()end
        return true
    end
end tileCache.list,tileCache.update=nil,nil
local _fL=_fH and rawget(_fH,"dropTaken")if type(_fL)=="function"then
    for k_fM,v_fN in pairs(getUpvalues(_fL))do
        if not tileCache.list and _dD(v_fN)then tileCache.list=v_fN elseif not tileCache.update and type(v_fN)=="function"then tileCache.update=v_fN
            end
    end
if tileCache.list and not tileCache.update then tileCache.findUpdate()end
end
local remote_DropTaken=obj_WorldRemotes and obj_WorldRemotes:FindFirstChild("DropTaken")if not tileCache.list and remote_DropTaken and getconnections then
    local _fP,_fQ=pcall(getconnections,remote_DropTaken.OnClientEvent)if _fP and type(_fQ)=="table"then
        for k_fR,v_fS in ipairs(_fQ)do
            local _fT,_fU=pcall(function()return v_fS.Function end)if _fT and type(_fU)=="function"then
                for k_fV,v_fW in pairs(getUpvalues(_fU))do
                    if not tileCache.list and _dD(v_fW)then tileCache.list=v_fW elseif not tileCache.update and type(_fW)=="function"then tileCache.update=v_fW
                        end
                end
        end
    if tileCache.list then break
    end
end
end
end
return tileCache.list~=nil
end tileCache.findRefs()modules.Trees=nil
if not modules.Trees then _ev()end
if modules.World and type(rawget(modules.World,"treeLook"))=="function"and getupvalue then
    local _fX,_fY=pcall(getupvalue,modules.World.treeLook,8)if _fX and type(_fY)=="table"then modules.Trees=_fY
    end
end
local obj_TreeChanged=obj_WorldRemotes and _J:FindFirstChild("TreeChanged")if not modules.Trees and obj_TreeChanged and getconnections then
    local _ga,_gb=pcall(getconnections,obj_TreeChanged.OnClientEvent)if _ga and type(_gb)=="table"then
        for k_gc,v_gd in ipairs(_gb)do
            local _ge,_gf=pcall(function()return v_gd.Function end)if _ge and type(_gf)=="function"then
                for k_gg,v_gh in pairs(getUpvalues(_gf))do
                    if type(v_gh)=="table"and v_gh~=modules.World and rawget(v_gh,"fg")==nil then
                        local _gi,_gj=next(v_gh)if _gj==nil or(type(_gj)=="table"and type(rawget(_gj,"p"))=="number")then modules.Trees=v_gh break
                        end
                end
        end
end
if modules.Trees then break
end
end
end
end
return modules.World~=nil
end end)()end
local function getWorldMod()if modules.World and type(rawget(modules.World,"fg"))=="table"then
        return modules.World
    end modules.Scan()return modules.World
end
local function _gl()if modules.InvTable then
        return modules.InvTable
    end modules.Scan()return modules.InvTable
end
local function _gm()if modules.Rigs then
        return modules.Rigs
    end modules.Scan()return modules.Rigs
end
local function _gn(_go)if not _go then
        return nil
    end
if next(itemDB)==nil then getItemDB()end
local _gp=tonumber(_go)local _gq=(_gp and(rawget(itemDB,_gp)or _P[_gp]))or rawget(itemDB,tostring(_go))or itemDB[tostring(_go)]if type(_gq)=="table"then
    return _gq
end
if type(itemDB.get)=="function"then
    local _gr,_gs=pcall(itemDB.get,_gp or _go)if _gr and type(_gs)=="table"then
        return _gs
    end
end
return nil
end
local function _gt(_gu)local _gv=_gn(_gu)if type(_gv)=="table"then
        local _gw=rawget(_gv,"name")or _gv.name or rawget(_gv,"title")or rawget(_gv,"itemName")or rawget(_gv,1)if type(_gw)=="string"and _gw~=""then
            return _gw
        end
end
return "Item #"..tostring(_gu)end
local function getWorldPos(_gy)if not _gy then
        return 0
    end
if not modules.Inv then modules.Scan()end
local _gz=modules.Inv
if not _gz then
    return 0
end
if type(_gz.count)=="function"then
    local _gA,_gB=pcall(function()return _gz:count(_gy)end)if _gA and type(_gB)=="number"then
        return _gB
    end
end
local _gC=0
if type(_gz.slots)=="table"then
    for k_gD,v_gE in pairs(_gz.slots)do
        if type(v_gE)=="table"and v_gE.id==_gy then _gC=_gC+((v_gE.n or 0))end
    end
end
return _gC
end
local function _gF(_gG)_gG=tonumber(_gG)if not _gG then
        return nil
    end
local _gH=_gn(_gG)if _gH and(_gH.kind=="seed"or type(_gH.tree)=="table"or type(_gH.grow)=="number")then
    return _gG
end
local _gI=(_gH and tonumber(_gH.seedId))or(_gG+1)local _gJ=_gn(_gI)if _gJ and(_gJ.kind=="seed"or type(_gJ.tree)=="table"or type(_gJ.grow)=="number")then
    return _gI
end
return _gG+1
end
local function _gK(_gL)_gL=tonumber(_gL)if not _gL then
        return nil
    end
local _gM=_gn(_gL)if _gM and _gM.kind~="seed"and type(_gM.tree)~="table"and type(_gM.grow)~="number"then
    return _gL
end
local _gN=(_gM and tonumber(_gM.blockId))or(_gL-1)local _gO=_gn(_gN)if _gO and _gO.kind~="seed"then
    return _gN
end
return _gL-1
end
local _gP=nil
local function _gQ()if _gP then
        return _gP
    end
if itemDB[2]and type(itemDB[2].name)=="string"and itemDB[2].name:lower()=="dirt"then _gP=2
    return 2
end
for k_gR,v_gS in pairs(itemDB)do
    if type(k_gR)=="number"and type(v_gS)=="table"and type(v_gS.name)=="string"and v_gS.name:lower()=="dirt"then _gP=k_gR
        return k_gR
    end
end
return 2
end
local _gT=nil
local function _gU()if _gT then
        return _gT
    end
local _gV=_gF(_gQ())if _gV then _gT=_gV
    return _gV
end
return 3
end
local function _gW()local obj_GameGui=_H:FindFirstChild("GameGui")local obj_World=obj_GameGui and obj_GameGui:FindFirstChild("World")local obj_Camera=obj_World and obj_World:FindFirstChild("Camera")local obj_Tiles=obj_Camera and obj_Camera:FindFirstChild("Tiles")local obj_PlayerView=obj_Camera and obj_Camera:FindFirstChild("PlayerView")if not(obj_Tiles and obj_PlayerView and obj_Tiles:IsA("GuiObject")and obj_PlayerView:IsA("GuiObject"))then
        return nil
    end
local _hc=obj_Tiles:FindFirstChildWhichIsA("ImageLabel")local _hd=(_hc and _hc.AbsoluteSize.X>0)and _hc.AbsoluteSize.X or 64
local _he=obj_PlayerView.AbsolutePosition+(obj_PlayerView.AbsoluteSize/2)local _hf=_he-obj_Tiles.AbsolutePosition return{x=_hf.X/_hd,y=(_hf.Y/_hd)+0.475,vx=0,vy=0,facing=1,grounded=true,dead=false,active=true,}end
local function _hg()if not modules.State then modules.Scan()end
    if modules.State then
        local _hh,_hi=pcall(modules.State)if _hh and type(_hi)=="table"and type(_hi.x)=="number"and type(_hi.y)=="number"and _hi.active~=false then
            return _hi
        end
end
return _gW()end
local function _hj()local _hk=_hg()if _hk then
        return _hk.x+config.calibX,_hk.y+config.calibY,(_hk.facing and _hk.facing<0)and-1 or 1
    end
return nil,"Karakter belum berada di world"end
function hooks.Swing(_hl,_hm,_hn)if not config.visualAnim or not(hooks.fn and hooks.idx and hooks.set)then
        return
    end
local _ho=_hg()local _hp=(_ho and _hl+0.5<_ho.x)and-1 or 1 pcall(hooks.set,hooks.fn,hooks.idx,{t=os.clock(),x=_hl+0.5,y=_hm+0.5,facing=_hp,kind=_hn})end
function hooks.Place(_hq,_hr,_hs)if not config.visualAnim then
        return
    end hooks.Swing(_hq,_hr,"build")local _ht=itemDB[_hs]if _ht and _ht.kind~="seed"and modules.Particles and#modules.Particles>0 then
    local _hu=hooks.Particles or modules.Particles[1]hooks.Particles=_hu pcall(function()_hu:place(_hq+0.5,_hr+0.5)end)end
end
local function _hv()local _hw,_hx=_hj()if not _hw then
        return nil
    end
return math.floor(_hw),math.floor(_hx-0.475)end
local function _hy()local _hz=getWorldMod()local _hA=_hz and rawget(_hz,"name")return type(_hA)=="string"and _hA or""end
local function placeTile(_hC,_hD,_hE,_hF)local _hG=_hC or getWorldMod()if not _hG or _hE<0 or _hF<0 or _hE>=_hG.w or _hF>=_hG.h then
        return nil
    end
local _hH=rawget(_hG,_hD)local _hI=_hH and _hH[_hF]return _hI and(_hI[_hE]or 0)or nil
end
local function _hJ(_hK,_hL,_hM)local _hN=_hK or getWorldMod()return _hN and type(_hN.w)=="number"and _hL>=0 and _hM>=0 and _hL<_hN.w and _hM<_hN.h
end
local function _hO(_hP)local _hQ=itemDB and itemDB[_hP]return(type(_hQ)=="table"and _hQ.background)and "bg"or "fg"end
local function _hR()local _hS=modules.Hud or _gl()if _hS and type(_hS.punchRange)=="function"then
        local _hT,_hU=pcall(_hS.punchRange)if _hT and type(_hU)=="number"and _hU>0 then
            return _hU
        end
end
return 2.5
end
local function _hV()local _hW=modules.Hud or _gl()if _hW and type(_hW.buildRange)=="function"then
        local _hX,_hY=pcall(_hW.buildRange)if _hX and type(_hY)=="number"and _hY>0 then
            return _hY
        end
end
return 2.5
end
local function _hZ(_ia,_ib,_ic,_id,_ie)if _id~=0 and hooks.Place then hooks.Place(_ib,_ic,_id)end
    if not modules.SetTile then modules.Scan()end
    if modules.SetTile then
        local _if=pcall(modules.SetTile,_ia,_ib,_ic,_id,false,_ie==true)if _if then keyDownCallbacks[_ib..",".._ic]=os.clock()return true
        end
end
if _bb and type(_bc)=="table"and type(_bc.tile)=="table"then
    local _ig=pcall(_bc.tile.send,{layer=(_ia=="bg")and 2 or 1,x=_ib,y=_ic,id=_id,flip=_ie==true,})if _ig then
        local _ih=getWorldMod()if _ih and _ih[_ia]and _ih[_ia][_ic]then _ih[_ia][_ic][_ib]=_id
        end keyDownCallbacks[_ib..",".._ic]=os.clock()return true
end elseif remote_SetTile then pcall(function()remote_SetTile:FireServer(_ia,_ib,_ic,_id,_ie==true)end)local _ii=getWorldMod()if _ii and _ii[_ia]and _ii[_ia][_ic]then _ii[_ia][_ic][_ib]=_id
end keyDownCallbacks[_ib..",".._ic]=os.clock()return true
end
return false
end
local function _ij(_ik,_il,_im)if not _ik or _ik<=0 then
        return false
    end
if getWorldPos(_ik)<=0 then
    return false
end
local _in=_hO(_ik)local _io=_hZ(_in,_il.x,_il.y,_ik,(_im or 1)<0)if not _io then
    return false
end
if modules.Inv and type(modules.Inv.remove)=="function"then pcall(function()modules.Inv:remove(_ik,1)end)end sessionStats.Placed=sessionStats.Placed+(1)return true
end
local function _ip(_iq,_ir)local _is=_iq..",".._ir
    local _it=keyDownCallbacks[_is]if _it then
        local _iu=os.clock()-_it
        if _iu<WALK_SPEED_FAST then task.wait(WALK_SPEED_FAST-_iu)end keyDownCallbacks[_is]=nil
    end
end
local _iv={[6]=true,[8]=true,[202]=true,[204]=true,[206]=true,[242]=true,[1796]=true,[4994]=true,[5814]=true,[7188]=true,}local function _iw(_ix,_iy,_iz)if not _ix or _ix==0 or _iv[_ix]then
        return false
    end
local _iA=getWorldMod()if _iA and _iy and _iz then
    if typeof(_iA.spawn)=="Vector2"and _iy==math.floor(_iA.spawn.X)and _iz==math.floor(_iA.spawn.Y)then
        return false
    end
if type(_iA.lock)=="table"and _iA.lock.x==_iy and _iA.lock.y==_iz then
    return false
end
end
local _iB=_gn(_ix)if not _iB then
    if _iA and _iz and _iz>=_iA.h-6 then
        return false
    end
return true
end
if _iB.lock or _iB.area or _iB.guildLock or _iB.vend or _iB.display or _iB.bedrock or _iB.unbreakable or _iB.door or _iB.entrance then
    return false
end
local _iC=tostring(rawget(_iB,"name")or _iB.name or""):lower()if _iC:find("bedrock",1,true)or _iC:find("lock",1,true)or _iC:find("main door",1,true)or _iC:find("white door",1,true)or _iC:find("vending",1,true)then
    return false
end
local _iD=(_iB.kind=="seed")and 20 or _iB.hits
if type(_iD)=="number"then
    return _iD>0
end
if _iB.staffHits then
    return false
end
return true
end
local function _iE(_iF,_iG,_iH)if _iH==nil then _iH=true
    end
local _iI=getWorldMod()if not _iI then
    return nil
end
local _iJ=placeTile(_iI,"fg",_iF,_iG)if _iJ==nil then
    return nil
end
local _iK=placeTile(_iI,"bg",_iF,_iG)local _iL,_iM
if _iJ~=0 then _iL,_iM="fg",_iJ elseif _iH and _iK and _iK~=0 then _iL,_iM="bg",_iK
    end
if not _iL or not _iw(_iM,_iF,_iG)then
    return nil
end _ip(_iF,_iG)if not modules.Punch then modules.Scan()end
if modules.Punch then
    local _iN=pcall(modules.Punch,_iF,_iG,config.mutePunch or nil,nil)if not _iN then
        return nil
    end hooks.Swing(_iF,_iG,"punch")if placeTile(_iI,_iL,_iF,_iG)~=_iM then sessionStats.Broken=sessionStats.Broken+(1)tileCache.brokeAt[_iF..",".._iG]=os.clock()return "broke",_iM,_iL
end
return "hit",_iM,_iL
end
return nil
end
local _iO=false
local _iP={}local _iQ=nil
local function _iR()if _iO then
        return true
    end
for k_iS,v_iT in pairs(_iP)do
    if v_iT then
        return true
    end
end
return false
end
local function _iU()local _iV=getWorldMod()if not _iV then
        return
    end
if _iR()then _iV.ghost=true else inputAxis.up,inputAxis.down=false,false _iV.ghost=(localPlayer:GetAttribute("Ghost")==true)end
if _iQ then _iQ.Enabled=_iO
end
end
local function _iW(_iX,_iY)_iP[_iX]=_iY and true or nil _iU()end
local function _iZ()_iO=true _iU()return true
end
local function _ja()_iO=false _iU()return true
end trackConn(svc_RunSvc.Heartbeat:Connect(function()if not isAlive()then
    return
end
local _jb=modules.World
if not _jb then
    return
end
if tileCache.collecting then _jb.speedScale=1 elseif config.walkSpeed~=100 then _jb.speedScale=config.walkSpeed/100
    end
if _iR()and _jb.ghost~=true then _jb.ghost=true
end end))local modClick={clickOn=false,token=0,conn=nil,last="-",BadEdge={},PlacedScaffolds=0,}do(function()local _jd,_je=math.floor,math.abs
local function _jf(_jg,_jh)local _ji=getWorldMod()local _jj=_ji and _ji.fg and _ji.fg[_jh]return(_jj and _jj[_jg])or 0
end
local function _jk(_jl,_jm)local _jn=_jf(_jl,_jm)if _jn~=0 then
        return itemDB[_jn]end
    return nil
end
local function _jo(_jp,_jq)local _jr=getWorldMod()if not _jr then
        return true
    end
if _jp<0 or _jp>=_jr.w or _jq>=_jr.h then
    return true
end
if _jq<0 then
    return false
end
local _js=_jk(_jp,_jq)if not _js then
    return false
end
if _js.combiner then
    local _jt,_ju=pcall(_jr.combinerShut,_jp,_jq)return(not _jt)or(_ju and true or false)end
if _js.vip then
    local _jv,_jw=pcall(_jr.vipMay,_jp,_jq)return not(_jv and _jw)end
if _js.entrance then
    local _jx=_jr.switches and _jr.switches[_jq*_jr.w+_jp]if _js.gate then
        return not(_jx and _jx.off==true)end
    if _jx and _jx.public then
        return false
    end
local _jy,_jz=pcall(function()return _jr.areas.mayBuild(_jr.lock,_jp,_jq)end)return not(_jy and _jz)end
return _js.solid and true or false
end
local function _jA(_jB,_jC)local _jD=_jf(_jB,_jC)if _jD==0 then
        return false
    end
if _jD==4 or _jD==410 then
    return true
end
local _jE=itemDB[_jD]if not _jE then
    return false
end
if _jE.deadly or _jE.hurts or _jE.laser or _jE.bounce or _jE.bouncer then
    return true
end
local _jF=tostring(rawget(_jE,"name")or _jE.name or""):lower()if _jF:find("lava",1,true)or _jF:find("spike",1,true)or _jF:find("magma",1,true)or _jF:find("acid",1,true)or _jF:find("fire",1,true)or _jF:find("pinball",1,true)or _jF:find("trampoline",1,true)then
    return true
end
return false
end
local function _jG(_jH,_jI)local _jJ=_jk(_jH,_jI)return _jJ~=nil and _jJ.platform and true or false
end
local function _jK(_jL,_jM)return not _jo(_jL,_jM)and not _jA(_jL,_jM)end
local function _jN(_jO,_jP)return not _jA(_jO,_jP+1)and(_jo(_jO,_jP+1)or _jG(_jO,_jP+1))end modClick.HazardAt=_jA
local function _jQ(_jR,_jS,_jT,_jU)return _je(_jS+0.5-_jR.x)<=_jU and _je(_jT+0.5-(_jR.y-0.475))<=_jU
end
local function _jV(_jW,_jX)local _jY=getWorldMod()if not _jY or _jW<0 or _jX<0 or _jW>=_jY.w or _jX>=_jY.h then
        return false
    end
if _jf(_jW,_jX)~=0 then
    return false
end
local _jZ,_ka=pcall(function()if _jY.areas and type(_jY.areas.canEdit)=="function"and not _jY.areas.canEdit(_jW,_jX)then
        return false
    end
if type(_jY.builderOk)=="function"and not _jY.builderOk(_jW,_jX,true)then
    return false
end
return true end)return(not _jZ)or _ka
end
local function _kb()local _kc={config.harvestScaffoldId,_gQ(),config.farmPlaceId,}for k_kd,v_ke in ipairs(_kc)do
        if type(v_ke)=="number"and v_ke>0 and getWorldPos(v_ke)>0 then
            local _kf=itemDB[v_ke]if _kf and _kf.solid and _kf.kind~="seed"then
                return v_ke
            end
    end
end
if modules.Inv and type(modules.Inv.slots)=="table"then
    for k_kg,v_kh in ipairs(modules.Inv.slots)do
        local _ki=v_kh.id and itemDB[v_kh.id]if _ki and _ki.solid and _ki.kind~="seed"and not _ki.lock and(v_kh.n or 0)>0 then
            return v_kh.id
        end
end
end
return _gQ()end
local function _kj(_kk,_kl)local _km=_kb()if not _km or getWorldPos(_km)<=0 or not _jV(_kk,_kl)then
        return false
    end
local _kn=_hg()if _kn and not _jQ(_kn,_kk,_kl,_hV()+0.5)then
    return false
end
if _ij(_km,{x=_kk,y=_kl},1)then modClick.PlacedScaffolds=modClick.PlacedScaffolds+(1)return true
end
return false
end modClick.SolidAt=_jo modClick.OpenAt=_jK modClick.RealSupport=_jN modClick.PlaceScaffold=_kj modClick.StateReaches=_jQ modClick.PlaceOk=_jV
function modClick.Los(_ko,_kp,_kq,_kr)if _kr-_kp>=2 then
        for _ks=_kp+1,_kr-1
        do
            if _jo(_kq,_ks)then
                return false
            end
    end elseif _kp-_kr>=2 then
    for _kt=_kr+1,_kp-1
    do
        if _jo(_kq,_kt)then
            return false
        end
end
end
return true
end
function modClick.AirCheck(_ku)if not _ku or _ku.grounded then modClick.AirAt=nil
        return
    end
if not modClick.AirAt then modClick.AirAt=os.clock()elseif os.clock()-modClick.AirAt>3 then modClick.AirAt=nil
        local _kv=(_ku.facing or 1)<0 inputState.active=true inputState.right,inputState.left=_kv,not _kv task.wait(0.2)inputState.right,inputState.left=false,false
    end
end
local function _kw(_kx,_ky,_kz,_kA,_kB)_kz=_kz+(1)local _kC=_kz
    while _kC>1
    do
        local _kD=math.floor(_kC/2)if _kx[_kD]<=_kA then break
        end _kx[_kC],_ky[_kC]=_kx[_kD],_ky[_kD]_kC=_kD
end _kx[_kC],_ky[_kC]=_kA,_kB
return _kz
end
local function _kE(_kF,_kG,_kH)local _kI=_kG[1]local _kJ,_kK=_kF[_kH],_kG[_kH]_kF[_kH],_kG[_kH]=nil,nil _kH=_kH-(1)if _kH>0 then
        local _kL=1
        while true
        do
            local _kM=_kL*2
            if _kM>_kH then break
            end
        if _kM<_kH and _kF[_kM+1]<_kF[_kM]then _kM=_kM+(1)end
        if _kJ<=_kF[_kM]then break
        end _kF[_kL],_kG[_kL]=_kF[_kM],_kG[_kM]_kL=_kM
end _kF[_kL],_kG[_kL]=_kJ,_kK
end
return _kI,_kH
end
function modClick.AStar(_kN,_kO,_kP,_kQ,_kR,_kS,_kT,_kU)local _kV=getWorldMod()if not _kV then
        return nil,false,{}end
    local _kW,_kX=_kV.w,_kV.h
    local _kY=_kW*_kX _kS=_kS or 0.4
    local _kZ=_jd(_kS)local _la=math.ceil(-_kS+0.025)local _lb=_jd(_kS+0.025)local _lc,_ld,_le={},{},{}local function _lf(_lg,_lh)if _lg<0 or _lg>=_kW or _lh>=_kX then
            return false
        end
    if _lh<0 then
        return true
    end
local _li=_lh*_kW+_lg
local _lj=_lc[_li]if _lj==nil then _lj=_jK(_lg,_lh);_lc[_li]=_lj
end
return _lj
end
local function _lk(_ll,_lm)if _ll<0 or _ll>=_kW or _lm<0 or _lm>=_kX then
        return false
    end
local _ln=_lm*_kW+_ll
local _lo=_ld[_ln]if _lo==nil then _lo=_jN(_ll,_lm);_ld[_ln]=_lo
end
return _lo
end
local function _lp(_lq,_lr)if not _kT or _lq<0 or _lq>=_kW or _lr<0 or _lr>=_kX then
        return false
    end
local _ls=_lr*_kW+_lq
local _lt=_le[_ls]if _lt==nil then _lt=_jV(_lq,_lr);_le[_ls]=_lt
end
return _lt
end
local function _lu(_lv,_lw)local _lx=_je(_kQ-_lv)-_kS
    local _ly=_kR-_lw
    local _lz=_je(_ly)-_kS
    local _lA=(_ly<0)and 1.5 or 0.5 return(_lx>0 and _lx or 0)+_lA*(_lz>0 and _lz or 0)end
local function _lB(_lC,_lD)if _kP[_lD*_kW+_lC]then
        return true
    end
if _kS>=1 then
    for _lE=_lD+_la,_lD+_lb
    do
        if _lE>=0 and _lE<_kX then
            local _lF=_lE*_kW
            for _lG=_lC-_kZ,_lC+_kZ
            do
                if _lG>=0 and _lG<_kW and _kP[_lF+_lG]and not(_lG==_lC and _lE==_lD+1)then
                    return true
                end
        end
end
end
end
return false
end
local _lH,_lI,_lJ,_lK,_lL={},{},{},{},{}local _lM=0
local function _lN(_lO,_lP,_lQ,_lR,_lS)_lM=_lM+(1)_lH[_lM],_lI[_lM],_lJ[_lM],_lK[_lM],_lL[_lM]=_lO,_lP,_lQ,_lR,_lS
end
local function _lT(_lU,_lV)_lM=0
    for _lW=-1,1,2
    do
        local _lX=_lU+_lW
        if _lf(_lX,_lV)then
            if _lk(_lX,_lV)then _lN(_lX,_lV,"walk",1,false)else
                if _lp(_lX,_lV+1)then _lN(_lX,_lV,"walk",3,true)end
                local _lY=_lV+1
                while _lY<_kX and _lY-_lV<=40 and _lf(_lX,_lY)and not _lk(_lX,_lY)do _lY=_lY+(1)end
                if _lY<_kX and _lf(_lX,_lY)and _lk(_lX,_lY)then _lN(_lX,_lY,"fall",1+0.5*(_lY-_lV),false)end
                if _lf(_lU,_lV-1)and _lf(_lU,_lV-2)then
                    for _lZ=2,3
                    do
                        local _ma=_lU+(_lZ-1)*_lW
                        if not(_lf(_ma,_lV)and _lf(_ma,_lV-1)and _lf(_ma,_lV-2))then break
                        end
                    if _lZ==3 and _lk(_ma,_lV)then break
                    end
                local _mb=_lU+_lZ*_lW
                if _lf(_mb,_lV-1)and _lf(_mb,_lV-2)then
                    for _mc=0,2
                    do
                        if not _lf(_mb,_lV+_mc)then break
                        end
                    if _lk(_mb,_lV+_mc)then _lN(_mb,_lV+_mc,"gap",_lZ+0.5+0.5*_mc,false)break
                    end
            end
    end
end
end
end
end
for _md=1,3
do
    if not _lf(_lU,_lV-_md)then break
    end
if _lf(_lU,_lV-_md-1)and _lf(_lX,_lV-_md)and _lk(_lX,_lV-_md)and _lf(_lX,_lV-_md-1)then _lN(_lX,_lV-_md,"jump",1+1.5*_md,false)end
end
for _me=1,2
do
    if _lf(_lU,_lV-1)and(_me==1 or _lf(_lU,_lV-2))and _lf(_lX,_lV-_me)and _lk(_lX,_lV-_me)and not(_lf(_lU,_lV-_me-1)and _lf(_lX,_lV-_me-1))then _lN(_lX,_lV-_me,"stair",3+1.5*_me,false)end
end
end
if _kT and _lf(_lU,_lV-1)and _lf(_lU,_lV-2)and _lf(_lU,_lV-3)and _lp(_lU,_lV)then _lN(_lU,_lV-1,"pillar",4,true)end
return _lM
end
local _mf=_kO*_kW+_kN
local _mg,_mh,_mi,_mj,_mk={[_mf]=0},{},{},{},{}local _ml,_mm,_mn={},{},0 _mn=_kw(_ml,_mm,_mn,_lu(_kN,_kO),_mf)local _mo=0
local _mp=os.clock()while _mn>0
do
    local _mq _mq,_mn=_kE(_ml,_mm,_mn)if not _mk[_mq]then _mk[_mq]=true
        local _mr,_ms=_mq%_kW,math.floor(_mq/_kW)if _lB(_mr,_ms)then
            local _mt={}local _mu=_mq
            while _mu~=_mf
            do
                local _mv=_mh[_mu]table.insert(_mt,1,{fx=_mv%_kW,fy=math.floor(_mv/_kW),x=_mu%_kW,y=math.floor(_mu/_kW),kind=_mi[_mu],build=_mj[_mu],key=_mv*_kY+_mu,})_mu=_mv
            end
        return _mt,false,_mk
    end _mo=_mo+(1)if _mo>6500 then
    return nil,false,_mk
end
if _mo%400==0 then task.wait()if _kU and _kU()then
        return nil,false,_mk
    end
end
local _mw=_mg[_mq]local _mx=_lT(_mr,_ms)for _my=1,_mx
do
    local _mz=_lI[_my]*_kW+_lH[_my]if not _mk[_mz]then
        local _mA=modClick.BadEdge[_mq*_kY+_mz]if not(_mA and _mA>_mp)then
            local _mB=_mw+_lK[_my]local _mC=_mg[_mz]if _mC==nil or _mB<_mC then _mg[_mz],_mh[_mz],_mi[_mz],_mj[_mz]=_mB,_mq,_lJ[_my],_lL[_my]_mn=_kw(_ml,_mm,_mn,_mB+_lu(_lH[_my],_lI[_my]),_mz)end
        end
end
end
end
end
return nil,true,_mk
end
local function _mD(_mE,_mF,_mG)local _mH=_mF-_mE.x
    local _mI=_mE.vx or 0
    local _mJ=_mE.grounded and 48 or 17
    local _mK=0
    if _je(_mH)>_mG then _mK=_mH>0 and 1 or-1
        if _mI*_mK>0 and(_mI*_mI)/(2*_mJ)>=_je(_mH)-_mG*0.5 then _mK=0
        end
end inputState.left=_mK<0 inputState.right=_mK>0
end
local function _mL(_mM,_mN,_mO)local _mP=getWorldMod()if not _cM or not _hg()then
        if _mP and _mP.goTo then pcall(_mP.goTo,_mM,_mN)task.wait(math.max(0.25,config.moveStepDelay))return true
        end
    return false
end inputState.active=true
local _mQ=_mM+0.5
local _mR=_hg()if not _mR then _cO();return false
end
local _mS=1.6+_je(_mQ-_mR.x)*0.38
local _mT=os.clock()while os.clock()-_mT<=_mS and isAlive()do
    if _mO and _mO()then _cO();return false
    end
local _mU=_hg()if not _mU or _mU.dead then _cO();return false
end
local _mV,_mW=_jd(_mU.x),_jd(_mU.y-0.475)if _mU.grounded and _mW~=_mN then _cO();return false
end _mD(_mU,_mQ,0.1)if _mV==_mM and _je(_mU.x-_mQ)<=0.22 and _mU.grounded and _je(_mU.vx or 0)<2.2 then _cO()return true
end task.wait()end _cO()return false
end
local function _mX(_mY,_mZ)inputState.active=true
    local _na=_mY.x+0.5
    local _nb=1.6+0.3*(_mY.y-_mY.fy)local _nc=os.clock()while os.clock()-_nc<=_nb and isAlive()do
        if _mZ and _mZ()then _cO();return false
        end
    local _nd=_hg()if not _nd or _nd.dead then _cO();return false
    end _mD(_nd,_na,0.1)if _nd.grounded then
    local _ne,_nf=_jd(_nd.x),_jd(_nd.y-0.475)if _nf==_mY.y then
        if _ne==_mY.x and _je(_nd.x-_na)<=0.25 then _cO()return true
        end elseif _nf~=_mY.fy then _cO()return false
    end
end task.wait()end _cO()return false
end
local function _ng(_nh,_ni)if not _mL(_nh.fx,_nh.fy,_ni)then
        return false
    end inputState.active=true
local _nj=_nh.fy-_nh.y
local _nk=_nh.y+1
local _nl=_nk-((_nj==1)and 0 or 0.4)local _nm=_nh.x+0.5 _cO()task.wait()inputState.jump=true
local _nn=os.clock()local _no=false
while os.clock()-_nn<=1.8 and isAlive()do
    if _ni and _ni()then _cO();return false
    end
local _np=_hg()if not _np or _np.dead then _cO();return false
end
if not _np.grounded then _no=true
end
if inputState.jump and(_np.y<=_nl or(_no and(_np.vy or 0)>=0))then inputState.jump=false
end
if _np.y<=_nk+0.25 then _mD(_np,_nm,0.1)else _mD(_np,_nh.fx+0.5,0.15)end
if _no and _np.grounded then
    local _nq,_nr=_jd(_np.x),_jd(_np.y-0.475)_cO()return(_nr==_nh.y and _nq==_nh.x and _je(_np.x-_nm)<=0.26)end
if not _no and os.clock()-_nn>0.38 then break
end task.wait()end _cO()return false
end
local function _ns(_nt,_nu)if not _mL(_nt.fx,_nt.fy,_nu)then
        return false
    end inputState.active=true
local _nv=_hg()if not _nv then _cO();return false
end
local _nw=(_nt.x>_nt.fx)and 1 or-1
local _nx=_nt.fx+0.5+_nw*0.6
local _ny=_nv.y
local _nz=_nt.x+0.5 _cO()local _nA=os.clock()local _nB,_nC,_nD=false,false,0
while os.clock()-_nA<=2.2 and isAlive()do
    if _nu and _nu()then _cO();return false
    end
local _nE=_hg()if not _nE or _nE.dead then _cO();return false
end
if not _nB then inputState.left,inputState.right=_nw<0,_nw>0 if(_nE.x-_nx)*_nw>=0 or not _nE.grounded then _nB,_nD=true,os.clock()inputState.jump=_nE.grounded
    end else
if not _nE.grounded then _nC=true
end
if inputState.jump and(_nE.y<=_ny-1 or(_nC and(_nE.vy or 0)>=0))then inputState.jump=false
end _mD(_nE,_nz,0.1)if _nC and _nE.grounded then
local _nF,_nG=_jd(_nE.x),_jd(_nE.y-0.475)_cO()return(_nG==_nt.y and _nF==_nt.x and _je(_nE.x-_nz)<=0.26)end
if not _nC and os.clock()-_nD>0.38 then break
end
end task.wait()end _cO()return false
end
local function _nH(_nI,_nJ)if not _mL(_nI.fx,_nI.fy,_nJ)then
        return false
    end inputState.active=true
local _nK=(_nI.x>_nI.fx)and 1 or-1
local _nL=_nI.y+1
local _nM=_nI.fx+0.5+_nK*0.17
for _nN=1,3
do
    local _nO=os.clock()while os.clock()-_nO<=0.8 and isAlive()do
        if _nJ and _nJ()then _cO();return false
        end
    local _nP=_hg()if not _nP or _nP.dead then _cO();return false
    end _mD(_nP,_nM,0.03)if _je(_nP.x-_nM)<=0.06 and _je(_nP.vx or 0)<1 then break
end task.wait()end _cO()task.wait()local _nQ=_hg()if not _nQ then
return false
end
local _nR=_nQ.y inputState.jump=true _nO=os.clock()local _nS,_nT=false,nil
while os.clock()-_nO<=1.8 and isAlive()do
    if _nJ and _nJ()then _cO();return false
    end
local _nU=_hg()if not _nU or _nU.dead then _cO();return false
end
if not _nU.grounded then _nS=true
end
if inputState.jump and(_nU.y<=_nL-0.1 or(_nS and(_nU.vy or 0)>=0))then inputState.jump=false
end
local _nV=(_nN==1 and _nU.y<=_nL+0.02)or(_nN==2 and _nU.y<=_nR-0.15)or(_nN==3 and _nU.y<=_nL+0.25)if _nS and _nV then inputState.right,inputState.left=_nK>0,_nK<0 else _mD(_nU,_nM,0.03)end
if _nS and _nU.grounded then _nT=_jd(_nU.y-0.475)break
end
if not _nS and os.clock()-_nO>0.35 then break
end task.wait()end _cO()if _nT==_nI.y then
return _mL(_nI.x,_nI.y,_nJ)end
if _nT~=nil and _nT~=_nI.fy then
    return false
end
if not _mL(_nI.fx,_nI.fy,_nJ)then
    return false
end
end
return false
end
local function _nW(_nX,_nY)if not _mL(_nX.fx,_nX.fy,_nY)then
        return false
    end
if _jf(_nX.fx,_nX.fy)~=0 then
    return false
end inputState.active=true _cO()task.wait()inputState.jump=true
local _nZ=os.clock()local _oa,_ob=false,false
while os.clock()-_nZ<=1.8 and isAlive()do
    if _nY and _nY()then _cO();return false
    end
local _oc=_hg()if not _oc or _oc.dead then _cO();return false
end
if not _oc.grounded then _ob=true
end _mD(_oc,_nX.fx+0.5,0.12)if inputState.jump and(_oc.y<_nX.fy-0.9 or(_ob and(_oc.vy or 0)>=0))then inputState.jump=false
end
if not _oa and _ob and _oc.y<_nX.fy-0.25 and((_oc.vy or 0)>-6 or _oc.y<_nX.fy-0.8)then _oa=_kj(_nX.fx,_nX.fy)if not _oa then _cO();return false
    end
end
if _oc.grounded and _ob then _cO()local _od,_oe=_jd(_oc.x),_jd(_oc.y-0.475)return _oa and _od==_nX.x and _oe==_nX.y
end
if not _ob and os.clock()-_nZ>0.38 then break
end task.wait()end _cO()return false
end modClick.ExecWalk=_mL modClick.ExecPillar=_nW
function modClick.FollowPath(_of,_og)local _oh={}for k_oi,v_oj in pairs(_iP)do _oh[k_oi]=v_oj
    end table.clear(_iP)local _ok=_iO _iO=false _iU()inputState.active=true
local _ol={}local function _om()if#_ol==0 then
        return
    end
for _on=#_ol,1,-1
do
    local _oo=_ol[_on]local _op,_oq=_hv()if not(_op==_oo.x and _oq==_oo.y-1)then
        local _or=_hg()if _or and _jQ(_or,_oo.x,_oo.y,_hR()-0.1)and _jf(_oo.x,_oo.y)~=0 and _iw(_jf(_oo.x,_oo.y))then _ip(_oo.x,_oo.y)local _os=os.clock()while _jf(_oo.x,_oo.y)~=0 and os.clock()-_os<3.0 and isAlive()do
                if _og and _og()then break
                end _iE(_oo.x,_oo.y,false)task.wait(0.15)end
    end
if _jf(_oo.x,_oo.y)==0 then table.remove(_ol,_on)end
end
end
end
local function _ot(_ou)_om()_cO()inputState.active=false _iO=_ok
    for k_ov,v_ow in pairs(_oh)do _iP[k_ov]=v_ow
    end _iU()return _ou
end
local _ox=1
while _ox<=#_of and isAlive()do
    if _og and _og()then
        return _ot(false)end
    local _oy=_of[_ox]local _oz,_oA=_ox,false
    if _oy.kind=="walk"then
        local _oB=_oy.x-_oy.fx
        while _of[_oz+1]and _of[_oz+1].kind=="walk"and(_of[_oz+1].x-_of[_oz+1].fx)==_oB
        do _oz=_oz+(1)end
        local _oC=false
        for _oD=_ox,_oz
        do
            if _of[_oD].build then _oC=true;break
            end
    end
if _oC then _oA=true
    for _oE=_ox,_oz
    do
        if _og and _og()then
            return _ot(false)end
        local _oF=_of[_oE]if _oF.build and not _jN(_oF.x,_oF.y)then
            if not _kj(_oF.x,_oF.y+1)then _oA=false;break
            end table.insert(_ol,{x=_oF.x,y=_oF.y+1})task.wait(0.14)end
    if not _mL(_oF.x,_oF.y,_og)then _oA=false;break
    end _om()end else _oA=_mL(_of[_oz].x,_of[_oz].y,_og)_om()end elseif _oy.kind=="pillar"then _oA=_nW(_oy,_og)if _oA then table.insert(_ol,{x=_oy.fx,y=_oy.fy})task.wait(0.08)_om()end elseif _oy.kind=="fall"then _oA=_mX(_oy,_og)_om()elseif _oy.kind=="jump"then _oA=_ng(_oy,_og)_om()elseif _oy.kind=="gap"then _oA=_ns(_oy,_og)_om()elseif _oy.kind=="stair"then _oA=_nH(_oy,_og)_om()end _cO()if not _oA then modClick.BadEdge[_oy.key]=os.clock()+20
            return _ot(false)end _ox=_oz+1
    end
return _ot(true)end
function modClick.ClimbUpWithDirt(_oG,_oH,_oI,_oJ,_oK,_oL)local _oM=getWorldMod()if not _oM then
        return false
    end
if _oJ==nil then _oJ=true
end
if _oL==nil then _oL=false
end
local _oN=math.max(0.24,tonumber(_oK)or tonumber(config.moveStepDelay)or 0.28)local _oO={}for k_oP,v_oQ in pairs(_iP)do _oO[k_oP]=v_oQ
end table.clear(_iP)local _oR=_iO
local _oS=tileCache.collecting _iO=false tileCache.collecting=true _oM.speedScale=1 _iU()inputState.active=true _cO()local _oT={}local function _oU(_oV)if not _oJ then
        return
    end
local _oW={}for _oX in pairs(_oT)do
    if _oX>=_oV then table.insert(_oW,_oX)end
end table.sort(_oW,function(_oY,_oZ)return _oY>_oZ end)for k_pa,v_pb in ipairs(_oW)do
if _oI and _oI()then
    return
end
local _pc=_jf(_oG,v_pb)if _pc~=0 and _iw(_pc,_oG,v_pb)then _ip(_oG,v_pb)local _pd=os.clock()while _jf(_oG,v_pb)~=0 and(os.clock()-_pd)<3.5 and isAlive()do
        if _oI and _oI()then break
        end
    local _pe=_hg()if _pe and math.abs((v_pb+0.5)-(_pe.y-0.475))>_hR()-0.1 then _oM.ghost=true pcall(_oM.goTo,_oG,math.max(0,v_pb-2))task.wait(0.06)end _iE(_oG,v_pb,false)task.wait(0.14)end
end
if _jf(_oG,v_pb)==0 then _oT[v_pb]=nil
end
end
end
local function _pf()if not _oJ or next(_oT)==nil then
        return
    end
local _pg=(_oG<=2)and{_oG+1,_oG+2}or((_oG>=_oM.w-3)and{_oG-1,_oG-2}or{_oG+1,_oG-1})for k_ph,v_pi in ipairs(_pg)do
    if _hJ(_oM,v_pi,_oH)and _jK(v_pi,_oH)and _jN(v_pi,_oH)then _mL(v_pi,_oH,_oI)task.wait(0.12)break
    end
end _oM.ghost=true
local _pj={}for _pk in pairs(_oT)do table.insert(_pj,_pk)end table.sort(_pj)for k_pl,v_pm in ipairs(_pj)do
    if _oI and _oI()then break
    end
if _jf(_oG,v_pm)~=0 and _iw(_jf(_oG,v_pm),_oG,v_pm)then
    local _pn=math.max(0,v_pm-1)local _po,_pp=_hv()if _po and _pp and(math.abs(_po-_oG)>2 or math.abs(_pp-v_pm)>2)then _oM.ghost=true pcall(_oM.goTo,_oG,_pn)task.wait(0.08)end _ip(_oG,v_pm)local _pq=os.clock()while _jf(_oG,v_pm)~=0 and(os.clock()-_pq)<3.5 and isAlive()do
        if _oI and _oI()then break
        end _oM.ghost=true _iE(_oG,v_pm,false)task.wait(0.14)end
end
if _jf(_oG,v_pm)==0 then _oT[v_pm]=nil
end
end
end
local function _pr(_ps)pcall(_pf)_cO()inputState.active=false tileCache.collecting=_oS
    if config.walkSpeed~=100 and modules.World and not _oS then modules.World.speedScale=config.walkSpeed/100
    end _iO=_oR
for k_pt,v_pu in pairs(_oO)do _iP[k_pt]=v_pu
end _iU()return _ps
end
local _pv,_pw=_hv()if not _pv then
    return _pr(false)end
if _pv~=_oG then
    if not _mL(_oG,_pw,_oI)then pcall(_oM.goTo,_oG,_pw)task.wait(_oN)end _pv,_pw=_hv()if not _pv then
        return _pr(false)end
end
local _px=_kb()if _hJ(_oM,_oG,_pw+1)and not _jN(_oG,_pw)then
    if _jf(_oG,_pw+1)==0 and _kj(_oG,_pw+1)then _oT[_pw+1]=_px task.wait(WALK_SPEED_FAST)end
end
local _py=0
while _pw>_oH and isAlive()do
    if _oI and _oI()then
        return _pr(false)end
    local _pz=_pw-1
    if not _oL and _jf(_oG,_pz)~=0 and _jo(_oG,_pz)then
        return _pr(false)end
    if _oL then
        for _pA=_pz,math.max(0,_pz-2),-1
        do
            local _pB=_jf(_oG,_pA)if _pB~=0 and _iw(_pB,_oG,_pA)then
                local _pC=os.clock()while _jf(_oG,_pA)~=0 and(os.clock()-_pC)<4 and isAlive()do
                    if _oI and _oI()then
                        return _pr(false)end _iE(_oG,_pA,false)task.wait(0.15)end
            end
    end
end
if tileCache.walkToX then tileCache.walkToX(_oG+0.5,0.6)end
local _pD=_pw
local _pE=(_jf(_oG,_pw)==0)local _pF=_nW({fx=_oG,fy=_pw,x=_oG,y=_pz},_oI)if _pF or(_pE and _jf(_oG,_pw)~=0)then _oT[_pw]=_px elseif _jf(_oG,_pw)==0 then
        if _kj(_oG,_pw)then _oT[_pw]=_px
        end task.wait(0.14)pcall(_oM.goTo,_oG,_pz)end task.wait(math.max(WALK_SPEED_FAST,_oN))local _pG,_pH=_hv()if _pH and _pH<_pD then _pw=_pH _py=0 else
    if _jf(_oG,_pD)~=0 and _jK(_oG,_pz)then pcall(_oM.goTo,_oG,_pz)task.wait(0.18)_pG,_pH=_hv()end
    if _pH and _pH<_pD then _pw=_pH _py=0 else _py=_py+1
        if _py>=3 then
            return _pr(false)end
    end
end _oU(_pw+2)end
return _pr(true)end
local function _pI(_pJ,_pK,_pL,_pM,_pN)local _pO,_pP=_pJ.w,_pJ.h
    local _pQ=_pL*_pO+_pK
    local _pR=_pN*_pO+_pM
    if _pQ==_pR then return{}end
    local _pS={_pQ}local _pT={[_pQ]=-1}local _pU=1
    local _pV={{0,-1},{1,0},{-1,0},{0,1}}while _pU<=#_pS and _pU<=3500
    do
        local _pW=_pS[_pU]_pU=_pU+1
        if _pW==_pR then
            local _pX={}local _pY=_pW
            while _pY~=_pQ
            do table.insert(_pX,1,{x=_pY%_pO,y=math.floor(_pY/_pO)})_pY=_pT[_pY]end
            return _pX
        end
    local _pZ,_qa=_pW%_pO,math.floor(_pW/_pO)for _qb,_qc in ipairs(_pV)do
        local _qd,_qe=_pZ+v_qc[1],_qa+v_qc[2]if _qd>=0 and _qd<_pO and _qe>=0 and _qe<_pP then
            local _qf=_qe*_pO+_qd
            if _pT[_qf]==nil and(_qf==_pR or _jK(_qd,_qe))then _pT[_qf]=_pW table.insert(_pS,_qf)end
        end
end
end
return nil
end
function modClick.FlyTo(_qg,_qh,_qi,_qj,_qk)local _ql=getWorldMod()if not _ql or type(_ql.goTo)~="function"then
        return false
    end
local _qm=math.max(0.16,tonumber(_qj)or tonumber(config.moveStepDelay)or 0.22)for _qn=1,3
do
    if _qi and _qi()then
        return false
    end
local _qo,_qp=_hv()if not _qo then
    return false
end
if _qo==_qg and _qp==_qh then
    return true
end _ql.ghost=true
local _qq=_pI(_ql,_qo,_qp,_qg,_qh)if _qq and#_qq>0 then
    local _qr=false
    for k_qs,v_qt in ipairs(_qq)do
        if _qi and _qi()then
            return false
        end _ql.ghost=true pcall(_ql.goTo,v_qt.x,v_qt.y)task.wait(_qm)local _qu,_qv=_hv()if not _qu or(math.abs(_qu-v_qt.x)>2 or math.abs(_qv-v_qt.y)>2)then _qr=true break
    end
end
local _qw,_qx=_hv()if not _qr and _qw==_qg and _qx==_qh then
    return true
end
end
local _qy=0
local _qz=160 while(_qo~=_qg or _qp~=_qh)and _qz>0 and isAlive()do _qz=_qz-1
    if _qi and _qi()then
        return false
    end _ql.ghost=true
local _qA,_qB=_hv()if not _qA then
    return false
end _qo,_qp=_qA,_qB
if _qo==_qg and _qp==_qh then
    return true
end
local _qC=(_qg>_qo and 1)or(_qg<_qo and-1)or 0
local _qD=(_qh>_qp and 1)or(_qh<_qp and-1)or 0
local _qE,_qF=_qo,_qp
if _qD<0 and _jK(_qo,_qp-1)then _qE,_qF=_qo,_qp-1 elseif _qC~=0 and _jK(_qo+_qC,_qp)then _qE,_qF=_qo+_qC,_qp elseif _qD~=0 and _jK(_qo,_qp+_qD)then _qE,_qF=_qo,_qp+_qD elseif _qp>0 and _jK(_qo,_qp-1)then _qE,_qF=_qo,_qp-1 elseif _qk then _qE,_qF=_qo+_qC,_qp+_qD else break
                end pcall(_ql.goTo,_qE,_qF)task.wait(_qm)local _qG,_qH=_hv()if _qG==_qo and _qH==_qp then _qy=_qy+1
                if _qy>=3 then break
                end else _qy=0
        end
end
local _qI,_qJ=_hv()if _qI==_qg and _qJ==_qh then
    return true
end
end
return false
end
function modClick.LegitTo(_qK,_qL,_qM,_qN,_qO)local _qP=os.clock()local _qQ=getWorldMod()if not _qQ then
        return false,"world"end
    if _qO==nil then _qO=false
    end
local _qR=_qN or 0.4
for _qS=1,3
do
    if _qM and _qM()then
        return false,"cancel"end
    local _qT,_qU=_hv()if not _qT then
        return false,"pos"end
    if _qT==_qK and _qU==_qL then
        return true,os.clock()-_qP
    end
local _qV=_hg()if _qV and _qR>=1 and _jQ(_qV,_qK,_qL,_qR)then
    return true,os.clock()-_qP
end
local _qW={[_qL*_qQ.w+_qK]=true}local _qX=modClick.AStar(_qT,_qU,_qW,_qK,_qL,_qR,_qO,_qM)if _qX and#_qX>0 then
    if modClick.FollowPath(_qX,_qM)then
        local _qY,_qZ=_hv()local _ra=_hg()if(_qY==_qK and _qZ==_qL)or(_ra and _jQ(_ra,_qK,_qL,_qR+0.35))then
            return true,os.clock()-_qP
        end
end else
if _qU~=_qL then
    local _rb=(math.abs(_qT-1)<=math.abs(_qT-(_qQ.w-2)))and 1 or(_qQ.w-2)local _rc={[_qL*_qQ.w+_rb]=true}local _rd=modClick.AStar(_qT,_qU,_rc,_rb,_qL,0.5,_qO,_qM)if _rd and#_rd>0 then modClick.FollowPath(_rd,_qM)end
end
end task.wait(0.15)end
return false,"nopath"end
function modClick.StepGoTo(_re,_rf,_rg,_rh)local _ri=modClick.FlyTo(_re,_rf,_rg,config.moveStepDelay,_rh==true)_iU()return _ri,_ri and 0 or "stuck"end
function modClick.Go(_rj,_rk,_rl,_rm,_rn)local _ro=(config.moveMethod=="Teleport Mode")or(config.moveMode=="fly")or(config.moveMode=="teleport")if not _ro then
        local _rp=getWorldMod()if _rp and not _iO then _rp.ghost=false
        end
    local _rq,_rr=modClick.LegitTo(_rj,_rk,_rl,_rm,_rn)return _rq,_rr
end
return modClick.StepGoTo(_rj,_rk,_rl,false)end
function modClick.To(_rs,_rt,_ru,_rv,_rw)local _rx=modClick.Go(_rs,_rt,_ru,_rv,_rw)return _rx
end
local _ry=nil
local function _rz()if not _ry and getgcFn and debug and debug.info then
        for _rA,v_rB in ipairs(getgcFn(true))do
            if type(v_rB)=="function"then
                local _rC,_rD=pcall(debug.info,v_rB,"n")if _rC and _rD=="act"and getupvalue then
                    local _rE,_rF=pcall(getupvalue,v_rB,1)local _rG,_rH=pcall(getupvalue,v_rB,2)local _rI,_rJ=pcall(getupvalue,v_rB,4)local _rK,_rL=pcall(getupvalue,v_rB,5)if _rE and typeof(_rF)=="Instance"and _rF.ClassName=="Players"and _rG and type(_rH)=="number"and _rI and type(_rJ)=="number"and _rK and type(_rL)=="number"then _ry=v_rB break
                    end
            end
    end
end
end
if _ry and getupvalue then
    local _rM,_rN=pcall(getupvalue,_ry,2)local _rO,_rP=pcall(getupvalue,_ry,4)local _rQ,_rR=pcall(getupvalue,_ry,5)if _rM and _rO and _rQ and type(_rN)=="number"and type(_rP)=="number"and type(_rR)=="number"and _rP>0 then
        return _rN,_rR,_rP
    end
end
local obj_GameGui=obj_PlayerGui:FindFirstChild("GameGui")local obj_World=obj_GameGui and obj_GameGui:FindFirstChild("World")local obj_Camera=obj_World and obj_World:FindFirstChild("Camera")local obj_Tiles=obj_Camera and obj_Camera:FindFirstChild("Tiles")if obj_Tiles and obj_Tiles:IsA("GuiObject")then
    local _rW=64
    local _rX=-obj_Tiles.Position.X.Offset/_rW
    local _rY=-obj_Tiles.Position.Y.Offset/_rW
    return _rX,_rY,_rW
end
return nil
end
function modClick.ScreenToTile(_rZ)local _sa,_sb,_sc=_rz()if not _sa then
        return nil
    end
local obj_GameGui=obj_PlayerGui:FindFirstChild("GameGui")local obj_World=(obj_GameGui and obj_GameGui:FindFirstChild("World"))or obj_PlayerGui:FindFirstChild("World",true)if not obj_World or not obj_World:IsA("GuiObject")then
    return nil
end
local _sf=obj_World:FindFirstChildWhichIsA("UIScale",true)local _sg=_sf and _sf.Scale or 1
local _sh=(Vector2.new(_rZ.X,_rZ.Y)-obj_World.AbsolutePosition)/_sg
return _jd(_sa+_sh.X/_sc),_jd(_sb+_sh.Y/_sc)end
local function _si(_sj,_sk)if _sk or not modClick.clickOn then
        return
    end
if _sj.UserInputType~=Enum.UserInputType.MouseButton1 and _sj.UserInputType~=Enum.UserInputType.Touch then
    return
end
if config.clickTpShift and not(svc_UserInputSvc:IsKeyDown(Enum.KeyCode.LeftShift)or svc_UserInputSvc:IsKeyDown(Enum.KeyCode.RightShift))then
    return
end
local _sl,_sm=modClick.ScreenToTile(_sj.Position)if not _sl then notify("Click TP: posisi klik tidak terbaca.")return
end modClick.token=modClick.token+(1)local _sn=modClick.token task.spawn(function()local _so=os.clock()local _sp,_sq=modClick.Go(_sl,_sm,function()return modClick.token~=_sn or not modClick.clickOn or not isAlive()end,0.4,true)if _sp then modClick.last=string.format("Sampai (%d,%d) dalam %.2fs",_sl,_sm,os.clock()-_so)notify(modClick.last)elseif _sq~="cancel"then modClick.last="Gagal ("..tostring(_sq)..")"notify("Click TP gagal: "..tostring(_sq))end end)end
function modClick.StartClick()if modClick.clickOn then
        return true
    end
if not _rz()then notify("Click TP: data kamera game tidak ditemukan.")return false
end modClick.clickOn=true modClick.conn=_f(svc_UserInputSvc.InputBegan:Connect(_si))return true
end
function modClick.StopClick()if not modClick.clickOn then
        return false
    end modClick.clickOn=false modClick.token=modClick.token+(1)if modClick.conn then modClick.conn:Disconnect()modClick.conn=nil
end _cO()return true
end end)()end
local _sr=0
local function _ss(_st)_st=math.floor(tonumber(_st)or 0)if _st<1 or _st>MAX_ITEM_ID then notify("Jumlah WL tidak valid!")return false
    end
local _su=os.clock()if _su-_sr<WALK_SPEED_DEFAULT then task.wait(WALK_SPEED_DEFAULT-(_su-_sr))end _sr=os.clock()local _sv=config.dropId or 242
if remote_DropItem then pcall(function()remote_DropItem:FireServer(_sv,_st)end)notify(string.format("Drop %d %s dikirim!",_st,_gt(_sv)))return true elseif _bb and type(_bc)=="table"and _bc.drop then pcall(_bc.drop.send,{id=_sv,n=_st})notify(string.format("Drop %d %s dikirim!",_st,_gt(_sv)))return true
    end notify("Remote DropItem tidak ditemukan!")return false
end
local _sw
local function _sx(_sy)_sy=trim(_sy):upper()if _sy==""then notify("Nama world tidak boleh kosong!")return false
    end config.lastWorld=_sy saveConfig()if _sw then pcall(_sw)end
local _sz=modules.Menu
if _sz and type(rawget(_sz,"enter"))=="function"then pcall(_sz.enter,_sy)notify("Memasuki world: ".._sy)return true
end
local _sA=getWorldMod()if _sA and type(rawget(_sA,"enter"))=="function"then pcall(_sA.enter,_sy)notify("Memasuki world: ".._sy)return true
end notify("Fungsi enter world tidak ditemukan.")return false
end
local function _sB()local _sC=_hy()if _sC~=""then config.lastWorld=_sC saveConfig()end
    if _sw then pcall(_sw)end pcall(function()svc_TeleportSvc:TeleportToPlaceInstance(game.PlaceId,game.JobId,localPlayer)end)end
local function _sD(_sE)local _sF,_sG=_hv()if not _sF then notify("Posisi karakter belum terbaca!")return false
    end
local _sH="pos"..tostring(_sE)config[_sH]={x=_sF,y=_sG,world=_hy()}saveConfig()notify(string.format("Pos %d disimpan di (%d, %d) [%s]",_sE,_sF,_sG,_hy()))return true
end
local function _sI()local _sJ,_sK=_hv()local _sL,_sM=config.pos1 or{},config.pos2 or{}local _sN=string.format("Sekarang: (%s, %s) | Pos1: (%s, %s) | Pos2: (%s, %s)",_sJ and tostring(_sJ)or "-",_sK and tostring(_sK)or "-",_sL.x and tostring(_sL.x)or "-",_sL.y and tostring(_sL.y)or "-",_sM.x and tostring(_sM.x)or "-",_sM.y and tostring(_sM.y)or "-")notify(_sN,"Info Posisi")end
local function _sO(_sP,_sQ)local _sR="pos"..tostring(_sP)local _sS=config[_sR]if type(_sS)~="table"or type(_sS.x)~="number"or type(_sS.y)~="number"then notify("Pos "..tostring(_sP).." belum disimpan!")return false
    end
local _sT=modClick.To(_sS.x,_sS.y,nil,0.3,true)if _sT then
    local _sU=tonumber(_sQ)or tonumber(config.winDrop)or 0
    if _sU>=1 then task.wait(0.15)_ss(_sU)end
end
return _sT
end
local _sV
local _sW=nil
local _sX="farm"local _sY=nil
local _sZ=nil
local modAutoPlace={on=false,token=0,Override=nil,Quiet=false,stats={status="Mati",placed=0,broken=0,picked=0,fail=0,cycles=0},}local modBreak={on=false,token=0,status="Mati",stats={scanned=0,broken=0,picked=0,skipped=0,left=0,pass=0,row=-1},}local modTrees={on=false,token=0,status="Mati",stats={totalTrees=0,ready=0,harvested=0,planted=0,skipped=0,picked=0},}local modDirt={on=false,token=0,status="Mati",stats={topDirtY=0,bedrockY=0,broken=0,placed=0,picked=0,step="-"},}local _te={on=false,roaming=false,token=0,status="Mati",made=0,planted=0,fail={},skip={},}local modFarm={on=false,token=0,phase="-",status="Mati",harvested=0,planted=0,dropped=0,traveling=false,home="",Zone=nil,skip={},}local modGems={on=false,token=0,phase="-",status="Mati",collected=0,dropped=0,traveling=false,pauseCollect=false,}local modRecycle={recycled=0,converted=0,status="-",}local modIntrusion={on=false,mode="idle",allow={},alerted={},saved=nil,token=0,backAt=0,calmAt=nil,leftFg=nil,status="Mati",detected=0,hereText="tidak ada",staffServerText="tidak ada",}local _tj={busy=false,leaving=false,last=nil,lastAt=0,count=0,status="-",}local _tk={on=false,sent=0,last="-",nextAt=0}local function isSeedItem(itemId)local _tn=itemDB and _P[_tm]return type(_tn)=="table"and(_tn.kind=="seed"or type(_tn.tree)=="table"or type(_tn.grow)=="number")end
local function doFarmAction(_tp,_tq,_tr,_ts)_tp=_tp or getWorldMod()if not _tp then
        return nil
    end
local _tt=itemDB[_ts]if not _tt then
    return nil
end
local _tu=tonumber(_tt.grow)or tonumber(_tt.baseGrow)or 31
local _tv=_tr*_tp.w+_tq
if type(_tp.treeLook)=="function"then pcall(_tp.treeLook,_tq,_tr)end
if not modules.Trees then modules.Scan()end
local _tw=modules.Trees and modules.Trees[_tv]if type(_tw)=="table"then
    if _tw.ripe==true or _tw.fruitMade==true or _tw.step==1 then
        return 0
    end
if type(_tw.tree)=="table"and type(_tw.tree.p)=="number"then
    return _tw.tree.p+_tu
end
if type(_tw.p)=="number"then
    return _tw.p+_tu
end
end
local _tx=_tp.placedAt and _tp.placedAt.fg
if _tx and type(_tx[_tv])=="number"then
    return workspace:GetServerTimeNow()-(os.clock()-_tx[_tv])+_tu
end
return nil
end
local function _ty(_tz,_tA,_tB,_tC)local _tD=doFarmAction(_tz,_tA,_tB,_tC)if not _tD then
        return false
    end
return workspace:GetServerTimeNow()>=_tD
end
local function _tE(_tF,_tG,_tH,_tI)_tF=_tF or getWorldMod()if not _hJ(_tF,_tG,_tH)or _tH+1>=_tF.h then
        return false
    end if(placeTile(_tF,"fg",_tG,_tH)or 0)~=0 then
    return false
end
local _tJ=placeTile(_tF,"fg",_tG,_tH+1)or 0
if _tJ==0 then
    return false
end
local _tK=itemDB[_tJ]if not _tK or _tK.kind=="seed"then
    return false
end
if not(modClick.SolidAt(_tG,_tH+1)or _tK.platform)then
    return false
end
local _tM,_tN=pcall(function()if _tF.areas and type(_tF.areas.canEdit)=="function"and not _tF.areas.canEdit(_tG,_tH)then
        return false
    end
if type(_tF.builderOk)=="function"and not _tF.builderOk(_tG,_tH,true)then
    return false
end
local _tL=_tI and itemDB[_tI]if _tL and type(_tF.needsWay)=="function"and _tF.needsWay(_tL)and type(_tF.wayBlocked)=="function"and _tF.wayBlocked(_tG,_tH)then
    return false
end
return true end)return(not _tM)or _tN
end do(function()local function _tO(_tP,_tQ,_tR)return _tQ>=_tP.x-0.15 and _tQ<_tP.x+1.15 and _tR>=_tP.y-0.15 and _tR<_tP.y+1.15
    end
local function _tS(_tT,_tU)if type(_tT)~="table"or _tT.taking or _tT.pending or _tT.display or(_tT.n or 0)<=0 or type(_tT.x)~="number"then
        return false
    end
if _tT.armed==false and _tT.id~=112 then
    return false
end
local _tV=_tT.uid and inputHooks[_tT.uid]return not(_tV and _tU<_tV)end
function tileCache.applyTaken(_tW,_tX)local _tY=tileCache.list
    if not _tY or not table.find(_tY,_tW)then
        return
    end
if not tileCache.update and tileCache.findUpdate then tileCache.findUpdate()end
if tileCache.update then
    local _tZ=pcall(tileCache.update,_tW,_tX)if _tZ then
        if _tX>0 then _tW.flown=nil
            if typeof(_tW.frame)=="Instance"then pcall(function()_tW.frame.Visible=not _tW.culled end)end
        end
    return
end
end _tW.n=_tX
if _tX>0 then _tW.flown=nil
    if typeof(_tW.frame)=="Instance"then pcall(function()_tW.frame.Visible=not _tW.culled end)end else
    local _ua=table.find(_tY,_tW)if _ua then table.remove(_tY,_ua)end
    if typeof(_tW.frame)=="Instance"then pcall(function()_tW.frame:Destroy()end)end
end
end
function tileCache.waitNearDrops(_ub)local _uc=tileCache.list
    if not _uc then
        return
    end task.wait(0.15)local _ud=os.clock()while os.clock()-_ud<(_ub or 0.45)and isAlive()do
    local _ue=_hg()if not _ue or not _ue.x then
        return
    end
local _uf=false
for k_ug,v_uh in ipairs(_uc)do
    if type(v_uh)=="table"and type(v_uh.x)=="number"and(v_uh.n or 0)>0 and v_uh.armed~=false and math.abs(v_uh.x-_ue.x)<0.6 and v_uh.y+0.3>_ue.y-0.95 and v_uh.y-0.3<_ue.y then
        local _ui=true
        if v_uh.id~=112 and modules.Inv and type(modules.Inv.room)=="function"then
            local _uj,_uk=pcall(function()return modules.Inv:room(v_uh.id)end)if _uj and type(_uk)=="number"and _uk<=0 then _ui=false
            end
    end
if _ui then _uf=true;break
end
end
end
if not _uf then
    return
end task.wait()end
end
function tileCache.waitSpawn(_ul)if not tileCache.list and tileCache.findRefs then tileCache.findRefs()end
    local _um=0.1 pcall(function()_um=localPlayer:GetNetworkPing()end)local _un=math.clamp(0.15+2.5*_um,0.25,0.85)local _uo=nil
    for k_up,v_uq in ipairs(_ul)do
        local _ur=tileCache.brokeAt[v_uq.x..","..v_uq.y]if _ur and os.clock()-_ur<_un and(not _uo or _ur>_uo)then _uo=_ur
        end
end
if not _uo then
    return
end
local _us=tileCache.list
while os.clock()-_uo<_un and isAlive()do
    if _us then
        for k_ut,v_uu in ipairs(_us)do
            if type(v_uu)=="table"and type(v_uu.x)=="number"and(_uu.born or 0)>=_uo-0.2 then
                for k_uv,v_uw in ipairs(_ul)do
                    if _tO(v_uw,v_uu.x,v_uu.y)then task.wait(0.05)return
                    end
            end
    end
end
end task.wait()end
end
local function _ux(_uy)local _uz=getWorldMod()local _uA=_uz and rawget(_uz,"takeDrop")if type(_uA)~="function"and not remote_TakeDrop then
        return false
    end
local _uB=os.clock()if not _tS(_uy,_uB)then
    return false
end
local _uC=_uy.n
if _uy.id~=112 and modules.Inv and type(modules.Inv.room)=="function"then
    local _uD,_uE=pcall(function()return modules.Inv:room(_uy.id)end)if _uD and type(_uE)=="number"then _uC=math.min(_uC,_uE)end
end
if _uC<=0 then
    if _uy.uid then inputHooks[_uy.uid]=_uB+1
    end
local _uF=webhookSvc.LastFull[_uy.id]if not _uF or _uB-_uF>120 then webhookSvc.LastFull[_uy.id]=_uB webhookSvc.Send("full","Inventori penuh: ".._gt(_uy.id).." tidak bisa diambil lagi")end
return false
end _uy.taking=true
if typeof(_uy.frame)=="Instance"then pcall(function()_uy.frame.Visible=false end)end
local _uG,_uH
if type(_uA)=="function"then _uG,_uH=pcall(_uA,_uy.uid,_uC)else _uG,_uH=pcall(remote_TakeDrop.InvokeServer,remote_TakeDrop,_uy.uid,_uC)end _uy.taking=false
if not(_uG and type(_uH)=="number"and _uH>0)then modAutoPlace.stats.fail=modAutoPlace.stats.fail+1 _uy.refused=os.clock()_uy.failN=(_uy.failN or 0)+1
    if _uy.uid then inputHooks[_uy.uid]=os.clock()+math.min(8,_uy.failN)end _uy.flown=nil
    if typeof(_uy.frame)=="Instance"then pcall(function()_uy.frame.Visible=not _uy.culled end)end
    return false
end
if _uy.uid then inputHooks[_uy.uid]=nil
end
if _uy.id==112 then
    if modules.Gems and type(modules.Gems.addGems)=="function"then pcall(modules.Gems.addGems,_uH)end elseif modules.Inv and type(modules.Inv.add)=="function"then pcall(function()modules.Inv:add(_uy.id,_uH)end)end tileCache.applyTaken(_uy,math.max(0,(_uy.n or 0)-_uH))sessionStats.Collected=sessionStats.Collected+_uH sessionStats.Items[_uy.id]=(sessionStats.Items[_uy.id]or 0)+_uH modAutoPlace.stats.picked=modAutoPlace.stats.picked+_uH
    if modBreak.on then modBreak.stats.picked=modBreak.stats.picked+_uH
    end
if modTrees.on then modTrees.stats.picked=modTrees.stats.picked+_uH
end
if modDirt.on then modDirt.stats.picked=modDirt.stats.picked+_uH
end
return true
end
function tileCache.walkToX(_uI,_uJ)local _uK=_hg()if not _uK or _uK.dead then
        return false
    end
if math.abs(_uI-_uK.x)<=0.18 and math.abs(_uK.vx or 0)<2.0 then _cO()return true
end inputState.active=true
local _uL=0.14
local _uM=os.clock()while isAlive()and(modAutoPlace.on or modAutoPlace.Override~=nil or modTrees.on or modFarm.on or modFarm.traveling or modGems.on)and(os.clock()-_uM)<(_uJ or 1.6)do
    local _uN=_hg()if not _uN or _uN.dead then break
    end
local _uO=_uI-_uN.x
local _uP=_uN.vx or 0
local _uQ=_uN.grounded and 48 or 17
local _uR=0
if math.abs(_uO)>_uL then _uR=(_uO>0)and 1 or-1
    if _uP*_uR>0 and(_uP*_uP)/(2*_uQ)>=math.abs(_uO)-_uL*0.5 then _uR=0
    end
end inputState.left=(_uR<0)inputState.right=(_uR>0)if math.abs(_uO)<=0.18 and _uN.grounded and math.abs(_uP)<2.2 then _cO()return true
end task.wait()end _cO()return false
end
function tileCache.touchAll(_uS,_uT,_uU)if type(_uS)~="table"or#_uS==0 then
        return false
    end
local _uV=getWorldMod()if not _uV then
    return false
end
local _uW,_uX=_uT,_uT
local _uY={}for k_uZ,v_va in ipairs(_uS)do
    if not modClick.SolidAt(v_va.x,v_va.y)then
        if v_va.y==_uU and math.abs(v_va.x-_uT)<=3 then
            if v_va.x<_uW then _uW=v_va.x
            end
        if v_va.x>_uX then _uX=v_va.x
        end elseif v_va.y<_uU and math.abs(v_va.x-_uT)<=2 then
        if not _uY[v_va.x]or v_va.y<_uY[v_va.x]then _uY[v_va.x]=v_va.y
        end
end
end
end
local _vb=inputState.active inputState.active=true tileCache.collecting=true _uV.speedScale=1
local function _vc(_vd)_cO()local _ve=(_vd<=_uU-2)inputState.jump=true
    local _vf=os.clock()local _vg=false
    while isAlive()and(modAutoPlace.on or modAutoPlace.Override~=nil)and(os.clock()-_vf)<1.1
    do
        local _vh=_hg()if not _vh or _vh.dead then break
        end
    if not _vh.grounded then _vg=true
        if not _ve or _vh.y<=(_vd+0.6)or(_vh.vy or 0)>=0 then inputState.jump=false
        end
end
if _vg and _vh.grounded then break
end
if not _vg and(os.clock()-_vf)>0.32 then break
end task.wait()end _cO()end pcall(function()if _uW<_uT then tileCache.walkToX(_uW+0.5,1.5)if _uY[_uW]then _vc(_uY[_uW])_uY[_uW]=nil else task.wait(0.06)end
end
if _uX>_uT then tileCache.walkToX(_uX+0.5,1.8)if _uY[_uX]then _vc(_uY[_uX])_uY[_uX]=nil else task.wait(0.06)end
end
for k_vi,v_vj in pairs(_uY)do
    if not isAlive()or not(modAutoPlace.on or modAutoPlace.Override~=nil)then break
    end tileCache.walkToX(k_vi+0.5,1.4)_vc(v_vj)end
if isAlive()and(modAutoPlace.on or modAutoPlace.Override~=nil)then tileCache.walkToX(_uT+0.5,1.6)end end)_cO()tileCache.collecting=false
if config.walkSpeed~=100 and modules.World then modules.World.speedScale=config.walkSpeed/100
end inputState.active=_vb
return true
end
local _vk=0 trackConn(svc_RunSvc.Heartbeat:Connect(function()if not isAlive()then
        return
    end
if modGems and modGems.pauseCollect then
    return
end
local _vl=(modAutoPlace.Override and modAutoPlace.Override.offsets)or config.farmGrid
local _vm=(modAutoPlace.on and config.farmTake)or(modAutoPlace.Override~=nil)local _vn=config.collectAround or(modBreak.on and config.clearTake)or(modTrees.on and config.harvestTake)or(modDirt.on and config.dfTake)or _te.on or modFarm.on or(session.Rotation and session.Rotation.on)if not _vm and not _vn then
    return
end
local _vo=os.clock()if _vo<(tileCache.nextTick or 0)then
    return
end tileCache.nextTick=_vo+((config.collectMode=="Remote")and 0.1 or 0.2)local _vp=tileCache.list
if not _vp then
    if _vo>=_vk then _vk=_vo+5
        if tileCache.findRefs then tileCache.findRefs()else modules.Scan()end
    end
return
end
local _vq=_hg()if not _vq or type(_vq.x)~="number"then
    return
end
local _vr,_vs=_vq.x,_vq.y-0.475
if config.collectMode~="Remote"then
    local _vt={}for k_vu,v_vv in ipairs(_vp)do
        if type(v_vv)=="table"and type(v_vv.x)=="number"and math.abs(v_vv.x-_vr)<=1.5 and math.abs(v_vv.y-_vs)<=1.5 then _vt[v_vv]=v_vv.n or 0
        end
end
for k_vw,v_vx in pairs(tileCache.seen or{})do
    if _vt[k_vw]==nil and not table.find(_vp,k_vw)and k_vw.id and v_vx>0 then sessionStats.Collected=sessionStats.Collected+v_vx sessionStats.Items[k_vw.id]=(sessionStats.Items[k_vw.id]or 0)+v_vx modAutoPlace.stats.picked=modAutoPlace.stats.picked+v_vx
        if modBreak.on then modBreak.stats.picked=modBreak.stats.picked+v_vx
        end
    if modTrees.on then modTrees.stats.picked=modTrees.stats.picked+v_vx
    end
if modDirt.on then modDirt.stats.picked=modDirt.stats.picked+v_vx
end
end
end tileCache.seen=_vt
return
end if#_vp==0 then
return
end
local _vy,_vz=math.floor(_vr),math.floor(_vs)local _vA=(tonumber(config.collectRadius)or 3)+0.25
local _vB=modFarm.Zone
if _vB and _vB.world~=_hy()then _vB=nil
end
for _vC=#_vp,1,-1
do
    local _vD=_vp[_vC]if _tS(_vD,_vo)and not(_vB and math.abs(_vD.x-_vB.x)<=2.5 and math.abs(_vD.y-_vB.y)<=2.5)then
        local _vE=_vn and math.abs(_vD.x-_vr)<=_vA and math.abs(_vD.y-_vs)<=_vA
        if not _vE and _vm then
            for k_vF,v_vG in pairs(_vl)do
                if v_vG then
                    local _vH,_vI=tostring(k_vF):match("^(-?%d+),(-?%d+)$")if _vH and _vI then
                        local _vJ,_vK=_vy+tonumber(_vH),_vz+tonumber(_vI)if _tO({x=_vJ,y=_vK},_vD.x,_vD.y)then _vE=true break
                        end
                end
        end
end
end
if _vE then task.spawn(_ux,_vD)end
end
end end))end)()end
local _vL,_vM,_vN do(function()local _vO={{1,0},{-1,0},{0,1},{0,-1},{1,1},{1,-1},{-1,1},{-1,-1}}local _vP=0
        local function _vQ(_vR)if not _vR or not config.farmFastBreak then
                return
            end pcall(function()for k_vS,v_vT in pairs(_vR)do
                local _vU=string.lower(tostring(k_vS))if string.find(_vU,"punch",1,true)and(string.find(_vU,"ready",1,true)or string.find(_vU,"lock",1,true)or string.find(_vU,"cd",1,true)or string.find(_vU,"cool",1,true)or string.find(_vU,"gate",1,true)or string.find(_vU,"wait",1,true))then
                    if type(v_vT)=="boolean"then _vR[k_vS]=false elseif type(v_vT)=="number"then _vR[_vS]=0
                        end
                end
        end end)end
local function _vV(_vW)_vW=tonumber(_vW)or 0.20
    if not config.farmDynamicDelay then
        return math.max(0.04,_vW)end
    local _vX=math.clamp((tonumber(config.farmDynamicJitterMs)or 45)/1000,0.01,0.12)local _vY=(math.random(-1000,1000)/1000)*_vX
    local _vZ=math.max(0.05,_vW+_vY)if math.abs(_vZ-_vP)<0.008 then _vZ=math.max(0.05,_vZ+((_vY>=0)and 0.015 or-0.012))end _vP=_vZ
    return _vZ
end
local function _wa()local _wb=getWorldMod()local _wc=_wb and rawget(_wb,"raymanOn")if type(_wc)~="function"then
        return false
    end
local _wd,_we=pcall(_wc)return _wd and _we==true
end
local function _wf(_wg,_wh,_wi)local _wj={}for k_wk,v_wl in ipairs(_wi)do _wj[v_wl.x..","..v_wl.y]=v_wl
    end
local _wm,_wn=nil,nil
for k_wo,v_wp in ipairs(_vO)do
    local _wq={}for _wr=1,3
    do
        local _ws=_wj[(_wg+v_wp[1]*_wr)..","..(_wh+v_wp[2]*_wr)]if _ws then _wq[#_wq+1]=_ws
        end
end if#_wq>=2 and#_wq>(_wm and#_wm or 0)then _wm,_wn=_wq,v_wp
end
end
return _wm,_wn
end
local function _wt(_wu)local _wv=_hg()if not _wv or not _wv.x then
        return
    end
if _bb and type(_bc)=="table"and _bc.act then pcall(_bc.act.send,{kind=4,x=_wv.x+_wu[1],y=_wv.y-0.475+_wu[2]})end
end
local function _ww()local _wx=(modAutoPlace.Override and modAutoPlace.Override.offsets)or config.farmGrid
    local _wy={}for k_wz,_wA in pairs(_wx)do
        if v_wA then
            local _wB,_wC=tostring(k_wz):match("^(-?%d+),(-?%d+)$")_wB,_wC=tonumber(_wB),tonumber(_wC)if _wB and _wC and not(_wB==0 and _wC==0)then table.insert(_wy,{dx=_wB,dy=_wC})end
        end
end table.sort(_wy,function(_wD,_wE)if _wD.dy~=_wE.dy then
    return _wD.dy<_wE.dy
end
return _wD.dx<_wE.dx end)return _wy
end
local function _wF(_wG,_wH,_wI)local _wJ=placeTile(_wG,"fg",_wH,_wI)if _wJ==nil then
        return false
    end
if _wJ~=0 then
    return _iw(_wJ,_wH,_wI)end
local _wK=placeTile(_wG,"bg",_wH,_wI)return config.farmBreakBg and _wK~=nil and _wK~=0 and _iw(_wK,_wH,_wI)end
local function _wL(_wM)local _wN=tostring(_wM or""):gsub("%s","")local _wO,_wP=string.match(_wN,"^([^:]*):(.+)$")if not _wO then _wO=_wN
    end _wO=string.upper(_wO):gsub("[^A-Z0-9]","")if _wP==""then _wP=nil
end
return _wO,_wP
end
local function _wQ(_wR,_wS)_wR=trim(_wR):upper()if _wR==""then
        return true
    end
if _hy():upper()==_wR and not _wS then
    return true
end
if _sw then pcall(_sw)end
if _hy()~=""then
    local _wT=modules.Menu
    if _wT and type(rawget(_wT,"openPicker"))=="function"then pcall(_wT.openPicker)else
        local _wU=getWorldMod()if _wU and type(rawget(_wU,"call"))=="function"then pcall(_wU.call,"LeaveWorld")end
    end task.wait(1.8)end
local _wV=getWorldMod()if _wS and _wV then rawset(_wV,"arriveDoor",_wS)end
local _wW=_wV and rawget(_wV,"fg")local _wX=modules.Menu
if _wX and type(rawget(_wX,"enter"))=="function"then pcall(_wX.enter,_wR)elseif _wV and type(rawget(_wV,"enter"))=="function"then pcall(_wV.enter,_wR)else
        return false
    end
local _wY=os.clock()while isAlive()and(os.clock()-_wY)<12
do
    local _wZ=getWorldMod()if _wZ and rawget(_wZ,"fg")~=_wW and _hy():upper()==_wR then modules.Scan(true)task.wait(1.2)return true
    end task.wait(0.25)end
return false
end
local function _xa(_xb)if not tileCache.list and tileCache.findRefs then tileCache.findRefs()end
    local _xc=tileCache.list
    if type(_xc)~="table"then
        return nil
    end
local _xd,_xe=_hv()_xd,_xe=_xd or 50,_xe or 30
local _xf,_xg=nil,math.huge
for k_xh,v_xi in ipairs(_xc)do
    if type(v_xi)=="table"and v_xi.id==_xb and(v_xi.n or 0)>0 and not v_xi.display and type(v_xi.x)=="number"then
        local _xj=math.abs(v_xi.x-_xd)+math.abs(v_xi.y-_xe)if _xj<_xg then _xf,_xg=v_xi,_xj
        end
end
end
return _xf
end
local function _xk(_xl,_xm,_xn)local function _xo()return modAutoPlace.on and modAutoPlace.token==_xn and isAlive()end
    local _xp,_xq=_wL(config.farmRefillWorld)local _xr=_xm.world
    local _xs=(_xp~=""and _xp:upper()~=_xr:upper())or(_xq~=nil)modFarm.traveling=true
    if _xs then modAutoPlace.stats.status="Refill: Warping to ".._xp..(_xq and(":".._xq)or"").."..."if not _wQ(_xp,_xq)then modFarm.traveling=false
            return false
        end
end modules.Scan()if tileCache.findRefs then tileCache.findRefs()end task.wait(0.6)while _xo()and getWorldPos(_xl)<200
do
    local _xt=_xa(_xl)if not _xt then break
    end
local _xu,_xv=math.floor(_xt.x),math.floor(_xt.y)modAutoPlace.stats.status=string.format("Refill: Taking %s at (%d,%d) [%d/200]",_gt(_xl),_xu,_xv,getWorldPos(_xl))modClick.To(_xu,_xv,function()return not _xo()end,0.35,false)if tileCache.walkToX then
    local _xw=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_xt.x,1.0)tileCache.collecting=false inputState.active=_xw
end
local _xx=getWorldMod()local _xy=_xx and rawget(_xx,"takeDrop")if type(_xy)=="function"and _xt.uid then
    local _xz=200-getWorldPos(_xl)if _xz>0 then pcall(_xy,_xt.uid,math.min(_xt.n or 1,_xz))end
end task.wait(0.35)end
if _hy():upper()~=_xr:upper()and _xo()then modAutoPlace.stats.status="Refill: Returning to ".._xr.."..."if not _wQ(_xr,nil)and _xo()then task.wait(3)_wQ(_xr,nil)end
end modFarm.traveling=false
if _xo()and _hy():upper()==_xr:upper()then modAutoPlace.stats.status=string.format("Refill: Walking back to (%d,%d)...",_xm.x,_xm.y)modClick.To(_xm.x,_xm.y,function()return not _xo()end,0.25,false)if tileCache.walkToX then
        local _xA=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_xm.x+0.5,1.2)tileCache.collecting=false inputState.active=_xA
    end
end
return getWorldPos(_xl)>0
end
local function _xB(_xC,_xD)local _xE=0
    while modAutoPlace.on and modAutoPlace.token==_xC and isAlive()do
        local _xF=getWorldMod()if not _xF or _hy()~=_xD.world then modAutoPlace.stats.status="World changed, stopped"break
        end
    local _xG=(modAutoPlace.Override and modAutoPlace.Override.mode)or config.farmMode
    local _xH=_xG~="Break saja"local _xI=_xG~="Place saja"local _xJ=(modAutoPlace.Override and modAutoPlace.Override.block)or config.farmPlaceId
    local function _xK()if modAutoPlace.Override or not config.farmAutoDropSeed then
            return false
        end
    local _xL=isSeedItem(itemId)and _xJ or _gF(_xJ)if not _xL then
        return false
    end
local _xM=tonumber(config.farmSeedDropAt)or 200
local _xN=(_xM>=196)and 195 or math.max(1,_xM)local _xO=getWorldPos(_xL)if _xO>=_xN then
    local _xP=math.max(0,tonumber(config.farmSeedKeep)or 0)local _xQ=_xO-_xP
    if _xQ>0 and modFarm and type(modFarm.ExternalDropSeed)=="function"then
        local _xR=trim(config.farmDropWorld or"")local _xS,_xT=tonumber(config.farmDropX)or-1,tonumber(config.farmDropY)or-1
        if _xR==""and(_xS<0 or _xT<0)then _xS=math.clamp(_xD.x+((_xD.x>=4)and-2 or 2),1,_xF.w-2)_xT=_xD.y
        end modAutoPlace.stats.status=string.format("Auto Drop Seed %s x%d...",_gt(_xL),_xQ)modFarm.ExternalDropSeed(_xL,_xQ,_xR,_xS,_xT,_xD.world,_xD.x,_xD.y,function()return modAutoPlace.on and modAutoPlace.token==_xC and isAlive()end)return true
end
end
return false
end
if _xK()then _xF=getWorldMod()if not _xF then break
    end
end
local _xU=_ww()if#_xU==0 then modAutoPlace.stats.status="Select tiles in 5x5 Grid first"if not modAutoPlace.Quiet then notify("Auto Farm: Select at least 1 tile in the 5x5 Grid.")end break
end
local _xV=_hg()local _xW,_xX=_hv()if not _xW then break
end
local _xY=(_xX~=_xD.y)or(not _xV)or(math.abs(_xV.x-(_xD.x+0.5))>0.38)if not modAutoPlace.Override and _xY then
    if _xX==_xD.y and math.abs(_xW-_xD.x)<=4 and tileCache.walkToX then
        local _xZ=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_xD.x+0.5,1.5)tileCache.collecting=false inputState.active=_xZ else modClick.To(_xD.x,_xD.y,function()return modAutoPlace.token~=_xC end,0.2,false)end _xW,_xX=_xD.x,_xD.y
end
local _ya={}for k_yb,v_yc in ipairs(_xU)do
    local _yd,_ye=_xD.x+v_yc.dx,_xD.y+v_yc.dy
    if _hJ(_xF,_yd,_ye)then table.insert(_ya,{x=_yd,y=_ye})end
end
local _yf,_yg=false,false
if _xH then modAutoPlace.stats.status="Placing ".._gt(_xJ)local _yh=_hO(_xJ)for k_yi,v_yj in ipairs(_ya)do
        if not modAutoPlace.on or modAutoPlace.token~=_xC then break
        end
    local _yk=placeTile(_xF,"fg",v_yj.x,v_yj.y)local _yl=placeTile(_xF,_yh,v_yj.x,v_yj.y)if _yl==0 and(_yh=="bg"or _yk==0)then
        if getWorldPos(_xJ)<=0 then _yg=true break
        end
    if _ij(_xJ,v_yj,_xD.facing)then modAutoPlace.stats.placed=modAutoPlace.stats.placed+(1)_yf=true task.wait(_vV(config.farmPlaceMs/1000))end
end
end
end
if not modAutoPlace.on or modAutoPlace.token~=_xC then break
end
local _ym={}local _yn={}if _xI then modAutoPlace.stats.status="Breaking ("..(_wa()and "Rayman"or("Multi "..config.farmMultiTarget))..")"local _yo=math.clamp(math.floor(config.farmMultiTarget or 1),1,5)local _yp,_yq=1,{}while modAutoPlace.on and modAutoPlace.token==_xC and isAlive()do while#_yq<_yo and _yp<=#_ya
        do
            local _yr=_ya[_yp]_yp=_yp+(1)if _wF(_xF,_yr.x,_yr.y)then _yq[#_yq+1]={x=_yr.x,y=_yr.y,n=0}local _ys=_yr.x..",".._yr.y
                if not _yn[_ys]then _yn[_ys]=true table.insert(_ym,{x=_yr.x,y=_yr.y})end
            end
    end if#_yq==0 then break
end
local _yt,_yu=nil,nil
if _yo>1 and _wa()then _yt,_yu=_wf(_xD.x,_xD.y,_yq)end
if not _yu then _yt={_yq[1]}end
local _yv=os.clock()if _yu then _wt(_yu)end
local _yw,_yx=false,false
for k_yy,v_yz in ipairs(_yt)do
    if not modAutoPlace.on or modAutoPlace.token~=_xC then break
    end
if k_yy>1 then task.wait(0.05)end _vQ(_xF)local _yA=_iE(v_yz.x,v_yz.y,config.farmBreakBg)v_yz.n=v_yz.n+(1)if _yA then _yw,_yf=true,true
end
if _yA=="broke"then modAutoPlace.stats.broken=modAutoPlace.stats.broken+(1)_yx=true
end
if _yA==nil or v_yz.n>80 or not _wF(_xF,v_yz.x,v_yz.y)then v_yz.done=true
end v_yz.used=true
end
local _yB={}for k_yC,v_yD in ipairs(_yq)do
    if not v_yD.done and not v_yD.used then _yB[#_yB+1]=v_yD
    end
end
for k_yE,v_yF in ipairs(_yt)do v_yF.used=nil
    if not v_yF.done then _yB[#_yB+1]=v_yF
    end
end _yq=_yB
if _yw then
    local _yG=_vV(config.farmDelay)if _yu then _yG=math.max(_yG,0.35)end
    if config.farmFastBreak then
        local _yH=(_xE>0 and _xE or _yv)+_yG
        local _yI=os.clock()if _yH<_yI-_yG then _yH=_yI
        end _xE=_yH
    local _yJ=_yH-_yI
    if _yJ>0.002 then task.wait(_yJ)end else
    local _yK=_yG-(os.clock()-_yv)if _yK>0.005 then task.wait(_yK)end
end
end
if _yx and not config.farmFastBreak and#_yq>0 and config.farmAfterBreakMs>0 then task.wait(config.farmAfterBreakMs/1000)end
end
end if#_ym>0 and(config.farmTake or modAutoPlace.Override)and config.collectMode=="Legit"then modAutoPlace.stats.status="Collecting drops..."task.wait(0.18)if tileCache.touchAll then tileCache.touchAll(_ym,_xD.x,_xD.y)end task.wait(0.15)end
if _xK()then _xF=getWorldMod()if not _xF then break
    end
end
if _xH and not modAutoPlace.Override and getWorldPos(_xJ)<=0 then
    if config.farmAutoRefill then
        if _xk(_xJ,_xD,_xC)then _xF=getWorldMod()_yf=true _yg=false else _yg=true
        end else _yg=true
end
end
if not _yf then
    if _yg then modAutoPlace.stats.status=_gt(_xJ).." depleted"if not modAutoPlace.Quiet then notify("Auto Farm stopped: ".._gt(_xJ).." is out of stock.")webhookSvc.Send("stop","Auto Farm stopped: ".._gt(_xJ).." depleted")end break
    end task.wait(_vV(config.farmDelay))end modAutoPlace.stats.cycles=modAutoPlace.stats.cycles+(1)end
end _vN=_xB _vM=function()if not modAutoPlace.on then
    return false
end modAutoPlace.token=modAutoPlace.token+1 modAutoPlace.on=false _cO()inputState.active=false modAutoPlace.stats.status="Idle"if _sY then pcall(_sY)end
return true
end _vL=function()if modAutoPlace.on then
    return true
end
if modBreak.on then modBreak.Stop()end
if modTrees.on then modTrees.Stop()end
if modDirt.on then modDirt.Stop()end
if _te.on then _te.Stop()end
if modFarm.on then modFarm.Stop()end
if session.Rotation and session.Rotation.on then session.Rotation.Stop()end
local _yL=config.farmMode~="Break saja"if _yL and(type(config.farmPlaceId)~="number"or config.farmPlaceId<=0)then notify("Select a Farm Block ID first in the Auto Farm tab.")return false
end
local _yM,_yN,_yO=_hj()if not _yM then notify("Character position not detected.")return false
end
local _yP={x=math.floor(_yM),y=math.floor(_yN-0.475),facing=_yO,world=_hy(),}modAutoPlace.Override=nil modAutoPlace.Quiet=false modAutoPlace.token=modAutoPlace.token+(1)local _yQ=modAutoPlace.token modAutoPlace.on=true modAutoPlace.stats.status="Running"if _sY then pcall(_sY)end task.spawn(function()local _yR,_yS=pcall(_xB,_yQ,_yP)_cO()inputState.active=false
    if not _yR then warn("[ANCHHub] Auto Farm error: "..tostring(_yS))end
    if modAutoPlace.token==_yQ then modAutoPlace.on=false
        if modAutoPlace.stats.status=="Running"then modAutoPlace.stats.status="Idle"end
        if _sY then pcall(_sY)end
        if _sV then _sV()end
    end end)return true
end end)()end do(function()local _yT=5.5
local function _yU(_yV,_yW,_yX)local _yY=placeTile(_yV,"fg",_yW,_yX)if _yY==nil then
        return nil
    end
if _yY~=0 then
    if _iw(_yY,_yW,_yX)then
        return "fg",_yY
    end
return nil
end
if config.clearIncludeBg then
    local _yZ=placeTile(_yV,"bg",_yW,_yX)if _yZ and _yZ~=0 and _iw(_yZ,_yW,_yX)then
        return "bg",_yZ
    end
end
return nil
end
local function _za(_zb,_zc,_zd)if not _hJ(_zb,_zc,_zd)then
        return false
    end
if not modClick.OpenAt(_zc,_zd)then
    return false
end
if _zd+1>=_zb.h then
    return false
end
if modClick.HazardAt and modClick.HazardAt(_zc,_zd+1)then
    return false
end
return modClick.RealSupport(_zc,_zd)end
local function _ze(_zf,_zg)for _zh=0,_zf.h-1
    do
        local _zi={}for _zj=0,_zf.w-1
        do
            local _zk,_zl=_yU(_zf,_zj,_zh)if _zk then
                local _zm=_zj..",".._zh
                if not _zg[_zm]then table.insert(_zi,{x=_zj,y=_zh,id=_zl,layer=_zk,key=_zm})end
            end
    end if#_zi>0 then
    return _zh,_zi
end
end
return nil,{}end
local function _zn(_zo,_zp,_zq,_zr)local _zs=(_zr==1)and 1 or-1
    local _zt=-_zs
    local _zu={{x=_zp+_zs,y=_zq},{x=_zp+_zt,y=_zq},{x=_zp+_zs*2,y=_zq},{x=_zp+_zt*2,y=_zq},{x=_zp+_zs,y=_zq-1},{x=_zp+_zt,y=_zq-1},{x=_zp,y=_zq-1},}local _zv={}for k_zw,v_zx in ipairs(_zu)do
        if _za(_zo,v_zx.x,v_zx.y)then table.insert(_zv,v_zx)end
    end
return _zv
end
local function _zy(_zz,_zA,_zB,_zC)local _zD,_zE=_yU(_zz,_zA,_zB)if not _zD then
        return true
    end
local _zF=os.clock()local _zG=_hR()-0.1
while not _zC()do
    local _zH,_zI=_yU(_zz,_zA,_zB)if not _zH then task.wait(0.06)_zH,_zI=_yU(_zz,_zA,_zB)if not _zH then
            return true
        end
end
if _zH~=_zD or _zI~=_zE then _zD,_zE=_zH,_zI _zF=os.clock()end if(os.clock()-_zF)>=_yT then
    return false,"timeout"end
local _zJ=_hg()if not _zJ or not modClick.StateReaches(_zJ,_zA,_zB,_zG+0.35)then
    return false,"out_of_range"end modBreak.status=string.format("Breaking %s (%d,%d)",_gt(_zI),_zA,_zB)local _zK=_iE(_zA,_zB,config.clearIncludeBg)if _zK==nil then
    return false,"unbreakable"elseif _zK=="broke"then modBreak.stats.broken=modBreak.stats.broken+(1)_zF=os.clock()end task.wait(math.max(0.04,config.clearBreakDelay))end
return false,"cancelled"end
local function _zL(_zM,_zN,_zO,_zP,_zQ)_iW("autoclear",false)if _zM and not _iO then _zM.ghost=false
    end
local _zR=_hR()-0.15
local _zS=_hg()local _zT,_zU=_hv()if _zS and _zT and _zU and modClick.StateReaches(_zS,_zN,_zO,_zR)and _za(_zM,_zT,_zU)and not(_zT==_zN and _zU==_zO-1 and modClick.OpenAt(_zN+_zP,_zO)and _za(_zM,_zN+_zP,_zO))then
    return true
end
local _zV=os.clock()while not _zQ()and(os.clock()-_zV)<0.5
do
    local _zW=_hg()if _zW and _zW.grounded then break
    end task.wait(0.03)end
local _zX=_zn(_zM,_zN,_zO,_zP)for k_zY,v_zZ in ipairs(_zX)do
    if _zQ()then
        return false
    end
if modClick.LegitTo(v_zZ.x,v_zZ.y,_zQ,0.35,true)then
    local _Aa=_hg()if _Aa and modClick.StateReaches(_Aa,_zN,_zO,_zR+0.3)then
        return true
    end
end
end
if modClick.LegitTo(_zN,_zO,_zQ,math.max(1.8,_zR),true)then
    local _Ab=_hg()if _Ab and modClick.StateReaches(_Ab,_zN,_zO,_zR+0.3)then
        return true
    end
end
return false
end
local function _Ac(_Ad,_Ae)_iW("autoclear",false)_cO()inputState.active=false
    local _Af={}local _Ag={}local _Ah=0
    local _Ai=1
    while modBreak.on and modBreak.token==_Ad and isAlive()do
        local _Aj=getWorldMod()if not _Aj or _hy()~=_Ae.world then modBreak.status="World changed, stopped"break
        end
    if not _iO then _Aj.ghost=false
    end
local _Ak=function()return not modBreak.on or modBreak.token~=_Ad or not isAlive()end
local _Al,_Am=_ze(_Aj,_Af)if not _Al then
    if next(_Af)~=nil and _Ah<3 then _Ah=_Ah+(1)table.clear(_Af)table.clear(modClick.BadEdge)task.wait(0.5)continue
    end break
end modBreak.stats.row=_Al modBreak.stats.scanned=#_Am modBreak.stats.left=#_Am
local _An=_hv()if config.clearSweep=="Zig-zag"and _An then
    local _Ao,_Ap=_Am[1].x,_Am[#_Am].x
    for k_Aq,v_Ar in ipairs(_Am)do
        if v_Ar.x<_Ao then _Ao=v_Ar.x
        end
    if _Ar.x>_Ap then _Ap=_Ar.x
    end
end _Ai=(math.abs(_An-_Ap)<math.abs(_An-_Ao))and-1 or 1 else _Ai=1
end
if _Ai==-1 then table.sort(_Am,function(_As,_At)return _As.x>_At.x end)else table.sort(_Am,function(_Au,_Av)return _Au.x<_Av.x end)end
local _Aw=_Am[1]if _Aw and _yU(_Aj,_Aw.x,_Aw.y)then modBreak.status=string.format("Opening edge pocket at (%d,%d)...",_Aw.x,_Aw.y)if _zL(_Aj,_Aw.x,_Aw.y,-_Ai,_Ak)then _zy(_Aj,_Aw.x,_Aw.y,_Ak)if _hJ(_Aj,_Aw.x,_Aw.y+1)and modClick.HazardAt(_Aw.x,_Aw.y+1)and _yU(_Aj,_Aw.x,_Aw.y+1)then modBreak.status=string.format("Clearing Lava below edge (%d,%d)...",_Aw.x,_Aw.y+1)if _zL(_Aj,_Aw.x,_Aw.y+1,-_Ai,_Ak)then _zy(_Aj,_Aw.x,_Aw.y+1,_Ak)end
        end
end
end
for k_Ax,v_Ay in ipairs(_Am)do
    if _Ak()then
        return
    end _Aj=getWorldMod()if not _Aj or _hy()~=_Ae.world then
    return
end
if _yU(_Aj,v_Ay.x,v_Ay.y)then
    if _hJ(_Aj,v_Ay.x,v_Ay.y+1)and modClick.HazardAt(v_Ay.x,v_Ay.y+1)and _yU(_Aj,v_Ay.x,v_Ay.y+1)then
        if _zL(_Aj,_Ay.x,_Ay.y+1,-_Ai,_Ak)then _zy(_Aj,v_Ay.x,v_Ay.y+1,_Ak)end
    end modBreak.status=string.format("Walking beside (%d,%d) [%d/%d]",v_Ay.x,v_Ay.y,k_Ax,#_Am)local _Az=_zL(_Aj,v_Ay.x,v_Ay.y,-_Ai,_Ak)if _Az then
    local _AA,_AB=_zy(_Aj,v_Ay.x,v_Ay.y,_Ak)if not _AA and _AB=="out_of_range"and _yU(_Aj,v_Ay.x,v_Ay.y)then
        if _zL(_Aj,v_Ay.x,v_Ay.y,-_Ai,_Ak)then _AA,_AB=_zy(_Aj,_Ay.x,_Ay.y,_Ak)end
    end
if _AA or not _yU(_Aj,v_Ay.x,v_Ay.y)then modBreak.stats.left=math.max(0,modBreak.stats.left-1)else _Af[v_Ay.key]=true modBreak.stats.skipped=modBreak.stats.skipped+(1)modBreak.status=string.format("Skipped (%d,%d) [%s]",v_Ay.x,_Ay.y,tostring(_AB))end else _Ag[v_Ay.key]=(_Ag[v_Ay.key]or 0)+1
if _Ag[v_Ay.key]>=2 then _Af[v_Ay.key]=true modBreak.stats.skipped=modBreak.stats.skipped+(1)end
end else modBreak.stats.left=math.max(0,modBreak.stats.left-1)end
end
end _iW("autoclear",false)_cO()inputState.active=false modBreak.status="Completed"local _AC=string.format("Auto Clear finished! Broken: %d | Collected: %d | Skipped: %d",modBreak.stats.broken,modBreak.stats.picked,modBreak.stats.skipped)notify(_AC)webhookSvc.Send("stop",_AC)end
function modBreak.Stop()if not modBreak.on then
        return false
    end modBreak.token=modBreak.token+(1)modBreak.on=false _iW("autoclear",false)_cO()inputState.active=false modBreak.status="Idle"return true
end
function modBreak.Start()if modBreak.on then
        return true
    end
if modAutoPlace.on then _vM()end
if modTrees.on then modTrees.Stop()end
if modDirt.on then modDirt.Stop()end
if _te.on then _te.Stop()end
if modFarm.on then modFarm.Stop()end
if session.Rotation and session.Rotation.on then session.Rotation.Stop()end
local _AD,_AE=_hj()if not _AD then notify("Character position not detected.");return false
end
local _AF={x=math.floor(_AD),y=math.floor(_AE-0.475),world=_hy()}modBreak.token=modBreak.token+(1)local _AG=modBreak.token modBreak.on=true modBreak.status="Starting"modBreak.stats={scanned=0,broken=0,picked=0,skipped=0,left=0,pass=1,row=-1}task.spawn(function()local _AH,_AI=pcall(_Ac,_AG,_AF)if not _AH then warn("[ANCHHub] Auto Clear error: "..tostring(_AI))end _iW("autoclear",false)_cO()inputState.active=false
    if modBreak.token==_AG then modBreak.on=false
        if modBreak.status~="Completed"then modBreak.status="Idle"end
        if _sV then _sV()end
    end end)return true
end end)()end do(function()local _AJ={}local function _AK(_AL,_AM,_AN,_AO)local _AP=trim(config.harvestSaveWorld or"")local _AQ=tonumber(config.harvestSaveX)or-1
    local _AR=tonumber(config.harvestSaveY)or-1
    if _AP==""and(_AQ<0 or _AR<0)then if(tonumber(config.pabrikDropX)or-1)>=0 and(tonumber(config.pabrikDropY)or-1)>=0 then _AP=trim(config.pabrikDropWorld or"")_AQ,_AR=tonumber(config.pabrikDropX),tonumber(config.pabrikDropY)elseif(tonumber(config.farmDropX)or-1)>=0 and(tonumber(config.farmDropY)or-1)>=0 then _AP=trim(config.farmDropWorld or"")_AQ,_AR=tonumber(config.farmDropX),tonumber(config.farmDropY)elseif type(config.pos1)=="table"and type(config.pos1.x)=="number"and type(config.pos1.y)=="number"then _AP=trim(config.pos1.world or"")_AQ,_AR=config.pos1.x,config.pos1.y else _AQ,_AR=_AM,_AN
                end
        end
    return _AP,_AQ,_AR
end
local function _AS(_AT,_AU,_AV,_AW,_AX)local function _AY()return modTrees.on and modTrees.token==_AX and isAlive()end
    local _AZ=getWorldPos(_AT)if _AZ<=0 then
        return false
    end
local _Ba=getWorldMod()local _Bb,_Bc,_Bd=_AK(_AU.world,_AU.x,_AU.y,_Ba)modTrees.status=string.format("Tas Block penuh (%d)! Menuju pos simpan (%d,%d)...",_AZ,_Bc,_Bd)notify(string.format("Auto Harvest: Menyimpan %s x%d ke (%d,%d)...",_gt(_AT),_AZ,_Bc,_Bd),"Farmer ANCH",4)modGems.pauseCollect=true
local _Be=config.harvestTake config.harvestTake=false
if modFarm and type(modFarm.ExternalDropSeed)=="function"then modFarm.ExternalDropSeed(_AT,_AZ,_Bb,_Bc,_Bd,_AU.world,_AV,_AW,_AY)end config.harvestTake=_Be modGems.pauseCollect=false modTrees.status="Selesai simpan block, melanjutkan panen..."return true
end
local function _Bf(_Bg)if not tileCache.list and tileCache.findRefs then tileCache.findRefs()end
    local _Bh=tileCache.list
    if type(_Bh)~="table"then
        return nil
    end
local _Bi,_Bj=_hv()_Bi,_Bj=_Bi or 50,_Bj or 30
local _Bk=os.clock()local _Bl=modFarm.Zone
if _Bl and _Bl.world~=_hy()then _Bl=nil
end
local _Bm,_Bn=nil,math.huge
for k_Bo,v_Bp in ipairs(_Bh)do
    if type(v_Bp)=="table"and v_Bp.id==_Bg and(v_Bp.n or 0)>0 and not v_Bp.display and type(v_Bp.x)=="number"then
        local _Bq=v_Bp.uid or(math.floor(v_Bp.x)..","..math.floor(v_Bp.y))local _Br=_AJ[_Bq]local _Bs,_Bt=math.floor(v_Bp.x),math.floor(v_Bp.y)if not(_Br and _Bk<_Br)and not modClick.SolidAt(_Bs,_Bt)then
            local _Bu=math.abs(_Bp.x-_Bi)+math.abs(_Bp.y-_Bj)if _Bu<_Bn then _Bm,_Bn=v_Bp,_Bu
            end
    end
end
end
return _Bm
end
local function _Bv(_Bw,_Bx)local function _By()return modTrees.on and modTrees.token==_Bx and isAlive()end
    local _Bz=false
    local _BA={}local _BB=os.clock()while _By()and getWorldPos(_Bw)<200 and(os.clock()-_BB)<40
    do
        local _BC=_Bf(_Bw)if not _BC then break
        end
    local _BD=_BC.uid or(math.floor(_BC.x)..","..math.floor(_BC.y))_BA[_BD]=(_BA[_BD]or 0)+1
    if _BA[_BD]>2 then _AJ[_BD]=os.clock()+45 continue
    end
local _BE,_BF=math.floor(_BC.x),math.floor(_BC.y)local _BG=getWorldPos(_Bw)modTrees.status=string.format("Seed habis! Mengambil drop %s di (%d,%d) [%d/200]...",_gt(_Bw),_BE,_BF,_BG)local _BH=modClick.To(_BE,_BF,function()return not _By()end,0.4,config.harvestUseBlock)if _BH and tileCache.walkToX then
    local _BI=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_BC.x,0.9)tileCache.collecting=false inputState.active=_BI
end
local _BJ=getWorldMod()local _BK=_BJ and rawget(_BJ,"takeDrop")if type(_BK)=="function"and _BC.uid then
    local _BL=200-getWorldPos(_Bw)if _BL>0 then pcall(_BK,_BC.uid,math.min(_BC.n or 1,_BL))end
end task.wait(0.35)if getWorldPos(_Bw)>_BG then _Bz=true _AJ[_BD]=nil elseif not _BH then _AJ[_BD]=os.clock()+45
end
end
return _Bz or getWorldPos(_Bw)>0
end
local function _BM(_BN,_BO)if config.harvestModFly then _iW("autoharvest",true)end table.clear(_AJ)local _BP={}local _BQ=0
    local _BR=tonumber(config.harvestSeedId)or 3
    local _BS=_gK(_BR)while modTrees.on and modTrees.token==_BN and isAlive()do _BQ=_BQ+(1)local _BT=getWorldMod()if not _BT or _hy()~=_BO.world then modTrees.status="World berubah, berhenti"break
        end _BR=tonumber(config.harvestSeedId)or 3 _BS=_gK(_BR)if config.harvestDoHarvest and config.harvestAutoSaveBlock and _BS and getWorldPos(_BS)>=200 then
        local _BU,_BV=_hv()_AS(_BS,_BO,_BU or _BO.x,_BV or _BO.y,_BN)if not modTrees.on or modTrees.token~=_BN then break
        end _BT=getWorldMod()if not _BT then break
    end
end
if config.harvestDoPlant and getWorldPos(_BR)<=0 and config.harvestAutoTakeSeed~=false then
    if _Bf(_BR)then _Bv(_BR,_BN)_BT=getWorldMod()if not _BT then break
        end
end
end modTrees.status="Scan pohon & lahan tanam..."local _BW={}local _BX={}local _BY=0
local _BZ=0
local _Ca=(getWorldPos(_BR)>0)or(config.harvestAutoTakeSeed~=false and _Bf(_BR)~=nil)local _Cb=config.harvestDoPlant and _BR and _Ca
local _Cc=1
for _Cd=0,_BT.h-1
do
    local _Ce,_Cf={},{}for _Cg=0,_BT.w-1
    do
        local _Ch=placeTile(_BT,"fg",_Cg,_Cd)or 0
        if _Ch~=0 and _Ch==_BR then _BY=_BY+1
            if config.harvestDoHarvest and not _BP[_Cg..",".._Cd]then
                if _ty(_BT,_Cg,_Cd,_Ch)then table.insert(_Ce,{x=_Cg,y=_Cd,id=_Ch})else _BZ=_BZ+1
                end
        end elseif _Cb and _Ch==0 and _tE(_BT,_Cg,_Cd,_BR)then table.insert(_Cf,{x=_Cg,y=_Cd})end
end if#_Ce>0 or#_Cf>0 then
if _Cc==-1 then table.sort(_Ce,function(_Ci,_Cj)return _Ci.x>_Cj.x end)table.sort(_Cf,function(_Ck,_Cl)return _Ck.x>_Cl.x end)else table.sort(_Ce,function(_Cm,_Cn)return _Cm.x<_Cn.x end)table.sort(_Cf,function(_Co,_Cp)return _Co.x<_Cp.x end)end
for k_Cq,v_Cr in ipairs(_Ce)do table.insert(_BW,v_Cr)end
for k_Cs,v_Ct in ipairs(_Cf)do table.insert(_BX,v_Ct)end _Cc=-_Cc
end
end modTrees.stats.totalTrees=_BY modTrees.stats.ready=#_BW
if _BQ==1 then modTrees.stats.skipped=_BZ
    if config.harvestDoHarvest and#_BW==0 then notify(string.format(("Tidak ada pohon %s yang siap panen terdeteksi! (Total pohon: %d,".." Belum siap: %d)"),_gt(_BR),_BY,_BZ),"Auto Harvest",5)else notify(string.format(("Farmer Scan (%s): %d siap panen, %d belum siap | %d lahan kosong".."."),_gt(_BR),#_BW,_BZ,#_BX),"Farmer ANCH",4)end
end if#_BW==0 and#_BX==0 then break
end
local _Cu=false
local _Cv=math.min(_hR(),_hV())-0.15
for k_Cw,v_Cx in ipairs(_BW)do
    if not modTrees.on or modTrees.token~=_BN or not isAlive()then
        return
    end _BT=getWorldMod()if not _BT or _hy()~=_BO.world then
    return
end
if config.harvestAutoSaveBlock and _BS and getWorldPos(_BS)>=200 then _AS(_BS,_BO,v_Cx.x,v_Cx.y,_BN)if not modTrees.on or modTrees.token~=_BN then
        return
    end _BT=getWorldMod()if not _BT then
    return
end
end
if placeTile(_BT,"fg",v_Cx.x,v_Cx.y)==v_Cx.id then
    local _Cy=_hg()if not(_Cy and modClick.StateReaches(_Cy,_Cx.x,v_Cx.y,_Cv))then modTrees.status=string.format("Jalan ke pohon (%d,%d) [%d/%d | Block: %d/200]",v_Cx.x,v_Cx.y,k_Cw,#_BW,_BS and getWorldPos(_BS)or 0)local _Cz=modClick.To(v_Cx.x,v_Cx.y,function()return modTrees.token~=_BN or not modTrees.on end,_Cv,config.harvestUseBlock)if not _Cz then _BP[v_Cx.x..","..v_Cx.y]=true modTrees.stats.skipped=modTrees.stats.skipped+1
        end task.wait(math.max(0.08,config.harvestTpDelay))end
local _CA=_hg()if _CA and modClick.StateReaches(_CA,v_Cx.x,v_Cx.y,_Cv+0.5)then modTrees.status=string.format("Panen %s (%d,%d) [%d/%d]",_gt(v_Cx.id),v_Cx.x,v_Cx.y,k_Cw,#_BW)local _CB=os.clock()while modTrees.on and modTrees.token==_BN and placeTile(_BT,"fg",v_Cx.x,v_Cx.y)==v_Cx.id and os.clock()-_CB<3.5
    do _iE(v_Cx.x,v_Cx.y,false)task.wait(math.max(0.05,config.harvestDelay))end
    if placeTile(_BT,"fg",v_Cx.x,v_Cx.y)~=v_Cx.id then _Cu=true modTrees.stats.harvested=modTrees.stats.harvested+1 sessionStats.Harvested=sessionStats.Harvested+1 modTrees.stats.ready=math.max(0,modTrees.stats.ready-1)if config.harvestTake then task.wait(0.14)local _CC,_CD=_hv()if config.collectMode=="Legit"and _CC and _CD==v_Cx.y and math.abs(_CC-v_Cx.x)<=3 and not modClick.SolidAt(v_Cx.x,v_Cx.y)and tileCache.walkToX then
                local _CE=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(v_Cx.x+0.5,0.9)tileCache.collecting=false inputState.active=_CE
                if tileCache.waitNearDrops then tileCache.waitNearDrops(0.25)end else task.wait(0.15)end
        end
    if config.harvestDoPlant and _BR then
        if getWorldPos(_BR)<=0 and config.harvestAutoTakeSeed~=false then _Bv(_BR,_BN)end
        if getWorldPos(_BR)>0 and _tE(_BT,v_Cx.x,v_Cx.y,_BR)then task.wait(0.06)if _ij(_BR,{x=v_Cx.x,y=v_Cx.y},1)then modTrees.stats.planted=modTrees.stats.planted+1 sessionStats.Planted=sessionStats.Planted+1 task.wait(math.max(0.05,config.harvestPlantDelay))end
        end
end
if config.harvestAutoSaveBlock and _BS and getWorldPos(_BS)>=200 then _AS(_BS,_BO,v_Cx.x,v_Cx.y,_BN)if not modTrees.on or modTrees.token~=_BN then
        return
    end _BT=getWorldMod()end else _BP[v_Cx.x..","..v_Cx.y]=true modTrees.stats.skipped=modTrees.stats.skipped+1
end
end
end
end
if config.harvestDoPlant and _BR and#_BX>0 then
    for k_CF,v_CG in ipairs(_BX)do
        if not modTrees.on or modTrees.token~=_BN or not isAlive()then
            return
        end
    if getWorldPos(_BR)<=0 then
        if config.harvestAutoTakeSeed~=false and _Bf(_BR)then
            if not _Bv(_BR,_BN)then notify("Auto Plant: ".._gt(_BR).." habis & drop tidak terjangkau!","Auto Plant",4)break
            end else notify("Auto Plant berhenti: ".._gt(_BR).." di tas dan di world sudah habis!","Auto Plant",4)break
    end
end _BT=getWorldMod()if not _BT or _hy()~=_BO.world then
return
end
if _tE(_BT,v_CG.x,v_CG.y,_BR)then
    local _CH=_hg()if not(_CH and modClick.StateReaches(_CH,v_CG.x,v_CG.y,_Cv))then modTrees.status=string.format("Jalan ke tanam (%d,%d) [%d/%d | Seed: %d]",v_CG.x,v_CG.y,k_CF,#_BX,getWorldPos(_BR))modClick.To(_CG.x,_CG.y,function()return modTrees.token~=_BN or not modTrees.on end,_Cv,config.harvestUseBlock)task.wait(math.max(0.08,config.harvestTpDelay))end
    local _CI=_hg()if _CI and modClick.StateReaches(_CI,v_CG.x,v_CG.y,_Cv+0.5)and _tE(_BT,v_CG.x,v_CG.y,_BR)then
        if _ij(_BR,v_CG,1)then _Cu=true modTrees.stats.planted=modTrees.stats.planted+1 sessionStats.Planted=sessionStats.Planted+1 modTrees.status=string.format("Tanam %s (%d,%d) [Sisa: %d]",_gt(_BR),v_CG.x,v_CG.y,getWorldPos(_BR))task.wait(math.max(0.05,config.harvestPlantDelay))end
    end
end
end
end
if not _Cu then break
end
end modGems.pauseCollect=false _iW("autoharvest",false)_cO()inputState.active=false modTrees.status="Selesai"local _CJ=string.format("Farmer selesai! Panen: %d | Tanam: %d | Drop diambil: %d",modTrees.stats.harvested,modTrees.stats.planted,modTrees.stats.picked)notify(_CJ)webhookSvc.Send("stop",_CJ)end
function modTrees.Stop()if not modTrees.on then
        return false
    end modTrees.token=modTrees.token+(1)modTrees.on=false modGems.pauseCollect=false _iW("autoharvest",false)_cO()inputState.active=false modTrees.status="Mati"return true
end
function modTrees.Start()if modTrees.on then
        return true
    end
if modAutoPlace.on then _vM()end
if modBreak.on then modBreak.Stop()end
if modDirt.on then modDirt.Stop()end
if _te.on then _te.Stop()end
if modFarm.on then modFarm.Stop()end
if session.Rotation and session.Rotation.on then session.Rotation.Stop()end
local _CK,_CL=_hj()if not _CK then notify("Posisi belum terdeteksi.");return false
end
local _CM={x=math.floor(_CK),y=math.floor(_CL-0.475),world=_hy()}modTrees.token=modTrees.token+(1)local _CN=modTrees.token modTrees.on=true modTrees.status="Mulai"modTrees.stats={totalTrees=0,ready=0,harvested=0,planted=0,skipped=0,picked=0}task.spawn(function()local _CO,_CP=pcall(_BM,_CN,_CM)if not _CO then warn("[ANCHHub] Farmer error: "..tostring(_CP))end modGems.pauseCollect=false _iW("autoharvest",false)_cO()inputState.active=false
    if modTrees.token==_CN then modTrees.on=false
        if modTrees.status~="Selesai"then modTrees.status="Mati"end
        if _sV then _sV()end
    end end)return true
end end)()end do(function()local _CQ=6.5
local _CR={}local function _CS(_CT)if _CT==8 then
        return true
    end
local _CU=itemDB and itemDB[_CT]return type(_CU)=="table"and type(_CU.name)=="string"and _CU.name:lower():find("bedrock",1,true)~=nil
end
local function _CV()local _CW=0.10 pcall(function()_CW=localPlayer:GetNetworkPing()end)return math.clamp(0.12+(_CW*2.2),0.14,0.55)end
local function _CX(_CY,_CZ)return((_CY-_CZ)%2)==0
end
local function _Da(_Db)local _Dc=nil
    for _Dd=0,_Db.h-1
    do
        for _De=0,_Db.w-1
        do if(placeTile(_Db,"fg",_De,_Dd)or 0)==6 then _Dc=_Dd break
            end
    end
if _Dc then break
end
end
if not _Dc and typeof(_Db.spawn)=="Vector2"then _Dc=math.floor(_Db.spawn.Y)end
local _Df=_Dc and(_Dc+1)or nil
if not _Df then
    for _Dg=10,_Db.h-8
    do
        local _Dh=0
        for _Di=0,_Db.w-1
        do
            local _Dj=placeTile(_Db,"fg",_Di,_Dg)or 0
            local _Dk=placeTile(_Db,"bg",_Di,_Dg)or 0 if(_Dj~=0 or _Dk~=0)and not _CS(_Dj)then _Dh=_Dh+(1)end
        end
    if _Dh>=math.floor(_Db.w*0.5)then _Df=_Dg break
    end
end
end _Df=_Df or 37
local _Dl=nil
for _Dm=_Df+1,_Db.h-1
do
    local _Dn=0
    for _Do=0,_Db.w-1
    do
        if _CS(placeTile(_Db,"fg",_Do,_Dm)or 0)then _Dn=_Dn+(1)end
    end
if _Dn>=math.floor(_Db.w*0.4)then _Dl=_Dm break
end
end _Dl=_Dl or(_Db.h-6)return _Df,_Dl
end
local function _Dp(_Dq,_Dr,_Ds,_Dt)if not _hJ(_Dq,_Dr,_Ds)then
        return false
    end
if _CR[_Dr..",".._Ds]then
    return false
end
local _Du=placeTile(_Dq,"fg",_Dr,_Ds)or 0
if _Du~=0 and _iw(_Du,_Dr,_Ds)then
    return true
end
if _Dt~=false then
    local _Dv=placeTile(_Dq,"bg",_Dr,_Ds)or 0
    if _Dv~=0 and _iw(_Dv,_Dr,_Ds)then
        return true
    end
end
return false
end
local function _Dw(_Dx,_Dy,_Dz)if not _Dx or not _Dx.x or not _Dx.y then
        return false
    end return(_Dy+1>_Dx.x-0.30)and(_Dy<_Dx.x+0.30)and(_Dz+1>_Dx.y-0.95)and(_Dz<_Dx.y)end
local function _DA(_DB,_DC)local _DD=_hg()if not _DD or not _DD.x or not _DD.y then
        return false
    end
local _DE=_hV()-0.05
return math.abs((_DB+0.5)-_DD.x)<=_DE and math.abs((_DC+0.5)-(_DD.y-0.475))<=_DE
end
local function _DF(_DG,_DH)local _DI=_hg()if not _DI or not _DI.x or not _DI.y then
        return false
    end
local _DJ=_hR()-0.05
return math.abs((_DG+0.5)-_DI.x)<=_DJ and math.abs((_DH+0.5)-(_DI.y-0.475))<=_DJ
end
local function _DK(_DL,_DM,_DN)local _DO=_hg()if not _DO or _DO.dead then
        return false
    end
if math.abs(_DL-_DO.x)<=0.16 and math.abs(_DO.vx or 0)<2.0 then _cO()return true
end
local _DP=inputState.active
local _DQ=tileCache.collecting inputState.active=true tileCache.collecting=true
if modules.World then modules.World.speedScale=1
end
local _DR=0.14
local _DS=os.clock()local _DT=false
while not _DN()and(os.clock()-_DS)<(_DM or 1.5)do
    local _DU=_hg()if not _DU or _DU.dead then break
    end
local _DV=_DL-_DU.x
local _DW=_DU.vx or 0
local _DX=_DU.grounded and 48 or 17
local _DY=0
if math.abs(_DV)>_DR then _DY=(_DV>0)and 1 or-1
    if _DW*_DY>0 and(_DW*_DW)/(2*_DX)>=math.abs(_DV)-_DR*0.5 then _DY=0
    end
end inputState.left=(_DY<0)inputState.right=(_DY>0)if math.abs(_DV)<=0.16 and _DU.grounded and math.abs(_DW)<2.0 then _DT=true break
end task.wait()end _cO()tileCache.collecting=_DQ
if config.walkSpeed~=100 and modules.World and not _DQ then modules.World.speedScale=config.walkSpeed/100
end inputState.active=_DP
return _DT
end
local function _DZ(_Ea,_Eb,_Ec,_Ed)local _Ee=_hg()if not _Ee or not _DA(_Eb,_Ec)or _Dw(_Ee,_Eb,_Ec)then
        return false
    end
if _ij(_Ea,{x=_Eb,y=_Ec},_Ed or 1)then modDirt.stats.placed=modDirt.stats.placed+(1)return true
end
return false
end
local _Ef
local _Eg
local _Eh
local function _Ei(_Ej,_Ek,_El,_Em)if not _hJ(_Ej,_Ek,_El)then
        return true
    end
local _En=tonumber(config.dfPlatformId)or 102
local _Eo=placeTile(_Ej,"fg",_Ek,_El)or 0
if _Eo==0 or(config.dfUsePlatform and _Eo==_En)then
    return true
end
if not _iw(_Eo,_Ek,_El)then
    return false
end _ip(_Ek,_El)local _Ep=os.clock()while not _Em()and(os.clock()-_Ep)<4.5
do _Ej=getWorldMod()if not _Ej then
        return false
    end
local _Eq=placeTile(_Ej,"fg",_Ek,_El)or 0
if _Eq==0 then task.wait(_CV())if(placeTile(_Ej,"fg",_Ek,_El)or 0)==0 then
        return true
    end
end
if not _DF(_Ek,_El)then
    return false
end
local _Er=_iE(_Ek,_El,false)if _Er=="broke"then modDirt.stats.broken=modDirt.stats.broken+(1)end task.wait(math.max(0.04,config.dfBreakDelay))end return(placeTile(_Ej,"fg",_Ek,_El)or 0)==0
end
local function _Es(_Et,_Eu,_Ev,_Ew,_Ex,_Ey)local _Ez=function()return modDirt.token~=_Ey or not modDirt.on or not isAlive()end
    local _EA,_EB=_hv()if not _EA or _EB~=_Ev then
        return false
    end
if _EA==_Eu then
    local _EC=_hg()if _EC and _EC.grounded and math.abs(_EC.x-(_Eu+0.5))<=0.25 then
        return true
    end
return _DK(_Eu+0.5,0.8,_Ez)end
local _ED=_gQ()local _EE=(_Eu>=_EA)and 1 or-1
for _EF=_EA,_Eu,_EE
do
    if _Ez()then
        return false
    end _Et=getWorldMod()if not _Et then
    return false
end
local _EG,_EH=_hv()if not _EG or _EH~=_Ev then
    return false
end
if _EF~=_EG and not _CX(_Ev,_Ew)and not modClick.OpenAt(_EF,_Ev)then
    local _EI=placeTile(_Et,"fg",_EF,_Ev)or 0
    if _EI~=0 and _iw(_EI,_EF,_Ev)then
        local _EJ=_EF-_EE _DK(_EJ+0.5,1.0,_Ez)_Ei(_Et,_EF,_Ev,_Ez)end
end
local _EK=_Ev+1
if _EF>=2 and _EF<=(_Et.w-3)and _CX(_EK,_Ew)and _hJ(_Et,_EF,_EK)and not modClick.RealSupport(_EF,_Ev)then
    local _EL=(_EF==_EG)and _EG or(_EF-_EE)_DK(_EL+0.5,1.0,_Ez)local _EM=placeTile(_Et,"fg",_EF,_EK)or 0
    if _EM~=0 and modClick.HazardAt(_EF,_EK)and _iw(_EM,_EF,_EK)then _Ei(_Et,_EF,_EK,_Ez)end if(placeTile(_Et,"fg",_EF,_EK)or 0)==0 then
        if getWorldPos(_ED)<=0 and _Ef then _Ef(_Et,_EL,_Ev,_Ew,_Ew,_Ex,_Ey)end
        if getWorldPos(_ED)>0 then _DZ(_ED,_EF,_EK,_EE)task.wait(math.max(WALK_SPEED_FAST,_CV()))end
    end
end
end
if modClick.ExecWalk(_Eu,_Ev,_Ez)then _DK(_Eu+0.5,0.6,_Ez)return true
end
return _DK(_Eu+0.5,1.5,_Ez)end
local function _EN(_EO,_EP,_EQ,_ER,_ES,_ET)local _EU=function()return modDirt.token~=_ET or not modDirt.on or not isAlive()end
    local _EV,_EW=_hv()if not _EV or not _EW then
        return false
    end
if _EW<=_EQ then
    return true
end
if config.moveMethod=="Teleport Mode"or config.dfModFly then _iW("autodf",true)local _EX=modClick.FlyTo(_EP,_EQ,_EU,config.dfTpDelay,false)_iW("autodf",false)return _EX
end
local _EY=_EO.w
local _EZ=_gQ()if _EW==(_EQ+1)and _EV>=2 and _EV<=(_EY-3)and _CX(_EW,_ER)and(placeTile(_EO,"fg",_EV,_EW)or 0)==0 then
    if getWorldPos(_EZ)>0 then _DK(_EV+0.5,0.5,_EU)modClick.ExecPillar({fx=_EV,fy=_EW,x=_EV,y=_EQ},_EU)task.wait(math.max(WALK_SPEED_FAST,_CV()))local _Fa,_Fb=_hv()if _Fb==_EQ then
            return _Es(_EO,_EP,_EQ,_ER,_ES,_ET)end
    end
end
if modClick.LegitTo(_EP,_EQ,_EU,0.4,false)then
    local _Fc,_Fd=_hv()if _Fd==_EQ then
        return true
    end
end
local _Fe=(math.abs(_EV-1)<=math.abs(_EV-(_EY-2)))local _Ff=_Fe and 1 or(_EY-2)local _Fg=_Fe and 2 or(_EY-3)local _Fh=math.max(5,(_EW-_EQ)+3)if getWorldPos(_EZ)<_Fh and _Ef then _Ef(_EO,nil,nil,_ER,_ER,_ES,_ET)end _EV,_EW=_hv()if not _EV then
    return false
end
if _EV~=_Ff then
    if _EV>=2 and _EV<=(_EY-3)and _CX(_EW,_ER)and(placeTile(_EO,"fg",_EV,_EW)or 0)==0 and getWorldPos(_EZ)>0 then modClick.ExecPillar({fx=_EV,fy=_EW,x=_EV,y=_EW-1},_EU)task.wait(math.max(WALK_SPEED_FAST,_CV()))_EV,_EW=_hv()end
    if _EV and _EW and _EV~=_Ff then _Es(_EO,_Fg,_EW,_ER,_ES,_ET)_EV,_EW=_hv()if _EV==_Fg then
            if _hJ(_EO,_Ff,_EW+1)and not modClick.RealSupport(_Ff,_EW)and getWorldPos(_EZ)>0 then _DZ(_EZ,_Ff,_EW+1,(_Ff>_Fg)and 1 or-1)task.wait(math.max(WALK_SPEED_FAST,_CV()))end
            if _Dp(_EO,_Ff,_EW,false)then _Ei(_EO,_Ff,_EW,_EU)end _DK(_Ff+0.5,1.2,_EU)task.wait(0.12)end
    end
end _EV,_EW=_hv()if not _EV then
return false
end
local _Fi=_EV
local _Fj=(_Fi<=1)and 2 or((_Fi>=_EY-2)and(_EY-3)or((_Fi<_EY/2)and(_Fi+1)or(_Fi-1)))local _Fk=(_Fi<=1 or _Fi>=_EY-2)local _Fl={}if _Fk and _hJ(_EO,_Fi,_EW+1)and not _CS(placeTile(_EO,"fg",_Fi,_EW+1)or 0)then _Fl[_EW+1]=true
end
local _Fm=_EW
local _Fn=0
while _Fm>_EQ and not _EU()do _EO=getWorldMod()if not _EO then break
    end
local _Fo=_Fm+2
if _hJ(_EO,_Fi,_Fo)and(_Fl[_Fo]or(_Fk and not _CS(placeTile(_EO,"fg",_Fi,_Fo)or 0)))then if(placeTile(_EO,"fg",_Fi,_Fo)or 0)~=0 then modDirt.status=string.format("Cleaning climb block (%d,%d)...",_Fi,_Fo)_Ei(_EO,_Fi,_Fo,_EU)end _Fl[_Fo]=nil
end
local _Fp=_Fm-1
if _Fk and _Dp(_EO,_Fi,_Fp,false)then _Ei(_EO,_Fi,_Fp,_EU)end _DK(_Fi+0.5,0.5,_EU)local _Fq=((placeTile(_EO,"fg",_Fi,_Fm)or 0)==0)local _Fr=modClick.ExecPillar({fx=_Fi,fy=_Fm,x=_Fi,y=_Fp},_EU)task.wait(math.max(WALK_SPEED_FAST,_CV()))local _Fs=(not _Fk)and _CX(_Fm,_ER)if(_Fq or _Fr or(placeTile(_EO,"fg",_Fi,_Fm)or 0)==_EZ)and not _Fs then _Fl[_Fm]=true
end
local _Ft,_Fu=_hv()if _Fu and _Fu<_Fm then _Fm=_Fu _Fn=0
    local _Fv=_Fm+2
    if _hJ(_EO,_Fi,_Fv)and(_Fl[_Fv]or(_Fk and not _CS(placeTile(_EO,"fg",_Fi,_Fv)or 0)))then if(placeTile(_EO,"fg",_Fi,_Fv)or 0)~=0 then _Ei(_EO,_Fi,_Fv,_EU)end _Fl[_Fv]=nil
    end else _Fn=_Fn+(1)if _Fn>=3 then break
end
end
end _EO=getWorldMod()if _EO and not _EU()then
if _Dp(_EO,_Fj,_EQ,false)and not _CX(_EQ,_ER)then _Ei(_EO,_Fj,_EQ,_EU)end
if _hJ(_EO,_Fj,_EQ+1)and(placeTile(_EO,"fg",_Fj,_EQ+1)or 0)==0 and getWorldPos(_EZ)>0 then _DZ(_EZ,_Fj,_EQ+1,(_Fj>_Fi)and 1 or-1)task.wait(math.max(WALK_SPEED_FAST,_CV()))end _DK(_Fj+0.5,1.2,_EU)task.wait(0.15)local _Fw,_Fx=_hv()if _Fw==_Fj and _Fx==_EQ then
    for _Fy=math.max(0,_EQ),math.min(_ES-1,_EQ+2)do
        if _EU()then break
        end
    local _Fz=(not _Fk)and _CX(_Fy,_ER)if not _Fz and(_Fl[_Fy]or _Fk)and(placeTile(_EO,"fg",_Fi,_Fy)or 0)~=0 then modDirt.status=string.format("Cleaning last scaffold (%d,%d)...",_Fi,_Fy)_Ei(_EO,_Fi,_Fy,_EU)end
end
end
local _FA=tonumber(config.dfPlatformId)or 102
if config.dfUsePlatform and _Fk and _CX(_EQ+1,_ER)and getWorldPos(_FA)>0 then if(placeTile(_EO,"fg",_Fi,_EQ+1)or 0)==0 then _DZ(_FA,_Fi,_EQ+1,(_Fi<_Fj)and-1 or 1)task.wait(math.max(WALK_SPEED_FAST,_CV()))end
end
end
return _Es(_EO,_EP,_EQ,_ER,_ES,_ET)end
local function _FB(_FC,_FD,_FE,_FF,_FG,_FH)local _FI=function()return modDirt.token~=_FH or not modDirt.on or not isAlive()end
    local _FJ,_FK=_hv()if not _FJ or not _FK then
        return false
    end
if _FK==_FE then
    return _Es(_FC,_FD,_FE,_FF,_FG,_FH)end
if config.moveMethod=="Teleport Mode"or config.dfModFly then _iW("autodf",true)local _FL=modClick.FlyTo(_FD,_FE,_FI,config.dfTpDelay,false)_iW("autodf",false)return _FL
end
local _FM=_FC.w
local _FN=_gQ()local _FO=tonumber(config.dfPlatformId)or 102
local _FP=(math.abs(_FD-2)<=math.abs(_FD-(_FM-3)))local _FQ=_FP and 1 or(_FM-2)local _FR=_FP and 2 or(_FM-3)local _FS=_FK
local _FT=0
while _FS<_FE and _FT<25 and not _FI()do _FT=_FT+(1)_FC=getWorldMod()if not _FC then
        return false
    end
local _FU=math.min(_FE,_FS+2)local _FV=_FS+2
local _FW=_FU+1
if getWorldPos(_FN)<3 and _Ef then _Ef(_FC,_FR,_FS,_FF,_FF,_FG,_FH)end _Es(_FC,_FR,_FS,_FF,_FG,_FH)_DK(_FR+0.5,0.8,_FI)if _FI()then
    return false
end
local _FX,_FY=_hv()if _FX~=_FR or _FY~=_FS then
    if _FY and _FY>_FE then
        return _EN(_FC,_FD,_FE,_FF,_FG,_FH)elseif _FY and _FY==_FE then break
        end task.wait(0.15)continue
end
if _hJ(_FC,_FQ,_FV)and(placeTile(_FC,"fg",_FQ,_FV)or 0)==0 then
    for _FZ=1,3
    do
        if _FI()or(placeTile(_FC,"fg",_FQ,_FV)or 0)~=0 then break
        end _DZ(_FN,_FQ,_FV,(_FQ>_FR)and 1 or-1)task.wait(math.max(WALK_SPEED_FAST,_CV()))end
end
if _hJ(_FC,_FQ,_FV)and(placeTile(_FC,"fg",_FQ,_FV)or 0)==0 then task.wait(0.2)continue
end
if _Dp(_FC,_FQ,_FS,false)then _Ei(_FC,_FQ,_FS,_FI)end
if _Dp(_FC,_FQ,_FS+1,false)then _Ei(_FC,_FQ,_FS+1,_FI)end modDirt.status=string.format("Stepping into shaft (%d,%d)...",_FQ,_FS+1)_DK(_FQ+0.5,1.4,_FI)local _Ga=os.clock()while not _FI()and(os.clock()-_Ga)<0.6
do
    local _Gb=_hg()local _Gc,_Gd=_hv()if _Gb and _Gb.grounded and _Gc==_FQ and _Gd==(_FS+1)then break
    end task.wait(0.04)end
local _Ge,_Gf=_hv()if _Ge~=_FQ or _Gf~=(_FS+1)then
    if _Gf and _Gf>=_FU then _FS=_Gf continue
    end _Ei(_FC,_FQ,_FV,_FI)continue
end
if _hJ(_FC,_FQ,_FW)and(placeTile(_FC,"fg",_FQ,_FW)or 0)==0 then
    for _Gg=1,3
    do
        if _FI()or(placeTile(_FC,"fg",_FQ,_FW)or 0)~=0 then break
        end _DZ(_FN,_FQ,_FW,1)task.wait(math.max(WALK_SPEED_FAST,_CV()))end
end
if _Dp(_FC,_FR,_FU,false)then _Ei(_FC,_FR,_FU,_FI)end
if _hJ(_FC,_FR,_FW)then
    local _Gh=placeTile(_FC,"fg",_FR,_FW)or 0
    if _Gh~=0 and modClick.HazardAt(_FR,_FW)and _iw(_Gh,_FR,_FW)then _Ei(_FC,_FR,_FW,_FI)end if(placeTile(_FC,"fg",_FR,_FW)or 0)==0 and getWorldPos(_FN)>0 then _DZ(_FN,_FR,_FW,(_FR>_FQ)and 1 or-1)task.wait(math.max(WALK_SPEED_FAST,_CV()))end
end _Ei(_FC,_FQ,_FV,_FI)local _Gi=os.clock()while not _FI()and(os.clock()-_Gi)<0.6
do
    local _Gj=_hg()local _Gk,_Gl=_hv()if _Gj and _Gj.grounded and _Gl==_FU then break
    end task.wait(0.04)end modDirt.status=string.format("Entering corridor (%d,%d)...",_FR,_FU)_DK(_FR+0.5,1.4,_FI)task.wait(0.12)local _Gm,_Gn=_hv()if _Gm==_FR and _Gn==_FU then
local _Go=config.dfUsePlatform and((placeTile(_FC,"fg",_FQ,_FW)or 0)==_FO)if not _Go and(placeTile(_FC,"fg",_FQ,_FW)or 0)~=0 then modDirt.status=string.format("Cleaning shaft catcher (%d,%d)...",_FQ,_FW)_Ei(_FC,_FQ,_FW,_FI)end if(placeTile(_FC,"fg",_FQ,_FV)or 0)~=0 and not(config.dfUsePlatform and(placeTile(_FC,"fg",_FQ,_FV)or 0)==_FO)then _Ei(_FC,_FQ,_FV,_FI)end
end
local _Gp,_Gq=_hv()if not _Gq then
    return false
end
if _Gq>_FE then
    return _EN(_FC,_FD,_FE,_FF,_FG,_FH)end _FS=_Gq
end
return _Es(_FC,_FD,_FE,_FF,_FG,_FH)end _Eg=function(_Gr,_Gs,_Gt,_Gu,_Gv,_Gw)local _Gx=function()return modDirt.token~=_Gw or not modDirt.on or not isAlive()end
for _Gy=1,4
do
    if _Gx()then
        return false
    end _Gr=getWorldMod()if not _Gr then
    return false
end
local _Gz=_hg()local _GA,_GB=_hv()if not _Gz or not _GA or _Gz.dead then task.wait(0.25)continue
end
if not _Gz.grounded and not(config.moveMethod=="Teleport Mode"or config.dfModFly)then
    local _GC=os.clock()while not _Gx()and(os.clock()-_GC)<1.2
    do
        local _GD=_hg()if _GD and _GD.grounded then break
        end task.wait(0.04)end _Gz=_hg()_GA,_GB=_hv()if not _Gz or not _GA then continue
end
end
if _GA==_Gs and _GB==_Gt and math.abs(_Gz.x-(_Gs+0.5))<=0.30 then
    return true
end
if config.moveMethod=="Teleport Mode"or config.dfModFly then _iW("autodf",true)local _GE=modClick.FlyTo(_Gs,_Gt,_Gx,config.dfTpDelay,false)_iW("autodf",false)if _GE then
        return true
    end elseif _GB==_Gt then
    if _Es(_Gr,_Gs,_Gt,_Gu,_Gv,_Gw)then
        local _GF,_GG=_hv()if _GF==_Gs and _GG==_Gt then
            return true
        end
end elseif _GB>_Gt then
if _EN(_Gr,_Gs,_Gt,_Gu,_Gv,_Gw)then
    local _GH,_GI=_hv()if _GH==_Gs and _GI==_Gt then
        return true
    end
end elseif _GB<_Gt then
if _FB(_Gr,_Gs,_Gt,_Gu,_Gv,_Gw)then
    local _GJ,_GK=_hv()if _GJ==_Gs and _GK==_Gt then
        return true
    end
end
end task.wait(0.12)end
local _GL,_GM=_hv()return(_GL==_Gs and _GM==_Gt)end _Eh=function(_GN,_GO,_GP,_GQ,_GR,_GS,_GT,_GU)if not _hJ(_GN,_GO,_GP)then
    return true
end
if not _Dp(_GN,_GO,_GP,true)then
    return true
end
local _GV=function()return modDirt.token~=_GU or not modDirt.on or not isAlive()end
local _GW=os.clock()local _GX=-1
while not _GV()do _GN=getWorldMod()if not _GN then
        return false
    end
if not _Dp(_GN,_GO,_GP,true)then task.wait(_CV())if not _Dp(_GN,_GO,_GP,true)then
        return true
    end
end
local _GY=_hg()local _GZ,_Ha=_hv()if not _GY or _Ha~=_GR or math.abs(_GY.x-(_GQ+0.5))>0.65 or not _DF(_GO,_GP)then _Eg(_GN,_GQ,_GR,_GS,_GT,_GU)_GW=os.clock()end
if not _DF(_GO,_GP)then
    return false
end
local _Hb=placeTile(_GN,"fg",_GO,_GP)or 0
local _Hc=placeTile(_GN,"bg",_GO,_GP)or 0
local _Hd=(_Hb~=0)and _Hb or _Hc
if _Hd~=_GX then _GX=_Hd _GW=os.clock()end if(os.clock()-_GW)>=_CQ then _CR[_GO..",".._GP]=true
    return false
end
local _He=_iE(_GO,_GP,true)if _He=="broke"then modDirt.stats.broken=modDirt.stats.broken+(1)_GW=os.clock()end task.wait(math.max(0.04,config.dfBreakDelay))end
return false
end
local function _Hf(_Hg,_Hh,_Hi,_Hj,_Hk,_Hl,_Hm,_Hn)if not config.dfUsePlatform then
        return
    end
local _Ho=tonumber(config.dfPlatformId)or 102
if _Ho<=0 or getWorldPos(_Ho)<=0 then
    return
end
if not _hJ(_Hg,_Hh,_Hi)then
    return
end if(placeTile(_Hg,"fg",_Hh,_Hi)or 0)==_Ho then
return
end _Eg(_Hg,_Hj,_Hk,_Hl,_Hm,_Hn)local _Hp=placeTile(_Hg,"fg",_Hh,_Hi)or 0
if _Hp~=0 and _iw(_Hp,_Hh,_Hi)then _Eh(_Hg,_Hh,_Hi,_Hj,_Hk,_Hl,_Hm,_Hn)end
for _Hq=1,3
do
    if not modDirt.on or modDirt.token~=_Hn then break
    end if(placeTile(_Hg,"fg",_Hh,_Hi)or 0)==_Ho or getWorldPos(_Ho)<=0 then break
end _Eg(_Hg,_Hj,_Hk,_Hl,_Hm,_Hn)_DZ(_Ho,_Hh,_Hi,(_Hh>=_Hj)and 1 or-1)task.wait(math.max(WALK_SPEED_FAST,_CV()))end
end
local function _Hr(_Hs,_Ht)local _Hu=tileCache.list
    if not _Hu then modules.Scan();_Hu=tileCache.list
    end
if type(_Hu)~="table"then
    return nil
end
local _Hv,_Hw=_hv()_Hv,_Hw=_Hv or 50,_Hw or 30
local _Hx,_Hy=nil,math.huge
for k_Hz,v_HA in ipairs(_Hu)do
    if type(v_HA)=="table"and(v_HA.id==_Hs or v_HA.id==_Ht)and(v_HA.n or 0)>0 and type(v_HA.x)=="number"then
        local _HB=math.abs(v_HA.x-_Hv)+math.abs(v_HA.y-_Hw)if _HB<_Hy then _Hx,_Hy=v_HA,_HB
        end
end
end
return _Hx
end
local function _HC(_HD,_HE,_HF,_HG,_HH,_HI)local _HJ=_gQ()local _HK=_gU()local _HL=_HE-1
    if _HL<0 then
        return false
    end
local _HM={}local _HN=0
for _HO=3,_HD.w-4
do
    if not modDirt.on or modDirt.token~=_HH then break
    end
if getWorldPos(_HK)<=0 or _HN>=(_HI or 20)then break
end if(placeTile(_HD,"fg",_HO,_HE)or 0)==_HJ and(placeTile(_HD,"fg",_HO,_HL)or 0)==0 then _Eg(_HD,_HO,_HL,_HF,_HG,_HH)if _ij(_HK,{x=_HO,y=_HL},1)then sessionStats.Planted=sessionStats.Planted+(1)table.insert(_HM,{x=_HO,y=_HL,plantedTime=os.clock()})_HN=_HN+(1)task.wait(0.18)end
end
end
for _HP=2,_HD.w-3
do if(placeTile(_HD,"fg",_HP,_HL)or 0)==_HK then
        local _HQ=false
        for k_HR,v_HS in ipairs(_HM)do
            if v_HS.x==_HP and _HS.y==_HL then _HQ=true;break
            end
    end
if not _HQ then table.insert(_HM,{x=_HP,y=_HL,plantedTime=os.clock()-25})end
end
end if#_HM==0 then
return false
end
local _HT=_P[_HK]local _HU=(_HT and(tonumber(_HT.grow)or tonumber(_HT.baseGrow)))or 31
for k_HV,v_HW in ipairs(_HM)do
    if not modDirt.on or modDirt.token~=_HH then
        return false
    end
while modDirt.on and modDirt.token==_HH and isAlive()do if(placeTile(_HD,"fg",v_HW.x,v_HW.y)or 0)~=_HK then break
    end
local _HX=os.clock()-v_HW.plantedTime
if _ty(_HD,v_HW.x,v_HW.y,_HK)or _HX>=(_HU+1.5)then break
end
local _HY=math.max(0,math.ceil(_HU-_HX))modDirt.status=string.format("Waiting Dirt Tree (%ds) [%d/%d]...",_HY,k_HV,#_HM)task.wait(0.5)end if(placeTile(_HD,"fg",v_HW.x,v_HW.y)or 0)==_HK then modDirt.status=string.format("Harvesting Dirt Tree (%d,%d) [%d/%d]",v_HW.x,v_HW.y,k_HV,#_HM)_Eg(_HD,v_HW.x,v_HW.y,_HF,_HG,_HH)local _HZ=os.clock()while modDirt.on and modDirt.token==_HH and(placeTile(_HD,"fg",v_HW.x,v_HW.y)or 0)==_HK and(os.clock()-_HZ)<3.5
do
    local _Ia=_iE(_HW.x,_HW.y,false)if _Ia=="broke"then sessionStats.Harvested=sessionStats.Harvested+(1)end task.wait(math.max(0.05,config.dfBreakDelay))end task.wait(_CV())end
end
return true
end
local function _Ib(_Ic,_Id,_Ie)local _If=_gQ()for _Ig=_Id,_Ie-1,2
    do
        local _Ih=0
        for _Ii=3,_Ic.w-4
        do if(placeTile(_Ic,"fg",_Ii,_Ig)or 0)==_If and(placeTile(_Ic,"fg",_Ii,_Ig-1)or 0)==0 then _Ih=_Ih+(1)if _Ih>=12 then
                    return _Ig
                end
        end
end
end
return _Id
end _Ef=function(_Ij,_Ik,_Il,_Im,_In,_Io,_Ip)local _Iq=_gQ()local _Ir=_gU()if getWorldPos(_Iq)>0 then
    return true
end modDirt.stats.step="Restock Dirt"local _Is=_Ib(_Ij,_In,_Io)while modDirt.on and modDirt.token==_Ip and isAlive()and getWorldPos(_Iq)<15
do
    if getWorldPos(_Ir)>0 then modDirt.status="Dirt empty! Planting & harvesting Dirt Seeds..."_HC(_Ij,_Is,_In,_Io,_Ip,20)if getWorldPos(_Iq)>=15 then break
        end
end
local _It=_Hr(_Iq,_Ir)if _It then
    local _Iu,_Iv=math.floor(_It.x),math.floor(_It.y)modDirt.status=string.format("Collecting Dirt/Seed drop at (%d, %d)...",_Iu,_Iv)_Eg(_Ij,_Iu,_Iv,_In,_Io,_Ip)task.wait(0.5)if getWorldPos(_Iq)>=15 then break
    end
end
if getWorldPos(_Iq)<15 and getWorldPos(_Ir)==0 then
    local _Iw=5
    local _Ix,_Iy=4,_Is-1 _Eg(_Ij,_Ix,_Iy,_In,_Io,_Ip)while modDirt.on and modDirt.token==_Ip and getWorldPos(_Ir)<4 and getWorldPos(_Iq)>0
    do if(placeTile(_Ij,"fg",_Iw,_Iy)or 0)==0 then _DZ(_Iq,_Iw,_Iy,1)task.wait(WALK_SPEED_FAST)end _Eh(_Ij,_Iw,_Iy,_Ix,_Iy,_In,_Io,_Ip)task.wait(0.2)end
    if getWorldPos(_Ir)==0 then break
    end
end
end
if _Ik and _Il then _Eg(_Ij,_Ik,_Il,_In,_Io,_Ip)end
return getWorldPos(_Iq)>0
end
local function _Iz(_IA,_IB,_IC,_ID,_IE,_IF,_IG,_IH)if not _hJ(_IA,_IB,_IC)then
        return true
    end
local _II=_gQ()local _IJ=placeTile(_IA,"fg",_IB,_IC)or 0
if _IJ==_II then
    return true
end
if _IJ~=0 and not _iw(_IJ,_IB,_IC)then
    return true
end
local _IK=function()return modDirt.token~=_IH or not modDirt.on or not _e()end
if not _Eg(_IA,_ID,_IE,_IF,_IG,_IH)then
    return false
end _DK(_ID+0.5,0.6,_IK)if not _DA(_IB,_IC)then
return false
end
if _IJ~=0 and _IJ~=_II then _Ei(_IA,_IB,_IC,_IK)end
for _IL=1,4
do
    if _IK()then
        return false
    end _IA=getWorldMod()if not _IA then
    return false
end if(placeTile(_IA,"fg",_IB,_IC)or 0)==_II then
return true
end
if getWorldPos(_II)<=0 then _Ef(_IA,_ID,_IE,_IC,_IF,_IG,_IH)end
if getWorldPos(_II)<=0 then
    return false
end
if not _Eg(_IA,_ID,_IE,_IF,_IG,_IH)then
    return false
end
local _IM=_hg()if _IM and _Dw(_IM,_IB,_IC)then _DK(_ID+0.5,0.6,_IK)end
if not _DA(_IB,_IC)then
    return false
end _DZ(_II,_IB,_IC,(_IB>=_ID)and 1 or-1)task.wait(math.max(WALK_SPEED_FAST,_CV()))if(placeTile(_IA,"fg",_IB,_IC)or 0)==_II then
return true
end
end return(placeTile(_IA,"fg",_IB,_IC)or 0)==_II
end
local function _IN(_IO,_IP,_IQ,_IR,_IS)local _IT=tonumber(config.dfPlatformId)or 102
    for _IU=_IR,_IS-1
    do
        local _IV,_IW=placeTile(_IO,"fg",_IP,_IU)or 0,placeTile(_IO,"bg",_IP,_IU)or 0
        local _IX,_IY=placeTile(_IO,"fg",_IQ,_IU)or 0,placeTile(_IO,"bg",_IQ,_IU)or 0
        if _CS(_IV)and _CS(_IX)then break
        end
    local _IZ=config.dfUsePlatform and(_IX==_IT)if(_IV~=0 and _iw(_IV,_IP,_IU))or(_IW~=0 and _iw(_IW,_IP,_IU))or(not _IZ and _IX~=0 and _iw(_IX,_IQ,_IU))or(_IY~=0 and _iw(_IY,_IQ,_IU))then
        return _IU
    end
end
return nil
end
local function _Ja(_Jb,_Jc,_Jd,_Je,_Jf,_Jg,_Jh)local _Ji=_IN(_Jb,_Jc,_Jd,_Je,_Jf)if not _Ji then modDirt.status="Vertical edge ".._Jg.." already clean, skipping..."return true
    end modDirt.stats.step="Vertical Edge ".._Jg
local _Jj=(_Jd<5)and 2 or(_Jb.w-3)local _Jk=tonumber(config.dfPlatformId)or 102
local _Jl=function()return modDirt.token~=_Jh or not modDirt.on or not isAlive()end
local _Jm=math.max(0,_Ji-1)local _Jn=modClick.RealSupport(_Jd,_Jm)and _Jd or(modClick.RealSupport(_Jc,_Jm)and _Jc or _Jj)_Eg(_Jb,_Jn,_Jm,_Je,_Jf,_Jh)for _Jo=_Ji,_Jf-1
do
    if _Jl()then
        return false
    end _Jb=getWorldMod()if not _Jb then
    return false
end
if _CS(placeTile(_Jb,"fg",_Jc,_Jo))and _CS(placeTile(_Jb,"fg",_Jd,_Jo))then break
end
local _Jp=math.max(0,_Jo-1)local _Jq=modClick.OpenAt(_Jc,_Jp)and modClick.RealSupport(_Jc,_Jp)local _Jr=modClick.OpenAt(_Jd,_Jp)and modClick.RealSupport(_Jd,_Jp)local _Js=modClick.OpenAt(_Jj,_Jp)and modClick.RealSupport(_Jj,_Jp)modDirt.status=string.format("Vertical %s: Breaking Y=%d",_Jg,_Jo)if _Jq and not _Jr then
    local _Jt=placeTile(_Jb,"fg",_Jd,_Jo)or 0
    if not(config.dfUsePlatform and _Jt==_Jk)then _Eh(_Jb,_Jd,_Jo,_Jc,_Jp,_Je,_Jf,_Jh)end
    if _Jl()then
        return false
    end _Eh(_Jb,_Jc,_Jo,_Jc,_Jp,_Je,_Jf,_Jh)else
local _Ju=_Jr and _Jd or(_Js and _Jj or(_Jq and _Jc or _Jd))if not _Jr and not _Jq and not _Js and(placeTile(_Jb,"fg",_Jd,_Jo)or 0)==0 then
    local _Jv=_gQ()if getWorldPos(_Jv)>0 and _DA(_Jd,_Jo)then _DZ(_Jv,_Jd,_Jo,1)task.wait(math.max(WALK_SPEED_FAST,_CV()))end
end _Eh(_Jb,_Jc,_Jo,_Ju,_Jp,_Je,_Jf,_Jh)if _Jl()then
return false
end
local _Jw=placeTile(_Jb,"fg",_Jd,_Jo)or 0
if not(config.dfUsePlatform and _Jw==_Jk)then _Eh(_Jb,_Jd,_Jo,_Ju,_Jp,_Je,_Jf,_Jh)end
end
if config.dfUsePlatform and _CX(_Jo,_Je)and getWorldPos(_Jk)>0 then _Hf(_Jb,_Jd,_Jo,_Jd,_Jp,_Je,_Jf,_Jh)end
end
if modDirt.on and modDirt.token==_Jh then
    local _Jx=math.max(0,_Je-1)modDirt.status=string.format("Climbing up from %s to surface...",_Jg)_EN(_Jb,_Jj,_Jx,_Je,_Jf,_Jh)end
return true
end
local function _Jy(_Jz,_JA,_JB,_JC,_JD)local _JE=_gQ()if _Dp(_Jz,_JA,_JB,true)then
        return true
    end
if _JC>=_JD then
    local _JF=placeTile(_Jz,"fg",_JA,_JC)or 0
    if config.dfReplacePlatform then
        if _JF~=_JE and(_JF==0 or _iw(_JF,_JA,_JC))and not _CR[_JA..",".._JC]then
            return true
        end else if(_JF==0 or modClick.HazardAt(_JA,_JC))and not _CR[_JA..",".._JC]then
        return true
    end
end
end
return false
end
local function _JG(_JH,_JI,_JJ)local _JK=_JI-1
    local _JL,_JM=nil,nil
    for _JN=2,_JH.w-3
    do
        if _Jy(_JH,_JN,_JI,_JK,_JJ)then
            if not _JL then _JL=_JN
            end _JM=_JN
    end
end
return _JL,_JM
end
local function _JO(_JP,_JQ)local _JR=_gQ()local _JS=_JQ-1
    local _JT,_JU=nil,nil
    for _JV=2,_JP.w-3
    do
        local _JW=placeTile(_JP,"fg",_JV,_JQ)or 0
        local _JX=(_JW~=_JR)and(_JW==0 or _iw(_JW,_JV,_JQ))and not _CR[_JV..",".._JQ]local _JY=_Dp(_JP,_JV,_JS,true)if _JX or _JY then
            if not _JT then _JT=_JV
            end _JU=_JV
    end
end
return _JT,_JU
end
local function _JZ(_Ka,_Kb)local _Kc=godOn
    if not _Kc and StartGod then pcall(StartGod)end _iW("autodf",false)table.clear(_CR)local _Kd=getWorldMod()if not _Kd then
        return
    end
local _Ke,_Kf=_Da(_Kd)modDirt.stats.topDirtY=_Ke modDirt.stats.bedrockY=_Kf notify(string.format("Auto DF Smart Resume (Surface Y=%d, Bedrock Y=%d).",_Ke,_Kf))local _Kg=_Kd.w
if not _Ja(_Kd,0,1,_Ke,_Kf,"Left (1-2)",_Ka)then
    return
end
if not modDirt.on or modDirt.token~=_Ka then
    return
end
if not _Ja(_Kd,_Kg-2,_Kg-1,_Ke,_Kf,"Right (99-100)",_Ka)then
    return
end
if not modDirt.on or modDirt.token~=_Ka then
    return
end
for _Kh=_Ke+1,_Kf-1,2
do
    if not modDirt.on or modDirt.token~=_Ka or not isAlive()then
        return
    end _Kd=getWorldMod()if not _Kd or _hy()~=_Kb.world then
    return
end
local _Ki=_Kh-1
local _Kj=_Kh-2
for _Kk=1,2
do
    if not modDirt.on or modDirt.token~=_Ka or not isAlive()then
        return
    end _Kd=getWorldMod()if not _Kd then
    return
end
local _Kl,_Km=_JG(_Kd,_Kh,_Ke)if not _Kl then
    if _Kk==1 then modDirt.status=string.format("Row Y=%d already complete, skipping...",_Kh)end break
end modDirt.stats.step=string.format("Bottom: Row Y=%d",_Kh)local _Kn=_hv()or 2
local _Ko=(math.abs(_Kn-_Kl)<=math.abs(_Kn-_Km))local _Kp=_Ko and _Kl or _Km
local _Kq=_Ko and _Km or _Kl
local _Kr=_Ko and 1 or-1
if not _Eg(_Kd,_Kp,_Kj,_Ke,_Kf,_Ka)then break
end
if config.dfUsePlatform and _Ki>=_Ke then
    if _Kp<=3 then _Hf(_Kd,1,_Ki,2,_Kj,_Ke,_Kf,_Ka)elseif _Kp>=_Kg-4 then _Hf(_Kd,_Kg-2,_Ki,_Kg-3,_Kj,_Ke,_Kf,_Ka)end
    end
for _Ks=_Kp,_Kq,_Kr
do
    if not modDirt.on or modDirt.token~=_Ka or not isAlive()then
        return
    end _Kd=getWorldMod()if not _Kd or _hy()~=_Kb.world then
    return
end
local _Kt=(_Ks==_Kp)and _Kp or(_Ks-_Kr)if _Dp(_Kd,_Ks,_Kj,true)then _Eh(_Kd,_Ks,_Kj,_Kt,_Kj,_Ke,_Kf,_Ka)end
if _Ks~=_Kp then
    if config.dfReplacePlatform or(placeTile(_Kd,"fg",_Ks,_Ki)or 0)==0 or modClick.HazardAt(_Ks,_Ki)then _Iz(_Kd,_Ks,_Ki,_Kt,_Kj,_Ke,_Kf,_Ka)end elseif(placeTile(_Kd,"fg",_Kp,_Ki)or 0)==0 then _Iz(_Kd,_Kp,_Ki,_Kp,_Kj,_Ke,_Kf,_Ka)end
    if not _Eg(_Kd,_Ks,_Kj,_Ke,_Kf,_Ka)then break
    end
if _Ks==(_Kp+_Kr)and(config.dfReplacePlatform or modClick.HazardAt(_Kp,_Ki))then _Iz(_Kd,_Kp,_Ki,_Ks,_Kj,_Ke,_Kf,_Ka)end
if _Dp(_Kd,_Ks,_Kh,true)then modDirt.status=string.format("Row Y=%d | Breaking (%d,%d)",_Kh,_Ks,_Kh)_Eh(_Kd,_Ks,_Kh,_Ks,_Kj,_Ke,_Kf,_Ka)end
end
if config.dfUsePlatform and _Ki>=_Ke then
    if _Kq>=_Kg-4 then _Hf(_Kd,_Kg-2,_Ki,_Kg-3,_Kj,_Ke,_Kf,_Ka)elseif _Kq<=3 then _Hf(_Kd,1,_Ki,2,_Kj,_Ke,_Kf,_Ka)end
    end
end
end
for _Ku=_Ke-2,2,-2
do
    if not modDirt.on or modDirt.token~=_Ka or not isAlive()then
        return
    end _Kd=getWorldMod()if not _Kd or _hy()~=_Kb.world then
    return
end
local _Kv=_Ku-1
for _Kw=1,2
do
    if not modDirt.on or modDirt.token~=_Ka or not isAlive()then
        return
    end _Kd=getWorldMod()if not _Kd then
    return
end
local _Kx,_Ky=_JO(_Kd,_Ku)if not _Kx then
    if _Kw==1 then modDirt.status=string.format("Upper Platform Y=%d complete, skipping...",_Ku)end break
end modDirt.stats.step=string.format("Upper: Platform Y=%d",_Ku)local _Kz=_hv()or 2
local _KA=(math.abs(_Kz-_Kx)<=math.abs(_Kz-_Ky))local _KB=_KA and _Kx or _Ky
local _KC=_KA and _Ky or _Kx
local _KD=_KA and 1 or-1
if not _Eg(_Kd,_KB,_Kv,_Ke,_Kf,_Ka)then break
end
if config.dfUsePlatform and(_KB<=3 or _KB>=_Kg-4)then
    local _KE=_KA and 1 or(_Kg-2)_Hf(_Kd,_KE,_Ku,_KB,_Kv,_Ke,_Kf,_Ka)end
for _KF=_KB,_KC,_KD
do
    if not modDirt.on or modDirt.token~=_Ka or not isAlive()then
        return
    end _Kd=getWorldMod()if not _Kd or _hy()~=_Kb.world then
    return
end
local _KG=(_KF==_KB)and _KB or(_KF-_KD)if _Dp(_Kd,_KF,_Kv,true)then _Eh(_Kd,_KF,_Kv,_KG,_Kv,_Ke,_Kf,_Ka)end modDirt.status=string.format("Upper Y=%d | Placing Dirt (%d,%d)",_Ku,_KF,_Ku)_Iz(_Kd,_KF,_Ku,_KG,_Kv,_Ke,_Kf,_Ka)if not _Eg(_Kd,_KF,_Kv,_Ke,_Kf,_Ka)then break
end
end
if config.dfUsePlatform and(_KC>=_Kg-4 or _KC<=3)then
    local _KH=_KA and(_Kg-2)or 1 _Hf(_Kd,_KH,_Ku,_KC,_Kv,_Ke,_Kf,_Ka)end
end
end
if not _Kc and StopGod then pcall(StopGod)end _iW("autodf",false)_cO()inputState.active=false modDirt.stats.step="Completed"modDirt.status="Completed"local _KI=string.format(("Full World Dirt Farm finished! Broken: %d | Placed: %d | Drops: ".."%d"),modDirt.stats.broken,modDirt.stats.placed,modDirt.stats.picked)notify(_KI)webhookSvc.Send("pabrik",_KI)end
function modDirt.Stop()if not modDirt.on then
        return false
    end modDirt.token=modDirt.token+(1)modDirt.on=false _iW("autodf",false)_cO()inputState.active=false modDirt.status="Idle"modDirt.stats.step="-"return true
end
function modDirt.Start()if modDirt.on then
        return true
    end
if modAutoPlace.on then _vM()end
if modBreak.on then modBreak.Stop()end
if modTrees.on then modTrees.Stop()end
if _te.on then _te.Stop()end
if modFarm.on then modFarm.Stop()end
if session.Rotation and session.Rotation.on then session.Rotation.Stop()end
local _KJ,_KK=_hj()if not _KJ then notify("Character position not detected.");return false
end
local _KL={x=math.floor(_KJ),y=math.floor(_KK-0.475),world=_hy()}modDirt.token=modDirt.token+(1)local _KM=modDirt.token modDirt.on=true modDirt.status="Starting"modDirt.stats={topDirtY=0,bedrockY=0,broken=0,placed=0,picked=0,step="Initializing"}task.spawn(function()local _KN,_KO=pcall(_JZ,_KM,_KL)if not _KN then warn("[ANCHHub] Auto DF error: "..tostring(_KO))end _iW("autodf",false)_cO()inputState.active=false
    if modDirt.token==_KM then modDirt.on=false
        if modDirt.status~="Completed"then modDirt.status="Idle"end
        if _sV then _sV()end
    end end)return true
end end)()end do(function()function _te.Result(_KP,_KQ)if not(_bh and type(_bi)=="table"and type(_bi.result)=="function")then
    return nil
end
if not(_KP and _KQ)then
    return nil
end
local _KR,_KS=pcall(_bi.result,_KP,_KQ)return _KR and _KS or nil
end
function _te.ResultText()local _KT,_KU=config.spliceA,config.spliceB
    if not(_KT and _KU)then
        return "Pilih Seed A dan Seed B"end
    local _KV=_te.Result(_KT,_KU)if not _KV then
        return "Hasil: Kombinasi ini tidak bisa di-splice"end
    return "Hasil Splice: ".._gt(_KV).." ["..tostring(_KV).."]"end
local function _KW(_KX,_KY,_KZ)if not modules.Trees then modules.Scan()end
    local _La=modules.Trees and modules.Trees[_KZ*_KX.w+_KY]return type(_La)=="table"and _La.s==true
end
local function _Lb(_Lc,_Ld,_Le,_Lf)local _Lg=_Lc and rawget(_Lc,"spliceSeed")if type(_Lg)~="function"then
        return false,"fungsi spliceSeed tidak ditemukan"end
    local _Lh,_Li=pcall(_Lg,_Ld,_Le,_Lf)if _Lh and _Li and itemDB[_Li]then
        if modules.Inv and type(modules.Inv.remove)=="function"then pcall(function()modules.Inv:remove(_Lf,1)end)end
        if modules.SetTile then pcall(modules.SetTile,"fg",_Ld,_Le,_Li,true)end _te.made=_te.made+(1)_te.status=string.format("Splice jadi %s (%d,%d)",_gt(_Li),_Ld,_Le)return true
    end
return false,"ditolak server"end
local function _Lj(_Lk,_Ll)local _Lm=math.min(_hR(),_hV())-0.15
    while _te.on and _te.token==_Lk and isAlive()do
        local _Ln=getWorldMod()if not _Ln or _hy()~=_Ll.world then _te.status="World berubah, berhenti"break
        end
    local _Lo,_Lp=config.spliceA,config.spliceB
    local _Lq,_Lr=getWorldPos(_Lo),getWorldPos(_Lp)if _Lr<=0 then _te.status="Seed B habis!"notify("Auto Splice berhenti: ".._gt(_Lp).." habis.")break
    end
local _Ls=false
if config.spliceRoam then
    local _Lt={}local _Lu=os.clock()for _Lv=0,_Ln.h-1
    do
        for _Lw=0,_Ln.w-1
        do
            local _Lx=_Lw..",".._Lv
            if not(_te.skip[_Lx]and _te.skip[_Lx]>_Lu)then
                local _Ly=placeTile(_Ln,"fg",_Lw,_Lv)or 0
                if _Ly==0 and _Lq>0 and _tE(_Ln,_Lw,_Lv,_Lo)then table.insert(_Lt,{x=_Lw,y=_Lv,key=_Lx})elseif _Ly==_Lo and not _KW(_Ln,_Lw,_Lv)and not _ty(_Ln,_Lw,_Lv,_Lo)then table.insert(_Lt,{x=_Lw,y=_Lv,key=_Lx})end
                end
        end
end if#_Lt==0 then _te.status=(_Lq<=0)and "Seed A habis & tidak ada pohon A"or "Tidak ada lahan kosong untuk tanam/splice"break
end
for k_Lz,v_LA in ipairs(_Lt)do
    if not _te.on or _te.token~=_Lk or not isAlive()then break
    end
if getWorldPos(_Lp)<=0 then break
end
local _LB=_hg()local _LC,_LD=_hv()if not(_LB and modClick.StateReaches(_LB,v_LA.x,v_LA.y,_Lm))then _te.status=string.format("Menuju (%d,%d) [%d/%d]",v_LA.x,v_LA.y,k_Lz,#_Lt)if _LD and v_LA.y<_LD then modClick.ClimbUpWithDirt(_LC,v_LA.y,function()return _te.token~=_Lk end,true,config.moveStepDelay)end modClick.To(v_LA.x,v_LA.y,function()return _te.token~=_Lk end,_Lm,true)task.wait(0.2)end if(placeTile(_Ln,"fg",v_LA.x,v_LA.y)or 0)==0 and getWorldPos(_Lo)>0 then
    if _ij(_Lo,{x=v_LA.x,y=v_LA.y},1)then _te.planted=_te.planted+(1)sessionStats.Planted=sessionStats.Planted+(1)_Ls=true task.wait(math.max(0.14,config.spliceMs/1000))end
end if(placeTile(_Ln,"fg",v_LA.x,v_LA.y)or 0)==_Lo and getWorldPos(_Lp)>0 and not _KW(_Ln,v_LA.x,v_LA.y)then
local _LE,_LF=_Lb(_Ln,v_LA.x,v_LA.y,_Lp)if not _LE then _te.skip[v_LA.key]=os.clock()+45 _te.status=string.format("Gagal splice (%d,%d): %s",v_LA.x,_LA.y,tostring(_LF))else _Ls=true
end task.wait(math.max(0.14,config.spliceMs/1000))end
end else
local _LG,_LH=_hv()if not _LG then break
end
local _LI=os.clock()for _LJ,_LK in pairs(config.farmGrid)do
    if v_LK then
        local _LL,_LM=tostring(k_LJ):match("^(-?%d+),(-?%d+)$")if _LL and _LM then
            local _LN,_LO=_LG+tonumber(_LL),_LH+tonumber(_LM)local _LP=_LN..",".._LO
            if _hJ(_Ln,_LN,_LO)and not(_te.fail[_LP]and _te.fail[_LP]>_LI)then
                local _LQ=placeTile(_Ln,"fg",_LN,_LO)or 0
                if _LQ==0 and getWorldPos(_Lo)>0 and getWorldPos(_Lp)>0 and _tE(_Ln,_LN,_LO,_Lo)then
                    if _ij(_Lo,{x=_LN,y=_LO},1)then _te.planted=_te.planted+(1)sessionStats.Planted=sessionStats.Planted+(1)_Ls=true task.wait(math.max(0.14,config.spliceMs/1000))end
                end if(placeTile(_Ln,"fg",_LN,_LO)or 0)==_Lo and getWorldPos(_Lp)>0 and not _KW(_Ln,_LN,_LO)then
                local _LR,_LS=_Lb(_Ln,_LN,_LO,_Lp)if not _LR then _te.fail[_LP]=os.clock()+30 _te.status=string.format("Gagal splice (%d,%d): %s",_LN,_LO,tostring(_LS))end _Ls=true task.wait(math.max(0.14,config.spliceMs/1000))end
        end
end
end
end
if not _Ls then
    if getWorldPos(_Lo)<=0 or getWorldPos(_Lp)<=0 then _te.status="Seed habis"break
    end _te.status="Menunggu tile Grid kosong..."task.wait(1)end
end
if not _Ls and config.spliceRoam then break
end task.wait(0.2)end
end
function _te.Stop()if not _te.on then
        return false
    end _te.token=_te.token+(1)_te.on=false _te.roaming=false _cO()inputState.active=false _te.status="Mati"return true
end
function _te.Start()if _te.on then
        return true
    end
if not(config.spliceA and config.spliceB)or config.spliceA==config.spliceB then notify("Auto Splice: Pilih Seed A dan Seed B yang berbeda!")return false
end
if _bh and type(_bi)=="table"and not _te.Result(config.spliceA,config.spliceB)then notify("Kombinasi Seed A & Seed B ini tidak bisa di-splice!")return false
end
if modAutoPlace.on then _vM()end
if modBreak.on then modBreak.Stop()end
if modTrees.on then modTrees.Stop()end
if modDirt.on then modDirt.Stop()end
if modFarm.on then modFarm.Stop()end
local _LT,_LU=_hj()if not _LT then notify("Posisi belum terdeteksi.");return false
end
local _LV={x=math.floor(_LT),y=math.floor(_LU-0.475),world=_hy()}table.clear(_te.fail)table.clear(_te.skip)_te.token=_te.token+(1)local _LW=_te.token _te.on=true _te.roaming=config.spliceRoam _te.status="Mulai..."task.spawn(function()local _LX,_LY=pcall(_Lj,_LW,_LV)if not _LX then warn("[ANCHHub] Auto Splice error: "..tostring(_LY))end _cO()inputState.active=false
    if _te.token==_LW then _te.on=false _te.roaming=false
        if _te.status=="Mulai..."then _te.status="Mati"end
        if _sV then _sV()end
    end end)return true
end end)()end do(function()local _LZ={}local _Ma={}local function _Mb(_Mc)if writefile then _Mc.updatedAt=os.time()pcall(writefile,file_ANCHHub_Pabrik,svc_HttpSvc:JSONEncode(_Mc))end
end
local function _Md()if writefile then pcall(writefile,file_ANCHHub_Pabrik,"{\"active\":false}")end
    if isfile and delfile and isfile(file_ANCHHub_Pabrik)then pcall(delfile,file_ANCHHub_Pabrik)end
end
function modFarm.ParseDropTarget()local _Me=tostring(config.pabrikDropWorld or""):gsub("%s","")local _Mf,_Mg=string.match(_Me,"^([^:]*):(.+)$")if not _Mf then _Mf=_Me
    end _Mf=string.upper(_Mf):gsub("[^A-Z0-9]","")if _Mg==""then _Mg=nil
end
return _Mf,_Mg
end
local function _Mh()local _Mi=modules.Menu
    if _Mi and type(rawget(_Mi,"openPicker"))=="function"and pcall(_Mi.openPicker)then
        return true
    end
local _Mj=getWorldMod()if _Mj and type(rawget(_Mj,"call"))=="function"then
    return pcall(_Mj.call,"LeaveWorld")end
return false
end
local function _Mk(_Ml,_Mm)_Ml=trim(_Ml):upper()if _Ml==""then
        return false,"empty world name"end
    if _hy():upper()==_Ml and not _Mm then
        return true
    end
if _sw then pcall(_sw)end
for _Mn=1,3
do
    if not isAlive()then
        return false,"stopped"end
    if _hy()~=""and(_hy():upper()~=_Ml or _Mm)then _Mh()task.wait(1.8)end
    local _Mo=getWorldMod()if _Mm and _Mo then rawset(_Mo,"arriveDoor",_Mm)end
    local _Mp=_Mo and rawget(_Mo,"fg")local _Mq=modules.Menu
    if _Mq and type(rawget(_Mq,"enter"))=="function"then pcall(_Mq.enter,_Ml)elseif _Mo and type(rawget(_Mo,"enter"))=="function"then pcall(_Mo.enter,_Ml)else modules.Scan(true)end
        local _Mr=os.clock()while isAlive()and(os.clock()-_Mr)<14
        do
            local _Ms=getWorldMod()if _Ms and(rawget(_Ms,"fg")~=_Mp or not _Mm)and _hy():upper()==_Ml and _hv()then modules.Scan(true)task.wait(1.0)return true
            end task.wait(0.25)end task.wait(1.5)end
return false,"timeout entering ".._Ml
end
local function _Mt(_Mu)if not tileCache.list and tileCache.findRefs then tileCache.findRefs()end
    local _Mv=tileCache.list
    if type(_Mv)~="table"then
        return nil
    end
local _Mw,_Mx=_hv()_Mw,_Mx=_Mw or 50,_Mx or 30
local _My=modFarm.Zone
if _My and _My.world~=_hy()then _My=nil
end
local _Mz=os.clock()local _MA,_MB=nil,math.huge
for k_MC,v_MD in ipairs(_Mv)do
    if type(v_MD)=="table"and v_MD.id==_Mu and(v_MD.n or 0)>0 and not v_MD.display and type(v_MD.x)=="number"then
        local _ME=v_MD.uid or(math.floor(v_MD.x)..","..math.floor(v_MD.y))local _MF=_Ma[_ME]local _MG,_MH=math.floor(_MD.x),math.floor(_MD.y)if not(_MF and _Mz<_MF)and not modClick.SolidAt(_MG,_MH)then
            if not(_My and math.abs(v_MD.x-_My.x)<=2.5 and math.abs(v_MD.y-_My.y)<=2.5)then
                local _MI=math.abs(v_MD.x-_Mw)+math.abs(v_MD.y-_Mx)if _MI<_MB then _MA,_MB=v_MD,_MI
                end
        end
end
end
end
return _MA
end
local function _MJ(_MK,_ML)local _MM=false
    local _MN={}local _MO=os.clock()while _ML()and getWorldPos(_MK)<200 and(os.clock()-_MO)<35
    do
        local _MP=_Mt(_MK)if not _MP then break
        end
    local _MQ=_MP.uid or(math.floor(_MP.x)..","..math.floor(_MP.y))_MN[_MQ]=(_MN[_MQ]or 0)+1
    if _MN[_MQ]>2 then _Ma[_MQ]=os.clock()+45 continue
    end
local _MR,_MS=math.floor(_MP.x),math.floor(_MP.y)local _MT=getWorldPos(_MK)modFarm.phase="COLLECT BLOCK"modFarm.status=string.format("Collecting dropped %s at (%d,%d)...",_gt(_MK),_MR,_MS)local _MU=modClick.To(_MR,_MS,function()return not _ML()end,0.45,false)if _MU and tileCache.walkToX then
    local _MV=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_MP.x,0.8)tileCache.collecting=false inputState.active=_MV
end
local _MW=getWorldMod()local _MX=_MW and rawget(_MW,"takeDrop")if type(_MX)=="function"and _MP.uid then
    local _MY=200-getWorldPos(_MK)if _MY>0 then pcall(_MX,_MP.uid,math.min(_MP.n or 1,_MY))end
end task.wait(0.35)if getWorldPos(_MK)>_MT then _MM=true _Ma[_MQ]=nil elseif not _MU then _Ma[_MQ]=os.clock()+45
end
end
return _MM
end
local function _MZ(_Na,_Nb,_Nc)local _Nd=modules.Hud or _gl()local _Ne=_Nd and rawget(_Nd,"onDrop")local _Nf=_Nb
    local _Ng=0
    while _Nf>0 and _Nc()and getWorldPos(_Na)>0 and _Ng<15
    do
        local _Nh=getWorldPos(_Na)local _Ni=math.min(_Nf,_Nh,200)if type(_Ne)=="function"then pcall(_Ne,_Na,_Ni)elseif remote_DropItem then pcall(function()remote_DropItem:FireServer(_Na,_Ni)end)elseif _bb and type(_bc)=="table"and _bc.drop then pcall(_bc.drop.send,{id=_Na,n=_Ni})end task.wait(0.8)local _Nj=_Nh-getWorldPos(_Na)if _Nj>0 then _Nf=_Nf-_Nj modFarm.dropped=modFarm.dropped+_Nj else _Ng=_Ng+1
                    local _Nk,_Nl=_hv()if _Nk and _Nl and not modClick.SolidAt(_Nk+1,_Nl)then
                        if tileCache.walkToX then
                            local _Nm=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_Nk+1.5,1.2)tileCache.collecting=false inputState.active=_Nm else modClick.To(_Nk+1,_Nl,function()return not _Nc()end,0.35,false)end task.wait(0.25)else
                        return _Nb-_Nf,"drop tile full"end
                end
        end
    return _Nb-_Nf,nil
end
local function _Nn(_No,_Np,_Nq)local _Nr,_Ns=modFarm.ParseDropTarget()local _Nt=modFarm.home~=""and modFarm.home or _hy()if _Nr==""then _Nr=_Nt
    end
if config.pabrikDropX<0 and not _Ns and _Nr:upper()==_Nt:upper()then modFarm.status="Drop position not set (skipping drop)"modFarm.dropOffUntil=os.clock()+60
    return
end modFarm.traveling=true modGems.pauseCollect=true
local _Nu=_Nr:upper()~=_hy():upper()_Mb({active=true,stage="dropping",homeWorld=_Nt,targetWorld=_Nr,doorId=_Ns,seedId=_No,dropAmount=_Np,})local _Nv,_Nw=true,nil
if _Nu or _Ns then modFarm.status="Warping to storage world ".._Nr..(_Ns and(":".._Ns)or"").."..."local _Nx,_Ny=_Mk(_Nr,_Ns)if not _Nx then _Nv,_Nw=false,"Failed entering ".._Nr.." ("..tostring(_Ny)..")"end
end
if _Nv and _Nq()and config.pabrikDropX>=0 and config.pabrikDropY>=0 then modFarm.status=string.format("Walking to drop pos (%d,%d)...",config.pabrikDropX,config.pabrikDropY)local _Nz=false
    for _NA=1,3
    do
        if not _Nq()then break
        end
    if modClick.To(config.pabrikDropX,config.pabrikDropY,function()return not _Nq()end,0.45,false)then _Nz=true break
    end task.wait(0.3)end
if not _Nz then _Nv,_Nw=false,"Could not reach drop position"end
end
if _Nv and _Nq()then
    local _NB=_hg()if _NB then modFarm.Zone={world=_hy(),x=_NB.x,y=_NB.y-0.475}end
    local _NC,_ND=_MZ(_No,_Np,_Nq)if _NC>0 then
        local _NE=string.format("Dropped %s x%d in %s",_gt(_No),_NC,_hy())modFarm.status=_NE notify(_NE,"Factory ANCH")webhookSvc.Send("pabrik",_NE)end
    if _ND then _Nv,_Nw=false,_ND
    end
if not _Nu then
    local _NF,_NG=_hv()if _NF and _NG and _NF>1 and not modClick.SolidAt(_NF-1,_NG)and tileCache.walkToX then
        local _NH=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_NF-0.5,1.0)tileCache.collecting=false inputState.active=_NH
    end
end
end
if not _Nv then modFarm.dropOffUntil=os.clock()+60 modFarm.status="Drop failed: "..tostring(_Nw)end _Mb({active=true,stage="farming",homeWorld=_Nt,targetWorld=_Nr,seedId=_No,})if _Nt~=""and _hy():upper()~=_Nt:upper()and _Nq()then
    for _NI=1,4
    do
        if not _Nq()or _hy():upper()==_Nt:upper()then break
        end modFarm.status=string.format("Returning to factory world %s (%d/4)...",_Nt,_NI)if _Mk(_Nt,nil)then break
    end task.wait(2.5)end
end modGems.pauseCollect=false modFarm.traveling=false
end
function modFarm.ExternalDropSeed(_NJ,_NK,_NL,_NM,_NN,_NO,_NP,_NQ,_NR)local _NS,_NT,_NU,_NV=config.pabrikDropWorld,config.pabrikDropX,config.pabrikDropY,modFarm.home config.pabrikDropWorld=_NL or""config.pabrikDropX=_NM or-1 config.pabrikDropY=_NN or-1 modFarm.home=_NO or _hy()_Nn(_NJ,_NK,_NR)config.pabrikDropWorld,config.pabrikDropX,config.pabrikDropY,modFarm.home=_NS,_NT,_NU,_NV
    if _NP and _NQ and _NR()then modClick.To(_NP,_NQ,function()return not _NR()end,0.3,false)end
end
local function _NW(_NX,_NY)if not config.pabrikDrop then
        return false
    end
local _NZ=getWorldPos(_NX)local _Oa=math.max(1,tonumber(config.pabrikMaxSeed)or 100)if _NZ>_Oa and os.clock()>=(modFarm.dropOffUntil or 0)then
    local _Ob=_NZ-_Oa
    if _Ob>0 then modFarm.phase="DROP EXCESS SEEDS"modFarm.status=string.format("Seeds %d > Max (%d)! Dropping %d seeds...",_NZ,_Oa,_Ob)_Nn(_NX,_Ob,_NY)return true
    end
end
return false
end
local function _Oc(_Od,_Oe,_Of)if not _Od then
        return false
    end
for k_Og,v_Oh in pairs(config.pabrikTiles)do
    if v_Oh then
        local _Oi,_Oj=tostring(k_Og):match("^(-?%d+),(-?%d+)$")if _Oi and _Oj then
            local _Ok,_Ol=_Oe+tonumber(_Oi),_Of+tonumber(_Oj)local _Om=placeTile(_Od,"fg",_Ok,_Ol)or 0
            local _On=placeTile(_Od,"bg",_Ok,_Ol)or 0 if(_Om~=0 and _iw(_Om,_Ok,_Ol))or(config.farmBreakBg and _On~=0 and _iw(_On,_Ok,_Ol))then
                return true
            end
    end
end
end
return false
end
local function _Oo(_Op,_Oq,_Or)if config.pabrikBreakX<0 or config.pabrikBreakY<0 then modFarm.status="Break position not set! Click SetPos Break first."notify("Factory: Click 'SetPos Break' in the Seed Factory tab first!")task.wait(2.5)return false
    end
if next(config.pabrikTiles)==nil then config.pabrikTiles={["1,0"]=true}end
while _Or()do _NW(_Op,_Or)if not _Or()then break
    end
local _Os=getWorldMod()local _Ot=_Oc(_Os,config.pabrikBreakX,config.pabrikBreakY)if getWorldPos(_Oq)<=0 and not _Ot then
    if not _MJ(_Oq,_Or)or getWorldPos(_Oq)<=0 then break
    end
end modFarm.phase="BREAK BLOCK"local _Ou,_Ov=_hv()if _Ou~=config.pabrikBreakX or _Ov~=config.pabrikBreakY then modFarm.status=string.format("Walking to Break Pos (%d,%d)...",config.pabrikBreakX,config.pabrikBreakY)local _Ow=false
for _Ox=1,3
do
    if not _Or()then break
    end
if modClick.To(config.pabrikBreakX,config.pabrikBreakY,function()return not _Or()end,0.45,false)then _Ow=true break
end
local _Oy,_Oz=_hv()if _Oy and _Oz and math.abs(_Oy-config.pabrikBreakX)<=2 and math.abs(_Oz-config.pabrikBreakY)<=2 then _iE(config.pabrikBreakX,config.pabrikBreakY,false)end task.wait(0.35)end
if not _Ow then modFarm.status="Failed walking to Break Pos, retrying..."task.wait(1.5)break
end
end
if not _Or()then break
end
if tileCache.walkToX then
    local _OA=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(config.pabrikBreakX+0.5,1.0)tileCache.collecting=false inputState.active=_OA
end
local _OB,_OC,_OD=_hj()if not _OB then break
end
local _OE={x=config.pabrikBreakX,y=config.pabrikBreakY,facing=_OD,world=_hy(),}modAutoPlace.Override={offsets=config.pabrikTiles,block=_Oq,mode="Place + Break"}modAutoPlace.Quiet=true modAutoPlace.token=modAutoPlace.token+1
local _OF=modAutoPlace.token modAutoPlace.on=true
local _OG=sessionStats.Placed+sessionStats.Broken
local _OH=os.clock()task.spawn(function()while modAutoPlace.on and modAutoPlace.token==_OF
    do task.wait(0.4)local _OI=sessionStats.Placed+sessionStats.Broken
        if _OI~=_OG then _OG,_OH=_OI,os.clock()end
        local _OJ=getWorldPos(_Op)local _OK=getWorldPos(_Oq)local _OL=getWorldMod()local _OM=_Oc(_OL,_OE.x,_OE.y)if not _Or()or(_OK<=0 and not _OM and not tileCache.collecting)or(config.pabrikDrop and _OJ>=195 and not _OM)or(os.clock()-_OH>10)then modAutoPlace.on=false
        end
end end)modFarm.status=string.format("Breaking %s at (%d,%d) [Bag: %d]...",_gt(_Oq),_OE.x,_OE.y,getWorldPos(_Oq))pcall(_vN,_OF,_OE)modAutoPlace.on=false modAutoPlace.Override=nil modAutoPlace.Quiet=false task.wait(0.3)end
return true
end
local function _ON(_OO,_OP)if config.pabrikBreakX<0 or config.pabrikBreakY<0 then
        return false
    end
if _OO==config.pabrikBreakX and _OP==config.pabrikBreakY then
    return true
end
for k_OQ,v_OR in pairs(config.pabrikTiles)do
    if v_OR then
        local _OS,_OT=tostring(k_OQ):match("^(-?%d+),(-?%d+)$")if _OS and _OT then
            if _OO==(config.pabrikBreakX+tonumber(_OS))and _OP==(config.pabrikBreakY+tonumber(_OT))then
                return true
            end
    end
end
end
return false
end
local function _OU(_OV,_OW)local _OX={}local _OY=0
    local _OZ=nil
    local _Pa=workspace:GetServerTimeNow()local _Pb=itemDB[_OW]local _Pc=(_Pb and(tonumber(_Pb.grow)or tonumber(_Pb.baseGrow)))or 31
    local _Pd=1
    for _Pe=0,_OV.h-1
    do
        local _Pf={}for _Pg=0,_OV.w-1
        do
            local _Ph=_Pe*_OV.w+_Pg
            local _Pi=placeTile(_OV,"fg",_Pg,_Pe)or 0
            if _Pi==_OW then
                local _Pj=doFarmAction(_OV,_Pg,_Pe,_Pi)if not _Pj then
                    if not _LZ[_Ph]then _LZ[_Ph]=_Pa
                    end _Pj=_LZ[_Ph]+_Pc
            end
        if _Pa>=_Pj then table.insert(_Pf,{x=_Pg,y=_Pe,idx=_Ph})else _OY=_OY+1
            local _Pk=_Pj-_Pa
            if not _OZ or _Pk<_OZ then _OZ=_Pk
            end
    end else _LZ[_Ph]=nil
end
end if#_Pf>0 then
if _Pd==-1 then table.sort(_Pf,function(_Pl,_Pm)return _Pl.x>_Pm.x end)else table.sort(_Pf,function(_Pn,_Po)return _Pn.x<_Po.x end)end
for k_Pp,v_Pq in ipairs(_Pf)do table.insert(_OX,v_Pq)end _Pd=-_Pd
end
end
return _OX,_OY,_OZ
end
local function _Pr(_Ps,_Pt)local function _Pu()return modFarm.on and modFarm.token==_Ps and isAlive()end
    local _Pv=math.min(_hR(),_hV())-0.15
    while _Pu()do
        if modFarm.home~=""and _hy():upper()~=modFarm.home:upper()and not modFarm.traveling then modFarm.status="Returning to factory world "..modFarm.home.."..."_Mk(modFarm.home,nil)end
        local _Pw=getWorldMod()while not _Pw and _Pu()do task.wait(1)_Pw=getWorldMod()end
        if not _Pu()then break
        end
    local _Px=config.pabrikSeedId
    local _Py=math.max(1,tonumber(config.pabrikMaxSeed)or 100)if getWorldPos(_Pt)>0 or _Mt(_Pt)~=nil then _Oo(_Px,_Pt,_Pu)if not _Pu()then break
        end _Pw=getWorldMod()end _NW(_Px,_Pu)if not _Pu()then break
end _Pw=getWorldMod()local _Pz,_PA=_OU(_Pw,_Px)local _PB=#_Pz+_PA
local _PC=math.max(0,_Py-_PB)if getWorldPos(_Px)>0 and _PC>0 then modFarm.phase="PLANT SEED"local _PD={}local _PE=1
    for _PF=0,_Pw.h-1
    do
        local _PG={}for _PH=0,_Pw.w-1
        do if(placeTile(_Pw,"fg",_PH,_PF)or 0)==0 and _tE(_Pw,_PH,_PF,_Px)and not _ON(_PH,_PF)then table.insert(_PG,{x=_PH,y=_PF})end
        end if#_PG>0 then
        if _PE==-1 then table.sort(_PG,function(_PI,_PJ)return _PI.x>_PJ.x end)else table.sort(_PG,function(_PK,_PL)return _PK.x<_PL.x end)end
        for k_PM,v_PN in ipairs(_PG)do table.insert(_PD,v_PN)end _PE=-_PE
    end
end
local _PO=0
for k_PP,v_PQ in ipairs(_PD)do
    if not _Pu()or getWorldPos(_Px)<=0 or _PO>=_PC then break
    end _Pw=getWorldMod()if _Pw and _tE(_Pw,v_PQ.x,v_PQ.y,_Px)then
    local _PR=_hg()if not(_PR and modClick.StateReaches(_PR,v_PQ.x,v_PQ.y,_Pv))then modFarm.status=string.format("Walking Zig-Zag to plant (%d,%d) [%d/%d]",v_PQ.x,_PQ.y,_PO+1,_PC)modClick.To(_PQ.x,_PQ.y,function()return not _Pu()end,_Pv,false)end
    local _PS=_hg()if _PS and modClick.StateReaches(_PS,_PQ.x,_PQ.y,_Pv+0.5)and _tE(_Pw,v_PQ.x,v_PQ.y,_Px)and _ij(_Px,v_PQ,1)then _LZ[v_PQ.y*_Pw.w+v_PQ.x]=workspace:GetServerTimeNow()_PO=_PO+1 modFarm.planted=modFarm.planted+1 sessionStats.Planted=sessionStats.Planted+1 modFarm.status=string.format("Planting %s (%d/%d Max Seed)",_gt(_Px),_PB+_PO,_Py)task.wait(math.max(0.05,config.harvestPlantDelay))end
end
end
end
if not _Pu()then break
end _Pw=getWorldMod()local _PT,_PU,_PV=_OU(_Pw,_Px)if#_PT==0 and _PU>0 then modFarm.phase="WAIT GROW"while _Pu()do _Pw=getWorldMod()if not _Pw then break
    end _PT,_PU,_PV=_OU(_Pw,_Px)if#_PT>0 or _PU==0 then break
end
local _PW=math.max(1,math.ceil(_PV or 15))modFarm.status=string.format("Waiting for %d trees to grow (Â±%ds)...",_PU,_PW)task.wait(1)end
end
if not _Pu()then break
end if#_PT>0 then modFarm.phase="HARVEST ZIG-ZAG"for k_PX,v_PY in ipairs(_PT)do
    if not _Pu()then break
    end
if getWorldPos(_Pt)>=200 then modFarm.status="Blocks reached 200! Going to Break Pos..."_Oo(_Px,_Pt,_Pu)if not _Pu()then break
    end _NW(_Px,_Pu)if not _Pu()then break
end
end _Pw=getWorldMod()if _Pw and(placeTile(_Pw,"fg",v_PY.x,v_PY.y)or 0)==_Px then
local _PZ=_hg()if not(_PZ and modClick.StateReaches(_PZ,v_PY.x,v_PY.y,_Pv))then modFarm.status=string.format("Harvesting Zig-Zag (%d,%d) [%d/%d]",v_PY.x,v_PY.y,k_PX,#_PT)modClick.To(v_PY.x,v_PY.y,function()return not _Pu()end,_Pv,false)end
local _Qa=_hg()if _Qa and modClick.StateReaches(_Qa,_PY.x,_PY.y,_Pv+0.5)then
    local _Qb=os.clock()while _Pu()and(placeTile(_Pw,"fg",v_PY.x,v_PY.y)or 0)==_Px and os.clock()-_Qb<3.5
    do
        local _Qc=_iE(v_PY.x,v_PY.y,false)if _Qc=="broke"then _LZ[v_PY.idx or(v_PY.y*_Pw.w+v_PY.x)]=nil modFarm.harvested=modFarm.harvested+1 sessionStats.Harvested=sessionStats.Harvested+1
        end task.wait(math.max(0.05,config.harvestDelay))end
local _Qd,_Qe=_hv()if _Qd and _Qe==v_PY.y and math.abs(_Qd-v_PY.x)<=3 and not modClick.SolidAt(v_PY.x,v_PY.y)and tileCache.walkToX then
    local _Qf=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_PY.x+0.5,0.9)tileCache.collecting=false inputState.active=_Qf
end task.wait(0.15)end
end
end _MJ(_Pt,_Pu)if getWorldPos(_Pt)>0 then _Oo(_Px,_Pt,_Pu)end _NW(_Px,_Pu)else
if getWorldPos(_Px)<=0 and getWorldPos(_Pt)<=0 and _Mt(_Pt)==nil then modFarm.status="Done: All seeds, blocks, and trees are finished."_Md()break
end
end task.wait(0.3)end
end
function modFarm.Stop()_Md()if not modFarm.on then
        return false
    end modFarm.token=modFarm.token+1 modFarm.on=false modFarm.traveling=false modGems.pauseCollect=false
if modAutoPlace.Override then modAutoPlace.on=false modAutoPlace.Override=nil modAutoPlace.Quiet=false
end _cO()inputState.active=false modFarm.phase="-"modFarm.status="Idle"if _sY then pcall(_sY)end
return true
end
function modFarm.Start(_Qg)if modFarm.on then
        return true
    end
local _Qh=config.pabrikSeedId
local _Qi=_gK(_Qh)if not _Qh or not _Qi then notify("Factory: Select a valid factory Seed ID first!")return false
end
if modAutoPlace.on then _vM()end
if modBreak.on then modBreak.Stop()end
if modTrees.on then modTrees.Stop()end
if modDirt.on then modDirt.Stop()end
if _te.on then _te.Stop()end
if session.Rotation and _d.Rotation.on then _d.Rotation.Stop()end table.clear(_Ma)modFarm.home=_Qg or _hy()modFarm.dropOffUntil=0 modFarm.token=modFarm.token+1
local _Qj=modFarm.token modFarm.on=true modFarm.phase="STARTING"modFarm.status="Initializing Seed Factory..."_Mb({active=true,stage="farming",homeWorld=modFarm.home,seedId=_Qh,})if _sY then pcall(_sY)end
if _sV then _sV()end task.spawn(function()local _Qk,_Ql=pcall(_Pr,_Qj,_Qi)if not _Qk then warn("[ANCHHub] Pabrik error: "..tostring(_Ql))end modGems.pauseCollect=false _cO()inputState.active=false
    if modFarm.token==_Qj then modFarm.on=false modFarm.traveling=false modFarm.phase="-"if modFarm.status=="Initializing Seed Factory..."then modFarm.status="Idle"end
        if _sY then pcall(_sY)end
        if _sV then _sV()end
    end end)return true
end
function modFarm.CheckStartup()pcall(function()if not(isfile and readfile and isfile(file_ANCHHub_Pabrik))then
            return
        end
    local _Qm=readfile(file_ANCHHub_Pabrik)local _Qn=svc_HttpSvc:JSONDecode(_Qm)if type(_Qn)~="table"or not _Qn.active then
        return
    end
if os.time()-(tonumber(_Qn.updatedAt)or 0)>1800 then _Md()return
end
local _Qo=os.clock()while isAlive()and os.clock()-_Qo<30
do
    if _hy()~=""and _hv()then break
    end task.wait(1)end
if not isAlive()or _hy()==""then
    return
end modules.Scan(true)task.wait(1.2)local _Qp=_hy():upper()local _Qq=tostring(_Qn.homeWorld or""):upper()local _Qr=tostring(_Qn.targetWorld or""):upper()if _Qn.stage=="dropping"and _Qr~=""and _Qp==_Qr then notify("Resuming Factory Seed Drop in ".._Qp.."...","Factory ANCH")modFarm.home=_Qn.homeWorld modFarm.on=true modFarm.token=modFarm.token+1
local _Qs=modFarm.token _Nn(_Qn.seedId or config.pabrikSeedId,_Qn.dropAmount or 100,function()return modFarm.on and modFarm.token==_Qs and isAlive()end)modFarm.on=false
if _hy():upper()==_Qq then modFarm.Start(_Qn.homeWorld)end elseif _Qq~=""and _Qp==_Qq then notify("Resuming Seed Factory in ".._Qp.."!","Factory ANCH")modFarm.Start(_Qn.homeWorld)elseif _Qq~=""and _Qp~=_Qq then notify("Returning to Factory world: ".._Qq.."...","Factory ANCH")if _Mk(_Qq,nil)then modFarm.Start(_Qn.homeWorld)end
    end end)end end)()end do(function()local function _Qt(_Qu)if writefile then _Qu.updatedAt=os.time()pcall(writefile,file_ANCHHub_AutoMove,svc_HttpSvc:JSONEncode(_Qu))end
end
local function _Qv()if writefile then pcall(writefile,file_ANCHHub_AutoMove,"{\"active\":false}")end
    if isfile and delfile and isfile(file_ANCHHub_AutoMove)then pcall(delfile,file_ANCHHub_AutoMove)end
end
function modGems.ParseWorld(_Qw)local _Qx=tostring(_Qw or""):gsub("%s","")local _Qy,_Qz=string.match(_Qx,"^([^:]*):(.+)$")if not _Qy then _Qy=_Qx
    end _Qy=string.upper(_Qy):gsub("[^A-Z0-9]","")if _Qz==""then _Qz=nil
end
return _Qy,_Qz
end
local function _QA()local _QB=modules.Menu
    if _QB and type(rawget(_QB,"openPicker"))=="function"and pcall(_QB.openPicker)then
        return true
    end
local _QC=getWorldMod()if _QC and type(rawget(_QC,"call"))=="function"then
    return pcall(_QC.call,"LeaveWorld")end
return false
end
local function _QD(_QE,_QF)_QE=trim(_QE):upper()if _QE==""then
        return false,"nama world kosong"end
    if _hy():upper()==_QE and not _QF then
        return true
    end
if _sw then pcall(_sw)end
if _hy()~=""then _QA()task.wait(1.8)end
local _QG=getWorldMod()if _QF and _QG then rawset(_QG,"arriveDoor",_QF)end
local _QH=_QG and rawget(_QG,"fg")local _QI=modules.Menu
if _QI and type(rawget(_QI,"enter"))=="function"then pcall(_QI.enter,_QE)elseif _QG and type(rawget(_QG,"enter"))=="function"then pcall(_QG.enter,_QE)else
        return false,"fungsi enter world tidak ditemukan"end
    local _QJ=os.clock()while _e()and(os.clock()-_QJ)<12
    do
        local _QK=getWorldMod()if _QK and rawget(_QK,"fg")~=_QH and _hy():upper()==_QE then modules.Scan()task.wait(1.2)return true
        end task.wait(0.25)end
return false,"timeout masuk world ".._QE
end
local function _QL(_QM)if not tileCache.list and tileCache.findRefs then tileCache.findRefs()end
    local _QN=tileCache.list
    if type(_QN)~="table"then
        return nil,0
    end
local _QO,_QP=_hv()_QO,_QP=_QO or 50,_QP or 30
local _QQ,_QR=nil,math.huge
local _QS=0
for k_QT,v_QU in ipairs(_QN)do
    if type(v_QU)=="table"and v_QU.id==_QM and(v_QU.n or 0)>0 and not v_QU.display and type(v_QU.x)=="number"then _QS=_QS+(v_QU.n or 0)local _QV=math.abs(v_QU.x-_QO)+math.abs(_QU.y-_QP)if _QV<_QR then _QQ,_QR=v_QU,_QV
        end
end
end
return _QQ,_QS
end
local function _QW(_QX,_QY,_QZ,_Ra)local _Rb=modules.Hud or _gl()local _Rc=_Rb and rawget(_Rb,"onDrop")local _Rd,_Re=_QY,_QZ
    local _Rf=0
    while _Ra()and getWorldPos(_QX)>0 and _Rf<25
    do
        local _Rg=getWorldPos(_QX)local _Rh=math.min(_Rg,200)modGems.status=string.format("Drop %s x%d di (%d,%d)...",_gt(_QX),_Rh,_Rd,_Re)if type(_Rc)=="function"then pcall(_Rc,_QX,_Rh)elseif remote_DropItem then pcall(function()remote_DropItem:FireServer(_QX,_Rh)end)elseif _bb and type(_bc)=="table"and _bc.drop then pcall(_bc.drop.send,{id=_QX,n=_Rh})end task.wait(0.85)local _Ri=getWorldPos(_QX)local _Rj=_Rg-_Ri
                if _Rj>0 then modGems.dropped=modGems.dropped+_Rj
                end
            if getWorldPos(_QX)>0 and _Ra()then _Rf=_Rf+1 _Rd=_Rd+1
                local _Rk=getWorldMod()if _Rk and _Rd>=_Rk.w-1 then
                    return false,"Mentok ujung kanan world!"end modGems.status=string.format("Tile penuh! Geser kanan 1 langkah ke (%d,%d)...",_Rd,_Re)if not modClick.SolidAt(_Rd,_Re)and tileCache.walkToX then
                    local _Rl=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_Rd+0.5,1.5)tileCache.collecting=false inputState.active=_Rl else modClick.To(_Rd,_Re,function()return not _Ra()end,0.3,false)end task.wait(0.25)end
        end
    return getWorldPos(_QX)==0,nil
end
local function _Rm(_Rn)local function _Ro()return modGems.on and modGems.token==_Rn and isAlive()end
    local _Rp=tonumber(config.moveItemId)or 0
    local _Rq,_Rr=modGems.ParseWorld(config.moveWorld1)local _Rs,_Rt=modGems.ParseWorld(config.moveWorld2)while _Ro()do
        local _Ru=getWorldPos(_Rp)if _Ru<200 then modGems.pauseCollect=false modGems.phase="TAKE (WORLD 1)"_Qt({active=true,stage="taking",w1=config.moveWorld1,w2=config.moveWorld2,dropX=config.moveDropX,dropY=config.moveDropY,itemId=_Rp,})if _hy():upper()~=_Rq then modGems.traveling=true modGems.status="Pindah ke World 1: ".._Rq..(_Rr and(":".._Rr)or"").."..."local _Rv,_Rw=_QD(_Rq,_Rr)modGems.traveling=false
                if not _Rv then modGems.status="Gagal masuk World 1 ("..tostring(_Rw).."), coba lagi..."task.wait(4)continue
                end
        end
    if not _Ro()then break
    end modules.Scan()if tileCache.findRefs then tileCache.findRefs()end task.wait(0.8)local _Rx,_Ry=_QL(_Rp)if not _Rx then
    if getWorldPos(_Rp)>0 then modGems.status="Drop di World 1 habis, mengantar sisa tas ke World 2..."else _Qv()modGems.pauseCollect=false modGems.phase="SELESAI"local _Rz=string.format("Auto Move Selesai! %s habis di %s. Total dipindahkan: %d",_gt(_Rp),_Rq,modGems.dropped)modGems.status=_Rz notify(_Rz,"Auto Move Selesai",6)webhookSvc.Send("pabrik",_Rz)break
    end else
while _Ro()and getWorldPos(_Rp)<200
do
    local _RA=_QL(_Rp)if not _RA then break
    end
local _RB,_RC=math.floor(_RA.x),math.floor(_RA.y)modGems.status=string.format("Ambil %s di (%d,%d) [Tas: %d/200]...",_gt(_Rp),_RB,_RC,getWorldPos(_Rp))local _RD=getWorldPos(_Rp)modClick.To(_RB,_RC,function()return not _Ro()end,0.35,false)if tileCache.walkToX then
    local _RE=inputState.active inputState.active=true tileCache.collecting=true tileCache.walkToX(_RA.x,1.0)tileCache.collecting=false inputState.active=_RE
end
local _RF=getWorldMod()local _RG=_RF and rawget(_RF,"takeDrop")if type(_RG)=="function"and _RA.uid then
    local _RH=200-getWorldPos(_Rp)if _RH>0 then pcall(_RG,_RA.uid,math.min(_RA.n or 1,_RH))end
end task.wait(0.35)local _RI=getWorldPos(_Rp)if _RI>_RD then modGems.collected=modGems.collected+(_RI-_RD)end
end
end
end
if not _Ro()then break
end
if getWorldPos(_Rp)>0 then modGems.phase="DROP (WORLD 2)"modGems.pauseCollect=true _Qt({active=true,stage="dropping",w1=config.moveWorld1,w2=config.moveWorld2,dropX=config.moveDropX,dropY=config.moveDropY,itemId=_Rp,})if _hy():upper()~=_Rs or _Rt then modGems.traveling=true modGems.status="Pindah ke World 2: ".._Rs..(_Rt and(":".._Rt)or"").."..."local _RJ,_RK=_QD(_Rs,_Rt)modGems.traveling=false
        if not _RJ then modGems.status="Gagal masuk World 2 ("..tostring(_RK).."), coba lagi..."task.wait(4)continue
        end
end
if not _Ro()then break
end
local _RL,_RM=tonumber(config.moveDropX)or-1,tonumber(config.moveDropY)or-1
if _RL>=0 and _RM>=0 then modGems.status=string.format("Menuju Pos Drop (%d,%d) di %s...",_RL,_RM,_Rs)local _RN=false
    for _RO=1,3
    do
        if not _Ro()then break
        end
    if modClick.To(_RL,_RM,function()return not _Ro()end,0.35,false)then _RN=true break
    end task.wait(0.3)end
if not _RN then modGems.status="Gagal jalan ke Pos Drop di World 2, coba ulang..."task.wait(2)continue
end else
local _RP,_RQ=_hv()_RL,_RM=_RP or 50,_RQ or 30
end
local _RR=_hg()if _RR and(_RR.facing or 1)<0 then inputState.active=true inputState.right=true task.wait(0.06)_cO()inputState.active=false
end
local _RS,_RT=_QW(_Rp,_RL,_RM,_Ro)if not _RS and _RT then modGems.status="Peringatan Drop: "..tostring(_RT)task.wait(2)end _Qt({active=true,stage="taking",w1=config.moveWorld1,w2=config.moveWorld2,dropX=config.moveDropX,dropY=config.moveDropY,itemId=_Rp,})end task.wait(0.3)end modGems.pauseCollect=false
end
function modGems.Stop()_Qv()if not modGems.on then
        return false
    end modGems.token=modGems.token+1 modGems.on=false modGems.traveling=false modGems.pauseCollect=false _cO()inputState.active=false modGems.phase="-"modGems.status="Mati"if _sV then _sV()end
return true
end
function modGems.Start()if modGems.on then
        return true
    end
local _RU=modGems.ParseWorld(config.moveWorld1)local _RV=modGems.ParseWorld(config.moveWorld2)local _RW=tonumber(config.moveItemId)or 0
if _RU==""or _RV==""then notify("Auto Move: Isi nama World 1 dan World 2 terlebih dahulu!")return false
end
if config.moveDropX<0 or config.moveDropY<0 then notify("Auto Move: SetPos Drop di World 2 terlebih dahulu!")return false
end
if _RW<=0 or not itemDB[_RW]then notify("Auto Move: ID Item tidak valid!")return false
end
if modAutoPlace.on then _vM()end
if modBreak.on then modBreak.Stop()end
if modTrees.on then modTrees.Stop()end
if modDirt.on then modDirt.Stop()end
if _te.on then _te.Stop()end
if modFarm.on then modFarm.Stop()end modGems.token=modGems.token+1
local _RX=modGems.token modGems.on=true modGems.phase="MULAI"modGems.status="Inisialisasi Auto Move..."if _sV then _sV()end task.spawn(function()local _RY,_RZ=pcall(_Rm,_RX)if not _RY then warn("[ANCHHub] AutoMove error: "..tostring(_RZ))end modGems.pauseCollect=false _cO()inputState.active=false
    if modGems.token==_RX then modGems.on=false modGems.traveling=false
        if modGems.phase~="SELESAI"then modGems.status="Mati"end
        if _sV then _sV()end
    end end)return true
end
function modGems.CheckStartup()pcall(function()if not(isfile and readfile and isfile(file_ANCHHub_AutoMove))then
            return
        end
    local _Sa=readfile(file_ANCHHub_AutoMove)local _Sb=svc_HttpSvc:JSONDecode(_Sa)if type(_Sb)~="table"or not _Sb.active then
        return
    end
if os.time()-(tonumber(_Sb.updatedAt)or 0)>1800 then _Qv()return
end
local _Sc=os.clock()while isAlive()and(os.clock()-_Sc)<30
do
    if _hy()~=""and _hv()then break
    end task.wait(1)end
if not isAlive()or _hy()==""then
    return
end modules.Scan()task.wait(1.2)if _Sb.w1 then config.moveWorld1=_Sb.w1
end
if _Sb.w2 then config.moveWorld2=_Sb.w2
end
if _Sb.dropX then config.moveDropX=_Sb.dropX
end
if _Sb.dropY then config.moveDropY=_Sb.dropY
end
if _Sb.itemId then config.moveItemId=_Sb.itemId
end notify("Melanjutkan progres Auto Move ("..tostring(_Sb.stage or "aktif")..")...","Auto Move ANCH")modGems.Start()end)end end)()end session.Rotation={on=false,token=0,worldIndex=1,currentWorld="-",phase="-",status="Idle",harvested=0,broken=0,planted=0,passes=0,traveling=false,}do(function()local _Sd=session.Rotation
local function _Se(_Sf)if writefile then _Sf.updatedAt=os.time()pcall(writefile,session.ROTATION_STATE_FILE,svc_HttpSvc:JSONEncode(_Sf))end
end
local function _Sg()if writefile then pcall(writefile,session.ROTATION_STATE_FILE,"{\"active\":false}")end
    if isfile and delfile and isfile(session.ROTATION_STATE_FILE)then pcall(delfile,session.ROTATION_STATE_FILE)end
end
function _Sd.ParseWorldsList()local _Sh={}local _Si=tostring(config.rotWorlds or"")for _Sj in string.gmatch(_Si,"[^,\n;]+")do
        local _Sk=trim(_Sj):gsub("%s","")if _Sk~=""then
            local _Sl,_Sm=string.match(_Sk,"^([^:]*):(.+)$")if not _Sl then _Sl=_Sk
            end _Sl=string.upper(_Sl):gsub("[^A-Z0-9]","")if _Sm==""then _Sm=nil
        end
    if _Sl~=""then table.insert(_Sh,{name=_Sl,door=_Sm,raw=_Sl..(_Sm and(":".._Sm)or"")})end
end
end
return _Sh
end
local function _Sn(_So,_Sp)_So=trim(_So):upper()if _So==""then
        return false,"empty world name"end
    if _hy():upper()==_So and not _Sp then
        return true
    end
if _sw then pcall(_sw)end
if _hy()~=""then
    local _Sq=modules.Menu
    if _Sq and type(rawget(_Sq,"openPicker"))=="function"then pcall(_Sq.openPicker)else
        local _Sr=getWorldMod()if _Sr and type(rawget(_Sr,"call"))=="function"then pcall(_Sr.call,"LeaveWorld")end
    end task.wait(1.8)end
local _Ss=getWorldMod()if _Sp and _Ss then rawset(_Ss,"arriveDoor",_Sp)end
local _St=_Ss and rawget(_Ss,"fg")local _Su=modules.Menu
if _Su and type(rawget(_Su,"enter"))=="function"then pcall(_Su.enter,_So)elseif _Ss and type(rawget(_Ss,"enter"))=="function"then pcall(_Ss.enter,_So)else
        return false,"enter function not found"end
    local _Sv=os.clock()while isAlive()and(os.clock()-_Sv)<12
    do
        local _Sw=getWorldMod()if _Sw and rawget(_Sw,"fg")~=_St and _hy():upper()==_So then modules.Scan(true)task.wait(1.2)return true
        end task.wait(0.25)end
return false,"timeout entering ".._So
end
local function _Sx(_Sy,_Sz)local _SA={}local _SB=workspace:GetServerTimeNow()local _SC=1
    for _SD=0,_Sy.h-1
    do
        local _SE={}for _SF=0,_Sy.w-1
        do
            local _SG=placeTile(_Sy,"fg",_SF,_SD)or 0
            if _SG==_Sz then
                local _SH=doFarmAction(_Sy,_SF,_SD,_SG)if _SH and _SB>=_SH then table.insert(_SE,{x=_SF,y=_SD})end
            end
    end if#_SE>0 then
    if _SC==-1 then table.sort(_SE,function(_SI,_SJ)return _SI.x>_SJ.x end)else table.sort(_SE,function(_SK,_SL)return _SK.x<_SL.x end)end
    for k_SM,v_SN in ipairs(_SE)do table.insert(_SA,v_SN)end _SC=-_SC
end
end
return _SA
end
local function _SO(_SP,_SQ)while _SQ()and getWorldPos(_SP)<200
    do
        if not tileCache.list and tileCache.findRefs then tileCache.findRefs()end
        local _SR=tileCache.list
        if type(_SR)~="table"then break
        end
    local _SS,_ST=_hv()_SS,_ST=_SS or 50,_ST or 30
    local _SU,_SV=nil,math.huge
    for k_SW,_SX in ipairs(_SR)do
        if type(_SX)=="table"and v_SX.id==_SP and(v_SX.n or 0)>0 and not v_SX.display and type(v_SX.x)=="number"then
            local _SY=math.abs(v_SX.x-_SS)+math.abs(v_SX.y-_ST)if _SY<_SV then _SU,_SV=v_SX,_SY
            end
    end
end
if not _SU then break
end
local _SZ,_Ta=math.floor(_SU.x),math.floor(_SU.y)_Sd.status=string.format("Collecting dropped %s at (%d,%d)...",_gt(_SP),_SZ,_Ta)modClick.To(_SZ,_Ta,function()return not _SQ()end,0.45,false)task.wait(0.4)end
end
local function _Tb(_Tc,_Td,_Te)local _Tf=math.min(_hR(),_hV())-0.15
    while _Te()and(getWorldPos(_Td)>0)do _Sd.phase="BREAK BLOCKS"local _Tg,_Th=config.rotBreakX,config.rotBreakY
        if _Tg<0 or _Th<0 then _Tg,_Th=config.pabrikBreakX,config.pabrikBreakY
        end
    local _Ti,_Tj=_hv()if _Tg>=0 and _Th>=0 then
        if _Ti~=_Tg or _Tj~=_Th then _Sd.status=string.format("Walking to Break Pos (%d,%d)...",_Tg,_Th)modClick.To(_Tg,_Th,function()return not _Te()end,0.45,false)end else _Tg,_Th=_Ti or 50,_Tj or 30
    end
if not _Te()then break
end
local _Tk,_Tl,_Tm=_hj()local _Tn=(next(config.pabrikTiles)~=nil)and config.pabrikTiles or{["1,0"]=true}local _To={x=_Tg,y=_Th,facing=_Tm or 1,world=_hy()}modAutoPlace.Override={offsets=_Tn,block=_Td,mode="Place + Break"}modAutoPlace.Quiet=true modAutoPlace.token=modAutoPlace.token+1
local _Tp=modAutoPlace.token modAutoPlace.on=true
local _Tq=sessionStats.Broken
local _Tr=sessionStats.Placed+sessionStats.Broken
local _Ts=os.clock()task.spawn(function()while modAutoPlace.on and modAutoPlace.token==_Tp
    do task.wait(0.4)local _Tt=sessionStats.Placed+sessionStats.Broken
        if _Tt~=_Tr then _Tr,_Ts=_Tt,os.clock()end
        if not _Te()or getWorldPos(_Td)<=0 or(os.clock()-_Ts>8)then modAutoPlace.on=false
        end
end end)_Sd.status=string.format("Breaking %s [Remaining: %d]...",_gt(_Td),getWorldPos(_Td))pcall(_vN,_Tp,_To)_Sd.broken=_Sd.broken+math.max(0,sessionStats.Broken-_Tq)modAutoPlace.on=false modAutoPlace.Override=nil modAutoPlace.Quiet=false task.wait(0.25)if getWorldPos(_Td)<=0 then _SO(_Td,_Te)end
end
if not _Te()then
    return
end
if getWorldPos(_Tc)>0 then _Sd.phase="PLANT SEEDS"local _Tu=getWorldMod()if _Tu then
        local _Tv={}local _Tw=1
        for _Tx=0,_Tu.h-1
        do
            local _Ty={}for _Tz=0,_Tu.w-1
            do if(placeTile(_Tu,"fg",_Tz,_Tx)or 0)==0 and _tE(_Tu,_Tz,_Tx,_Tc)then table.insert(_Ty,{x=_Tz,y=_Tx})end
            end if#_Ty>0 then
            if _Tw==-1 then table.sort(_Ty,function(_TA,_TB)return _TA.x>_TB.x end)else table.sort(_Ty,function(_TC,_TD)return _TC.x<_TD.x end)end
            for k_TE,v_TF in ipairs(_Ty)do table.insert(_Tv,v_TF)end _Tw=-_Tw
        end
end
for k_TG,v_TH in ipairs(_Tv)do
    if not _Te()or getWorldPos(_Tc)<=0 then break
    end _Tu=getWorldMod()if _Tu and _tE(_Tu,_TH.x,v_TH.y,_Tc)then
    local _TI=_hg()if not(_TI and modClick.StateReaches(_TI,v_TH.x,v_TH.y,_Tf))then _Sd.status=string.format("Planting Zig-Zag (%d,%d) [Seeds: %d]",v_TH.x,v_TH.y,getWorldPos(_Tc))modClick.To(_TH.x,v_TH.y,function()return not _Te()end,_Tf,false)end
    local _TJ=_hg()if _TJ and modClick.StateReaches(_TJ,v_TH.x,v_TH.y,_Tf+0.5)and _tE(_Tu,v_TH.x,v_TH.y,_Tc)then
        if _ij(_Tc,_TH,1)then _Sd.planted=_Sd.planted+1 sessionStats.Planted=sessionStats.Planted+1 task.wait(math.max(0.05,config.harvestPlantDelay))end
    end
end
end
end
end
end
local function _TK(_TL,_TM)local function _TN()return _Sd.on and _Sd.token==_TL and isAlive()end
    local _TO=math.min(_hR(),_hV())-0.15
    local _TP=tonumber(config.rotSeedId)or 3
    local _TQ=_gK(_TP)or _gQ()_Sd.worldIndex=_TM or 1
    while _TN()do
        local _TR=_Sd.ParseWorldsList()if#_TR==0 then _Sd.status="World list is empty!"notify("Rotation: Fill in the World List first!")break
        end
    if _Sd.worldIndex>#_TR then _Sd.passes=_Sd.passes+1
        if not config.rotLoop then _Sg()_Sd.phase="DONE"_Sd.status="All worlds finished!"notify("Multi-World Rotation finished all worlds!","Rotation ANCH",5)break
        end _Sd.worldIndex=1
end
local _TS=_TR[_Sd.worldIndex]_Sd.currentWorld=_TS.raw _Sd.phase="WARP"_Sd.status=string.format("Entering World [%d/%d]: %s...",_Sd.worldIndex,#_TR,_TS.raw)_Se({active=true,worldIndex=_Sd.worldIndex,worlds=config.rotWorlds,seedId=_TP,})if _hy():upper()~=_TS.name or _TS.door then _Sd.traveling=true
    local _TT,_TU=_Sn(_TS.name,_TS.door)_Sd.traveling=false
    if not _TT then _Sd.status="Failed to enter ".._TS.raw.." ("..tostring(_TU).."), retrying..."task.wait(4)continue
    end
end
if not _TN()then break
end modules.Scan()if tileCache.findRefs then tileCache.findRefs()end task.wait(1.0)while _TN()do
local _TV=getWorldMod()if not _TV or _hy():upper()~=_TS.name then break
end
if getWorldPos(_TQ)>=200 then _Tb(_TP,_TQ,_TN)if not _TN()then break
    end _TV=getWorldMod()end
local _TW=_Sx(_TV,_TP)if#_TW==0 then _SO(_TQ,_TN)if getWorldPos(_TQ)>0 or getWorldPos(_TP)>0 then _Tb(_TP,_TQ,_TN)end break
end _Sd.phase="HARVEST"for k_TX,v_TY in ipairs(_TW)do
if not _TN()then break
end
if getWorldPos(_TQ)>=200 then _Sd.status=("Block reached 200! Breaking & Planting before continuing harvest".."...")_Tb(_TP,_TQ,_TN)break
end _TV=getWorldMod()if _TV and(placeTile(_TV,"fg",v_TY.x,v_TY.y)or 0)==_TP then
local _TZ=_hg()if not(_TZ and modClick.StateReaches(_TZ,_TY.x,_TY.y,_TO))then _Sd.status=string.format("[%s] Harvesting (%d,%d) [%d/%d | Bag: %d/200]",_TS.name,v_TY.x,v_TY.y,k_TX,#_TW,getWorldPos(_TQ))modClick.To(v_TY.x,v_TY.y,function()return not _TN()end,_TO,false)end
local _Ua=_hg()if _Ua and modClick.StateReaches(_Ua,v_TY.x,v_TY.y,_TO+0.5)then
    local _Ub=os.clock()while _TN()and(placeTile(_TV,"fg",v_TY.x,v_TY.y)or 0)==_TP and(os.clock()-_Ub)<3.5
    do
        local _Uc=_iE(v_TY.x,v_TY.y,false)if _Uc=="broke"then _Sd.harvested=_Sd.harvested+1 sessionStats.Harvested=sessionStats.Harvested+1
        end task.wait(math.max(0.05,config.harvestDelay))end task.wait(0.18)end
end
end
end
if not _TN()then break
end
if config.rotDropExcess and config.rotSaveWorld~=""then
    local _Ud=tonumber(config.rotKeepSeed)or 100
    local _Ue=getWorldPos(_TP)-_Ud
    if _Ue>0 and modFarm and modFarm.ExternalDropSeed then _Sd.phase="DROP SURPLUS"_Sd.status=string.format("Dropping %d surplus seeds to %s...",_Ue,config.rotSaveWorld)modFarm.ExternalDropSeed(_TP,_Ue,config.rotSaveWorld,config.rotSaveX,config.rotSaveY,_TS.name,nil,nil,_TN)end
end webhookSvc.Send("pabrik",string.format("Rotation finished World **%s** (%d/%d). Moving to next world!",_TS.name,_Sd.worldIndex,#_TR))_Sd.worldIndex=_Sd.worldIndex+1 _Se({active=true,worldIndex=_Sd.worldIndex,worlds=config.rotWorlds,seedId=_TP,})task.wait(0.8)end
end
function _Sd.Stop()_Sg()if not _Sd.on then
        return false
    end _Sd.token=_Sd.token+1 _Sd.on=false _Sd.traveling=false
if modAutoPlace.Override then modAutoPlace.on=false modAutoPlace.Override=nil modAutoPlace.Quiet=false
end _cO()inputState.active=false _Sd.phase="-"_Sd.status="Idle"if _sV then _sV()end
return true
end
function _Sd.Start(_Uf)if _Sd.on then
        return true
    end
local _Ug=_Sd.ParseWorldsList()if#_Ug==0 then notify("Rotation: Enter at least 1 world in the World List!")return false
end
local _Uh=tonumber(config.rotSeedId)or 0
if _Uh<=0 or not _gK(_Uh)then notify("Rotation: Invalid Seed ID!")return false
end
if modAutoPlace.on then _vM()end
if modBreak.on then modBreak.Stop()end
if modTrees.on then modTrees.Stop()end
if modDirt.on then modDirt.Stop()end
if _te.on then _te.Stop()end
if modFarm.on then modFarm.Stop()end
if modGems.on then modGems.Stop()end _Sd.token=_Sd.token+1
local _Ui=_Sd.token _Sd.on=true _Sd.phase="STARTING"_Sd.status="Initializing Multi-World Rotation..."if _sV then _sV()end task.spawn(function()local _Uj,_Uk=pcall(_TK,_Ui,_Uf or 1)if not _Uj then warn("[ANCHHub] Rotation error: "..tostring(_Uk))end _cO()inputState.active=false
    if _Sd.token==_Ui then _Sd.on=false _Sd.traveling=false
        if _Sd.phase~="DONE"then _Sd.status="Idle"end
        if _sV then _sV()end
    end end)return true
end
function _Sd.CheckStartup()pcall(function()if not(isfile and readfile and isfile(session.ROTATION_STATE_FILE))then
            return
        end
    local _Ul=readfile(session.ROTATION_STATE_FILE)local _Um=svc_HttpSvc:JSONDecode(_Ul)if type(_Um)~="table"or not _Um.active then
        return
    end
if os.time()-(tonumber(_Um.updatedAt)or 0)>1800 then _Sg()return
end
local _Un=os.clock()while isAlive()and(os.clock()-_Un)<30
do
    if _hy()~=""and _hv()then break
    end task.wait(1)end
if not isAlive()or _hy()==""then
    return
end modules.Scan(true)task.wait(1.2)if _Um.worlds then config.rotWorlds=_Um.worlds
end
if _Um.seedId then config.rotSeedId=_Um.seedId
end notify("Resuming Multi-World Rotation (World #"..tostring(_Um.worldIndex or 1)..")...","Rotation ANCH")_Sd.Start(tonumber(_Um.worldIndex)or 1)end)end end)()end do(function()local _Uo={[242]=true,[1796]=true,[7188]=true}local _Up={{from=242,to=1796,name="Diamond Lock"},{from=1796,to=7188,name="Blue Gem Lock"},}local function _Uq(...)local _Ur=getWorldMod()local _Us=_Ur and rawget(_Ur,"call")if type(_Us)~="function"then
        return false
    end
return pcall(_Us,...)end
local function _Ut(_Uu)local _Uv=itemDB[_Uu]return _Uv~=nil and _Uv.kind~="tool"and not _Uv.lock and not _Uo[_Uu]end
function modRecycle.Recycle(_Uw,_Ux)if not modules.Inv or _Ux<=0 or not _Ut(_Uw)then
        return false
    end _Ux=math.min(_Ux,getWorldPos(_Uw))if _Ux<=0 then
    return false
end pcall(function()modules.Inv:remove(_Uw,_Ux)end)local _Uy=_Uq("Recycle",_Uw,_Ux)if _Uy then modRecycle.recycled=modRecycle.recycled+(_Ux)modRecycle.status=string.format("Recycle %s x%d",_gt(_Uw),_Ux)end
return _Uy
end
local function _Uz(_UA)local _UB=modules.Inv
    if not _UB or getWorldPos(_UA.from)<100 then
        return false
    end
if getWorldPos(_UA.to)+1>200 then
    return false
end pcall(function()_UB:remove(_UA.from,100)_UB:add(_UA.to,1)end)local _UC=_Uq("ConvertLock",_UA.from,_UA.to)if _UC then modRecycle.converted=modRecycle.converted+(1)modRecycle.status="Convert ke ".._UA.name
end
return _UC
end task.spawn(function()while isAlive()do pcall(function()if config.trashOn and type(config.trashList)=="table"then
            for k_UD,v_UE in ipairs(config.trashList)do
                local _UF=getWorldPos(v_UE)if _UF>=config.trashAt and _UF>config.trashKeep then modRecycle.Recycle(v_UE,_UF-config.trashKeep)task.wait(0.5)end
            end
    end
if config.convertLockOn then
    for k_UG,v_UH in ipairs(_Up)do
        if _Uz(v_UH)then task.wait(0.5)end
    end
end end)task.wait(2.5)end end)end)()end
local _UI={on=false,token=0,status="Mati",stocked=0,taken=0,dropped=0,picked={},carry={}}do(function()function _UI.ParsePoint()local _UJ=tostring(config.vendPoint or""):gsub("%s","")local _UK,_UL=string.match(_UJ,"^([^:|]*)[:|](.+)$")if not _UK then _UK=_UJ
            end _UK=string.upper(_UK):gsub("[^A-Z0-9]","")if _UL==""then _UL=nil
        end
    return _UK,_UL
end
function _UI.Sellable(_UM)if type(_UM)~="number"or _UM==112 then
        return false
    end
local _UN=itemDB[_UM]if not _UN or _UN.kind=="tool"then
    return false
end
if _UN.lock or _UN.area or _UN.guildLock or _UN.untradeable or _UN.vend or _UN.hub then
    return false
end
return true
end
function _UI.Allow(_UO)if not _UI.Sellable(_UO)then
        return false
    end
if type(config.vendItems)=="table"and#config.vendItems>0 and not table.find(config.vendItems,_UO)then
    return false
end
return true
end
function _UI.Machines()local _UP=getWorldMod()local _UQ={}if not _UP then
        return _UQ
    end
local _UR=os.clock()local _US=_UI.MachCache
local _UT
if _US and _US.w==_UP and(_UR-_US.at)<10 then _UT=_US.list else _UT={}for _UU=0,_UP.h-1
    do
        local _UV=_UP.fg[_UU]if _UV then
            for _UW=0,_UP.w-1
            do
                local _UX=_UV[_UW]or 0
                local _UY=_UX~=0 and itemDB[_UX]if _UY and _UY.vend then table.insert(_UT,{x=_UW,y=_UU,fg=_UX})end
            end
    end
end _UI.MachCache={w=_UP,at=_UR,list=_UT}end
local _UZ=rawget(_UP,"vends")local _Va=rawget(_UP,"vendOwner")for _Vb,_Vc in ipairs(_UT)do
    local _Vd,_Ve=true,true
    if type(_Va)=="function"then _Vd,_Ve=pcall(_Va,v_Vc.x,v_Vc.y)end
    if _Vd and _Ve then
        local _Vf=nil
        if type(_UZ)=="table"and type(_UZ.get)=="function"then
            local _Vg,_Vh=pcall(_UZ.get,_Vc.x,_Vc.y)if _Vg and type(_Vh)=="table"then _Vf=_Vh
            end
    end _Vf=_Vf or{}if not _Vf.shop then table.insert(_UQ,{x=v_Vc.x,y=v_Vc.y,fg=v_Vc.fg,id=_Vf.id,stock=tonumber(_Vf.stock)or 0,cap=(v_Vc.fg==9268)and 10398 or 5199,})end
end
end
return _UQ
end
function _UI.Call(...)local _Vi=getWorldMod()local _Vj=_Vi and rawget(_Vi,"vendCall")if type(_Vj)~="function"then
        return false
    end
local _Vk,_Vl=pcall(_Vj,...)return _Vk and _Vl==true
end
local function _Vm(_Vn,_Vo)local function _Vp()return _UI.on and _UI.token==_Vn and isAlive()end
    while _Vp()do
        local _Vq=_UI.Machines()if#_Vq==0 then _UI.status="Tidak ada Vending milikmu di world ini!"break
        end
    if config.vendMode=="Kosongkan sampai habis"then
        local _Vr=false
        for k_Vs,v_Vt in ipairs(_Vq)do
            if not _Vp()then break
            end
        if _Vt.id and _Vt.stock>0 and _UI.Allow(v_Vt.id)then _UI.status=string.format("Mengambil %s dari Vending (%d,%d)...",_gt(v_Vt.id),v_Vt.x,v_Vt.y)modClick.To(v_Vt.x,v_Vt.y,function()return not _Vp()end,0.4,false)local _Vu=getWorldPos(v_Vt.id)_UI.Call("empty",v_Vt.x,v_Vt.y)task.wait(0.45)local _Vv=getWorldPos(_Vt.id)-_Vu
            if _Vv>0 then _UI.taken=_UI.taken+_Vv _Vr=true
            end
        if getWorldPos(v_Vt.id)>=190 and modFarm and modFarm.ExternalDropSeed then modFarm.ExternalDropSeed(v_Vt.id,getWorldPos(v_Vt.id),config.vendPoint,config.vendDropX,config.vendDropY,_Vo,v_Vt.x,v_Vt.y,_Vp)end
    end
end
if not _Vr then _UI.status="Semua Vending sudah kosong!"break
end else
local _Vw=false
for k_Vx,v_Vy in ipairs(_Vq)do
    if not _Vp()then break
    end
local _Vz=(v_Vy.id and v_Vy.stock>0)and v_Vy.id or nil
if _Vz and _UI.Allow(_Vz)then
    local _VA=math.min(getWorldPos(_Vz),v_Vy.cap-v_Vy.stock)if _VA>0 then _UI.status=string.format("Mengisi %s +%d ke Vending (%d,%d)...",_gt(_Vz),_VA,v_Vy.x,v_Vy.y)modClick.To(v_Vy.x,v_Vy.y,function()return not _Vp()end,0.4,false)if _UI.Call("stock",v_Vy.x,v_Vy.y,_Vz,_VA)then _UI.stocked=_UI.stocked+_VA _Vw=true task.wait(0.35)end
    end
end
end
if not _Vw then _UI.status="Menunggu item di tas / drop untuk dimasukkan ke Vending..."task.wait(2)end
end task.wait(0.5)end
end
function _UI.Stop()if not _UI.on then
        return false
    end _UI.token=_UI.token+1 _UI.on=false _UI.status="Mati"return true
end
function _UI.Start()if _UI.on then
        return true
    end _UI.token=_UI.token+1
local _VB=_UI.token _UI.on=true _UI.status="Mulai..."local _VC=_hy()task.spawn(function()pcall(_Vm,_VB,_VC)if _UI.token==_VB then _UI.on=false
        if _sV then _sV()end
    end end)return true
end end)()end do(function()local function _VD(_VE)return(tostring(_VE or""):gsub("`.",""))end
local function _VF(_VG)if not(_bd and type(_be)=="table")then
        return nil
    end
local _VH,_VI=pcall(_be.isDeveloper,_VG)if _VH and _VI then
    return "Developer"end
local _VJ,_VK=pcall(_be.isModerator,_VG)if _VJ and _VK then
    return "Moderator"end
return nil
end
local function _VL()local _VM={}local _VN=modules.Others
    if not _VN or type(rawget(_VN,"list"))~="function"then
        return _VM
    end
local _VO,_VP=pcall(_VN.list)if not _VO or type(_VP)~="table"then
    return _VM
end
for k_VQ,v_VR in ipairs(_VP)do
    local _VS=type(v_VR)=="table"and tonumber(v_VR[1]or v_VR.userId)if _VS and _VS~=localPlayer.UserId then _VM[#_VM+1]={id=_VS,name=_VD(v_VR[2]or v_VR.name or _VS),role=_VF(_VS)}end
end
return _VM
end
local function _VT(_VU)local _VV={}for k_VW,v_VX in ipairs(_VU)do
        if v_VX.role or(config.guardWho=="Semua pemain"and not modIntrusion.allow[v_VX.id])then _VV[#_VV+1]=v_VX
        end
end
return _VV
end
local function _VY(_VZ)local _Wa=false
    if _VZ.role and _bd and type(_be.isUndercover)=="function"then
        local _Wb,_Wc=pcall(_be.isUndercover,_VZ.id)_Wa=_Wb and _Wc==true
    end
return _VZ.name.." ("..(_VZ.role or "Pemain")..(_Wa and ", undercover"or"")..")"end
local function _Wd(_We)local _Wf={}for _Wg,_Wh in ipairs(_We)do
        if k_Wg>5 then _Wf[#_Wf+1]="+"..(#_We-k_Wg+1).." lagi"break
        end _Wf[#_Wf+1]=_VY(v_Wh)end return#_Wf>0 and table.concat(_Wf,", ")or "tidak ada"end
local function _Wi()return(modAutoPlace.on and not modAutoPlace.Override)or modBreak.on or modTrees.on or modDirt.on or _te.on or modFarm.on or _tk.on
end
local function _Wj()local _Wk,_Wl=_hv()return{farm=modAutoPlace.on and not modAutoPlace.Override,clear=modBreak.on,farmer=modTrees.on,df=modDirt.on,splice=_te.on,pabrik=modFarm.on,spam=_tk.on,world=_hy(),tx=_Wk,ty=_Wl,}end
local function _Wm()if modFarm.on then modFarm.Stop()end
    if _te.on then _te.Stop()end
    if modAutoPlace.on then _vM()end
    if modBreak.on then modBreak.Stop();modBreak.status="Dijeda Penjaga"end
    if modTrees.on then modTrees.Stop();modTrees.status="Dijeda Penjaga"end
    if modDirt.on then modDirt.Stop();modDirt.status="Dijeda Penjaga"end
    if _tk.on then _tk.on=false
    end _cO()if _sV then _sV()end
end
local function _Wn()local _Wo=modules.Menu
    if _Wo and type(rawget(_Wo,"openPicker"))=="function"and pcall(_Wo.openPicker)then
        return true
    end
local _Wp=getWorldMod()if _Wp and type(rawget(_Wp,"call"))=="function"then
    return pcall(_Wp.call,"LeaveWorld")end
return false
end
local function _Wq(_Wr)local _Ws=getWorldMod()if not _Ws or _Wr==""then
        return false
    end
local _Wt=rawget(_Ws,"fg")local _Wu=modules.Menu
if _Wu and type(rawget(_Wu,"enter"))=="function"then pcall(_Wu.enter,_Wr)elseif type(rawget(_Ws,"enter"))=="function"then pcall(_Ws.enter,_Wr)else
        return false
    end
local _Wv=os.clock()while isAlive()and os.clock()-_Wv<8
do
    local _Ww=getWorldMod()if _Ww and rawget(_Ww,"fg")~=_Wt then
        return true
    end task.wait(0.25)end
return false
end
local function _Wx(_Wy,_Wz)if not _Wy then
        return
    end
if _Wy.world~=""and _hy()~=_Wy.world then
    return
end
if _Wy.spam then _tk.on=true
end
if _Wy.tx and _Wy.ty then
    local _WA,_WB=_hv()if _WA and(_WA~=_Wy.tx or _WB~=_Wy.ty)then modIntrusion.status=string.format("Jalan balik ke (%d,%d)...",_Wy.tx,_Wy.ty)modClick.To(_Wy.tx,_Wy.ty,function()return(_Wz and modIntrusion.token~=_Wz)or not isAlive()end,0.3,true)end
end
if _Wz and modIntrusion.token~=_Wz then
    return
end
if _Wy.farm then _vL()elseif _Wy.clear then modBreak.Start()elseif _Wy.farmer then modTrees.Start()elseif _Wy.df then modDirt.Start()elseif _Wy.splice then _te.Start()elseif _Wy.pabrik then modFarm.Start()end
                    if _sV then _sV()end
                end modIntrusion.Snapshot=_Wj modIntrusion.StopAllBots=_Wm modIntrusion.LeaveWorld=_Wn modIntrusion.EnterWorld=_Wq modIntrusion.ResumeSaved=_Wx modIntrusion.AnyRunning=_Wi
            function modIntrusion.AllowCurrentPlayers()local _WC=0
                for k_WD,v_WE in ipairs(_VL())do
                    if not v_WE.role then modIntrusion.allow[_WE.id]=true _WC=_WC+(1)end
                end
            return _WC
        end
    function modIntrusion.Set(_WF)modIntrusion.on=_WF modIntrusion.token=modIntrusion.token+(1)modIntrusion.mode,modIntrusion.saved,modIntrusion.calmAt="idle",nil,nil table.clear(modIntrusion.alerted)table.clear(modIntrusion.allow)if _WF then modIntrusion.AllowCurrentPlayers()modIntrusion.status="Aman (Memantau)"else modIntrusion.status="Mati"end
    end task.spawn(function()while isAlive()do pcall(function()local _WG={}for k_WH,v_WI in ipairs(_u:GetPlayers())do
                if _WI~=localPlayer then
                    local _WJ=_VF(_WI.UserId)if _WJ then table.insert(_WG,(_WI.DisplayName or _WI.Name).." (".._WJ..")")end
                end
        end modIntrusion.staffServerText=#_WG>0 and table.concat(_WG,", ")or "tidak ada"local _WK=(modIntrusion.mode~="away"and modIntrusion.mode~="out")and _VL()or{}modIntrusion.hereText=_Wd(_WK)if not modIntrusion.on then modIntrusion.status="Mati"return
    end
local _WL=os.clock()if modIntrusion.mode=="away"or modIntrusion.mode=="out"then
    local _WM=modIntrusion.saved and modIntrusion.saved.world or""if modIntrusion.mode=="out"or _WM==""then modIntrusion.status="Sudah keluar world"return
    end
local _WN=modIntrusion.backAt-_WL
if _WN>0 then modIntrusion.status=string.format("Di luar world. Masuk %s dlm %ds",_WM,math.ceil(_WN))return
end modIntrusion.status="Masuk kembali ke ".._WM.."..."if _Wq(_WM)then modules.Scan()task.wait(1.5)local _WO=_VT(_VL())if#_WO>0 then notify("Masih ada ".._Wd(_WO).."! Keluar lagi.","Penjaga ANCH")_Wn()modIntrusion.backAt=os.clock()+config.guardBackSec else notify("World sudah aman, melanjutkan aktivitas!","Penjaga ANCH")webhookSvc.Send("penjaga","World ".._WM.." aman, lanjut aktivitas")local _WP=modIntrusion.saved modIntrusion.mode,modIntrusion.saved="idle",nil modIntrusion.token=modIntrusion.token+(1)local _WQ=modIntrusion.token task.spawn(_Wx,_WP,_WQ)end else modIntrusion.backAt=os.clock()+math.max(15,config.guardBackSec)end
return
end
local _WR={}for k_WS,v_WT in ipairs(_WK)do _WR[v_WT.id]=true
end
for _WU in pairs(modIntrusion.alerted)do
    if not _WR[_WU]then modIntrusion.alerted[_WU]=nil
    end
end
local _WV=_VT(_WK)local _WW={}for k_WX,v_WY in ipairs(_WV)do
    if not modIntrusion.alerted[v_WY.id]then modIntrusion.alerted[v_WY.id]=true _WW[#_WW+1]=_WY
    end
end if#_WW>0 then modIntrusion.detected=modIntrusion.detected+(#_WW)local _WZ="Terdeteksi masuk world ".._hy()..": ".._Wd(_WW)notify(_WZ,"PERINGATAN PENJAGA",6)webhookSvc.Send("penjaga",_WZ)if config.guardStopAll or config.guardLeave then
    if not modIntrusion.saved then modIntrusion.saved=_Wj()end modIntrusion.token=modIntrusion.token+(1)_Wm()modIntrusion.calmAt=nil
    if config.guardLeave then
        if _Wn()then modIntrusion.backAt=os.clock()+config.guardBackSec modIntrusion.mode=config.guardAutoBack and "away"or "out"modIntrusion.status="Keluar world"return
        end
end modIntrusion.mode="pause"end
end if#_WV>0 then modIntrusion.calmAt=nil modIntrusion.status=(modIntrusion.mode=="pause"and "Dijeda! Ada: "or "Waspada! Ada: ").._Wd(_WV)elseif modIntrusion.mode=="pause"then modIntrusion.calmAt=modIntrusion.calmAt or _WL
    local _Xa=config.guardCalmSec-(_WL-modIntrusion.calmAt)if _Xa>0 then modIntrusion.status=string.format("Sudah sepi. Lanjut dlm %ds...",math.ceil(_Xa))else modIntrusion.calmAt=nil
        local _Xb=modIntrusion.saved modIntrusion.mode,modIntrusion.saved="idle",nil
        if config.guardAutoBack and _Xb then notify("World aman, melanjutkan aktivitas!","Penjaga ANCH")modIntrusion.token=modIntrusion.token+(1)local _Xc=modIntrusion.token task.spawn(_Wx,_Xb,_Xc)end
    end else modIntrusion.status="Aman (Memantau)"end end)task.wait(0.5)end end)function _tj.TargetWorld()local _Xd=tostring(config.targetWorld or""):upper():gsub("[^A-Z0-9]","")if _Xd~=""then
return _Xd
end
return config.lastWorld or""end task.spawn(function()while isAlive()do
    local _Xe=_hy()if _Xe~=""and not modFarm.traveling and not modGems.traveling and not(session.Rotation and _d.Rotation.traveling)then config.lastWorld=_Xe
    end
if _Wi()and modIntrusion.mode=="idle"then _tj.last=_Wj()_tj.lastAt=os.clock()else _tj.last=nil
end task.wait(1)end end)local function _Xf(_Xg)if not(config.reconnectOn and config.reconnectWorld)or _tj.busy or modFarm.traveling then
        return
    end
if modIntrusion.mode=="away"or modIntrusion.mode=="out"then
    return
end
local _Xh=_tj.last
if not _Xh or _Xh.world==""or os.clock()-_tj.lastAt>15 then
    return
end _tj.busy=true task.spawn(function()_Wm()_tj.status="Terlempar dari ".._Xh.world..". Masuk lagi..."webhookSvc.Send("rejoin","Terlempar dari world ".._Xh.world.." (".._VD(_Xg)..")")task.wait(config.reconnectDelay+1.5)for _Xi=1,3
do
    if not isAlive()or not config.reconnectOn then break
    end
if _Wq(_Xh.world)then modules.Scan()task.wait(1.5)_tj.count=_tj.count+(1)_tj.status="Berhasil masuk lagi ke ".._Xh.world webhookSvc.Send("rejoin","Berhasil masuk kembali ke ".._Xh.world)_Wx(_Xh,nil)_tj.busy=false
    return
end _tj.status=string.format("Gagal masuk (%d/3), coba lagi...",_Xi)task.wait(8)end _tj.busy=false end)end
if remote_WorldClosed and remote_WorldClosed:IsA("RemoteEvent")then _f(remote_WorldClosed.OnClientEvent:Connect(function(_Xj)if _e()then _Xf(_Xj)end end))end task.spawn(function()local _Xk=nil
    while isAlive()do task.wait(2)local _Xl=_hy()==""local _Xm=config.reconnectOn and config.reconnectKeep and not _tj.busy and not _tj.leaving and not modFarm.traveling and modIntrusion.mode=="idle"if not(_Xl and _Xm)then _Xk=nil else _Xk=_Xk or os.clock()local _Xn=_tj.TargetWorld()if _Xn~=""and os.clock()-_Xk>=config.reconnectDelay then _Xk=nil _tj.busy=true _tj.status="Di luar world, masuk ke ".._Xn.."..."if _Wq(_Xn)then modules.Scan()task.wait(1.5)_tj.count=_tj.count+(1)_tj.status="Kembali otomatis ke ".._Xn
                    if _tj.last and _tj.last.world==_Xn then _Wx(_tj.last,nil)end
                end _tj.busy=false
        end
end
end end)pcall(function()_f(svc_GuiSvc.ErrorMessageChanged:Connect(function(_Xo)if not isAlive()or type(_Xo)~="string"or _Xo==""then
    return
end
if not(config.reconnectOn and config.reconnectServer)or _tj.leaving then
    return
end _tj.leaving=true
local _Xp=_tj.last or(_Wi()and _Wj())or nil
local _Xq=(_Xp and _Xp.world)or _hy()if writefile and _Xp then _Xp.at=os.time()pcall(writefile,file_ANCHHub_Rejoin,svc_HttpSvc:JSONEncode(_Xp))end
if _sw then pcall(_sw)end webhookSvc.Send("rejoin","Disconnect dari server (".._Xo.."). Rejoin otomatis...")task.spawn(function()task.wait(config.reconnectDelay)while isAlive()do pcall(function()svc_TeleportSvc:Teleport(game.PlaceId,localPlayer,(_Xq~="")and{world=_Xq}or nil)end)task.wait(12)end end)end))end)function _tj.CheckStartup()pcall(function()if not(isfile and readfile and isfile(file_ANCHHub_Rejoin))then
    return
end
local _Xr=readfile(file_ANCHHub_Rejoin)if delfile then pcall(delfile,file_ANCHHub_Rejoin)end
local _Xs=svc_HttpSvc:JSONDecode(_Xr)if type(_Xs)~="table"or type(_Xs.world)~="string"or _Xs.world==""then
    return
end
if os.time()-(tonumber(_Xs.at)or 0)>900 then
    return
end _tj.busy=true _tj.status="Pulihkan sesi setelah Rejoin Server: ".._Xs.world
local _Xt=os.clock()local _Xu=false
while isAlive()and os.clock()-_Xt<50
do
    if _hy()==_Xs.world and _hv()then break
    end
if _hy()==""and not _Xu and os.clock()-_Xt>8 then _Xu=true _Wq(_Xs.world)end task.wait(2)end
if isAlive()and _hy()==_Xs.world then modules.Scan()task.wait(1.5)_tj.count=_tj.count+(1)webhookSvc.Send("rejoin","Berhasil rejoin server ke world ".._Xs.world..", melanjutkan bot!")_Wx(_Xs,nil)end _tj.busy=false end)end end)()end
local _Xv={claimed=0,redeemed=0,tried={},questFail={},questText="-",codeText="-",nextQuest=0,nextCode=0,}local _Xw={saved={}}do(function()local function _Xx(_Xy)local _Xz=tostring(math.floor(tonumber(_Xy)or 0))local _XA=_Xz:sub(1,1)=="-"if _XA then _Xz=_Xz:sub(2)end
            local _XB=_Xz:reverse():gsub("(%d%d%d)","%1."):reverse():gsub("^%.","")return(_XA and "-"or"").._XB
        end
    local function _XC(_XD)_XD=math.max(0,math.floor(_XD or 0))return string.format("%dj %dm %dd",math.floor(_XD/3600),math.floor((_XD%3600)/60),_XD%60)end
    function sessionStats.GemsNow()local _XE=modules.Gems
        local _XF=_XE and rawget(_XE,"addGems")if type(_XF)~="function"then
            return nil
        end
    for k_XG,v_XH in pairs(getUpvalues(_XF))do
        if type(v_XH)=="number"then
            return _XH
        end
end
return nil
end
function sessionStats.Reset()sessionStats.T0=os.clock()sessionStats.Gems0=sessionStats.GemsNow()sessionStats.Placed=0 sessionStats.Broken=0 sessionStats.Collected=0 sessionStats.Harvested=0 sessionStats.Planted=0 table.clear(sessionStats.Items)end
function sessionStats.Text()local _XI=math.max((os.clock()-sessionStats.T0)/3600,1/3600)local function _XJ(_XK,_XL)return string.format("%s: %s (%s/hr)",_XK,_Xx(_XL),_Xx(_XL/_XI))end
    local _XM=sessionStats.GemsNow()if _XM and not sessionStats.Gems0 then sessionStats.Gems0=_XM
    end
local _XN="Gems: -"if _XM and sessionStats.Gems0 then
    local _XO=_XM-sessionStats.Gems0 _XN=string.format("Gems: %s (%s%s, %s/hr)",_Xx(_XM),_XO>=0 and "+"or"",_Xx(_XO),_Xx(_XO/_XI))end
local _XP={}for k_XQ,_XR in pairs(sessionStats.Items)do table.insert(_XP,{id=k_XQ,n=v_XR})end table.sort(_XP,function(_XS,_XT)return _XS.n>_XT.n end)local _XU={}for _XV=1,math.min(5,#_XP)do _XU[_XV]=_gt(_XP[_XV].id).." x".._Xx(_XP[_XV].n)end
return table.concat({"Session Time: ".._XC(os.clock()-sessionStats.T0),_XN,_XJ("Blocks Broken",sessionStats.Broken),_XJ("Blocks Placed",sessionStats.Placed),_XJ("Drops Collected",sessionStats.Collected),_XJ("Trees Harvested",sessionStats.Harvested),_XJ("Seeds Planted",sessionStats.Planted),"Top Collected: "..(#_XU>0 and table.concat(_XU,", ")or "-"),},"\n")end task.spawn(function()local _XW=os.clock()while isAlive()do
    if config.webhookReportMin>0 and(os.clock()-_XW)>=config.webhookReportMin*60 then _XW=os.clock()local _XX,_XY=pcall(sessionStats.Text)if _XX then webhookSvc.Send("report","Laporan Statistik Sesi\n```\n".._XY.."\n```")end elseif config.webhookReportMin<=0 then _XW=os.clock()end task.wait(2)end end)local function _XZ()local obj_WorldChannels=svc_TextChatSvc:FindFirstChild("WorldChannels")if not obj_WorldChannels then
        return nil
    end
local _Yb=_hy()if _Yb~=""and obj_WorldChannels:FindFirstChild(_Yb)then
    return obj_WorldChannels:FindFirstChild(_Yb)end
for k_Yc,v_Yd in ipairs(obj_WorldChannels:GetChildren())do
    if v_Yd:IsA("TextChannel")then
        for _Ye,_Yf in ipairs(v_Yd:GetChildren())do
            if v_Yf:IsA("TextSource")and _Yf.UserId==localPlayer.UserId then
                return v_Yd
            end
    end
end
end
return nil
end
function _tk.SendNext()local _Yg=trim(config.chatText)if _Yg==""then _tk.last="Pesan chat belum diisi"return false
    end
local _Yh=_XZ()if not _Yh then _tk.last="Channel chat belum ada"return false
end
local _Yi,_Yj=pcall(_Yh.SendAsync,_Yh,_Yg)if _Yi then _tk.sent=_tk.sent+(1)_tk.last=_Yg else _tk.last="Gagal: "..tostring(_Yj)end
return _Yi
end task.spawn(function()while isAlive()do
    if _tk.on and os.clock()>=_tk.nextAt then _tk.SendNext()_tk.nextAt=os.clock()+math.max(3,config.chatInterval)end task.wait(0.3)end end)local function _Yk(_Yl)return(tostring(_Yl or""):gsub("`.",""))end
local function _Ym(...)if _bb and type(_bc)=="table"and type(_bc.call)=="function"then
        return pcall(_bc.call,...)end
    return false,"Net.call tidak tersedia"end
function _Xv.CheckQuests()local _Yn,_Yo,_Yp=_Ym("Quests","list")if not _Yn or not _Yo or type(_Yp)~="table"or type(_Yp.quests)~="table"then _Xv.questText="Quest belum terbaca dari server"return
    end
local _Yq,_Yr=0,0
local _Ys=os.clock()for k_Yt,v_Yu in ipairs(_Yp.quests)do _Yq=_Yq+(1)local _Yv,_Yw=tonumber(v_Yu.have)or 0,tonumber(v_Yu.need)or math.huge
    if v_Yu.claimed then _Yr=_Yr+(1)elseif _Yv>=_Yw and not((_Xv.questFail[_Yu.id]or 0)>_Ys)then
            local _Yx,_Yy,_Yz,_YA,_YB=_Ym("Quests","claim",_Yu.id)if _Yx and _Yy then _Yr=_Yr+(1)_Xv.claimed=_Xv.claimed+(1)local _YC=_Yk(_Yu.text or v_Yu.id)notify("Quest diklaim: ".._YC,"Bonus ANCH")webhookSvc.Send("bonus","Quest diklaim: ".._YC)if type(_YB)=="number"and modules.Gems and type(modules.Gems.setGems)=="function"then pcall(modules.Gems.setGems,_YB)end else _Xv.questFail[v_Yu.id]=_Ys+120
            end task.wait(0.5)end
end _Xv.questText=string.format("Selesai: %d/%d | Diklaim script: %d",_Yr,_Yq,_Xv.claimed)end
function _Xv.RedeemSingle(_YD)local _YE,_YF=_Ym("ModCommand","redeemcode",_YD)if not _YE then
        return nil,"Gagal menghubungi server"end
    local _YG=type(_YF)=="table"and type(_YF.lines)=="table"and _YF.lines or nil
    if not _YG then
        return false,"Balasan kosong"end
    local _YH=tostring(_YG[1]or"")local _YI={}for k_YJ,v_YK in ipairs(_YG)do table.insert(_YI,_Yk(v_YK))end
    return string.sub(_YH,1,2)=="`2",table.concat(_YI," ")end
function _Xv.CheckCodes()local _YL,_YM=_Ym("ActiveCodes")if not _YL or type(_YM)~="table"then _Xv.codeText="Gagal mengambil ActiveCodes"return
    end
if _YM.note~=nil then _Xv.codeText="Redeem ditutup: ".._Yk(_YM.note)return
end
local _YN,_YO=0,0
for k_YP,v_YQ in ipairs(_YM)do _YN=_YN+(1)local _YR=v_YQ.code and tostring(v_YQ.code)if v_YQ.done then _YO=_YO+(1)elseif _YR and not _Xv.tried[_YR]and not(type(v_YQ.uses)=="number"and v_YQ.uses==0)then
            local _YS,_YT=_Xv.RedeemSingle(_YR)if _YS~=nil then _Xv.tried[_YR]=true
            end
        if _YS then _YO=_YO+(1)_Xv.redeemed=_Xv.redeemed+(1)notify(_YR.." -> "..tostring(_YT),"Redeem Berhasil!")webhookSvc.Send("bonus","Redeem berhasil ".._YR..": "..tostring(_YT))end task.wait(0.8)end
end _Xv.codeText=string.format("Code aktif: %d | Sudah ditukar: %d | Baru: %d",_YN,_YO,_Xv.redeemed)end task.spawn(function()while isAlive()do
local _YU=os.clock()if config.bonusAutoQuest and _YU>=_Xv.nextQuest then _Xv.nextQuest=_YU+30 pcall(_Xv.CheckQuests)end
if config.bonusAutoRedeem and _YU>=_Xv.nextCode then _Xv.nextCode=_YU+300 pcall(_Xv.CheckCodes)end task.wait(1)end end)local _YV=setmetatable({},{__index=function()return 0 end,__newindex=function()end})local _YW=setmetatable({l=_YV,k={}},{__index=function()return 0 end,__newindex=function()end})local _YX _YX=setmetatable({},{__index=function()return _YX end,__newindex=function()end,__call=function()return _YX end,})local function _YY(_YZ,_Za,_Zb)if type(_YZ)=="table"and type(rawget(_YZ,_Za))=="function"then table.insert(_Xw.saved,{_YZ,_Za,rawget(_YZ,_Za)})_YZ[_Za]=_Zb
    end
end
function _Xw.Set(_Zc)config.liteMode=_Zc
    if _Zc then if#_Xw.saved==0 then
            if _bk and _bl then _YY(_bl,"spawn",function()return _YW end)end
            if _bf and _bg then _YY(_bg,"play",function()return _YX end)_YY(_bg,"playAt",function()return _YX end)end
        end
    for k_Zd,v_Ze in ipairs(modules.Particles)do pcall(function()for _Zf,_Zg in ipairs(v_Ze.live)do
                if typeof(v_Zg.l)=="Instance"then v_Zg.l.Visible=false
                end
        end end)end else
for _Zh,v_Zi in ipairs(_Xw.saved)do pcall(function()v_Zi[1][v_Zi[2]]=_Zi[3]end)end table.clear(_Xw.saved)end
end
local _Zj={t0=os.clock(),tag=nil,panel=nil,cachedTag=nil,cachedPanel=nil,nextScan=0}local _Zk=ColorSequence.new({ColorSequenceKeypoint.new(0.00,Color3.fromRGB(48,255,106)),ColorSequenceKeypoint.new(0.25,Color3.fromRGB(60,205,255)),ColorSequenceKeypoint.new(0.50,Color3.fromRGB(231,255,47)),ColorSequenceKeypoint.new(0.75,Color3.fromRGB(60,205,255)),ColorSequenceKeypoint.new(1.00,Color3.fromRGB(48,255,106)),})local _Zl=Enum.Font.FredokaOne
local function _Zm(_Zn)if not _Zn then
        return nil
    end
local obj_World=_Zn:FindFirstChild("World")local obj_Camera=obj_World and obj_World:FindFirstChild("Camera")local obj_NameTag=obj_Camera and obj_Camera:FindFirstChild("NameTag")if obj_NameTag then
    return obj_NameTag
end
local _Zr=#(localPlayer.DisplayName or"")local _Zs=#(localPlayer.Name or"")local _Zt=nil
for k_Zu,_Zv in ipairs(_Zn:GetChildren())do
    if v_Zv:IsA("Frame")then
        for k_Zw,v_Zx in ipairs(v_Zv:GetChildren())do
            if v_Zx:IsA("Frame")and v_Zx:FindFirstChildOfClass("UIScale")then
                for k_Zy,v_Zz in ipairs(v_Zx:GetChildren())do
                    if v_Zz:IsA("Frame")and v_Zz.ZIndex==1016 then
                        local obj_BitmapText=_Zz:FindFirstChild("BitmapText")if obj_BitmapText then
                            local _ZB=#obj_BitmapText:GetChildren()if _ZB==_Zr or _ZB==_Zs then
                                return v_Zz
                            end _Zt=_Zt or v_Zz
                    end
            end
    end
end
end
end
end
return _Zt
end
local function _ZC()local _ZD=os.clock()if _Zj.cachedTag and not _Zj.cachedTag.Parent then _Zj.cachedTag=nil
    end
if _Zj.cachedPanel and not _Zj.cachedPanel.Parent then _Zj.cachedPanel=nil
end if(not _Zj.cachedTag or not _Zj.cachedPanel)and _ZD>=_Zj.nextScan then _Zj.nextScan=_ZD+0.5
local obj_GameGui=obj_PlayerGui:FindFirstChild("GameGui")if not _Zj.cachedTag then _Zj.cachedTag=_Zm(obj_GameGui)end
if not _Zj.cachedPanel then
    local obj_ChatGui=obj_PlayerGui:FindFirstChild("ChatGui")local obj_HUD=obj_ChatGui and obj_ChatGui:FindFirstChild("HUD")local obj_PlayerPanel=obj_HUD and obj_HUD:FindFirstChild("PlayerPanel")_Zj.cachedPanel=obj_PlayerPanel and obj_PlayerPanel:FindFirstChild("Name")end
end
return _Zj.cachedTag,_Zj.cachedPanel
end
local function _ZI(_ZJ,_ZK)local _ZL,_ZM=pcall(svc_TextSvc.GetTextSize,svc_TextSvc,_ZJ,_ZK,_Zl,Vector2.new(2000,200))return(_ZL and _ZM.X or#_ZJ*_ZK*0.55)+6
end
local function _ZN(_ZO,_ZP,_ZQ)local _ZR=Instance.new("TextLabel")_ZR.Name="ANCHWatermark"_ZR.BackgroundTransparency=1 _ZR.Font=_Zl _ZR.TextSize=_ZP _ZR.TextColor3=Color3.new(1,1,1)_ZR.Text=config.watermarkText _ZR.ZIndex=_ZQ and 1017 or 10
    if _ZQ then _ZR.AnchorPoint=Vector2.new(0.5,0.5)_ZR.Position=UDim2.fromScale(0.5,0.5)else _ZR.AnchorPoint=Vector2.new(0,0.5)_ZR.Position=UDim2.new(0,3,0.5,0)_ZR.TextXAlignment=Enum.TextXAlignment.Left
    end
local _ZS=Instance.new("UIStroke",_ZR)_ZS.Thickness=2 _ZS.Color=Color3.fromRGB(18,28,20)local _ZT=Instance.new("UIGradient",_ZR)_ZT.Color=_Zk _ZT.Rotation=12
local _ZU=Instance.new("UIScale",_ZR)_ZR.Parent=_ZO return{holder=_ZO,bitmap=_ZO:FindFirstChild("BitmapText"),label=_ZR,gr=_ZT,sc=_ZU,size=_ZP,isTag=_ZQ,text=nil,w=0}end
local function _ZV(_ZW)if not _ZW then
        return
    end pcall(function()_ZW.label:Destroy()end)local obj_BitmapText=(_ZW.holder and _ZW.holder:FindFirstChild("BitmapText"))or _ZW.bitmap
if obj_BitmapText then pcall(function()obj_BitmapText.Visible=true end)end
end
function session.RestoreWatermark()_ZV(_Zj.tag)_ZV(_Zj.panel)_Zj.tag,_Zj.panel=nil,nil
end
local function _ZY(_ZZ,_baa,_bab,_bac)if not _baa then _ZV(_ZZ);return nil
    end
if not _ZZ or _ZZ.holder~=_baa or not _ZZ.label.Parent then _ZV(_ZZ)_ZZ=_ZN(_baa,_bab,_bac)end
if _ZZ.text~=config.watermarkText then _ZZ.text=config.watermarkText _ZZ.label.Text=config.watermarkText _ZZ.w=_ZI(config.watermarkText,_bab)end
local obj_BitmapText=_baa:FindFirstChild("BitmapText")if obj_BitmapText then _ZZ.bitmap=obj_BitmapText
    if obj_BitmapText.Visible then obj_BitmapText.Visible=false
    end
end
if _bac then
    local _bae=math.max(_baa.Size.Y.Offset,_bab+6)_ZZ.label.Size=UDim2.fromOffset(_ZZ.w,_bae)_baa.Size=UDim2.fromOffset(_ZZ.w,_baa.Size.Y.Offset)else _ZZ.label.Size=UDim2.new(1,-6,1,0)end
return _ZZ
end trackConn(svc_RunSvc.RenderStepped:Connect(function()if not isAlive()then
    return
end
if not config.customWatermark then
    if _Zj.tag or _Zj.panel then session.RestoreWatermark()end
    return
end
local _baf,_bag=_ZC()_Zj.tag=_ZY(_Zj.tag,_baf,22,true)_Zj.panel=_ZY(_Zj.panel,_bag,21,false)local _bah=os.clock()-_Zj.t0
local _bai=Vector2.new(((_bah*0.45)%2)-1,0)local _baj=1+0.045*math.sin(_bah*3.2)if _Zj.tag then _Zj.tag.gr.Offset=_bai;_Zj.tag.sc.Scale=_baj
end
if _Zj.panel then _Zj.panel.gr.Offset=_bai;_Zj.panel.sc.Scale=_baj
end end))end)()end
local _bak,_bal,_bam,_ban,_bao,_bap,_baq=false,false,false,false,false,false,false
local _bar,_bas,_bat,_bau,_bav,_baw
local _bax,_bay,_baz,_baA,_baB,_baC
local _baD,_baE,_baF,_baG,_baH,_baI
local _baJ,_baK,_baL,_baM,_baN,_baO do(function()local _baP={}local function _baQ()local _baR={}local _baS=_gm()if not _baS then
                return _baR
            end
        for k_baT,v_baU in ipairs({1,-1,0})do
            local _baV=rawget(_baS,v_baU)if type(_baV)=="table"then
                for _baW,_baX in ipairs({"body","head","eyelids","blink","forearm","fist"})do
                    local _baY=_baV[v_baX]if typeof(_baY)=="Instance"then table.insert(_baR,{part=_baY,face=false})end
                end
            for k_baZ,v_bba in ipairs({"armBack","armFront"})do
                local _bbb=_baV[v_bba]local _bbc=(typeof(_bbb)=="Instance"and _bbb:FindFirstChild("Sprite"))or(type(_bbb)=="table"and _bbb.Sprite)if typeof(_bbc)=="Instance"then table.insert(_baR,{part=_bbc,face=false})end
            end
        if typeof(_baV.face)=="Instance"then table.insert(_baR,{part=_baV.face,face=true})end
    end
end
return _baR
end
function _bas()if not _bak then
        return false
    end _bak=false
for k_bbd,v_bbe in pairs(_baP)do pcall(function()k_bbd.ImageColor3=v_bbe end)end table.clear(_baP)return true
end
function _bar()if _bak then
        return true
    end
if not _gm()then notify("Rig karakter tidak ditemukan!");return false
end _bak=true table.clear(_baP)for k_bbf,v_bbg in ipairs(_baQ())do _baP[v_bbg.part]=v_bbg.part.ImageColor3
end task.spawn(function()while _bak and isAlive()do
    local _bbh=Color3.fromHSV(math.random(),0.55+math.random()*0.4,1)local _bbi=Color3.new(_bbh.R*0.38,_bbh.G*0.35,_bbh.B*0.3)for k_bbj,v_bbk in ipairs(_baQ())do
        if _baP[v_bbk.part]==nil then _baP[v_bbk.part]=v_bbk.part.ImageColor3
        end pcall(function()v_bbk.part.ImageColor3=v_bbk.face and _bbi or _bbh end)end
local _bbl=math.min(config.blinkMin,config.blinkMax)local _bbm=math.max(config.blinkMin,config.blinkMax)task.wait(_bbl+math.random()*(_bbm-_bbl))end end)return true
end
local _bbn=nil
function _bat()local _bbo=_gl()if not _bbo then notify("Inventory belum ditemukan!");return false
    end
if not _bbn then _bbn={build=_bbo.buildRange,punch=_bbo.punchRange}end
local _bbp=2.5+config.longhandRange _bbo.buildRange=function()return math.max(_bbn.build(),_bbp)end _bbo.punchRange=function()return math.max(_bbn.punch(),_bbp)end _bal=true
return true
end
function _bau()if not _bal then
        return false
    end
local _bbq=_gl()if _bbq and _bbn then _bbq.buildRange=_bbn.build _bbq.punchRange=_bbn.punch
end _bal=false
return true
end
local _bbr=nil
local function _bbs(_bbt,...)if _bam and _bbt==4992 and not inputState.active then
        return true
    end
if _bbr then
    return _bbr(_bbt,...)end
return false
end
function _bav()if _bam then
        return true
    end _bam=true
local _bbu=getWorldMod()if _bbu and type(rawget(_bbu,"jammerOn"))=="function"and rawget(_bbu,"jammerOn")~=_bbs then _bbr=rawget(_bbu,"jammerOn")_bbu.jammerOn=_bbs
end
return true
end
function _baw()if not _bam then
        return false
    end _bam=false
local _bbv=getWorldMod()if _bbv and _bbr and rawget(_bbv,"jammerOn")==_bbs then _bbv.jammerOn=_bbr
end
return true
end
local _bbw=nil
local _bbx=cloneref and cloneref(game:GetService("VirtualInputManager"))or game:GetService("VirtualInputManager")local function _bby()if getconnections then pcall(function()for k_bbz,v_bbA in ipairs(getconnections(localPlayer.Idled))do
                if v_bbA.Function==nil then
                    if v_bbA.Disable then v_bbA:Disable()elseif v_bbA.Disconnect then v_bbA:Disconnect()end
                    end
            end end)end
end
local function _bbB()pcall(function()svc_VirtualUser:CaptureController()local _bbC=workspace.CurrentCamera
        local _bbD=_bbC and _bbC.CFrame or CFrame.new()svc_VirtualUser:Button2Down(Vector2.new(0,0),_bbD)task.wait(0.08)svc_VirtualUser:Button2Up(Vector2.new(0,0),_bbD)svc_VirtualUser:ClickButton2(Vector2.new(0,0))end)end
function _bax()if _ban then
        return true
    end _ban=true _bby()_bbw=trackConn(localPlayer.Idled:Connect(function()if _ban and isAlive()then _bby()_bbB()end end))task.spawn(function()while _ban and isAlive()do _bby()_bbB()task.wait(60)end end)return true
end
function _bay()if not _ban then
        return false
    end _ban=false
if _bbw then _bbw:Disconnect();_bbw=nil
end
return true
end
local _bbE,_bbF=nil,nil
local _bbG=nil trackConn(svc_UserInputSvc.InputBegan:Connect(function(_bbH)if not isAlive()then
        return
    end
if _bbH.UserInputType==Enum.UserInputType.MouseButton1 or _bbH.UserInputType==Enum.UserInputType.Touch then
    local _bbI,_bbJ=modClick.ScreenToTile(_bbH.Position)if _bbI and _bbJ then _bbE,_bbF=_bbI,_bbJ
    end
end end))local function _bbK()if config.fastPull then
        return "pull","Fast Pull"end
    if config.fastKick then
        return "kick","Fast Kick"end
    if config.fastBan then
        return "ban","Fast Ban"end
    return nil,nil
end
local function _bbL(_bbM)local _bbN=_bbM or _bbG
    if type(_bbN)=="table"then _bbG=_bbN
        local _bbO=rawget(_bbN,"close")if type(_bbO)=="function"then pcall(_bbO)end
        local _bbP=rawget(_bbN,"box")if typeof(_bbP)=="Instance"and _bbP:IsA("GuiObject")then pcall(function()_bbP.Visible=false end)end
    end pcall(function()local obj_MenuGui=obj_PlayerGui:FindFirstChild("MenuGui")local obj_Player=obj_MenuGui and _bbQ:FindFirstChild("Player")if obj_Player and obj_Player:IsA("GuiObject")then obj_Player.Visible=false
    end end)end
local function _bbS(_bbT)local _bbU,_bbV,_bbW=nil,nil,nil
    if not(debug and debug.info and getupvalue)then
        return nil,nil,nil
    end
for _bbX=2,10
do
    local _bbY,_bbZ=pcall(debug.info,_bbX,"f")if not _bbY or type(_bbZ)~="function"then break
    end
for _bca=1,20
do
    local _bcb,_bcc=pcall(getupvalue,_bbZ,_bca)if not _bcb then break
    end
if type(_bcc)=="table"then
    if not _bbW and type(rawget(_bcc,"close"))=="function"and type(rawget(_bcc,"isOpen"))=="function"and rawget(_bcc,"box")~=nil then _bbW=_bcc _bbG=_bcc
    end
local _bcd=tonumber(rawget(_bcc,"userId"))local _bce=tonumber(rawget(_bcc,"id"))local _bcf=rawget(_bcc,"name")if _bcd and _bcd>1000 and _bcd~=localPlayer.UserId then
    if not _bbU or(_bbT~=nil and _bce==tonumber(_bbT))then _bbU=_bcd _bbV=type(_bcf)=="string"and _bcf:gsub("`.","")or tostring(_bcd)end
end
end
end
end
return _bbU,_bbV,_bbW
end
local function _bcg(_bch)local _bci,_bcj,_bck=_bbS(_bch)if _bci then
        return _bci,_bcj,_bck
    end
local _bcl=modules.Others
if not _bcl then modules.Scan();_bcl=modules.Others
end
local _bcm={}if _bcl and type(rawget(_bcl,"list"))=="function"then
    local _bcn,_bco=pcall(_bcl.list)if _bcn and type(_bco)=="table"then
        for k_bcp,v_bcq in pairs(_bco)do
            if type(v_bcq)=="table"then
                local _bcr=tonumber(v_bcq[1]or v_bcq.userId)local _bcs=tostring(v_bcq[2]or v_bcq.name or _bcr or""):gsub("`.","")if _bcr and _bcr~=localPlayer.UserId then
                    if _bch~=nil and(k_bcp==_bch or v_bcq.id==_bch or v_bcq.pid==_bch)then
                        return _bcr,_bcs,_bck
                    end table.insert(_bcm,{uid=_bcr,name=_bcs})end
        end
end
end
end
if _bcl and _bbE and _bbF and type(rawget(_bcl,"where"))=="function"and#_bcm>0 then
    local _bct,_bcu,_bcv=nil,nil,math.huge
    for _bcw,v_bcx in ipairs(_bcm)do
        local _bcy,_bcz,_bcA=pcall(_bcl.where,v_bcx.uid)if _bcy and type(_bcz)=="table"then _bcz,_bcA=_bcz.x or _bcz[1],_bcz.y or _bcz[2]end
        if _bcy and type(_bcz)=="number"and type(_bcA)=="number"then
            local _bcB=math.abs(_bcz-_bbE)+math.abs(_bcA-_bbF)if _bcB<_bcv then _bct,_bcu,_bcv=v_bcx.uid,v_bcx.name,_bcB
            end
    end
end
if _bct and _bcv<=6 then
    return _bct,_bcu,_bck
end
end if#_bcm>=1 then
return _bcm[1].uid,_bcm[1].name,_bck
end
for k_bcC,v_bcD in ipairs(svc_Players:GetPlayers())do
    if v_bcD~=localPlayer then
        return v_bcD.UserId,v_bcD.DisplayName or v_bcD.Name,_bck
    end
end
return nil,nil,_bck
end pcall(function()local obj_MenuGui=obj_PlayerGui:FindFirstChild("MenuGui")local obj_Player=_bcE and obj_MenuGui:FindFirstChild("Player")if obj_Player and obj_Player:IsA("GuiObject")then trackConn(obj_Player:GetPropertyChangedSignal("Visible"):Connect(function()if isAlive()and obj_Player.Visible and _bbK()then
            if os.clock()-(genv.__ANCH_LastFastWrench or 0)<0.8 then _bbL(_bbG)end
        end end))end end)if not genv.__ANCH_TrueOrigNetCall and _bb and type(_bc)=="table"and type(_bc.call)=="function"then
local _bcG=_bc.call
if isexecutorclosure and pcall(isexecutorclosure,_bcG)and isexecutorclosure(_bcG)then
    for k_bcH,v_bcI in pairs(getUpvalues(_bcG))do
        if type(v_bcI)=="function"and not(pcall(isexecutorclosure,v_bcI)and isexecutorclosure(v_bcI))then genv.__ANCH_TrueOrigNetCall=_bcI break
        end
end else genv.__ANCH_TrueOrigNetCall=_bcG
end
end
local _bcJ=genv.__ANCH_TrueOrigNetCall or(_bb and type(_bc)=="table"and _bc.call)or nil
local _bcK={}local _bcL=0
local _bcM
local function _bcN(_bcO,_bcP,_bcQ,_bcR,_bcS,_bcT)_bcL=os.clock()genv.__ANCH_LastFastWrench=_bcL _bbL(_bcT)task.defer(function()_bbL(_bcT)end)task.spawn(function()pcall(_bcO,"WorldCommand",_bcP,"#"..tostring(_bcR))pcall(_bcO,"SetBusy",0)task.wait(0.04)_bbL(_bcT)notify(string.format("%s -> %s (#%s)",_bcQ,tostring(_bcS or "Player"),tostring(_bcR)),_bcQ,2)end)end
local function _bcU(_bcV,_bcW,_bcX,...)local _bcY,_bcZ=_bbK()if _bcY then
        if _bcW=="GetPlayerLevel"or _bcW=="WrenchPlayer"or _bcW=="PlayerInfo"then
            local _bda,_bdb,_bdc=_bcg(_bcX)if _bda then
                if os.clock()-_bcL>0.15 then _bcN(_bcV,_bcY,_bcZ,_bda,_bdb,_bdc)else _bbL(_bdc)end
                return nil
            end elseif _bcW=="SetBusy"and _bcX==2 then
            if os.clock()-_bcL<1.0 then _bbL(_bbG)return false
            end
    end
end
return _bcV(_bcW,_bcX,...)end
if _bcJ then _bcM=function(_bdd,_bde,...)if not isAlive()then
            return _bcJ(_bdd,_bde,...)end
        return _bcU(_bcJ,_bdd,_bde,...)end _bc.call=_bcM
    if modules.World and type(rawget(modules.World,"call"))=="function"then rawset(modules.World,"call",_bcM)end
    if getgcFn and getupvalue and setupvalue then task.spawn(function()for k_bdf,v_bdg in ipairs(getgcFn(false))do
                if type(v_bdg)=="function"and v_bdg~=_bcM and v_bdg~=_bcU then
                    if not(isexecutorclosure and pcall(isexecutorclosure,_bdg)and isexecutorclosure(v_bdg))then
                        for _bdh=1,30
                        do
                            local _bdi,_bdj=pcall(getupvalue,v_bdg,_bdh)if not _bdi then break
                            end
                        if type(_bdj)=="function"then
                            local _bdk=false
                            if isexecutorclosure and pcall(isexecutorclosure,_bdj)and isexecutorclosure(_bdj)then
                                for k_bdl,v_bdm in pairs(getUpvalues(_bdj))do
                                    if v_bdm==_bcJ then _bdk=true break
                                    end
                            end
                    end
                if _bdj==_bcJ or _bdk then pcall(setupvalue,v_bdg,_bdh,_bcM)table.insert(_bcK,{fn=v_bdg,idx=_bdh,orig=_bcJ})end
            end
    end
end
end
end end)end
end
function session.RestoreFastWrench()if _bcJ and _bb and type(_bc)=="table"then _bc.call=_bcJ
    end
if _bcJ and modules.World and rawget(modules.World,"call")==_bcM then pcall(rawset,modules.World,"call",_bcJ)end
if setupvalue then
    for k_bdn,v_bdo in ipairs(_bcK)do pcall(setupvalue,v_bdo.fn,v_bdo.idx,v_bdo.orig)end
end table.clear(_bcK)end
local _bdp=nil
local _bdq=nil
local _bdr={}local function _bds()pcall(function()local obj_InventoryGui=obj_PlayerGui:FindFirstChild("InventoryGui")local obj_InfoDialog=obj_InventoryGui and obj_InventoryGui:FindFirstChild("InfoDialog")if obj_InfoDialog and obj_InfoDialog:IsA("GuiObject")then obj_InfoDialog.Visible=false
        end end)end
local function _bdv()local _bdw=_bdp or modules.Inv
    if _bdw then
        local _bdx=rawget(_bdw,"selected")if type(_bdx)=="number"and _bdx>0 then
            if getWorldPos(_bdx)>0 then
                return _bdx
            end
        local _bdy=rawget(_bdw,"slots")if type(_bdy)=="table"and type(_bdy[_bdx])=="table"and tonumber(_bdy[_bdx].id)then
            return tonumber(_bdy[_bdx].id)end
        if _P[_bdx]then
            return _bdx
        end
end
end
if type(_bdq)=="table"then
    for k_bdz,v_bdA in pairs(_bdq)do
        if type(v_bdA)=="table"and typeof(v_bdA.sel)=="Instance"and _bdA.sel.Visible and tonumber(_bdA.id)then
            return tonumber(v_bdA.id)end
    end
end
return nil
end
local function _bdB()_bds()local _bdC=_bdv()if not _bdC then notify("Pilih item di Backpack terlebih dahulu!","Fast Drop",2)return
    end
local _bdD=getWorldPos(_bdC)if _bdD<=0 then notify("Item sudah habis di tas!","Fast Drop",2)return
end
local _bdE=math.floor(tonumber(config.fastDropCount)or 0)local _bdF=(_bdE<=0)and _bdD or math.min(_bdE,_bdD)task.spawn(function()local _bdG=modules.Hud or _gl()local _bdH=_bdG and rawget(_bdG,"onDrop")if type(_bdH)=="function"then pcall(_bdH,_bdC,_bdF)elseif remote_DropItem then pcall(function()remote_DropItem:FireServer(_bdC,_bdF)end)elseif _bb and type(_bc)=="table"and _bc.drop then pcall(_bc.drop.send,{id=_bdC,n=_bdF})end _bds()notify(string.format("Fast Drop: %s x%d",_gt(_bdC),_bdF),"Fast Drop",2)end)end
    local function _bdI()_bds()local _bdJ=_bdv()if not _bdJ then notify("Pilih item di Backpack terlebih dahulu!","Fast Recycle",2)return
        end
    local _bdK=getWorldPos(_bdJ)if _bdK<=0 then notify("Item sudah habis di tas!","Fast Recycle",2)return
    end
local _bdL=math.floor(tonumber(config.fastRecycleCount)or 0)local _bdM=(_bdL<=0)and _bdK or math.min(_bdL,_bdK)task.spawn(function()if modRecycle and type(modRecycle.Recycle)=="function"then
        local _bdN=modRecycle.Recycle(_bdJ,_bdM)_bds()if _bdN then
            local _bdO=_gl()if _bdO and type(rawget(_bdO,"refresh"))=="function"then pcall(_bdO.refresh)end notify(string.format("Fast Recycle: %s x%d",_gt(_bdJ),_bdM),"Fast Recycle",2)else notify(_gt(_bdJ).." tidak bisa di-recycle!","Fast Recycle",2)end
    end end)end
local _bdP=nil
local _bdQ=nil
local _bdR=nil
local _bdS=0
local function _bdT()local obj_InventoryGui=obj_PlayerGui:FindFirstChild("InventoryGui")local obj_Holder=obj_InventoryGui and obj_InventoryGui:FindFirstChild("Holder")local obj_Backpack=obj_Holder and obj_Holder:FindFirstChild("Backpack")local obj_Actions=obj_Backpack and obj_Backpack:FindFirstChild("Actions")if not obj_Actions or not getconnections or not getupvalue or not setupvalue then
        return
    end
for k_bdY,v_bdZ in ipairs(obj_Actions:GetChildren())do
    if v_bdZ:IsA("GuiButton")then
        for _bea,_beb in ipairs({v_bdZ.Activated,v_bdZ.MouseButton1Click})do
            local _bec,_bed=pcall(getconnections,v_beb)if _bec and type(_bed)=="table"then
                for k_bee,v_bef in ipairs(_bed)do
                    local _beg=v_bef.Function
                    if type(_beg)=="function"and not(isexecutorclosure and pcall(isexecutorclosure,_beg)and isexecutorclosure(_beg))then
                        local _beh,_bei=pcall(getupvalue,_beg,1)local _bej,_bek=pcall(getupvalue,_beg,2)local _bel,_bem=pcall(getupvalue,_beg,3)local _ben,_beo=pcall(getupvalue,_beg,5)if _bej and type(_bek)=="table"and rawget(_bek,"drop")and rawget(_bek,"recycle")and _ben and type(_beo)=="function"then _bdp=(_beh and type(_bei)=="table")and _bei or _bdp _bdq=(_bel and type(_bem)=="table")and _bem or _bdq
                            local _bep=rawget(_bek,"drop")local _beq=rawget(_bek,"recycle")if v_bdZ==_bep then _bdP=_beg
                                if not _bep:GetAttribute("ANCHDropHook")then _bep:SetAttribute("ANCHDropHook",true)trackConn(_bep.InputBegan:Connect(function(_ber)if _ber.UserInputType==Enum.UserInputType.MouseButton1 or _ber.UserInputType==Enum.UserInputType.Touch then _bdR="drop"_bdS=os.clock()end end))end elseif v_bdZ==_beq then _bdQ=_beg
                                    if not _beq:GetAttribute("ANCHRecHook")then _beq:SetAttribute("ANCHRecHook",true)trackConn(_beq.InputBegan:Connect(function(_bes)if _bes.UserInputType==Enum.UserInputType.MouseButton1 or _bes.UserInputType==Enum.UserInputType.Touch then _bdR="recycle"_bdS=os.clock()end end))end
                                end
                            if not genv.__ANCH_TrueOrigOpenDialog then
                                if isexecutorclosure and pcall(isexecutorclosure,_beo)and isexecutorclosure(_beo)then
                                    for k_bet,v_beu in pairs(getUpvalues(_beo))do
                                        if type(v_beu)=="function"and not(pcall(isexecutorclosure,v_beu)and isexecutorclosure(v_beu))then genv.__ANCH_TrueOrigOpenDialog=v_beu break
                                        end
                                end else _a.__ANCH_TrueOrigOpenDialog=_beo
                        end
                end
            local _bev=genv.__ANCH_TrueOrigOpenDialog
            if _bev and _beo~=session.SharedDialogWrapper then session.SharedDialogWrapper=function(...)if isAlive()then
                        local _bew=(debug and debug.info and debug.info(2,"f"))or nil
                        local _bex=(_bew and _bdP and _bew==_bdP)or(_bdR=="drop"and(os.clock()-_bdS)<0.5)local _bey=(_bew and _bdQ and _bew==_bdQ)or(_bdR=="recycle"and(os.clock()-_bdS)<0.5)if _bex and not _bey then _bdR=nil
                            if config.fastDrop then _bdB()return
                            end elseif _bey and not _bex then _bdR=nil
                            if config.fastRecycle then _bdI()return
                            end
                    end
            end
        return _bev(...)end pcall(setupvalue,_beg,5,session.SharedDialogWrapper)table.insert(_bdr,{fn=_beg,idx=5,orig=_bev})end
end
end
end
end
end
end
end
end task.spawn(function()while isAlive()do pcall(_bdT)task.wait(1.5)end end)function session.RestoreFastBackpack()if setupvalue then
    for k_bez,v_beA in ipairs(_bdr)do pcall(setupvalue,v_beA.fn,v_beA.idx,v_beA.orig)end
end table.clear(_bdr)end
function _baz()_bao=true config.reconnectOn=true saveConfig()return true
end
function _baA()_bao=false config.reconnectOn=false saveConfig()return true
end
local _beB,_beC={},{}function _baB()if _bap then
        return true
    end _beB={}for k_beD,v_beE in pairs(itemDB)do
    if type(v_beE)=="table"then
        for k_beF,v_beG in ipairs({"hurts","deadly"})do
            if v_beE[v_beG]then table.insert(_beB,{item=v_beE,key=v_beG,value=rawget(v_beE,v_beG)})pcall(function()if setreadonly then setreadonly(v_beE,false)end rawset(v_beE,v_beG,false)end)end
        end
end
end
local remote_Burned=obj_WorldRemotes and obj_WorldRemotes:FindFirstChild("Burned")if remote_Burned and getconnections then
    local _beI,_beJ=pcall(getconnections,remote_Burned.OnClientEvent)if _beI and type(_beJ)=="table"then
        for k_beK,v_beL in ipairs(_beJ)do
            if pcall(function()v_beL:Disable()end)then table.insert(_beC,v_beL)end
        end
end
end _bap=true
return true
end
function _baC()if not _bap then
        return false
    end
for k_beM,v_beN in ipairs(_beB)do pcall(function()rawset(v_beN.item,v_beN.key,v_beN.value)end)end _beB={}for k_beO,v_beP in ipairs(_beC)do pcall(function()v_beP:Enable()end)end _beC={}_bap=false
return true
end
local _beQ={}local _beR=nil
local function _beS()local _beT=_gl()if not _beT then
        return nil
    end
local _beU=getUpvalues(_beT.isWorn)[1]return type(_beU)=="table"and _beU or nil
end
function _baJ(_beV)local _beW=_beS()return _beW and itemDB[_beV]and _beW[itemDB[_beV].slot]==_beV or false
end
function _baK(_beX)local _beY,_beZ=_gl(),_beS()if not _beY or not _beZ or not itemDB[_beX]then
        return false
    end
local _bfa=itemDB[_beX].slot
if type(_bfa)~="string"then
    return false
end
if _beZ[_bfa]==_beX then _beZ[_bfa]=_beQ[_bfa]or nil else
    if _beQ[_bfa]==nil then _beQ[_bfa]=_beZ[_bfa]or false
    end _beZ[_bfa]=_beX
end pcall(_beY.refresh)return true
end
function _baL()local _bfb,_bfc=_gl(),_beS()if not _bfb or not _bfc then
        return
    end
for k_bfd,v_bfe in pairs(_beQ)do _bfc[k_bfd]=v_bfe or nil
end table.clear(_beQ)pcall(_bfb.refresh)notify("Item visual dikembalikan.")end
function _baM()if _beR then
        return _beR
    end
local _bff={}for _bfg,_bfh in pairs(itemDB)do
    if type(k_bfg)=="number"and type(v_bfh)=="table"and type(_bfh.slot)=="string"and type(v_bfh.name)=="string"then
        local _bfi={}local _bfj=v_bfh.name:lower()if v_bfh.kuyang then table.insert(_bfi,"Kuyang")end
        if v_bfh.bot then table.insert(_bfi,"LegendBot")end
        if k_bfg==5480 or _bfj:find("rayman",1,true)then table.insert(_bfi,"Rayman")end table.insert(_bff,{id=k_bfg,name=_bfh.name,lower=_bfj,slot=_bfh.slot,tags=_bfi})end
end table.sort(_bff,function(_bfk,_bfl)return _bfk.name<_bfl.name end)_beR=_bff
return _bff
end
local _bfm=nil
local function _bfn()if _bfm then
        return _bfm
    end
local _bfo={}for k_bfp,v_bfq in pairs(itemDB)do
    if type(k_bfp)=="number"and type(v_bfq)=="table"and type(v_bfq.name)=="string"and type(v_bfq.slot)~="string"then table.insert(_bfo,{id=k_bfp,name=v_bfq.name,lower=v_bfq.name:lower(),kind=v_bfq.kind or "block"})end
end table.sort(_bfo,function(_bfr,_bfs)return _bfr.name<_bfs.name end)_bfm=_bfo
return _bfo
end
function _baI(_bft,_bfu)local _bfv=_bfn()_bft=trim(_bft):lower()if _bft==""then return{}end
    local _bfw=tonumber(_bft)local _bfx={}for k_bfy,v_bfz in ipairs(_bfv)do
        local _bfA=nil
        if _bfw and v_bfz.id==_bfw then _bfA=0 elseif v_bfz.lower==_bft then _bfA=1 elseif v_bfz.lower:sub(1,#_bft)==_bft then _bfA=2 elseif v_bfz.lower:find(_bft,1,true)then _bfA=3
                    end
                if _bfA then table.insert(_bfx,{entry=v_bfz,rank=_bfA})end
            end table.sort(_bfx,function(_bfB,_bfC)if _bfB.rank~=_bfC.rank then
                return _bfB.rank<_bfC.rank
            end
        return _bfB.entry.name<_bfC.entry.name end)local _bfD={}for _bfE=1,math.min(_bfu or 25,#_bfx)do _bfD[_bfE]=_bfx[_bfE].entry
    end
return _bfD
end
function _baG()local _bfF=getWorldMod()local _bfG=_bfF and rawget(_bfF,"growScan")if type(_bfG)~="table"or type(_bfG.open)~="function"then
        return false
    end
local _bfH=0
for k_bfI,v_bfJ in pairs(itemDB)do
    if type(k_bfI)=="number"and type(v_bfJ)=="table"and v_bfJ.growscan then _bfH=k_bfI;break
    end
end
local _bfK=pcall(_bfG.open,{item=_bfH,owner=true,blocksPublic=false,floatingPublic=false},function()end)return _bfK
end
function _baH()local _bfL=getWorldMod()if not _bfL or type(rawget(_bfL,"w"))~="number"then
        return nil
    end
local _bfM={fg={},bg={},drops={},trees={},w=_bfL.w,h=_bfL.h,totalFg=0,totalBg=0,totalDrops=0,piles=0,readyTrees=0,growingTrees=0,}local _bfN=workspace:GetServerTimeNow()for _bfO=0,_bfL.h-1
do
    local _bfP,_bfQ=_bfL.fg[_bfO],_bfL.bg and _bfL.bg[_bfO]for _bfR=0,_bfL.w-1
    do
        local _bfS=_bfP and _bfP[_bfR]or 0
        if _bfS~=0 then _bfM.fg[_bfS]=(_bfM.fg[_bfS]or 0)+1 _bfM.totalFg=_bfM.totalFg+(1)if isSeedItem(itemId)then
                local _bfT=doFarmAction(_bfL,_bfR,_bfO,_bfS)local _bfU=_bfM.trees[_bfS]if not _bfU then _bfU={ready=0,growing=0,nextIn=nil}_bfM.trees[_bfS]=_bfU
                end
            if _bfT and _bfN>=_bfT then _bfU.ready=_bfU.ready+(1)_bfM.readyTrees=_bfM.readyTrees+(1)else _bfU.growing=_bfU.growing+(1)_bfM.growingTrees=_bfM.growingTrees+(1)if _bfT then
                    local _bfV=_bfT-_bfN
                    if not _bfU.nextIn or _bfV<_bfU.nextIn then _bfU.nextIn=_bfV
                    end
            end
    end
end
end
local _bfW=_bfQ and _bfQ[_bfR]or 0
if _bfW~=0 then _bfM.bg[_bfW]=(_bfM.bg[_bfW]or 0)+1;_bfM.totalBg=_bfM.totalBg+(1)end
end
end
local _bfX=tileCache.list
if not _bfX and type(_bfL.dropList)=="function"then
    local _bfY,_bfZ=pcall(_bfL.dropList)if _bfY then _bfX=_bfZ
    end
end
if type(_bfX)=="table"then
    for k_bga,v_bgb in pairs(_bfX)do
        if type(_bgb)=="table"and type(v_bgb.id)=="number"and(v_bgb.n or 0)>0 then _bfM.drops[v_bgb.id]=(_bfM.drops[v_bgb.id]or 0)+(v_bgb.n or 1)_bfM.totalDrops=_bfM.totalDrops+((v_bgb.n or 1))_bfM.piles=_bfM.piles+(1)end
    end
end
return _bfM
end
function _baN()local _bgc,_bgd={"none"},{none=true}if _bd and type(_be)=="table"and type(_be.titlesOf)=="function"then
        local _bge,_bgf=pcall(_be.titlesOf,localPlayer.UserId)if _bge and type(_bgf)=="table"then
            for k_bgg,v_bgh in ipairs(_bgf)do
                if type(v_bgh)=="string"and not _bgd[v_bgh]then _bgd[v_bgh]=true
                    local _bgi=v_bgh
                    if type(_be.titleName)=="function"then
                        local _bgj,_bgk=pcall(_be.titleName,v_bgh)if _bgj and type(_bgk)=="string"and _bgk~=""and _bgk~=v_bgh then _bgi=_bgk.." [".._bgh.."]"end
                    end table.insert(_bgc,_bgi)end
        end
end
end
return _bgc
end
function _baO(_bgl)local _bgm=string.match(_bgl or"","%[(.-)%]$")or _bgl or "none"if _bgm==""then _bgm="none"end
    if _bb and type(_bc)=="table"and type(_bc.call)=="function"then task.spawn(function()local _bgn,_bgo=pcall(_bc.call,"PickTitle",_bgm)notify(_bgn and("Role dipasang: ".._bgm)or("Gagal pasang role: "..tostring(_bgo)))end)elseif remote_PickTitle then pcall(function()remote_PickTitle:FireServer(_bgm)end)notify("Role dikirim: ".._bgm)else notify("Fungsi PickTitle tidak ditemukan.")end
    end
function _baF()_Xv.CheckQuests()notify(_Xv.questText,"Info Quest")end
function _baD()if _baq then
        return true
    end _baq=true config.bonusAutoQuest=true _Xv.nextQuest=0
return true
end
function _baE()if not _baq then
        return false
    end _baq=false config.bonusAutoQuest=false
return true
end end)()end
local _bgJ={blink={label="Skin Blink",get=function()return _bak end,set=function(_bgp)return _bgp and _bar()or _bas()end},longhand={label="Longhand Reach",get=function()return _bal end,set=function(_bgq)return _bgq and _bat()or _bau()end},noclip={label="Noclip / ModFly",get=function()return _iO end,set=function(_bgr)return _bgr and _iZ()or _ja()end},ujump={label="Unlimited Jump",get=function()return _bam end,set=function(_bgs)return _bgs and _bav()or _baw()end},antiafk={label="Anti-AFK",get=function()return _ban end,set=function(_bgt)return _bgt and _bax()or _bay()end},autorejoin={label="Auto Reconnect",get=function()return config.reconnectOn end,set=function(_bgu)return _bgu and _baz()or _baA()end},god={label="God Mode",get=function()return _bap end,set=function(_bgv)return _bgv and _baB()or _baC()end},clicktp={label="Click TP",get=function()return modClick.clickOn end,set=function(_bgw)return _bgw and modClick.StartClick()or modClick.StopClick()end},lite={label="Lite Mode (FPS Boost)",get=function()return config.liteMode end,set=function(_bgx)_Xw.Set(_bgx);return true end},guard={label="Anti-Mod Guard",get=function()return modIntrusion.on end,set=function(_bgy)modIntrusion.Set(_bgy);return true end},autochat={label="Auto Chat",noSession=true,get=function()return _tk.on end,set=function(_bgz)_tk.on=_bgz;if _bgz then _tk.nextAt=0 end;return true end},autoclear={label="Auto Clear World",noSession=true,get=function()return modBreak.on end,set=function(_bgA)return _bgA and modBreak.Start()or modBreak.Stop()end},autoharvest={label="Farmer (Harvest/Plant)",noSession=true,get=function()return modTrees.on end,set=function(_bgB)return _bgB and modTrees.Start()or modTrees.Stop()end},automove={label="Auto Move Item",noSession=true,get=function()return modGems.on end,set=function(_bgC)return _bgC and modGems.Start()or modGems.Stop()end},autodf={label="Auto Dirt Farm",noSession=true,get=function()return modDirt.on end,set=function(_bgD)return _bgD and modDirt.Start()or modDirt.Stop()end},autosplice={label="Auto Splice",noSession=true,get=function()return _te.on end,set=function(_bgE)return _bgE and _te.Start()or _te.Stop()end},pabrik={label="Seed Factory",noSession=true,get=function()return modFarm.on end,set=function(_bgF)return _bgF and modFarm.Start()or modFarm.Stop()end},autofarm={label="Auto Farm",noSession=true,get=function()return modAutoPlace.on and not modAutoPlace.Override end,set=function(_bgG)return _bgG and _vL()or _vM()end},autoquest={label="Auto Quest",get=function()return _baq end,set=function(_bgH)return _bgH and _baD()or _baE()end},rotation={label="Multi-World Rotation",noSession=true,get=function()return _d.Rotation.on end,set=function(_bgI)return _bgI and session.Rotation.Start()or _d.Rotation.Stop()end},}local function _bgK(_bgL,_bgM)local _bgN=_bgJ[_bgL]if not _bgN then
        return
    end
if configDirty and _bgN.noSession then
    return
end _bgN.set(_bgM)if _bgN.get()==_bgM then notify(_bgN.label..(_bgM and " enabled."or " disabled."))if not _bgN.noSession then config.session[_bgL]=_bgM or nil else config.session[_bgL]=nil
end saveConfig()end
if _sV then _sV()end
end
local _bgO=0
local function _bgP()if type(genv.ANCHHub_ReloadCode)=="string"and _a.ANCHHub_ReloadCode~=""then
        return genv.ANCHHub_ReloadCode
    end
local _bgQ=config.scriptUrl
if type(_bgQ)~="string"or _bgQ==""then _bgQ=genv.ANCHHubURL
end
if type(_bgQ)=="string"and _bgQ~=""then
    return string.format("loadstring(game:HttpGet(%q))()",_bgQ)end
if isfile and readfile then
    for k_bgR,v_bgS in ipairs({file_ANCHHub_GrowBlox,"ANCHHub-Test.lua","ANCHHub.lua","ANCHHub_Loader.lua"})do
        local _bgT,_bgU=pcall(isfile,v_bgS)if _bgT and _bgU then
            return string.format("loadstring(readfile(%q))()",v_bgS)end
    end
end
return nil
end
local function _bgV()return queue_on_teleport or(syn and syn.queue_on_teleport)or(fluxus and fluxus.queue_on_teleport)or(getgenv and getgenv().queue_on_teleport)end _sw=function()if not config.autoReload or genv.__ANCHHub_TeleportQueued then
        return false
    end
local _bgW,_bgX=_bgV(),_bgP()if not _bgW or not _bgX then
    return false
end
local _bgY=("local g=(getgenv and getgenv()) or _G; if g.__ANCH_TpLock and (o".."s.clock()-g.__ANCH_TpLock)<6 then return end; g.__ANCH_TpLock=os"..".clock(); ").._bgX
local _bgZ=pcall(_bgW,_bgY)if _bgZ then genv.__ANCHHub_TeleportQueued=true
end
return _bgZ
end
local function _bha()if not writefile then notify("Executor tidak punya writefile.");return
    end
local _bhb=_bgP()if not _bhb then notify("Simpan skrip sebagai "..file_ANCHHub_GrowBlox.." di workspace atau isi URL dulu.");return
end
local _bhc="-- GSZ HUB | GrowBlox auto-loader\n".._bhb.."\n"pcall(writefile,"ANCHHub_Loader.lua",_bhc)for _bhd,_bhe in ipairs({"../autoexec/ANCHHub_Loader.lua","../Autoexec/ANCHHub_Loader.lua"})do
    local _bhf=pcall(writefile,_bhe,_bhc)local _bhg,_bhh=pcall(function()return isfile and isfile(v_bhe)end)if _bhf and _bhg and _bhh then notify("Auto-execute berhasil dipasang!")return
    end
end notify(("Salin ANCHHub_Loader.lua dari workspace ke folder autoexec execu".."tor."))end do(function()local _bhi=(gethui and gethui())or game:GetService("CoreGui")local function _bhj(_bhk)local _bhl=Instance.new("ScreenGui")_bhl.Name=_bhk _bhl.ResetOnSpawn=false _bhl.IgnoreGuiInset=true _bhl.ZIndexBehavior=Enum.ZIndexBehavior.Sibling _bhl.DisplayOrder=999 _bhl.Enabled=false _bhl.Parent=_bhi
    return _bhl
end _sW=_bhj("ANCHGridGui")local _bhm,_bhn,_bho=38,4,2
local _bhp=_bho*2+1
local _bhq=_bhp*_bhm+(_bhp-1)*_bhn
local _bhr=Instance.new("Frame",_sW)_bhr.Size=UDim2.fromOffset(_bhq+20,_bhq+96)_bhr.Position=UDim2.fromOffset(24,90)_bhr.BackgroundColor3=Color3.fromRGB(22,22,28)_bhr.BorderSizePixel=0 Instance.new("UICorner",_bhr).CornerRadius=UDim.new(0,10)local _bhs=Instance.new("UIStroke",_bhr)_bhs.Color=Color3.fromRGB(48,255,106)local _bht=Instance.new("TextLabel",_bhr)_bht.Size=UDim2.new(1,-106,0,28)_bht.Position=UDim2.fromOffset(10,4)_bht.BackgroundTransparency=1 _bht.Font=Enum.Font.GothamBold _bht.TextSize=12 _bht.TextXAlignment=Enum.TextXAlignment.Left _bht.TextColor3=Color3.fromRGB(235,235,245)_bht.Text="ANCH Grid (Farm)"_bht.Active=true
local _bhu=Instance.new("TextButton",_bhr)_bhu.Size=UDim2.fromOffset(62,22)_bhu.Position=UDim2.new(1,-98,0,7)_bhu.BackgroundColor3=Color3.fromRGB(60,60,75)_bhu.Text="Farm"_bhu.Font=Enum.Font.GothamBold _bhu.TextSize=11 _bhu.TextColor3=Color3.new(1,1,1)Instance.new("UICorner",_bhu).CornerRadius=UDim.new(0,6)local _bhv=Instance.new("TextButton",_bhr)_bhv.Size=UDim2.fromOffset(24,24)_bhv.Position=UDim2.new(1,-30,0,6)_bhv.BackgroundColor3=Color3.fromRGB(60,60,75)_bhv.Text="X"_bhv.Font=Enum.Font.GothamBold _bhv.TextSize=12 _bhv.TextColor3=Color3.new(1,1,1)Instance.new("UICorner",_bhv).CornerRadius=UDim.new(0,6)_bhv.MouseButton1Click:Connect(function()_sW.Enabled=false end)local _bhw=Instance.new("Frame",_bhr)_bhw.Size=UDim2.fromOffset(_bhq,_bhq)_bhw.Position=UDim2.fromOffset(10,36)_bhw.BackgroundTransparency=1
local _bhx=Color3.fromRGB(48,48,60)local _bhy=Color3.fromRGB(46,160,90)local _bhz=Color3.fromRGB(60,110,220)local _bhA={}local function _bhB()return(_sX=="pabrik")and config.pabrikTiles or config.farmGrid
end
local _bhC=Instance.new("TextButton",_bhr)_bhC.Size=UDim2.new(1,-20,0,30)_bhC.Position=UDim2.new(0,10,1,-54)_bhC.BackgroundColor3=_bhy _bhC.Font=Enum.Font.GothamBold _bhC.TextSize=13 _bhC.TextColor3=Color3.new(1,1,1)_bhC.Text="START FARM"Instance.new("UICorner",_bhC).CornerRadius=UDim.new(0,8)_bhC.MouseButton1Click:Connect(function()if _sX=="pabrik"then _bgK("pabrik",not modFarm.on)else _bgK("autofarm",not(modAutoPlace.on and not modAutoPlace.Override))end end)_sY=function()local _bhD=_bhB()local _bhE=_sX=="pabrik"_bhu.Text=_bhE and "Factory"or "Farm"_bhu.BackgroundColor3=_bhE and Color3.fromRGB(200,120,40)or Color3.fromRGB(60,60,75)_bht.Text=_bhE and "Factory Break Tiles"or "ANCH Grid (Farm)"for k_bhF,v_bhG in pairs(_bhA)do v_bhG.BackgroundColor3=_bhD[k_bhF]and _bhy or _bhx
    end
if _bhE then _bhC.Text=modFarm.on and "STOP FACTORY"or "START FACTORY"_bhC.BackgroundColor3=modFarm.on and Color3.fromRGB(200,60,60)or _bhy else
    local _bhH=modAutoPlace.on and not modAutoPlace.Override _bhC.Text=_bhH and "STOP FARM"or "START FARM"_bhC.BackgroundColor3=_bhH and Color3.fromRGB(200,60,60)or _bhy
end
end _sZ=function(_bhI)_sX=_bhI _sY()end _bhu.MouseButton1Click:Connect(function()_sZ(_sX=="pabrik"and "farm"or "pabrik")end)for _bhJ=0,_bhp-1
do
    for _bhK=0,_bhp-1
    do
        local _bhL,_bhM=_bhK-_bho,_bhJ-_bho
        local _bhN=_bhL..",".._bhM
        local _bhO=Instance.new("TextButton",_bhw)_bhO.Size=UDim2.fromOffset(_bhm,_bhm)_bhO.Position=UDim2.fromOffset(_bhK*(_bhm+_bhn),_bhJ*(_bhm+_bhn))_bhO.Font=Enum.Font.GothamBold _bhO.TextSize=11 _bhO.TextColor3=Color3.new(1,1,1)Instance.new("UICorner",_bhO).CornerRadius=UDim.new(0,6)if _bhL==0 and _bhM==0 then _bhO.Text="ME"_bhO.BackgroundColor3=_bhz _bhO.AutoButtonColor=false else _bhO.Text=""_bhO.BackgroundColor3=_bhB()[_bhN]and _bhy or _bhx _bhA[_bhN]=_bhO _bhO.MouseButton1Click:Connect(function()local _bhP=_bhB()_bhP[_bhN]=(not _bhP[_bhN])or nil saveConfig()_sY()end)end
    end
end
local _bhQ=Instance.new("TextButton",_bhr)_bhQ.Size=UDim2.new(1,-20,0,18)_bhQ.Position=UDim2.new(0,10,1,-22)_bhQ.BackgroundTransparency=1 _bhQ.Font=Enum.Font.Gotham _bhQ.TextSize=12 _bhQ.TextColor3=Color3.fromRGB(180,180,195)_bhQ.Text="Clear Selection"_bhQ.MouseButton1Click:Connect(function()if _sX=="pabrik"then config.pabrikTiles={}else config.farmGrid={}end saveConfig()_sY()end)local _bhR,_bhS,_bhT _bht.InputBegan:Connect(function(_bhU)if _bhU.UserInputType==Enum.UserInputType.MouseButton1 or _bhU.UserInputType==Enum.UserInputType.Touch then _bhR,_bhS,_bhT=true,_bhU.Position,_bhr.Position _bhU.Changed:Connect(function()if _bhU.UserInputState==Enum.UserInputState.End then _bhR=false
            end end)end end)trackConn(svc_UserInputSvc.InputChanged:Connect(function(_bhV)if _bhR and(_bhV.UserInputType==Enum.UserInputType.MouseMovement or _bhV.UserInputType==Enum.UserInputType.Touch)then
    local _bhW=_bhV.Position-_bhS _bhr.Position=UDim2.new(_bhT.X.Scale,_bhT.X.Offset+_bhW.X,_bhT.Y.Scale,_bhT.Y.Offset+_bhW.Y)end end))_iQ=_bhj("ANCHFlyPad")local function _bhX(_bhY,_bhZ,_bia)local _bib=Instance.new("TextButton",_iQ)_bib.Size=UDim2.fromOffset(60,60)_bib.AnchorPoint=Vector2.new(1,0.5)_bib.Position=UDim2.new(1,-24,0.5,_bhZ)_bib.BackgroundColor3=Color3.fromRGB(30,30,40)_bib.BackgroundTransparency=0.2 _bib.Text=_bhY _bib.Font=Enum.Font.GothamBold _bib.TextSize=26 _bib.TextColor3=Color3.new(1,1,1)Instance.new("UICorner",_bib).CornerRadius=UDim.new(1,0)local _bic=Instance.new("UIStroke",_bib)_bic.Color=Color3.fromRGB(48,255,106)_bic.Thickness=2
    local _bid=nil _bib.InputBegan:Connect(function(_bie)if _bie.UserInputType==Enum.UserInputType.Touch or _bie.UserInputType==Enum.UserInputType.MouseButton1 then _bid=_bie _bia(true)end end)trackConn(svc_UserInputSvc.InputEnded:Connect(function(_bif)if _bid and(_bif==_bid or _bif.UserInputType==Enum.UserInputType.MouseButton1)then _bid=nil _bia(false)end end))end _bhX("â²",-38,function(_big)inputAxis.up=_big end)_bhX("â¼",38,function(_bih)inputAxis.down=_bih end)end)()end
local _bii do(function()local _bij
        do
            local file_ANCHHub_WindUI_Cache="ANCHHub_WindUI_Cache.lua"local _bil=genv.__ANCH_WindUISource
            if type(_bil)~="string"or#_bil<1000 then
                if isfile and readfile then
                    local _bim,_bin=pcall(isfile,file_ANCHHub_WindUI_Cache)if _bim and _bin then
                        local _bio,_bip=pcall(readfile,file_ANCHHub_WindUI_Cache)if _bio and type(_bip)=="string"and#_bip>1000 then _bil=_bip
                        end
                end
        end
end
if type(_bil)~="string"or#_bil<1000 then
    local _biq,_bir=pcall(function()return game:HttpGet(("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/ma".."in.lua"))end)if _biq and type(_bir)=="string"and#_bir>1000 then _bil=_bir _a.__ANCH_WindUISource=_bil
        if writefile then pcall(writefile,file_ANCHHub_WindUI_Cache,_bil)end
    end
end
if type(_bil)=="string"and#_bil>1000 then genv.__ANCH_WindUISource=_bil _bij=loadstring(_bil)()else _bij=loadstring(game:HttpGet(("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/ma".."in.lua")))()end
end customNotifyFn=function(_bis,_bit,_biu)_bij:Notify({Title=_bit or "GSZ HUB | GrowBlox",Content=tostring(_bis),Icon="solar:bell-bold",Duration=_biu or 4,})end
local _biv=Color3.fromHex("#7775F2")local _biw=Color3.fromHex("#ECA201")local _bix=Color3.fromHex("#10C550")local _biy=Color3.fromHex("#257AF7")local _biz=Color3.fromHex("#EF4F1D")_bii=_bij:CreateWindow({Title="GSZ HUB  |  GrowBlox Beta",Folder="ANCHHub_GrowBlox",Icon="solar:folder-2-bold-duotone",NewElements=true,HideSearchBar=false,Theme="Indigo",OpenButton={Title="GSZ HUB",CornerRadius=UDim.new(1,0),StrokeThickness=3,Enabled=config.launcher,Draggable=true,OnlyMobile=false,Scale=0.5,Color=ColorSequence.new(Color3.fromHex("#30FF6A"),Color3.fromHex("#e7ff2f")),},})_bii:DisableTopbarButtons({"Fullscreen"})pcall(function()_bii:Tag({Title="V1.4 EN",Icon="github",Color=Color3.fromHex("#1c1c1c"),Border=true,})end)local _biA={tabs={},refreshers={},syncing=false,active="features",}_sV=function()_biA.syncing=true
    for k_biB,v_biC in ipairs(_biA.refreshers)do pcall(v_biC)end _biA.syncing=false
end
local function _biD(_biE,_biF)local _biG,_biH=pcall(_biF)if not _biG then warn("[ANCHHub UI] Error in "..tostring(_biE)..": "..tostring(_biH))end
end
local function _biI(_biJ,_biK,_biL)if not _biJ then
        return
    end pcall(function()if _biK and _biJ.SetTitle then _biJ:SetTitle(_biK)end
    if _biL and _biJ.SetDesc then _biJ:SetDesc(_biL)elseif _biL and _biJ.SetContent then _biJ:SetContent(_biL)end end)end
local function _biM(_biN,_biO,_biP,_biQ)local _biR=_bgJ[_biQ]if not _biR then
        return nil
    end
local _biS _biD("Toggle:"..tostring(_biQ),function()_biS=_biN:Toggle({Title=_biO,Desc=_biP,Value=_biR.get(),Callback=function(_biT)if _biA.syncing then
            return
        end
    if _biR.get()~=_biT then _bgK(_biQ,_biT)end end,})table.insert(_biA.refreshers,function()if _biS and _biS.Set then _biS:Set(_biR.get())end end)end)return _biS
end
local _biU=_bii:Section({Title="Main Section",Opened=true})local _biV=_bii:Section({Title="Automation",Opened=true})local _biW=_bii:Section({Title="Fast Helpers",Opened=true})local _biX=_bii:Section({Title="Inventory & World",Opened=true})local _biY=_bii:Section({Title="Safety & Utility",Opened=true})local _biZ=_bii:Section({Title="System & Settings",Opened=true})_biD("Tab:Dashboard",function()local _bja=_biU:Tab({Title="Dashboard & Stats",Icon="solar:home-2-bold",IconColor=_bix,IconShape="Square",Border=true,})_biA.tabs.features=_bja
    local _bjb=_bja:Paragraph({Title="Character & Game Connection Status",Desc="Detecting position...",})local _bjc=_bja:Paragraph({Title="Real-Time Session Statistics",Desc="Loading stats...",})task.spawn(function()while _e()and task.wait(0.6)do pcall(function()local _bjd,_bje=_hv()local _bjf=_hy()local _bjg=string.format(("World: %s | Inv: %s | State: %s | Punch: %s | Drop: %s | Trees: ".."%s"),modules.World and "OK"or "-",modules.Inv and "OK"or "-",modules.State and "OK"or "-",modules.Punch and "OK"or "-",tileCache.list and "OK"or "-",modules.Trees and "OK"or "-")if _bjd then _biI(_bjb,string.format("World: %s  |  Tile Position: (%d, %d)",_bjf~=""and _bjf or "-",_bjd,_bje),_bjg)else _biI(_bjb,"Character Status: Outside World",_bjg)end _biI(_bjc,"Real-Time Session Statistics",sessionStats.Text())end)end end)_bja:Button({Title="Rescan Game References (Reconnect Refs)",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()modules.Scan(true)notify("Game references refreshed!")end,})local _bjh=_bja:Group({})_bjh:Button({Title="Reset Stats",Justify="Center",Callback=function()sessionStats.Reset();notify("Session statistics reset.")end,})_bjh:Button({Title="Send Stats to Discord",Justify="Center",Callback=function()if not(config.webhookOn and webhookSvc.Valid(config.webhookUrl))then notify(("Enable & set your Discord Webhook URL in System & Settings first".."!"))else webhookSvc.Send("report","Session Statistics Report\n```\n"..sessionStats.Text().."\n```")notify("Statistics report queued for Discord!")end end,})end)_biD("Tab:Character",function()local _bji=_biU:Tab({Title="Character & Movement",Icon="solar:square-transfer-horizontal-bold",IconColor=_biy,IconShape="Square",Border=true,})_biA.tabs.nav=_bji
    local _bjj=_bji:Paragraph({Title="Universal Navigation Status",Desc="Last: -"})_bji:Dropdown({Title="Universal Movement Method (DF / Farmer / Factory / Clear)",Desc=("Legit Walking = Physical A* pathfinding | Teleport Mode = Tile-b".."y-tile real-time stepper."),Values={"Legit Walking","Teleport Mode"},Value=config.moveMethod or "Legit Walking",Callback=function(_bjk)config.moveMethod=_bjk or "Legit Walking"config.moveMode=(config.moveMethod=="Teleport Mode")and "fly"or "legit"saveConfig()notify("Movement method set to: "..config.moveMethod)end,})_bji:Space()task.spawn(function()while _e()and task.wait(0.6)do pcall(function()_biI(_bjj,"Movement Mode: "..config.moveMode:upper(),"Click TP Status: "..tostring(modClick.last).." | Scaffolds Placed: "..modClick.PlacedScaffolds)end)end end)_biM(_bji,"Click TP (Legit A* Pathfinding)",("Tap/click anywhere on screen to automatically walk & climb to th".."at tile."),"clicktp")_biM(_bji,"Noclip + FlyPad (â²/â¼)","Fly through blocks and display on-screen Up/Down buttons.","noclip")_biM(_bji,"Unlimited Jump (Air Jump)","Jump infinitely in mid-air.","ujump")_biM(_bji,"God Mode (Hazard Immunity)","Immune to lava, spikes, fire, and deadly obstacles.","god")_biM(_bji,"Longhand (Extended Reach)","Extend your punch and build range.","longhand")_biM(_bji,"Lite Mode (FPS Boost)","Disable particles & punch sound effects for higher FPS.","lite")_biM(_bji,"Skin Blink","Automatically cycle character skin colors.","blink")_biM(_bji,"Anti-AFK","Prevent idle disconnection.","antiafk")_bji:Space()_bji:Section({Title="Speed & Auto Collect Radius"})_bji:Slider({Title="Character Walkspeed (%)",Desc="100% = normal game speed.",IsTooltip=true,Step=10,Value={Min=50,Max=400,Default=math.clamp(config.walkSpeed,50,400)},Callback=function(_bjl)config.walkSpeed=tonumber(_bjl)or 100
        if config.walkSpeed==100 and modules.World then modules.World.speedScale=1
        end saveConfig()end,})_bji:Toggle({Title="Always Collect Nearby Drops",Value=config.collectAround,Callback=function(_bjm)config.collectAround=_bjm;saveConfig()end,})_bji:Slider({Title="Auto Collect Radius (Tiles)",IsTooltip=true,Step=1,Value={Min=1,Max=8,Default=math.clamp(config.collectRadius,1,8)},Callback=function(_bjn)config.collectRadius=math.floor(tonumber(_bjn)or 3);saveConfig()end,})_bji:Toggle({Title="Require Holding Shift for Click TP (PC)",Value=config.clickTpShift,Callback=function(_bjo)config.clickTpShift=_bjo;saveConfig()end,})end)_biD("Tab:AutoFarm",function()local _bjp=_biV:Tab({Title="Auto Farm",Icon="solar:check-square-bold",IconColor=_biw,IconShape="Square",Border=true,})_biA.tabs.farm=_bjp
local _bjq=_bjp:Paragraph({Title="Auto Farm Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.5)do pcall(function()local _bjr=config.farmPlaceId _biI(_bjq,"Status: "..modAutoPlace.stats.status.." ("..config.farmMode..")",string.format(("Block: %s [ID %d] (In Bag: %d)\nPlaced: %d | Broken: %d | Collect".."ed: %d | Cycles: %d"),_gt(_bjr),_bjr,getWorldPos(_bjr),modAutoPlace.stats.placed,modAutoPlace.stats.broken,modAutoPlace.stats.picked,modAutoPlace.stats.cycles))end)end end)_biM(_bjp,"Enable Auto Farm","Automatically place & break blocks based on the 5x5 Grid.","autofarm")_bjp:Dropdown({Title="Auto Collect Mode (Legit Physical / Remote)",Desc=("Legit = Physical sweep & small jump (anti-reject). Remote = Coll".."ect from range."),Values={"Legit","Remote"},Value=(config.collectMode=="Remote")and "Remote"or "Legit",Callback=function(_bjs)config.collectMode=(_bjs=="Remote")and "Remote"or "Legit"saveConfig()notify("Auto Collect Mode: "..config.collectMode)end,})_bjp:Toggle({Title="Hand Swing & Place Visual Effects",Desc="Show arm swing animation and particle effects locally.",Value=config.visualAnim,Callback=function(_bjt)config.visualAnim=_bjt;saveConfig()end,})_bjp:Button({Title="Open 5x5 Floating Grid (Farm Mode)",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()if _sZ then _sZ("farm")end
    if _sW then _sW.Enabled=not _sW.Enabled
    end end,})_bjp:Space()_bjp:Section({Title="Farm Mode & Speed"})local _bju={["Place + Break"]="Place + Break",["Break Only"]="Break saja",["Place Only"]="Place saja",}local _bjv={["Place + Break"]="Place + Break",["Break saja"]="Break Only",["Place saja"]="Place Only",}_bjp:Dropdown({Title="Auto Farm Mode",Values={"Place + Break","Break Only","Place Only"},Value=_bjv[config.farmMode]or "Place + Break",Callback=function(_bjw)config.farmMode=_bju[_bjw]or "Place + Break"saveConfig()end,})_bjp:Slider({Title="Multi-Target Break (1 - 5 Tiles)",Desc=("Hit multiple tiles in rotation. Automatically uses Rayman Fist i".."f equipped!"),IsTooltip=true,Step=1,Value={Min=1,Max=5,Default=math.clamp(config.farmMultiTarget,1,5)},Callback=function(_bjx)config.farmMultiTarget=math.clamp(math.floor(tonumber(_bjx)or 1),1,5);saveConfig()end,})_bjp:Input({Title="Farm Block ID",Value=tostring(config.farmPlaceId),Placeholder="e.g. 2 (Dirt)",Callback=function(_bjy)local _bjz=tonumber(_bjy)if _bjz and _bjz>0 then config.farmPlaceId=math.floor(_bjz)saveConfig()notify("Farm Block: ".._gt(config.farmPlaceId).." ["..config.farmPlaceId.."]")end end,})local _bjA={}local _bjB _bjp:Input({Title="Search Block in Database",Placeholder="Type block name...",Callback=function(_bjC)_bjA={}local _bjD={}if trim(_bjC)~=""then
    for _bjE,_bjF in ipairs(_baI(_bjC,25))do
        local _bjG=string.format("%s [%d]",v_bjF.name,v_bjF.id)_bjA[_bjG]=v_bjF.id table.insert(_bjD,_bjG)end
end if#_bjD==0 then _bjD={"No results"}end
if _bjB and _bjB.Refresh then pcall(function()_bjB:Refresh(_bjD)end)end end,})_bjB=_bjp:Dropdown({Title="Select Search Result",Values={"Type a block name above..."},Callback=function(_bjH)local _bjI=_bjA[_bjH]if _bjI then config.farmPlaceId=_bjI saveConfig()notify("Block set to: ".._gt(_bjI).." [".._bjI.."]")end end,})_bjp:Slider({Title="Place Delay (ms)",IsTooltip=true,Step=10,Value={Min=50,Max=1000,Default=math.clamp(config.farmPlaceMs,50,1000)},Callback=function(_bjJ)config.farmPlaceMs=tonumber(_bjJ)or 250;saveConfig()end,})_bjp:Input({Title="Break Delay (seconds)",Value=tostring(config.farmDelay),Placeholder="0.22",Callback=function(_bjK)local _bjL=tonumber(_bjK)if _bjL and _bjL>=0.03 and _bjL<=5 then config.farmDelay=_bjL;saveConfig()end end,})_bjp:Toggle({Title="Auto Collect Drops",Value=config.farmTake,Callback=function(_bjM)config.farmTake=_bjM;saveConfig()end,})_bjp:Space()_bjp:Section({Title="Fast Break, Anti-Detection & Auto Refill Block"})_bjp:Toggle({Title="Fast Break (Zero-Drift + Cooldown Gate Reset)",Desc=("Eliminates frame drift between hits for maximum server-allowed b".."reak speed."),Value=config.farmFastBreak,Callback=function(_bjN)config.farmFastBreak=_bjN;saveConfig()end,})_bjp:Toggle({Title="Dynamic Delay (Anti-Detection Rhythm Jitter)",Desc=("Automatically randomizes each punch & place delay (e.g. 0.12s, 0"..".17s, 0.20s) to bypass server rhythm detection."),Value=config.farmDynamicDelay,Callback=function(_bjO)config.farmDynamicDelay=_bjO;saveConfig()end,})_bjp:Slider({Title="Dynamic Jitter Range (+/- ms)",IsTooltip=true,Step=5,Value={Min=10,Max=100,Default=math.clamp(config.farmDynamicJitterMs or 45,10,100)},Callback=function(_bjP)config.farmDynamicJitterMs=math.floor(tonumber(_bjP)or 45);saveConfig()end,})_bjp:Toggle({Title="Auto Refill Block When Depleted (World-to-World Support)",Desc=("When blocks run out, automatically pick up floating blocks in cu".."rrent world or warp to Refill World and return."),Value=config.farmAutoRefill,Callback=function(_bjQ)config.farmAutoRefill=_bjQ;saveConfig()end,})_bjp:Input({Title="Refill Stock World (Empty = Current World | WORLD | WORLD:DOOR)",Value=config.farmRefillWorld,Placeholder="e.g. STORAGE1 or STORAGE1:DOOR1",Callback=function(_bjR)config.farmRefillWorld=trim(_bjR or"");saveConfig()end,})_bjp:Space()_bjp:Section({Title="Auto Save / Drop Seeds (When Seeds >= Threshold)"})_bjp:Toggle({Title="Enable Auto Drop Seeds When Full",Desc=("Automatically pause farming, drop seeds at target world/pos, and".." return to resume Auto Farm."),Value=config.farmAutoDropSeed,Callback=function(_bjS)config.farmAutoDropSeed=_bjS;saveConfig()end,})_bjp:Slider({Title="Drop When Seed Count Reaches >=",IsTooltip=true,Step=5,Value={Min=20,Max=200,Default=math.clamp(config.farmSeedDropAt or 200,20,200)},Callback=function(_bjT)config.farmSeedDropAt=math.floor(tonumber(_bjT)or 200);saveConfig()end,})_bjp:Slider({Title="Keep Seeds in Backpack",IsTooltip=true,Step=5,Value={Min=0,Max=190,Default=math.clamp(config.farmSeedKeep or 0,0,190)},Callback=function(_bjU)config.farmSeedKeep=math.floor(tonumber(_bjU)or 0);saveConfig()end,})_bjp:Input({Title="Seed Drop World (Empty = Current World | WORLD | WORLD:DOOR)",Value=config.farmDropWorld,Placeholder="e.g. STORAGE or STORAGE:1",Callback=function(_bjV)config.farmDropWorld=trim(_bjV or"");saveConfig()end,})_bjp:Button({Title="SetPos Seed Drop (Save Current Position)",Color=Color3.fromHex("#10C550"),Justify="Center",Callback=function()local _bjW,_bjX=_hv()if not _bjW then notify("Character position not detected!");return
end config.farmDropX,config.farmDropY=_bjW,_bjX saveConfig()notify(string.format("Auto Farm Seed Drop position saved at (%d, %d)!",_bjW,_bjX))end,})end)_biD("Tab:AutoClear",function()local _bjY=_biV:Tab({Title="Auto Clear",Icon="solar:cursor-square-bold",IconColor=_biz,IconShape="Square",Border=true,})_biA.tabs.clear=_bjY
local _bjZ=_bjY:Paragraph({Title="Auto Clear World Status",Desc="Loading..."})task.spawn(function()while _e()and task.wait(0.5)do pcall(function()local _bka=modBreak.stats _biI(_bjZ,string.format("Status: %s (Pass %d | Row Y=%s)",modBreak.status,_bka.pass,_bka.row>=0 and tostring(_bka.row)or "-"),string.format(("Targets: %d | Remaining: %d | Skipped: %d\nBroken: %d | Drops Pic".."ked: %d"),_bka.scanned,_bka.left,_bka.skipped,_bka.broken,_bka.picked))end)end end)_biM(_bjY,"Auto Clear World (Legit Walk + Hover Break)",("Walks via A* pathfinding between blocks and enables ModFly hover".." while breaking blocks underneath."),"autoclear")_bjY:Dropdown({Title="Sweep Direction",Values={"Zig-zag","Left -> Right"},Value=(config.clearSweep=="Zig-zag")and "Zig-zag"or "Left -> Right",Callback=function(_bkb)config.clearSweep=(_bkb=="Zig-zag")and "Zig-zag"or "Kiri â Kanan"saveConfig()end,})_bjY:Toggle({Title="Include Background Blocks",Value=config.clearIncludeBg,Callback=function(_bkc)config.clearIncludeBg=_bkc;saveConfig()end,})_bjY:Input({Title="Break Punch Delay (seconds)",Value=tostring(config.clearBreakDelay),Callback=function(_bkd)local _bke=tonumber(_bkd)if _bke and _bke>=0.03 and _bke<=5 then config.clearBreakDelay=_bke;saveConfig()end end,})_bjY:Input({Title="Move Step Delay (seconds)",Value=tostring(config.clearTpDelay),Callback=function(_bkf)local _bkg=tonumber(_bkf)if _bkg and _bkg>=0.05 and _bkg<=5 then config.clearTpDelay=_bkg;saveConfig()end end,})_bjY:Toggle({Title="Auto Collect Drops",Value=config.clearTake,Callback=function(_bkh)config.clearTake=_bkh;saveConfig()end,})end)_biD("Tab:Farmer",function()local _bki=_biV:Tab({Title="Farmer (Harvest/Plant)",Icon="solar:check-square-bold",IconColor=_bix,IconShape="Square",Border=true,})_biA.tabs.harvest=_bki
local _bkj=_bki:Paragraph({Title="Farmer Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.5)do pcall(function()local _bkk=modTrees.stats _biI(_bkj,"Status: "..modTrees.status,string.format(("Total Trees: %d | Ready: %d | Growing: %d\nHarvested: %d | Plante".."d: %d | Drops Picked: %d\nPlant Seed: %s [ID %d] (In Bag: %d)"),_bkk.totalTrees,_bkk.ready,_bkk.skipped,_bkk.harvested,_bkk.planted,_bkk.picked,_gt(config.harvestSeedId),config.harvestSeedId,getWorldPos(config.harvestSeedId)))end)end end)_biM(_bki,"Enable Farmer",("Automatically harvest ready trees & plant seeds using Zig-Zag A*".." walking."),"autoharvest")_bki:Toggle({Title="Auto Harvest (Break Ready Trees)",Value=config.harvestDoHarvest,Callback=function(_bkl)config.harvestDoHarvest=_bkl;saveConfig()end,})_bki:Toggle({Title="Auto Plant Seeds",Value=config.harvestDoPlant,Callback=function(_bkm)config.harvestDoPlant=_bkm;saveConfig()end,})_bki:Input({Title="Seed ID for Auto Plant",Desc="e.g. 3 = Dirt Seed, 5 = Lava Seed",Value=tostring(config.harvestSeedId),Placeholder="3",Callback=function(_bkn)local _bko=tonumber(_bkn)if _bko and _bko>0 then config.harvestSeedId=math.floor(_bko)saveConfig()notify("Plant Seed set to: ".._gt(config.harvestSeedId))end end,})_bki:Toggle({Title="Auto Save Block (>= 200)",Desc="Auto save block from harvest",Value=config.harvestAutoSaveBlock,Callback=function(_bkp)config.harvestAutoSaveBlock=_bkp saveConfig()end,})_bki:Toggle({Title="Auto Take Seed (Saat Habis)",Desc="Auto take seed when empty",Value=config.harvestAutoTakeSeed,Callback=function(_bkq)config.harvestAutoTakeSeed=_bkq saveConfig()end,})_bki:Input({Title="World Drop Block",Desc="Empty = this world, WORLD / WORLD:DOOR",Value=config.harvestSaveWorld,Placeholder="Example: STORAGE1:DOOR1",Callback=function(_bkr)config.harvestSaveWorld=trim(_bkr):upper()saveConfig()end,})_bki:Button({Title="SetPos Drop Block",Desc="Save current coordinate to position save block",Callback=function()local _bks,_bkt=_hv()if not _bks then notify("Posisi karakter belum terbaca!")return
    end config.harvestSaveX,config.harvestSaveY=_bks,_bkt saveConfig()notify(string.format("Pos Simpan Block Farmer diatur ke (%d, %d)",_bks,_bkt))end,})_bki:Toggle({Title="Use Scaffold Blocks When Climbing",Value=config.harvestUseBlock,Callback=function(_bku)config.harvestUseBlock=_bku;saveConfig()end,})_bki:Toggle({Title="Auto Collect Harvest Drops",Value=config.harvestTake,Callback=function(_bkv)config.harvestTake=_bkv;saveConfig()end,})end)_biD("Tab:AutoDF",function()local _bkw=_biV:Tab({Title="Auto DF (Full World)",Icon="solar:hamburger-menu-bold",IconColor=_biw,IconShape="Square",Border=true,})_biA.tabs.df=_bkw
local _bkx=_bkw:Paragraph({Title="Auto Dirt Farm Status",Desc="Loading..."})task.spawn(function()while _e()and task.wait(0.5)do pcall(function()local _bky=modDirt.stats
            local _bkz=_gQ()local _bkA=_gU()_biI(_bkx,"Status: "..modDirt.status.." ("..tostring(_bky.step)..")",string.format(("Top Dirt Row: Y=%d | Bedrock: Y=%d\nDirt in Bag: %d | Dirt Seeds:".." %d\nBroken: %d | Dirt Placed: %d | Drops Picked: %d"),_bky.topDirtY,_bky.bedrockY,getWorldPos(_bkz),getWorldPos(_bkA),_bky.broken,_bky.placed,_bky.picked))end)end end)_biM(_bkw,"Enable Auto Dirt Farm (Full World)",("Automatically build lower & upper Dirt Farm platforms + Smart Di".."rt Restock."),"autodf")_bkw:Toggle({Title="Replace Lava/Rock with Dirt on Platforms",Value=config.dfReplacePlatform,Callback=function(_bkB)config.dfReplacePlatform=_bkB;saveConfig()end,})_bkw:Toggle({Title="Use Platform",Desc="Automaticly place platform like wooden platform",Value=config.dfUsePlatform,Callback=function(_bkC)config.dfUsePlatform=_bkC saveConfig()end,})_bkw:Input({Title="ID Platform (Default: 102 = Wooden Platform)",Value=tostring(config.dfPlatformId or 102),Placeholder="102",Callback=function(_bkD)local _bkE=tonumber(_bkD)if _bkE and _bkE>0 then config.dfPlatformId=math.floor(_bkE)saveConfig()notify("Platform DF diset ke: ".._gt(config.dfPlatformId).." ["..config.dfPlatformId.."]")end end,})_bkw:Toggle({Title="Auto Collect Drops",Value=config.dfTake,Callback=function(_bkF)config.dfTake=_bkF;saveConfig()end,})_bkw:Toggle({Title="Enable ModFly During Auto DF (Anti-Lava)",Desc="Hover & stay immune to lava while breaking blocks.",Value=config.dfModFly,Callback=function(_bkG)config.dfModFly=_bkG saveConfig()if modDirt.on then _iW("autodf",_bkG)end end,})_bkw:Input({Title="Break Punch Delay (seconds)",Value=tostring(config.dfBreakDelay),Callback=function(_bkH)local _bkI=tonumber(_bkH)if _bkI and _bkI>=0.03 and _bkI<=5 then config.dfBreakDelay=_bkI;saveConfig()end end,})_bkw:Input({Title="Move Step Delay (seconds)",Value=tostring(config.dfTpDelay),Callback=function(_bkJ)local _bkK=tonumber(_bkJ)if _bkK and _bkK>=0.05 and _bkK<=5 then config.dfTpDelay=_bkK;saveConfig()end end,})end)_biD("Tab:AutoSplice",function()local _bkL=_biV:Tab({Title="Auto Splice",Icon="solar:square-transfer-horizontal-bold",IconColor=_biv,IconShape="Square",Border=true,})_biA.tabs.splice=_bkL
local _bkM=_bkL:Paragraph({Title="Auto Splice Status",Desc="Loading..."})task.spawn(function()while _e()and task.wait(0.6)do pcall(function()_biI(_bkM,"Status: ".._te.status,string.format(("%s\nSeed A: %s [%d] (x%d) | Seed B: %s [%d] (x%d)\nPlanted: %d | S".."pliced: %d"),_te.ResultText(),_gt(config.spliceA),config.spliceA,getWorldPos(config.spliceA),_gt(config.spliceB),config.spliceB,getWorldPos(config.spliceB),_te.planted,_te.made))end)end end)_biM(_bkL,"Enable Auto Splice","Plant Seed A and splice it with Seed B.","autosplice")_bkL:Input({Title="Seed A ID (Planted First)",Value=tostring(config.spliceA),Placeholder="3 (Dirt Seed)",Callback=function(_bkN)local _bkO=tonumber(_bkN)if _bkO and _bkO>0 then config.spliceA=math.floor(_bkO);saveConfig()end end,})_bkL:Input({Title="Seed B ID (Spliced onto Seed A)",Value=tostring(config.spliceB),Placeholder="5 (Lava Seed)",Callback=function(_bkP)local _bkQ=tonumber(_bkP)if _bkQ and _bkQ>0 then config.spliceB=math.floor(_bkQ);saveConfig()end end,})_bkL:Toggle({Title="Roam Entire World (A*)",Desc=("ON = Find empty tiles across the world. OFF = Only splice within".." 5x5 Grid."),Value=config.spliceRoam,Callback=function(_bkR)config.spliceRoam=_bkR;saveConfig()end,})_bkL:Slider({Title="Plant / Splice Delay (ms)",IsTooltip=true,Step=10,Value={Min=140,Max=2000,Default=math.clamp(config.spliceMs,140,2000)},Callback=function(_bkS)config.spliceMs=math.floor(tonumber(_bkS)or 300);saveConfig()end,})end)_biD("Tab:Pabrik",function()local _bkT=_biV:Tab({Title="Seed Factory",Icon="solar:folder-with-files-bold",IconColor=_biy,IconShape="Square",Border=true,})_biA.tabs.pabrik=_bkT
local _bkU=_bkT:Paragraph({Title="Seed Factory Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.6)do pcall(function()local _bkV=config.pabrikSeedId
            local _bkW=_gK(_bkV)local _bkX,_bkY=modFarm.ParseDropTarget()local _bkZ=(_bkX~=""and _bkX or "Current World")..(_bkY and(" Door:".._bkY)or"")..(config.pabrikDropX>=0 and string.format(" (%d,%d)",config.pabrikDropX,config.pabrikDropY)or"")_biI(_bkU,string.format("Status: %s (Phase: %s)",modFarm.status,modFarm.phase),string.format(("Seed: %s [%d] x%d | Block: %s x%d\nBreak Pos: %s\nDrop Target: %s ".."(Max Seed Cap: %d)\nTotals: Harvested %d | Planted %d | Dropped %".."d"),_gt(_bkV),_bkV,getWorldPos(_bkV),_bkW and _gt(_bkW)or "-",_bkW and getWorldPos(_bkW)or 0,config.pabrikBreakX>=0 and string.format("Tile (%d, %d)",config.pabrikBreakX,config.pabrikBreakY)or "Not set!",config.pabrikDrop and _bkZ or "Disabled",config.pabrikMaxSeed or 100,modFarm.harvested,modFarm.planted,modFarm.dropped))end)end end)_biM(_bkT,"Enable Seed Factory",("Full Cycle: Break Blocks -> Drop Excess Seeds -> Plant -> Wait -".."> Harvest -> Repeat."),"pabrik")_bkT:Input({Title="Factory Seed ID",Desc=("Block ID is detected automatically (e.g. 3 = Dirt Seed -> Block ".."ID 2 = Dirt)."),Value=tostring(config.pabrikSeedId),Callback=function(_bla)local _blb=tonumber(_bla)if _blb and _blb>0 then config.pabrikSeedId=math.floor(_blb);saveConfig()end end,})_bkT:Input({Title="Max Seed Cap (Plant & Rotation Limit)",Desc=("e.g. 100 = Only plant up to 100 seeds. Any extra seeds above 100".." after breaking are automatically dropped at storage."),Value=tostring(config.pabrikMaxSeed or 100),Placeholder="100",Callback=function(_blc)local _bld=tonumber(_blc)if _bld and _bld>=1 then config.pabrikMaxSeed=math.floor(_bld)saveConfig()notify("Factory Max Seed set to: "..tostring(config.pabrikMaxSeed))end end,})_bkT:Space()_bkT:Section({Title="Factory Break Position (SetPos Break)"})local _ble=_bkT:Group({})_ble:Button({Title="SetPos Break (Save Position)",Color=Color3.fromHex("#10C550"),Justify="Center",Callback=function()local _blf,_blg=_hv()if not _blf then notify("Character position not detected!");return
    end config.pabrikBreakX,config.pabrikBreakY=_blf,_blg saveConfig()notify(string.format("Factory Break Position saved at (%d, %d)!",_blf,_blg))end,})_ble:Button({Title="Go to Break Pos",Justify="Center",Callback=function()if config.pabrikBreakX<0 or config.pabrikBreakY<0 then notify("Break Position is not set yet!")return
end task.spawn(function()modClick.To(config.pabrikBreakX,config.pabrikBreakY,nil,0.3,true)end)end,})_bkT:Button({Title="Select Break Tiles (Open 5x5 Grid in Factory Mode)",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()if _sZ then _sZ("pabrik")end
if _sW then _sW.Enabled=true
end end,})_bkT:Space()_bkT:Section({Title="Seed Storage / Auto Drop Settings"})_bkT:Toggle({Title="Enable Auto Drop Excess Seeds to Storage",Value=config.pabrikDrop,Callback=function(_blh)config.pabrikDrop=_blh;saveConfig()end,})_bkT:Input({Title="Seed Storage World (WORLD or WORLD:DOOR_ID)",Value=config.pabrikDropWorld,Placeholder="e.g. STORAGE or STORAGE:1",Callback=function(_bli)config.pabrikDropWorld=trim(_bli or"");saveConfig()end,})_bkT:Button({Title="SetPos Seed Drop (Save Current Tile)",Justify="Center",Callback=function()local _blj,_blk=_hv()if not _blj then notify("Position not detected!");return
end config.pabrikDropX,config.pabrikDropY=_blj,_blk saveConfig()notify(string.format("Seed Drop Position saved at (%d, %d)",_blj,_blk))end,})end)_biD("Tab:AutoMove",function()local _bll=_biV:Tab({Title="Auto Move Item",Icon="solar:square-transfer-horizontal-bold",IconColor=_bix,IconShape="Square",Border=true,})_biA.tabs.automove=_bll
local _blm=_bll:Paragraph({Title="Auto Move Item Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.6)do pcall(function()local _bln=tonumber(config.moveItemId)or 0 _biI(_blm,string.format("Status: %s (Phase: %s)",modGems.status,modGems.phase),string.format(("Item: %s [ID %d] (In Bag: %d)\nWorld 1 (Take): %s  ->  World 2 (D".."rop): %s\nWorld 2 Drop Pos: %s\nTotal Picked: %d | Total Dropped: ".."%d"),_gt(_bln),_bln,getWorldPos(_bln),config.moveWorld1~=""and config.moveWorld1 or "(Not set)",config.moveWorld2~=""and config.moveWorld2 or "(Not set)",(config.moveDropX>=0 and config.moveDropY>=0)and string.format("(%d, %d)",config.moveDropX,config.moveDropY)or "(Not set)",modGems.collected,modGems.dropped))end)end end)_biM(_bll,"Enable Auto Move (World 1 -> World 2)",("Take dropped items in World 1 -> Warp & Drop in World 2 (steps r".."ight 1 tile if full) -> Loop until empty."),"automove")_bll:Input({Title="World 1 - Source World (WORLD or WORLD:DOOR_ID)",Value=config.moveWorld1,Placeholder="e.g. FARM1 or FARM1:DOOR1",Callback=function(_blo)config.moveWorld1=trim(_blo or"");saveConfig()end,})_bll:Input({Title="World 2 - Drop World (WORLD or WORLD:DOOR_ID)",Value=config.moveWorld2,Placeholder="e.g. STORAGE1 or STORAGE1:DOOR2",Callback=function(_blp)config.moveWorld2=trim(_blp or"");saveConfig()end,})_bll:Button({Title="SetPos Drop in World 2 (Save Current Position)",Color=Color3.fromHex("#10C550"),Justify="Center",Callback=function()local _blq,_blr=_hv()if not _blq then notify("Position not detected!");return
    end config.moveDropX,config.moveDropY=_blq,_blr saveConfig()notify(string.format("World 2 Drop Position saved at (%d, %d)!",_blq,_blr))end,})_bll:Input({Title="Item ID to Move",Value=tostring(config.moveItemId),Placeholder="e.g. 2 (Dirt) or 3 (Dirt Seed)",Callback=function(_bls)local _blt=tonumber(_bls)if _blt and _blt>0 then config.moveItemId=math.floor(_blt)saveConfig()notify("Auto Move Item set to: ".._gt(config.moveItemId).." ["..config.moveItemId.."]")end end,})end)_biD("Tab:Rotation",function()local _blu=_biV:Tab({Title="World Rotation",Icon="solar:square-transfer-horizontal-bold",IconColor=_biy,IconShape="Square",Border=true,})_biA.tabs.rotation=_blu
local _blv=_blu:Paragraph({Title="Multi-World Rotation Status",Desc="Loading..."})local _blw=session.Rotation task.spawn(function()while _e()and task.wait(0.6)do pcall(function()local _blx=tonumber(config.rotSeedId)or 3
            local _bly=_gK(_blx)or 2
            local _blz=_blw.ParseWorldsList()_biI(_blv,string.format("Status: %s (Phase: %s)",_blw.status,_blw.phase),string.format(("Current World: %s (#%d/%d | Full Loops: %d)\nSeed: %s [%d] (x%d) ".."| Block: %s (x%d)\nHarvested: %d | Broken: %d | Planted: %d"),_blw.currentWorld,_blw.worldIndex,#_blz,_blw.passes,_gt(_blx),_blx,getWorldPos(_blx),_gt(_bly),getWorldPos(_bly),_blw.harvested,_blw.broken,_blw.planted))end)end end)_biM(_blu,"Enable Multi-World Rotation",("Warp World 1 -> Harvest Ready -> Break at 200 Blocks -> Plant Se".."eds -> Next World -> Loop."),"rotation")_blu:Input({Title="Rotation World List (Separate with Comma)",Desc="Format: WORLD1, WORLD2:DOOR_ID, WORLD3",Value=config.rotWorlds,Placeholder="e.g. FARM1, FARM2:1, FARM3",Callback=function(_blA)config.rotWorlds=trim(_blA or"");saveConfig()end,})_blu:Input({Title="Target Tree Seed ID",Desc="e.g. 3 = Dirt Seed (Block ID is detected automatically).",Value=tostring(config.rotSeedId or 3),Placeholder="3",Callback=function(_blB)local _blC=tonumber(_blB)if _blC and _blC>0 then config.rotSeedId=math.floor(_blC)saveConfig()notify("Rotation Seed set to: ".._gt(config.rotSeedId))end end,})_blu:Toggle({Title="Loop Back to World 1 After Finishing All Worlds",Value=config.rotLoop,Callback=function(_blD)config.rotLoop=_blD;saveConfig()end,})_blu:Button({Title="SetPos Break for Rotation (Save Current Position)",Color=Color3.fromHex("#10C550"),Justify="Center",Callback=function()local _blE,_blF=_hv()if not _blE then notify("Position not detected!");return
    end config.rotBreakX,config.rotBreakY=_blE,_blF saveConfig()notify(string.format("Rotation Break Position saved at (%d, %d)!",_blE,_blF))end,})_blu:Space()_blu:Section({Title="Surplus Seed Storage (Optional)"})_blu:Toggle({Title="Auto Drop Surplus Seeds to Storage World",Value=config.rotDropExcess,Callback=function(_blG)config.rotDropExcess=_blG;saveConfig()end,})_blu:Input({Title="Seeds to Keep for Next World",Value=tostring(config.rotKeepSeed or 100),Callback=function(_blH)local _blI=tonumber(_blH)if _blI and _blI>=0 then config.rotKeepSeed=math.floor(_blI);saveConfig()end end,})_blu:Input({Title="Seed Storage World (WORLD or WORLD:DOOR_ID)",Value=config.rotSaveWorld,Placeholder="e.g. STORAGE or STORAGE:1",Callback=function(_blJ)config.rotSaveWorld=trim(_blJ or"");saveConfig()end,})_blu:Button({Title="SetPos Seed Drop in Storage World",Justify="Center",Callback=function()local _blK,_blL=_hv()if not _blK then notify("Position not detected!");return
end config.rotSaveX,config.rotSaveY=_blK,_blL saveConfig()notify(string.format("Rotation Storage Drop Position saved at (%d, %d)",_blK,_blL))end,})end)_biD("Tab:FastWrench",function()local _blM=_biW:Tab({Title="Fast Wrench",Icon="solar:square-transfer-horizontal-bold",IconColor=_biv,IconShape="Square",Border=true,})_biA.tabs.fastwrench=_blM _blM:Section({Title="Fast Wrench Actions (0ms Modal Bypass)"})local _blN,_blO,_blP _blN=_blM:Toggle({Title="Fast Pull (Wrench Player = Instant Pull)",Desc=("Bypass the wrench dialog and immediately pull the wrenched playe".."r."),Value=config.fastPull,Callback=function(_blQ)config.fastPull=_blQ
if _blQ then config.fastKick,config.fastBan=false,false
    if _blO and _blO.Set then pcall(function()_blO:Set(false)end)end
    if _blP and _blP.Set then pcall(function()_blP:Set(false)end)end notify("Fast Pull ENABLED! Wrench a player to pull them instantly.")end saveConfig()end,})_blO=_blM:Toggle({Title="Fast Kick (Wrench Player = Instant Kick)",Desc=("Bypass the wrench dialog and immediately kick the wrenched playe".."r."),Value=config.fastKick,Callback=function(_blR)config.fastKick=_blR
if _blR then config.fastPull,config.fastBan=false,false
    if _blN and _blN.Set then pcall(function()_blN:Set(false)end)end
    if _blP and _blP.Set then pcall(function()_blP:Set(false)end)end notify("Fast Kick ENABLED! Wrench a player to kick them instantly.")end saveConfig()end,})_blP=_blM:Toggle({Title="Fast Ban (Wrench Player = Instant Ban)",Desc=("Bypass the wrench dialog and immediately ban the wrenched player".."."),Value=config.fastBan,Callback=function(_blS)config.fastBan=_blS
if _blS then config.fastPull,config.fastKick=false,false
    if _blN and _blN.Set then pcall(function()_blN:Set(false)end)end
    if _blO and _blO.Set then pcall(function()_blO:Set(false)end)end notify("Fast Ban ENABLED! Wrench a player to ban them instantly.")end saveConfig()end,})end)_biD("Tab:FastDropRecycle",function()local _blT=_biW:Tab({Title="Fast Drop & Recycle",Icon="solar:square-transfer-horizontal-bold",IconColor=_biv,IconShape="Square",Border=true,})_biA.tabs.fastdroprecycle=_blT _blT:Section({Title="Fast Drop & Fast Recycle / Trash (0ms Dialog Bypass)"})_blT:Toggle({Title="Fast Drop (Click Drop = Instant Drop Without Dialog)",Desc=("Automatically bypass the quantity popup when clicking Drop in yo".."ur Backpack."),Value=config.fastDrop,Callback=function(_blU)config.fastDrop=_blU saveConfig()notify("Fast Drop "..(_blU and "ENABLED!"or "DISABLED."))end,})_blT:Input({Title="Fast Drop Amount (0 = Drop All)",Desc=("Set to 0 to instantly drop the entire stack of the selected item".."."),Value=tostring(config.fastDropCount or 0),Placeholder="0 = All",Callback=function(_blV)local _blW=tonumber(_blV)config.fastDropCount=(_blW and _blW>=0)and math.floor(_blW)or 0 saveConfig()notify("Fast Drop Amount set to: "..(config.fastDropCount==0 and "ALL"or tostring(config.fastDropCount)))end,})_blT:Space()_blT:Toggle({Title="Fast Recycle / Trash (Click Recycle = Instant Trash)",Desc=("Automatically bypass the confirmation popup when clicking Recycl".."e in your Backpack."),Value=config.fastRecycle,Callback=function(_blX)config.fastRecycle=_blX saveConfig()notify("Fast Recycle "..(_blX and "ENABLED!"or "DISABLED."))end,})_blT:Input({Title="Fast Recycle Amount (0 = Recycle All)",Desc=("Set to 0 to instantly recycle the entire stack of the selected i".."tem."),Value=tostring(config.fastRecycleCount or 0),Placeholder="0 = All",Callback=function(_blY)local _blZ=tonumber(_blY)config.fastRecycleCount=(_blZ and _blZ>=0)and math.floor(_blZ)or 0 saveConfig()notify("Fast Recycle Amount set to: "..(config.fastRecycleCount==0 and "ALL"or tostring(config.fastRecycleCount)))end,})end)_biD("Tab:Bag",function()local _bma=_biX:Tab({Title="Backpack (Recycle & Locks)",Icon="solar:check-square-bold",IconColor=_bix,IconShape="Square",Border=true,})_biA.tabs.bag=_bma
local _bmb=_bma:Paragraph({Title="Backpack Management Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.8)do pcall(function()local _bmc={}for k_bmd,_bme in ipairs(config.trashList or{})do table.insert(_bmc,_gt(v_bme).." ["..v_bme.."]")end _biI(_bmb,"Last Action: "..modRecycle.status,string.format(("Total Recycled: %d items | Locks Converted: %d times\nAuto-Recycl".."e List: %s"),modRecycle.recycled,modRecycle.converted,#_bmc>0 and table.concat(_bmc,", ")or "(None)"))end)end end)_bma:Toggle({Title="Enable Auto Recycle (Auto Trash Items)",Value=config.trashOn,Callback=function(_bmf)config.trashOn=_bmf;saveConfig()end,})_bma:Input({Title="Add / Remove Item ID from Auto-Recycle",Desc=("Enter an Item ID (e.g. 2 for Dirt) to toggle it in the Auto-Recy".."cle list."),Placeholder="Enter Item ID...",Callback=function(_bmg)local _bmh=tonumber(_bmg)if not _bmh or _bmh<=0 then
        return
    end _bmh=math.floor(_bmh)local _bmi=table.find(config.trashList,_bmh)if _bmi then table.remove(config.trashList,_bmi)notify(_gt(_bmh).." removed from Auto-Recycle list.")else table.insert(config.trashList,_bmh)notify(_gt(_bmh).." added to Auto-Recycle list.")end saveConfig()end,})_bma:Slider({Title="Recycle When Count >=",IsTooltip=true,Step=5,Value={Min=5,Max=200,Default=math.clamp(config.trashAt,5,200)},Callback=function(_bmj)config.trashAt=math.floor(tonumber(_bmj)or 150);saveConfig()end,})_bma:Slider({Title="Keep Amount in Backpack",IsTooltip=true,Step=5,Value={Min=0,Max=195,Default=math.clamp(config.trashKeep,0,195)},Callback=function(_bmk)config.trashKeep=math.floor(tonumber(_bmk)or 0);saveConfig()end,})_bma:Space()_bma:Section({Title="Locks & Quick Drop"})_bma:Toggle({Title="Auto Convert Locks (100 WL -> 1 DL, 100 DL -> 1 BGL)",Value=config.convertLockOn,Callback=function(_bml)config.convertLockOn=_bml;saveConfig()end,})local _bmm="100"_bma:Input({Title="World Lock Drop Amount",Value="100",Placeholder="Amount (1-10000)",Callback=function(_bmn)_bmm=_bmn end,})_bma:Button({Title="Drop World Locks Now",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()local _bmo=tonumber(_bmm)if _bmo and _bmo>=1 and _bmo<=MAX_ITEM_ID then task.spawn(_ss,math.floor(_bmo))else notify("Invalid WL amount!")end end,})end)_biD("Tab:GrowScan",function()local _bmp=_biX:Tab({Title="GrowScan 9000",Icon="solar:info-square-bold",IconColor=_biy,IconShape="Square",Border=true,})_biA.tabs.scan=_bmp
local _bmq=_bmp:Paragraph({Title="GrowScan 9000",Desc=("Click the button below to scan all blocks, trees, and floating d".."rops in the world.")})local function _bmr()local _bms=_baH()if not _bms then _biI(_bmq,"GrowScan","World not detected.")return
    end
local function _bmt(_bmu,_bmv)local _bmw={}for k_bmx,v_bmy in pairs(_bmu)do table.insert(_bmw,{id=k_bmx,n=v_bmy})end table.sort(_bmw,function(_bmz,_bmA)return _bmz.n>_bmA.n end)local _bmB={}for _bmC=1,math.min(_bmv or 12,#_bmw)do table.insert(_bmB,string.format("â¢ %s [%d] x%d",_gt(_bmw[_bmC].id),_bmw[_bmC].id,_bmw[_bmC].n))end return#_bmB>0 and table.concat(_bmB,"\n")or "Empty"end
local _bmD={}for _bmE,_bmF in pairs(_bms.trees)do
    local _bmG=v_bmF.nextIn and string.format(" (ready in %ds)",math.max(0,math.ceil(_bmF.nextIn)))or""table.insert(_bmD,string.format("â¢ %s: %d ready | %d growing%s",_gt(_bmE),v_bmF.ready,v_bmF.growing,_bmG))end
local _bmH=table.concat({string.format("World: %s (%dx%d)",_hy(),_bms.w,_bms.h),string.format("FG: %d | BG: %d | Floating: %d (%d stacks)",_bms.totalFg,_bms.totalBg,_bms.totalDrops,_bms.piles),string.format("Trees: %d ready | %d growing",_bms.readyTrees,_bms.growingTrees),"\n[TREES IN WORLD]:\n"..(#_bmD>0 and table.concat(_bmD,"\n")or "No trees"),"\n[FLOATING DROPS]:\n".._bmt(_bms.drops,10),"\n[WORLD BLOCKS]:\n".._bmt(_bms.fg,12),},"\n")_biI(_bmq,"GrowScan Results ("..os.date("%H:%M:%S")..")",_bmH)end _bmp:Button({Title="Scan World Now",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=_bmr,})_bmp:Button({Title="Open Native In-Game GrowScan UI",Justify="Center",Callback=function()if not _baG()then notify("Native GrowScan UI is unavailable.")end end,})end)_biD("Tab:Pos",function()local _bmI=_biX:Tab({Title="Teleport & Positions",Icon="solar:hamburger-menu-bold",IconColor=_biw,IconShape="Square",Border=true,})_biA.tabs.pos=_bmI
local _bmJ=""_bmI:Input({Title="Target World Name",Placeholder="Enter world name...",Callback=function(_bmK)_bmJ=trim(_bmK or"")end,})_bmI:Button({Title="Warp to World",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()if _bmJ~=""then task.spawn(_sx,_bmJ)else notify("Enter a world name first!")end end,})_bmI:Space()_bmI:Section({Title="Saved Positions (Pos 1 / Pos 2)"})for _bmL=1,2
do
    local _bmM=_bmI:Paragraph({Title="Position ".._bmL,Desc="Not set"})local function _bmN()local _bmO=config["pos".._bmL]if type(_bmO)=="table"and type(_bmO.x)=="number"then _biI(_bmM,"Saved Pos ".._bmL,string.format("Tile (%d, %d) in World %s",_bmO.x,_bmO.y,_bmO.world or "-"))else _biI(_bmM,"Position ".._bmL,"Not set")end
    end table.insert(_biA.refreshers,_bmN)_bmN()local _bmP=_bmI:Group({})_bmP:Button({Title="Save Pos ".._bmL,Justify="Center",Callback=function()_sD(_bmL);_sV()end})_bmP:Button({Title="Teleport (win".._bmL..")",Justify="Center",Callback=function()task.spawn(_sO,_bmL)end})end end)_biD("Tab:Vending",function()local _bmQ=_biX:Tab({Title="Vending Machine",Icon="solar:folder-with-files-bold",IconColor=_biv,IconShape="Square",Border=true,})_biA.tabs.vending=_bmQ
local _bmR=_bmQ:Paragraph({Title="Vending Bot Status",Desc="Loading..."})task.spawn(function()while isAlive()and task.wait(0.8)do pcall(function()_biI(_bmR,"Status: ".._UI.status,string.format("Mode: %s\nStocked: %d | Emptied: %d",config.vendMode,_UI.stocked,_UI.taken))end)end end)_bmQ:Toggle({Title="Enable Vending Machine Bot",Value=_UI.on,Callback=function(_bmS)if _bmS then _UI.Start()else _UI.Stop()end end,})local _bmT={["Restock from Backpack/Drops"]="Isi stock dari drop",["Empty Until Depleted"]="Kosongkan sampai habis",}local _bmU={["Isi stock dari drop"]="Restock from Backpack/Drops",["Kosongkan sampai habis"]="Empty Until Depleted",}_bmQ:Dropdown({Title="Vending Mode",Values={"Restock from Backpack/Drops","Empty Until Depleted"},Value=_bmU[config.vendMode]or "Restock from Backpack/Drops",Callback=function(_bmV)config.vendMode=_bmT[_bmV]or "Isi stock dari drop"saveConfig()end,})_bmQ:Input({Title="Drop World When Emptying (WORLD or WORLD:DOOR)",Value=config.vendPoint,Placeholder="e.g. STORAGE or STORAGE:1",Callback=function(_bmW)config.vendPoint=trim(_bmW or"");saveConfig()end,})_bmQ:Button({Title="SetPos Drop for Emptied Vending Items",Justify="Center",Callback=function()local _bmX,_bmY=_hv()if not _bmX then notify("Position not detected!");return
    end config.vendDropX,config.vendDropY=_bmX,_bmY saveConfig()notify(string.format("Vending Drop Position saved at (%d, %d)",_bmX,_bmY))end,})end)_biD("Tab:Guard",function()local _bmZ=_biY:Tab({Title="Guard & Reconnect",Icon="solar:info-square-bold",IconColor=_biz,IconShape="Square",Border=true,})_biA.tabs.guard=_bmZ
local _bna=_bmZ:Paragraph({Title="Guard & Reconnect Status",Desc="Idle"})task.spawn(function()while isAlive()and task.wait(0.6)do pcall(function()_biI(_bna,"Guard: "..modIntrusion.status.." | Reconnect: ".._tj.status,string.format(("Players in World: %s\nStaff in Server: %s\nDetections: %d | Rejoin".."s: %d"),modIntrusion.hereText,modIntrusion.staffServerText,modIntrusion.detected,_tj.count))end)end end)_biM(_bmZ,"Enable Anti-Mod Guard",("Monitor Moderators / Developers (including undercover) or other ".."players entering the world."),"guard")local _bnb={["Staff Only (Mod/Dev)"]="Staff (Mod/Dev)",["All Players"]="Semua pemain",}local _bnc={["Staff (Mod/Dev)"]="Staff Only (Mod/Dev)",["Semua pemain"]="All Players",}_bmZ:Dropdown({Title="Detection Target",Values={"Staff Only (Mod/Dev)","All Players"},Value=_bnc[config.guardWho]or "Staff Only (Mod/Dev)",Callback=function(_bnd)config.guardWho=_bnb[_bnd]or "Staff (Mod/Dev)"saveConfig()end,})_bmZ:Toggle({Title="Pause All Active Bots on Detection",Value=config.guardStopAll,Callback=function(_bne)config.guardStopAll=_bne;saveConfig()end,})_bmZ:Toggle({Title="Immediately Leave World on Detection",Value=config.guardLeave,Callback=function(_bnf)config.guardLeave=_bnf;saveConfig()end,})_bmZ:Toggle({Title="Auto Resume When Safe",Value=config.guardAutoBack,Callback=function(_bng)config.guardAutoBack=_bng;saveConfig()end,})_bmZ:Slider({Title="Return Wait Time (seconds)",IsTooltip=true,Step=5,Value={Min=15,Max=300,Default=math.clamp(config.guardBackSec,15,300)},Callback=function(_bnh)config.guardBackSec=tonumber(_bnh)or 60;saveConfig()end,})_bmZ:Button({Title="Whitelist Players Currently in World",Justify="Center",Callback=function()local _bni=modIntrusion.AllowCurrentPlayers()notify(_bni.." players in this world added to whitelist.")end,})_bmZ:Space()_bmZ:Section({Title="Auto Reconnect (World Closed & Server Disconnect)"})_biM(_bmZ,"Enable Auto Reconnect",("Re-enter the world & resume bot activities if kicked or disconne".."cted."),"autorejoin")_bmZ:Toggle({Title="Re-Enter When World Closes / Kicked",Value=config.reconnectWorld,Callback=function(_bnj)config.reconnectWorld=_bnj;saveConfig()end,})_bmZ:Toggle({Title="Always Stay in World (Auto Enter from Menu)",Value=config.reconnectKeep,Callback=function(_bnk)config.reconnectKeep=_bnk;saveConfig()end,})_bmZ:Toggle({Title="Auto Teleport on Server Disconnect",Value=config.reconnectServer,Callback=function(_bnl)config.reconnectServer=_bnl;saveConfig()end,})_bmZ:Input({Title="Reconnect Target World (Empty = Last World)",Placeholder="WORLDNAME",Callback=function(_bnm)config.targetWorld=trim(_bnm or"");saveConfig()end,})end)_biD("Tab:Bonus",function()local _bnn=_biY:Tab({Title="Auto Chat & Bonus",Icon="solar:file-text-bold",IconColor=_biv,IconShape="Square",Border=true,})_biA.tabs.bonus=_bnn
local _bno=_bnn:Paragraph({Title="Auto Chat & Bonus Status",Desc="Loading..."})task.spawn(function()while _e()and task.wait(0.8)do pcall(function()_biI(_bno,string.format("Auto Chat: %s (Sent: %d)",_tk.on and "ACTIVE"or "OFF",_tk.sent),string.format("Configured Message: %s\nLast Sent: %s\nQuests: %s\nRedeem: %s",config.chatText~=""and config.chatText or "(Not set)",_tk.last,_Xv.questText,_Xv.codeText))end)end end)_bnn:Section({Title="Auto Chat / Spammer (Single Message)"})_biM(_bnn,"Enable Auto Chat",("Automatically send your configured message to the world chat cha".."nnel."),"autochat")_bnn:Input({Title="Auto Chat Message",Value=config.chatText,Placeholder="Type the message to send...",Callback=function(_bnp)config.chatText=trim(_bnp or"")saveConfig()end,})_bnn:Slider({Title="Chat Interval (seconds)",IsTooltip=true,Step=1,Value={Min=3,Max=120,Default=math.clamp(config.chatInterval,3,120)},Callback=function(_bnq)config.chatInterval=tonumber(_bnq)or 6;saveConfig()end,})_bnn:Button({Title="Send Chat Message Once Now",Justify="Center",Callback=function()_tk.SendNext()end,})_bnn:Space()_bnn:Section({Title="Quests & Promo Codes"})_biM(_bnn,"Auto Claim Completed Quests","Automatically check and claim finished quests every 30s.","autoquest")_bnn:Toggle({Title="Auto Redeem Active Promo Codes",Value=config.bonusAutoRedeem,Callback=function(_bnr)config.bonusAutoRedeem=_bnr
    if _bnr then _Xv.nextCode=0
    end saveConfig()end,})local _bns=_bnn:Group({})_bns:Button({Title="Check Quests Now",Justify="Center",Callback=function()task.spawn(_baF)end,})_bns:Button({Title="Redeem All Active Codes",Justify="Center",Callback=function()task.spawn(function()_Xv.CheckCodes()notify(_Xv.codeText,"Promo Codes")end)end,})end)_biD("Tab:Visual",function()local _bnt=_biY:Tab({Title="Cosmetics & Roles",Icon="solar:check-square-bold",IconColor=_biy,IconShape="Square",Border=true,})_biA.tabs.visual=_bnt _bnt:Section({Title="Client-Side Visual Wearables"})local _bnu={}local _bnv _bnt:Input({Title="Search Wearable / Cosmetic",Placeholder="e.g. Rayman, Wings,Katana...",Callback=function(_bnw)_bnu={}local _bnx={}local _bny=trim(_bnw):lower()for k_bnz,v_bnA in ipairs(_baM())do
    if _bny==""or _bnA.lower:find(_bny,1,true)then
        local _bnB=string.format("%s [%d] (%s)",v_bnA.name,v_bnA.id,v_bnA.slot)_bnu[_bnB]=v_bnA.id table.insert(_bnx,_bnB)if#_bnx>=30 then break
        end
end
end if#_bnx==0 then _bnx={"No matching items"}end
if _bnv and _bnv.Refresh then pcall(function()_bnv:Refresh(_bnx)end)end end,})_bnv=_bnt:Dropdown({Title="Equip / Unequip Visual Item",Values={"Search for an item above..."},Callback=function(_bnC)local _bnD=_bnu[_bnC]if _bnD then _baK(_bnD)notify("Toggled visual item: ".._gt(_bnD))end end,})_bnt:Button({Title="Reset All Visual Wearables",Justify="Center",Callback=_baL,})_bnt:Space()_bnt:Section({Title="Watermark & Title Role"})_bnt:Toggle({Title="Custom Animated NameTag Watermark",Value=config.customWatermark,Callback=function(_bnE)config.customWatermark=_bnE;saveConfig()end,})_bnt:Input({Title="Custom Watermark Text",Value=config.watermarkText,Placeholder="GSZ HUB",Callback=function(_bnF)local _bnG=trim(_bnF or"")if _bnG~=""then config.watermarkText=_bnG;saveConfig()end end,})local _bnI=_bnt:Dropdown({Title="Select Owned Title / Role",Values=_baN(),Value=config.selectedRole or "none",Callback=function(_bnH)config.selectedRole=_bnH or "none"saveConfig()_baO(config.selectedRole)end,})_bnt:Button({Title="Refresh Owned Roles",Justify="Center",Callback=function()if _bnI and _bnI.Refresh then pcall(function()_bnI:Refresh(_baN())end)notify("Owned roles list refreshed!")end end,})end)_biD("Tab:Settings",function()local _bnJ=_biZ:Tab({Title="Webhook & Settings",Icon="solar:folder-with-files-bold",IconColor=_bix,IconShape="Square",Border=true,})_biA.tabs.settings=_bnJ
local _bnK=_bnJ:Paragraph({Title="Discord Webhook Status",Desc="Last Status: -"})task.spawn(function()while isAlive()and task.wait(1)do pcall(function()_biI(_bnK,"Discord Webhook: "..(config.webhookOn and "ENABLED"or "DISABLED"),"Delivery Status: "..tostring(webhookSvc.Status))end)end end)_bnJ:Toggle({Title="Enable Discord Webhook Notifications",Value=config.webhookOn,Callback=function(_bnL)config.webhookOn=_bnL;saveConfig()end,})_bnJ:Input({Title="Discord Webhook URL",Value=config.webhookUrl,Placeholder="https://discord.com/api/webhooks/...",Callback=function(_bnM)config.webhookUrl=trim(_bnM or"");saveConfig()end,})_bnJ:Slider({Title="Periodic Session Report Interval (minutes, 0 = Off)",IsTooltip=true,Step=5,Value={Min=0,Max=120,Default=math.clamp(config.webhookReportMin,0,120)},Callback=function(_bnN)config.webhookReportMin=tonumber(_bnN)or 0;saveConfig()end,})_bnJ:Button({Title="Send Test Webhook",Color=Color3.fromHex("#305dff"),Justify="Center",Callback=function()if not webhookSvc.Valid(config.webhookUrl)then notify("Invalid Discord Webhook URL!")else
        local _bnO=config.webhookOn config.webhookOn=true webhookSvc.Send("test","Test connection from **GSZ Hub | GrowBlox**! World: `".._hy().."`")config.webhookOn=_bnO notify("Test message queued!")end end,})_bnJ:Space()_bnJ:Section({Title="Session & Auto-Execute on Teleport"})_bnJ:Toggle({Title="Auto-Restore Enabled Features on Startup",Value=config.autoRestore,Callback=function(_bnP)config.autoRestore=_bnP;saveConfig()end,})_bnJ:Toggle({Title="Auto-Reload Script on World Teleport",Value=config.autoReload,Callback=function(_bnQ)config.autoReload=_bnQ;saveConfig()end,})_bnJ:Input({Title="Script Reload URL (Optional for queue_on_teleport)",Value=config.scriptUrl,Placeholder="https://raw.githubusercontent.com/...",Callback=function(_bnR)config.scriptUrl=trim(_bnR or"");saveConfig()end,})local _bnS=_bnJ:Group({})_bnS:Button({Title="Install Loader to Autoexec",Justify="Center",Callback=_bha,})_bnS:Button({Title="Rejoin Current Server",Justify="Center",Callback=_sB,})end)pcall(function()_bii:SetToggleKey(Enum.KeyCode.RightControl)end)do(function()local function _bnT(_bnU,_bnV)if not _bnU or _bnU==""then
            return not _bnV
        end _bnU=_bnU:lower()if _bnU=="on"or _bnU=="1"or _bnU=="true"then
        return true
    end
if _bnU=="off"or _bnU=="0"or _bnU=="false"then
    return false
end
return not _bnV
end
local function _bnW(_bnX)if type(_bnX)~="string"then
        return false
    end
local _bnY=config.prefix or "/"if _bnX:sub(1,#_bnY)~=_bnY then
    return false
end
local _bnZ=trim(_bnX:sub(#_bnY+1))if _bnZ==""then
    return false
end
local _boa,_bob=_bnZ:match("^(%S+)%s*(.*)$")if not _boa then
    return false
end _boa=_boa:lower()if _boa=="wld"or _boa=="wd"then task.spawn(_ss,tonumber(_bob))return true elseif _boa=="tp"or _boa=="warp"then task.spawn(_sx,_bob)return true elseif _boa=="pos1"then _sD(1);return true elseif _boa=="pos2"then _sD(2);return true elseif _boa=="win1"or _boa=="w1"then task.spawn(_sO,1,tonumber(_bob));return true elseif _boa=="win2"or _boa=="w2"then task.spawn(_sO,2,tonumber(_bob));return true elseif _boa=="pos"then _sI();return true elseif _boa=="rejoin"or _boa=="rj"then _sB();return true elseif _boa=="noclip"then _bgK("noclip",_bnT(_bob,_iO));return true elseif _boa=="unlimitedjump"or _boa=="uj"then _bgK("ujump",_bnT(_bob,_bam));return true elseif _boa=="blink"then _bgK("blink",_bnT(_bob,_bak));return true elseif _boa=="longhand"or _boa=="lh"then
                                            local _boc=tonumber(_bob)if _boc then config.longhandRange=_boc;saveConfig();_bgK("longhand",true)else _bgK("longhand",_bnT(_bob,_bal))end
                                            return true elseif _boa=="afk"then _bgK("antiafk",_bnT(_bob,_ban));return true elseif _boa=="autorejoin"or _boa=="arj"then _bgK("autorejoin",_bnT(_bob,config.reconnectOn));return true elseif _boa=="af"or _boa=="autofarm"then _bgK("autofarm",_bnT(_bob,modAutoPlace.on));return true elseif _boa=="ac"or _boa=="autoclear"then _bgK("autoclear",_bnT(_bob,modBreak.on));return true elseif _boa=="ah"or _boa=="autoharvest"then _bgK("autoharvest",_bnT(_bob,modTrees.on));return true elseif _boa=="adf"or _boa=="autodf"then _bgK("autodf",_bnT(_bob,modDirt.on));return true elseif _boa=="as"or _boa=="autosplice"then _bgK("autosplice",_bnT(_bob,_te.on));return true elseif _boa=="pabrik"or _boa=="factory"then _bgK("pabrik",_bnT(_bob,modFarm.on));return true elseif _boa=="guard"or _boa=="penjaga"then _bgK("guard",_bnT(_bob,modIntrusion.on));return true elseif _boa=="chat"or _boa=="autochat"then _bgK("autochat",_bnT(_bob,_tk.on));return true elseif _boa=="ctp"or _boa=="clicktp"then _bgK("clicktp",_bnT(_bob,modClick.clickOn));return true elseif _boa=="god"then _bgK("god",_bnT(_bob,_bap));return true elseif _boa=="lite"then _bgK("lite",_bnT(_bob,config.liteMode));return true elseif _boa=="gs"or _boa=="growscan"then _baG();return true elseif _boa=="blockid"or _boa=="bid"then
                                                                                                        local _bod=_baI(_bob,5)if#_bod==0 then notify("No blocks matching: "..tostring(_bob))else
                                                                                                            local _boe={}for k_bof,v_bog in ipairs(_bod)do table.insert(_boe,v_bog.name.." ["..v_bog.id.."]")end notify(table.concat(_boe,", "),"Block ID Search")end
                                                                                                        return true
                                                                                                    end
                                                                                                return false
                                                                                            end
                                                                                        local _boh={}local function _boi(_boj)if _boj:IsA("TextBox")and not _boh[_boj]then _boh[_boj]=true trackConn(_boj.FocusLost:Connect(function(_bok)if _bok and isAlive()then _bnW(_boj.Text)end end))end
                                                                                        end
                                                                                    for k_bol,v_bom in ipairs(obj_PlayerGui:GetDescendants())do _boi(v_bom)end trackConn(obj_PlayerGui.DescendantAdded:Connect(_boi))trackConn(localPlayer.Chatted:Connect(_bnW))end)()end end)()end session.Cleanup=function()session.Alive=false _cO()inputState.active=false
                                                                        if modAutoPlace.on then pcall(_vM)end
                                                                        if modBreak.on then pcall(modBreak.Stop)end
                                                                        if modTrees.on then pcall(modTrees.Stop)end
                                                                        if modDirt.on then pcall(modDirt.Stop)end
                                                                        if _te.on then pcall(_te.Stop)end
                                                                        if modFarm.on then pcall(modFarm.Stop)end
                                                                        if modGems and modGems.Stop then pcall(modGems.Stop)end
                                                                        if _UI and _UI.Stop then pcall(_UI.Stop)end
                                                                        if modClick.clickOn then pcall(modClick.StopClick)end
                                                                        if _bak then pcall(_bas)end
                                                                        if _bal then pcall(_bau)end
                                                                        if _iO then pcall(_ja)end
                                                                        if _bam then pcall(_baw)end
                                                                        if _bap then pcall(_baC)end
                                                                        if _ban then pcall(_bay)end
                                                                        if config.liteMode then pcall(_Xw.Set,false)end
                                                                        if session.RestoreWatermark then pcall(session.RestoreWatermark)end
                                                                        if session.RestoreFastWrench then pcall(session.RestoreFastWrench)end
                                                                        if session.RestoreFastBackpack then pcall(session.RestoreFastBackpack)end
                                                                        for k_bon,v_boo in ipairs(session.Connections)do pcall(function()_boo:Disconnect()end)end table.clear(session.Connections)if _sW then pcall(function()_sW:Destroy()end)end
                                                                        if _iQ then pcall(function()_iQ:Destroy()end)end
                                                                        if _bii and _bii.Destroy then pcall(function()_bii:Destroy()end)end
                                                                        if session.Rotation and session.Rotation.Stop then pcall(session.Rotation.Stop)end
                                                                    end task.spawn(function()genv.__ANCHHub_LoadingAt=nil configDirty=false notify("GSZ HUB V1.4 Loaded! All features are ready.","GSZ HUB",4,true)_bax()modules.Scan(true)sessionStats.Reset()if config.liteMode then _Xw.Set(true)end trackConn(localPlayer.OnTeleport:Connect(function()configDirty=false saveConfig()pcall(_sw)end))if config.autoRestore then
                                                                        for k_bop,v_boq in pairs(_bgJ)do
                                                                            if config.session[k_bop]and not v_boq.noSession and not v_boq.get()then pcall(v_boq.set,true)end
                                                                        end
                                                                    if _sV then _sV()end
                                                                end task.spawn(_tj.CheckStartup)task.spawn(modFarm.CheckStartup)task.spawn(modGems.CheckStartup)task.spawn(session.Rotation.CheckStartup)local _bor=_hy()while isAlive()do task.wait(1.5)local _bos=_hy()if _bos~=""and _bos~=_bor then _bor=_bos modules.Scan(true)end
                                                            end end)