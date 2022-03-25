local Keys = {
	["ESC"] = 322, 		["F1"] = 288, 		["F2"] = 289, 		["F3"] = 170, 		["F5"] = 166, 
	["F6"] = 167, 		["F7"] = 168, 		["F8"] = 169, 		["F9"] = 56, 		["F10"] = 57,
	["~"] = 243, 		["1"] = 157, 		["2"] = 158, 		["3"] = 160, 		["4"] = 164, 
	["5"] = 165,		["6"] = 159, 		["7"] = 161, 		["8"] = 162, 		["9"] = 163, 
	["-"] = 84, 		["="] = 83, 		["TAB"] = 37,		["Q"] = 44, 		["W"] = 32, 
	["E"] = 38, 		["R"] = 45, 		["T"] = 245, 		["Y"] = 246, 		["U"] = 303, 
	["P"] = 199, 		["["] = 39, 		["]"] = 40, 		["ENTER"] = 18, 	["CAPS"] = 137, 
	["A"] = 34, 		["S"] = 8, 			["D"] = 9, 			["F"] = 23, 		["G"] = 47, 
	["H"] = 74, 		["K"] = 311, 		["L"] = 182, 		["LEFTSHIFT"] = 21, ["Z"] = 20, 
	["X"] = 73, 		["C"] = 26, 		["V"] = 0, 			["B"] = 29,			["N"] = 249, 
	["M"] = 244, 		[","] = 82, 		["."] = 81, 		["LEFTCTRL"] = 36, 	["LEFTALT"] = 19,
	["SPACE"] = 22,		["RIGHTCTRL"] = 70, ["HOME"] = 213, 	["PAGEUP"] = 10, 	["PAGEDOWN"] = 11,
	["DELETE"] = 178, 	["LEFT"] = 174,		["RIGHT"] = 175, 	["TOP"] = 27, 		["DOWN"] = 173, 
	["NENTER"] = 201, 	["N4"] = 108, 		["N5"] = 60, 		["N6"] = 107,		["BACKSPACE"] = 177,
	["N+"] = 96, 		["N-"] = 97, 		["N7"] = 117, 		["N8"] = 61, 		["N9"] = 118
}

ESX = nil

CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Wait(0)
    end
end)

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function disableControl()
    DisableControlAction(2, 1, true)
    DisableControlAction(2, 1, true) -- Disable pan
    DisableControlAction(2, 2, true) -- Disable tilt 
    DisableControlAction(0, 59, true)
    SetPedCanPlayGestureAnims(PlayerPedId(), false)
    DisableControlAction(2, 24, true) -- Attack
    DisableControlAction(2, 257, true) -- Attack 2
    DisableControlAction(2, 25, true) -- Aim
    DisableControlAction(2, 263, true) -- Melee Attack 1
    DisableControlAction(0, 24, true) -- Attack
    DisableControlAction(0, 257, true) -- Attack 2
    DisableControlAction(0, 25, true) -- Aim
    DisableControlAction(0, 263, true) -- Melee Attack 1
    DisableControlAction(27, 23, true) -- Also 'enter'?
    DisableControlAction(0, 23, true) -- Also 'enter'?
    DisableControlAction(0, 288, true) -- Disable phone
    DisableControlAction(0,289, true) -- Inventory
    DisableControlAction(0, 289,  true) -- Inventory block
    DisableControlAction(0, 73,  true) -- Handups
    DisableControlAction(0, 105,  true) -- Handups
    DisableControlAction(0, 29,  true) -- Point
    DisableControlAction(0, Keys['Q'], true)
    DisableControlAction(0, Keys['Z'], true)
    DisableControlAction(0, Keys['S'], true)
    DisableControlAction(0, Keys['D'], true) 
    DisablePlayerFiring(PlayerPedId(), true)
    DisableControlAction(0, 82,  true) -- Animations
    DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
    DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
    DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
    DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
    DisableControlAction(0, 257, true) -- INPUT_ATTACK2
    DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
    DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
    DisableControlAction(0, 24, true) -- INPUT_ATTACK
    DisableControlAction(0, 25, true) -- INPUT_AIM
    DisableControlAction(0, 75, true)  -- Disable exit vehicle
    DisableControlAction(27, 75, true) -- Disable exit vehicle
    DisableControlAction(0, 65, true) -- Disable f9
    DisableControlAction(0, 167, true) -- Disable f6
    DisableControlAction(2, 59, true) -- Disable steering in vehicle
    DisableControlAction(0, 47, true)  -- Disable weapon
    DisableControlAction(0, 47, true)  -- Disable weapon
    DisableControlAction(0, 264, true) -- Disable melee
    DisableControlAction(0, 257, true) -- Disable melee
    DisableControlAction(0, 140, true) -- Disable melee
    DisableControlAction(0, 141, true) -- Disable melee
    DisableControlAction(0, 142, true) -- Disable melee
    DisableControlAction(0, 143, true) -- Disable melee
end

RegisterNetEvent('shop:SyncAccess')
AddEventHandler('shop:SyncAccess', function()
    ESX.TriggerServerCallback("dqp:getMask", function(result)
        MaskTab = result
    end)
end)

function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,1,-1)
end

function CreateMain()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z)
    SetCamFov(cam, 50.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateShoes()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.0, coords.y, coords.z)
    SetCamFov(cam, 50.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-1.0)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateFutal()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.55)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.55)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateArms()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z-0.15)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z-0.15)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateTop()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z+0.60)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateFace()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-2.0, coords.y-1.0, coords.z+0.5)
    SetCamFov(cam, 30.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z+0.5)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateBack()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x+1.75, coords.y, coords.z+0.60)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function CreateMontre()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.50, coords.y-1.5, coords.z+0.60)
    SetCamFov(cam, 20.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function Tourner()
    local back = GetEntityHeading(PlayerPedId())
    SetEntityHeading(PlayerPedId(), back+180)
end

function Left()
    local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x, coords.y-1.00, coords.z)
    SetCamFov(cam, 40.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end



function Angle()
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

function gettxt2(txtt)
    AddTextEntry('FMMC_MPM_NA', "Texte")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", txtt, "", "", "", 100)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
		local result = GetOnscreenKeyboardResult()
		if tonumber(result) ~= nil then
			if tonumber(result) >= 1 then

				return tonumber(result)
			else
				
			end
		else
		return result
		end
    end

end


RMenu.Add('aces', 'main', RageUI.CreateMenu("Magasin", "~b~Actions disponibles"))
RMenu.Add('aces', 'glasses', RageUI.CreateSubMenu(RMenu:Get('aces', 'main'), "Lunettes", "~b~Actions disponibles"))
RMenu.Add('aces', 'hats', RageUI.CreateSubMenu(RMenu:Get('aces', 'main'), "Chapeaux", "~b~Actions disponibles"))
RMenu.Add('aces', 'oreille', RageUI.CreateSubMenu(RMenu:Get('aces', 'main'), "Boucles d'oreilles", "~b~Actions disponibles"))
RMenu.Add('aces', 'masks', RageUI.CreateSubMenu(RMenu:Get('aces', 'main'), "Masques", "~b~Actions disponibles"))
RMenu.Add('aces', 'access', RageUI.CreateMenu("Mes Accessoires", "~b~Actions disponibles"))
RMenu:Get('aces', 'main').Closed = function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
        --		curSex = skin.sex
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
        end


local listClotheshop = {
	{x = -1336.73,    y = -1277.44, z = 4.88}
}

local watodo = {
	indexwatodo = 1,
	listwatodo = {'Equiper', 'Renommer', 'Supprimer'},
}

local watodoo = {
	indexwatodoo = 1,
	listwatodoo = {'Equiper', 'Renommer', 'Donner', 'Jeter'},
}


local watoda = {
	indexwatoda = 1,
	listwatoda = {'Masque', 'Chapeau', 'Lunettes', 'Boucles d\'oreilles'},
}

MaskTab = {}
local TenueTable = {}
CreateThread(function()
    while true do
      Wait(0)
      for k in pairs(listClotheshop) do

        local plyCoords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, listClotheshop[k].x, listClotheshop[k].y, listClotheshop[k].z)

        if dist <= 1.5 then
            RageUI.Text({
                message = "Appuyez sur ~b~[E]~s~ pour acheter des accessoires",
                time_display = 1
            })
             --   DisplayHelpTextThisFrame("HELP", false)
            attente = 1
            if IsControlJustPressed(1, 51) then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, _)
                    --		curSex = skin.sex
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                CreateMain()
                DrawAnim()
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.Visible(RMenu:Get('aces', 'main'), not RageUI.Visible(RMenu:Get('aces', 'main')))
           --    ESX.TriggerServerCallback('GetTenues', function(skin)
           --         TenueTable = skin
             --   end)
            end
        end
    end
        RageUI.IsVisible(RMenu:Get('aces', 'main'), true, true, true, function()
            Angle()
            disableControl()
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            if IsControlJustPressed(0, 191) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)     
            end
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(PlayerPedId(), false)
            end
            RageUI.Button("Masques", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('aces', 'masks'))
            RageUI.Button("Chapeaux", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('aces', 'hats'))
            RageUI.Button("Lunettes", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('aces', 'glasses'))
            RageUI.Button("Boucles d'oreilles", "", { RightLabel = "→" },true, function()
            end, RMenu:Get('aces', 'oreille'))
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('aces', 'masks'), true, true, true, function()
            CreateFace()
            Angle()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
            end
            if IsControlJustPressed(0, 22) then
                Tourner()
            end
            playerPed = PlayerPedId()
maskName = {"Pas de masque","Masque Cochon","Masque Crane","Masque Pogo","Masque hockey 1","Masque Singe","Masque Crane Mexicain","Masque Ogre","Masque Père Noël","Masque Renne","Masque Bonhomme Neige","Masque Soirée","Masque Théâtre","Masque Cupidon","Masque Hockey 2","Masque 3","Masque Crane Métal","Masque Chat","Masque Renard","Masque Hibou","Masque Raton Laveur","Masque Ours","Masque Buffle","Masque Taureau","Masque Aigle","Masque Dindon","Masque Loup","Masque Aviateur","Masque Combat","Masque Mort","Masque Hockey 4","Masque Pingouin","Masque Chaussette Noël","Masque Biscuit","Masque Vieux Noël","Masque Cagoule","Masque Gaz","Masque Cagoule Retournée","Masque Gaz Simple","Masque Zombie","Masque Momie","Masque Dent Pointue","Masque Frankenstein","Masque Manga H","Masque Manga F","Masque Manga H Padré","Masque Toxique","Masque Ruban","Masque Scotch","Masque Papier","Masque Simple","Masque Foulard","Masque Cagoule Braqueur","Masque Ninja 1","Masque Touareg","Masque Ninja 2","Masque Ninja 3","Masque Cagoule Rayé 1","Masque Cagoule Rayé 2","Masque Big Foot","Masque Citrouille","Masque vieux Zombie","Masque Acide","Masque Muscle","Masque Zombie Langue","Masque Loup Garou","Masque Mouche","Masque Gollum","Masque Démons","Masque Cousu","Masque Vampire Tourbi","Masque Sorcière","Masque Démons Moustache","Masque Chauve","Masque Biscuit 2","Masque Biscuit 3","Masque Noël Cigare","Masque Sapin Noël","Masque Fraise Pourri","Masque Big Foot 2","Masque Big Foot 3","Masque Big Foot 4","Masque Big Foot 5","Masque Big Foot 6","Masque Yéti","Masque Poulet","Masque Mère Noël 1","Masque Clochard Noël","Masque Mère Noël 2","Masque Combat 2","Masque Training 1","Masque Rino Métal","Masque Alien","Masque T-Rex","Masque Démons 2","Masque Clown","Masque Gorille","Masque Cheval","Masque Licorne","Masque Crane Motif","Masque Chien","Masque Training 2","Masque Dessin Fluo","Masque Soldat","Masque Ensemble Cagoule","Masque Combat Bouffon","Masque Combat Crane","Masque Training Combat","Masque Combat Mort","Masque Aviateur 2","Masque Combat Teubé","Masque Foulard 2","Masque Cagoule Teubé 2","Masque Ninja Motif","Masque Keffieh Ouvert","Masque Keffieh Fermé","Masque Keffieh Nez","Masque Cagoule Rayé 3","Masque Ninja 4","Masque Cagoule Retournée 2","Masque Chauve","Masque Oreillette","Masque Cagoule Plongée","Masque Collant","Masque Hockey 5","Masque Combat Connecté","Masque Hockey Cagoule","Masque Hockey Biscuit","Masque Simple 2","Masque Combat Gaz","Masque Combat Flamme","Masque Bélier","Masque Vision Nocturne", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque", "Masque"}            --maskName = {}
            for i=0,GetNumberOfPedDrawableVariations(playerPed, 1)-1,1 do 
                amount = {}
                for c = 1, GetNumberOfPedTextureVariations(playerPed, 1, i), 1 do
        
                    amount[c] = c 
                    
                end
                if maskName[i+1] == nil then
                    maskName[i+1] = GetLabelText(MaskConfig.Name[tostring(i)]["0"]["GXT"])
                end
                RageUI.Button(maskName[i+1], "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        mask1 = i
                        mask2 = 0
                        SetPedComponentVariation(PlayerPedId(), 1, mask1,mask2, 2)
                    end
                    if (Selected) then
                        TriggerServerEvent("dqp:SetNewMasque", mask1, mask2,"Masque", maskName[i+1])
                    end
                end)
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('aces', 'glasses'), true, true, true, function()
            CreateFace()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            lunetteItem = {
                "Aucune",
                "Lunette sport",
                "Lunette de soleil",
                "Lunette old school",
                "Lunette moyen-age",
                "Lunette de soleil",
                "Aucune",
                "Lunette de soleil",
                "Lunette",
                "Lunette sport",
                "Lunette mafieux",
                "Aucune",
                "Lunette luxe",
                "Lunette de baron",
                "Aucune",
                "Lunette sport",
                "Lunette sport",
                "Lunette teinté",
                "Lunette",
                "Fausse lunette",
                "Lunette moderne",
                "Lunette america",
                "Lunette america",
                "Lunette sport",
                
                "Lunette aviateur",
                "Lunette aviateur"
            }
            for i = 0,25,1 do
                --
                local amount = {}
                local playerPed = PlayerPedId()
                local ind = i+1
                for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 1, i), 1 do
        
                    amount[c] = c 
                    
                end
                if lunetteItem[i] == nil then
                    lunetteItem[i] = "Lunette #"..i
                end
                RageUI.Button(lunetteItem[ind], "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        glasses1 = i
                        glasses2 = 0
                        SetPedPropIndex(playerPed, 1, glasses1-1, glasses2, 2)
                    end
                    if (Selected) then
                        TriggerServerEvent("dqp:SetNewMasque", glasses1, glasses2,"Lunette", lunetteItem[i])
                    end
                end)
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('aces', 'chain'), true, true, true, function()
            CreateTop()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            local playerPed = PlayerPedId()
            for i = -1,GetNumberOfPedDrawableVariations(playerPed,7),1 do
                --
                local amount = {}
                local ind = i+2
                RageUI.Button("Chaine #"..ind, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        chain1 = i
                        chain2 = 0
                        SetPedComponentVariation(playerPed,7, chain1, chain2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
                            clothesSkin = {
            
                               ['chain_1'] = chain1,
                               ['chain_2'] = chain2,
                               
            
            
                           }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           
                       
                       
                   end)
            
                   TriggerEvent('skinchanger:getSkin', function(skin)
            
                       
                       TriggerServerEvent('esx_skin:save', skin)
                       
                   
                   
                   end)
                    end
                end)
                
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('aces', 'oreille'), true, true, true, function()
            CreateFace()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            boucleItem = {
                "Oreillete",
                "Oreillete",
                "Oreillete",
                "Aucun",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
                "Boucle d'oreille",
        
        
        
            }
            local playerPed = PlayerPedId()
            for i = 0,36,1 do
                --
                local amount = {}
                local ind = i+1
                for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 2, i), 1 do
        
                    amount[c] = c 
                    
                end
                if boucleItem[i] == nil then
                    boucleItem[i] = "Boucle #"..i
                end
                RageUI.Button(boucleItem[ind], "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        boucl1 = i
                        boucl2 = 0
                        SetPedPropIndex(playerPed, 2, boucl1, boucl2, 2)
                    end
                    if (Selected) then
                        TriggerServerEvent("dqp:SetNewMasque",boucl1,boucl2,"Boucle",boucleItem[i],2)
                    end
                end)
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('aces', 'clock'), true, true, true, function()
            CreateMontre()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            for i = -1,19,1 do
                --
                local amount = {}
                local playerPed = PlayerPedId()
                local ind = i+2
                for c = 1, GetNumberOfPedPropTextureVariations(playerPed, 6, i+1), 1 do
        
                    amount[c] = c 
                    
                end

                RageUI.Button("Montre #"..ind, "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        clock1 = i
                        clock2 = 0
                        SetPedPropIndex(playerPed, 6, clock1, clock2, 2)
                    end
                    if (Selected) then
                        TriggerEvent('skinchanger:getSkin', function(skin)
	
				
	
                            clothesSkin = {
            
                               ['watches_1'] = clock1,
                               ['watches_2'] = clock2,
                               
            
            
                           }
                           TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                           
                       
                       
                   end)
            
                   TriggerEvent('skinchanger:getSkin', function(skin)
            
                       
                       TriggerServerEvent('esx_skin:save', skin)
                       
                   
                   
                   end)
                    end
                end)
                
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('aces', 'bag'), true, true, true, function()
            CreateBack()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            RageUI.Button("Aucun", "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                if (Active) then
                    SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 2)
                end
                if (Selected) then
                    TriggerEvent('skinchanger:getSkin', function(skin)
            
                        
            
                        clothesSkin = {
                           ['bags_1'] = 0, ['chain_1'] = 0,
        
        
                        }
                       TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                       
                   
                   
               end)
        
               TriggerEvent('skinchanger:getSkin', function(skin)
        
                   
                   TriggerServerEvent('esx_skin:save', skin)
                   
               
               
               end)
                end
            end)
            RageUI.Button("Sac à dos", "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                if (Active) then
                    SetPedComponentVariation(PlayerPedId(),7, 3, 0, 2)
                end
                if (Selected) then
                    TriggerEvent('skinchanger:getSkin', function(skin)
            
                        
            
                        clothesSkin = {
                           ['chain_1'] = 2, ['chain_2'] = 0,
        
        
                       }
        
                       TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                       
                   
                   
               end)
        
               TriggerEvent('skinchanger:getSkin', function(skin)
        
                   
                   TriggerServerEvent('esx_skin:save', skin)
                   
               
               
               end)
                end
            end)
            RageUI.Button("Sac Tactique", "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                if (Active) then
                    SetPedComponentVariation(PlayerPedId(), 5, 44, 0, 2)
                end
                if (Selected) then
                    TriggerEvent('skinchanger:getSkin', function(skin)
            
                        
            
                        clothesSkin = {
                           ['bags_1'] = 44, ['torso_2'] = 0,
        
        
                        }
                       TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                       
                   
                   
               end)
        
               TriggerEvent('skinchanger:getSkin', function(skin)
        
                   
                   TriggerServerEvent('esx_skin:save', skin)
                   
               
               
               end)
                end
            end)
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('aces', 'hats'), true, true, true, function()
            CreateFace()
            if IsControlJustPressed(0, 194) then
                RenderScriptCams(0, 1, 1000, 1, 1)
                DestroyAllCams(true)
                CreateMain()
            end
            if IsControlJustPressed(0, 22) then
                Tourner()       
            end
            Angle()
            local chapeauItem = {
                "Casque",
                "Bonnet d'âne",
                "Bonnet",
                "Bob",
                "Casquette LS",
                "Bonnet",
                "Casquette miliaire",
                "Beret",
                "",
                "Casquette à l'envers",
                "Casquette",
                "",
                "Chapeau",
                "Chapeau Cowboy",
                "Bandana",
                "Casque de musique",
                "Casque",
                "Casque",
                "Casque",
                "Casque de pilote",
                "Bob de pêcheur",
                "Chapeau chill",
                "Chapeau de noël",
                "Chapeau de lutin",
                "Corne de noël",
                "Chapeau",
                "Chapeau melon",
                "Chapeau haut",
                "Bonnet",
                "Chapeau",
                "Chapeau",
                "Chapeau USA",
                "Chapeau USA",
                "Chapeau USA",
                "Bonnet USA",
                "USA",
                "Entenne USA",
                "Casque à bière",
                "Casque aviation",
                "Casque d'intervention",
                "Chapeau noël",
                "Chapeau noël",
                "Chapeau noël",
                "Chapeau noël",
                "Casquette",
                "Casquette à l'envers",
                "Casquette LSPD",
                "Casque d'aviateur",
                "Casque",
                "Casque",
                "Casque",
                "Casque",
                "Casque",
                "Casque",
                "Casque",
                "Casquette",
                "Casquette",
                "Casquette",
                "Chapeau Alien",
                "Casquette",
                "Casque",
                "Casquette",
                "Chapeau",
                "Casque",
                "Chapeau",
                "Casquette"
                
            }
            for i = -1,GetNumberOfPedDrawableVariations(PlayerPedId(), 0),1 do
                --
                local amount = {}
                local ind = i+2
                for c = 1, GetNumberOfPedPropTextureVariations(PlayerPedId(), 0, i+1), 1 do
        
                    amount[c] = c 
                    
                end
                if chapeauItem[i] == nil then
                    chapeauItem[i] = i
                end
                RageUI.Button(chapeauItem[ind], "Cette tenue est disponible dans notre magasin.", { RightLabel = "~g~25$" }, true, function(Hovered, Active, Selected)
                    if (Active) then
                        hats1 = i
                        hats2 = 0
                        SetPedPropIndex(PlayerPedId(), 0, hats1-1, 0, 2)
                    end
                    if (Selected) then
                        TriggerServerEvent("dqp:SetNewMasque", hats1-1,hats2,"Chapeau",chapeauItem[i],0)
                    end
                end)
        
            end
        end, function()
        end, 1)
        RageUI.IsVisible(RMenu:Get('aces', 'access'), true, true, true, function()
            RageUI.List("Enlever", watoda.listwatoda, watoda.indexwatoda, nil, { RightBadge = RageUI.BadgeStyle.Clothes }, true, function(Hovered, Active, Selected, Index)
                if (Selected) then
                    if Index == 1 then
                        local dict = 'missfbi4'
                        local myPed = PlayerPedId()
                        RequestAnimDict(dict)
                        while not HasAnimDictLoaded(dict) do
                            Wait(0)
                        end
                        local animation = ''
                        local flags = 0 -- only play the animation on the upper body
                        animation = 'takeoff_mask'
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Wait(1000)
                        SetEntityCollision(PlayerPedId(), true, true)
                        playerPed = PlayerPedId()
                        Wait(200)
                        SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 2)
                        ClearPedTasks(playerPed)
                    elseif Index == 2 then
                        local dict = 'missheistdockssetup1hardhat@'
                        local myPed = PlayerPedId()
                        RequestAnimDict(dict)

                        while not HasAnimDictLoaded(dict) do
                            Wait(0)
                        end

                        local animation = ''
                        local flags = 0 -- only play the animation on the upper body
                        animation = 'put_on_hat'
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Wait(1000)
                        SetEntityCollision(PlayerPedId(), true, true)
                        playerPed = PlayerPedId()
                        SetPedPropIndex(playerPed, 0, k.mask_1, k.mask_2, 2)
                        Wait(200)
                        ClearPedProp(PlayerPedId(), 0)
                        ClearPedTasks(playerPed)
                    elseif Index == 3 then
                        local dict = 'clothingspecs'
                        local myPed = PlayerPedId()
                        RequestAnimDict(dict)

                        while not HasAnimDictLoaded(dict) do
                            Wait(0)
                        end

                        local animation = ''
                        local flags = 0 -- only play the animation on the upper body
                        animation = 'try_glasses_positive_a'
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Wait(1000)
                        SetEntityCollision(PlayerPedId(), true, true)
                        playerPed = PlayerPedId()
                        Wait(200)
                        ClearPedProp(PlayerPedId(), 1)
                        ClearPedTasks(playerPed)
                    elseif Index == 4 then
                        local dict = 'mini@ears_defenders'
                        local myPed = PlayerPedId()
                        RequestAnimDict(dict)

                        while not HasAnimDictLoaded(dict) do
                            Wait(0)
                        end

                        local animation = ''
                        local flags = 0 -- only play the animation on the upper body
                        animation = 'takeoff_earsdefenders_idle'
                        TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                        Wait(1000)
                        SetEntityCollision(PlayerPedId(), true, true)
                        playerPed = PlayerPedId()
                        Wait(200)
                        ClearPedProp(PlayerPedId(), 2)
                        ClearPedTasks(playerPed)
                    end
                end
                watoda.indexwatoda = Index
            end)
            result = MaskTab
            if #result == 0 then
                RageUI.Button("Vide", "Aucun item sauvegarder", { RightLabel = "→" }, true, function(Hovered, Active, Selected)
                    if (Selected) then
                    end
                end)
            end
            for i = 1, #result, 1 do
                RageUI.List(result[i].label, watodoo.listwatodoo, watodoo.indexwatodoo, nil, { RightBadge = RageUI.BadgeStyle.Clothes }, true, function(Hovered, Active, Selected, Index)
                    if (Selected) then
                        if Index == 1 then
                            k = json.decode(result[i].mask)
                            ped = PlayerPedId()
                            uno = k.mask_1
                            dos = k.mask_2
                            typos = result[i].type
                            --(typos)
                            if typos == "Masque" then
    
                                if ped then
                                    local dict = 'missfbi4'
                                    local myPed = PlayerPedId()
                                    RequestAnimDict(dict)
    
                                    while not HasAnimDictLoaded(dict) do
                                        Wait(0)
                                    end
    
                                    local animation = ''
                                    local flags = 0 -- only play the animation on the upper body
                                    animation = 'takeoff_mask'
                                    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                    Wait(1000)
                                    SetEntityCollision(PlayerPedId(), true, true)
                                    playerPed = PlayerPedId()
                                    SetPedComponentVariation(playerPed, 1, k.mask_1, k.mask_2, 2)
                                    Wait(200)
                                    ClearPedTasks(playerPed)
                                end
                            elseif typos == "Lunette" then
    
                                if ped then
                                    local dict = 'clothingspecs'
                                    local myPed = PlayerPedId()
                                    RequestAnimDict(dict)
    
                                    while not HasAnimDictLoaded(dict) do
                                        Wait(0)
                                    end
    
                                    local animation = ''
                                    local flags = 0 -- only play the animation on the upper body
                                    animation = 'try_glasses_positive_a'
                                    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                    Wait(1000)
                                    SetEntityCollision(PlayerPedId(), true, true)
                                    playerPed = PlayerPedId()
                                    SetPedPropIndex(playerPed, 1, k.mask_1, k.mask_2, 2)
                                    Wait(200)
                                    ClearPedTasks(playerPed)
                                end
    
                            elseif typos == "Chapeau" then
    
                                if ped then
                                    local dict = 'missheistdockssetup1hardhat@'
                                    local myPed = PlayerPedId()
                                    RequestAnimDict(dict)
    
                                    while not HasAnimDictLoaded(dict) do
                                        Wait(0)
                                    end
    
                                    local animation = ''
                                    local flags = 0 -- only play the animation on the upper body
                                    animation = 'put_on_hat'
                                    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                    Wait(1000)
                                    SetEntityCollision(PlayerPedId(), true, true)
                                    playerPed = PlayerPedId()
                                    SetPedPropIndex(playerPed, 0, k.mask_1, k.mask_2, 2)
                                    Wait(200)
                                    ClearPedTasks(playerPed)
                                end
                            elseif typos == "Boucle" then
    
                                if ped then
                                    local dict = 'mini@ears_defenders'
                                    local myPed = PlayerPedId()
                                    RequestAnimDict(dict)
    
                                    while not HasAnimDictLoaded(dict) do
                                        Wait(0)
                                    end
    
                                    local animation = ''
                                    local flags = 0 -- only play the animation on the upper body
                                    animation = 'takeoff_earsdefenders_idle'
                                    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
                                    Wait(1000)
                                    SetEntityCollision(PlayerPedId(), true, true)
                                    playerPed = PlayerPedId()
                                    SetPedPropIndex(playerPed, 2, k.mask_1, k.mask_2, 2)
                                    Wait(200)
                                    ClearPedTasks(playerPed)
                                end
    
    
                            end
                        end
                        if Index == 2 then
                            typos = result[i].type
                            txt = gettxt2(result[i].label)
                            txt = tostring(txt)
                            if txt ~= nil then
                                TriggerServerEvent("dqp:RenameMasque", result[i].id, txt, typos)
                              RageUI.CloseAll()
                              result[i].label = txt
    
                            end
                        end
                        if Index == 3 then
                            local myPed = PlayerPedId()
                            if result[i].index == 99 then
                                SetPedComponentVariation(playerPed, 1, 0, 0, 2)
                            else
                                ClearPedProp(myPed, result[i].index)
                            end
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            local closestPed = GetPlayerPed(closestPlayer)
    
                            if IsPedSittingInAnyVehicle(closestPed) then
                                ESX.ShowNotification('~r~Impossible de donner un objet dans un véhicule')
                                return
                            end
    
                            if closestPlayer ~= -1 and closestDistance < 3.0 then
    
                                TriggerServerEvent('dqp:GiveAccessories', GetPlayerServerId(closestPlayer), result[i].id, result[i].label)
    
    
                                RageUI.CloseAll()
    
                                --table.remove( MaskTab, i  )
    
                            else
                                ESX.ShowNotification("~r~Aucun joueurs proche")
    
                            end
                        end
                        if Index == 4 then
                            TriggerServerEvent('dqp:Delclo', result[i].id, result[i].label,result[i])
                            if result[i].type == 'Masque' then
                                SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 2)
                            elseif result[i].type == 'Chapeau' then
                                ClearPedProp(PlayerPedId(), 0)
                            elseif result[i].type == 'Lunette' then
                                ClearPedProp(PlayerPedId(), 1)
                            elseif result[i].type == 'Boucle' then
                                ClearPedProp(PlayerPedId(), 2)
                            end
                            TriggerEvent('shop:SyncAccess')
                            RageUI.CloseAll()
                        end
                    end
                    watodoo.indexwatodoo = Index
                end)
            end
        end, function()
        end, 1)
        end
    end)



local blips = {
	{title="Magasin d'accèssoires", colour=8, id=102, x = -1336.73, y = -1277.44, z = 4.88}
}

CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.75)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(5)
	end
end

CreateThread(function()
	while true do
	  Wait(0)
      if IsControlJustPressed(0, 47) then
        ESX.TriggerServerCallback("dqp:getMask", function(result)
            MaskTab = result
        end)
        Wait(25)
        RageUI.Visible(RMenu:Get('aces', 'access'), not RageUI.Visible(RMenu:Get('aces', 'access')))
	  end
	end
  end)



function DrawAnim()
    local ped = PlayerPedId()
    local ad = "clothingshirt"
    loadAnimDict(ad)
    RequestAnimDict(dict)
    TaskPlayAnim(ped, ad, "check_out_a", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "check_out_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "check_out_c", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "intro", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "outro", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_base", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_a", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_c", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "try_shirt_positive_d", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
end


