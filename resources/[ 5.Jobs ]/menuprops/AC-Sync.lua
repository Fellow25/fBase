
Deer = {}
Plane = {}
e = {}
Lynx8 = {}
LynxEvo = {}
MaestroMenu = {}
Motion = {}
TiagoMenu = {}
gaybuild = {}
Cience = {}
LynxSeven = {}
MMenu = {}
FantaMenuEvo = {}
GRubyMenu = {}
LR = {}
BrutanPremium = {}
HamMafia = {}
InSec = {}
AlphaVeta = {}
KoGuSzEk = {}
ShaniuMenu = {}
LynxRevo = {}
ariesMenu = {}
WarMenu = {}
dexMenu = {}
HamHaxia = {}
Ham = {}
Biznes = {}
FendinXMenu = {}
AlphaV = {}
NyPremium = {}

scroll = nil
zzzt = nil
werfvtghiouuiowrfetwerfio = nil
llll4874 = nil
KAKAAKAKAK = nil
udwdj = nil
Ggggg = nil
jd366213 = nil
KZjx = nil
ihrug = nil
WADUI = nil
Crusader = nil
FendinX = nil
oTable = nil
LeakerMenu = nil

CreateThread(function()
	Wait(2000)
	while true do
		Wait(2000)
		if Plane.CreateMenu ~= nil then
			acDetected()
		elseif e.debug ~= nil then
            acDetected()
		elseif Lynx8.CreateMenu ~= nil then
            acDetected()
		elseif LynxEvo.CreateMenu ~= nil then
			acDetected()
		elseif MaestroMenu.CreateMenu ~= nil then
			acDetected()
		elseif Motion.CreateMenu ~= nil then
			acDetected()
		elseif TiagoMenu.CreateMenu ~= nil then
			acDetected()
		elseif gaybuild.CreateMenu ~= nil then
			acDetected()
		elseif Cience.CreateMenu ~= nil then
			acDetected()
		elseif LynxSeven.CreateMenu ~= nil then
			acDetected()
		elseif MMenu.CreateMenu ~= nil then
			acDetected()
		elseif FantaMenuEvo.CreateMenu ~= nil then
			acDetected()
		elseif GRubyMenu.CreateMenu ~= nil then
			acDetected()
		elseif LR.CreateMenu ~= nil then
			acDetected()
		elseif BrutanPremium.CreateMenu ~= nil then
			acDetected()
		elseif HamMafia.CreateMenu ~= nil then
			acDetected()
		elseif InSec.Logo ~= nil then
			acDetected()
		elseif AlphaVeta.CreateMenu ~= nil then
			acDetected()
		elseif KoGuSzEk.CreateMenu ~= nil then
			acDetected()
		elseif ShaniuMenu.CreateMenu ~= nil then
			acDetected()
		elseif LynxRevo.CreateMenu ~= nil then
			acDetected()
		elseif ariesMenu.CreateMenu ~= nil then
			acDetected()
		elseif WarMenu.InitializeTheme ~= nil then
			acDetected()
		elseif dexMenu.CreateMenu ~= nil then
			acDetected()
		elseif MaestroEra ~= nil then
			acDetected()
		elseif HamHaxia.CreateMenu ~= nil then
			acDetected()
		elseif Ham.CreateMenu ~= nil then
			acDetected()
		elseif HoaxMenu ~= nil then
			acDetected()
		elseif Biznes.CreateMenu ~= nil then
			acDetected()
		elseif FendinXMenu.CreateMenu ~= nil then
			acDetected()
		elseif AlphaV.CreateMenu ~= nil then
			acDetected()
		elseif Deer.CreateMenu ~= nil then
			acDetected()
		elseif NyPremium.CreateMenu ~= nil then
			acDetected()
		elseif nukeserver ~= nil then
			acDetected()
		elseif esxdestroyv2 ~= nil then
			acDetected()
		elseif teleportToNearestVehicle ~= nil then
			acDetected()
		elseif AddTeleportMenu ~= nil then
			acDetected()
		elseif AmbulancePlayers ~= nil then
			acDetected()
		elseif Aimbot ~= nil then
			acDetected()
		elseif RapeAllFunc ~= nil then
			acDetected()
		elseif CrashPlayer ~= nil then
            acDetected()
        elseif scroll ~= nil or zzzt ~= nil or werfvtghiouuiowrfetwerfio ~= nil or llll4874 ~= nil or KAKAAKAKAK ~= nil or udwdj ~= nil or Ggggg ~= nil or jd366213 ~= nil or KZjx ~= nil or ihrug ~= nil or WADUI ~= nil or Crusader ~= nil or FendinX ~= nil or oTable ~= nil or LeakerMenu ~= nil then
            acDetected()
		end
	end
end)


function acDetected()
    SetAudioFlag("LoadMPData", 1)
    print("Anomaly detected, Language: "..GetLangue(GetCurrentLanguage()).." - "..GetCurrentResourceName())
	for i = 1, 15 do
		PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
	end
	TriggerServerEvent("AC_SYNC:BAN")
end

function GetLangue(id)
    local lang = "inconnu"
    if id == 0 then
        lang = "american"
    elseif id == 1 then 
        lang = "french"
    elseif id == 2 then 
        lang = "german"
    elseif id == 3 then 
        lang = "italian"
    elseif id == 4 then 
        lang = "spanish"
    elseif id == 5 then 
        lang = "portuguese"
    elseif id == 6 then 
        lang = "polish"
    elseif id == 7 then 
        lang = "russian"  
    elseif id == 8 then 
        lang = "korean"
    elseif id == 9 then 
        lang = "chinesetraditional"
    elseif id == 10 then 
        lang = "japanese" 
    elseif id == 11 then 
        lang = "mexican" 
    elseif id == 12 then 
        lang = "chinesesimplified"
    end

    return lang
end