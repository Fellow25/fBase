ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

CreateThread(function()
    if AutoEcole.jeveuxblips then
        local drivingschool = AddBlipForCoord(-41.51, -215.29, 45.80)
    
        SetBlipSprite(drivingschool, 269)
        SetBlipColour(drivingschool, 18)
        SetBlipScale(drivingschool, 0.80)
        SetBlipAsShortRange(drivingschool, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Auto-École")
        EndTextCommandSetBlipName(drivingschool)
    end
end)

-- Garage

GAutoEcolevoiture = {
	{nom = "Moto", modele = "Enduro"},
	{nom = "Voiture", modele = "blista"},
	{nom = "Camion", modele = "Hauler"},
}

function GarageAutoEcole()
  local GAutoEcole = RageUI.CreateMenu("Garage", "Auto-École")
    RageUI.Visible(GAutoEcole, not RageUI.Visible(GAutoEcole))
        while GAutoEcole do
            Wait(0)
                RageUI.IsVisible(GAutoEcole, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            end 
                        end
                    end) 

                    for k,v in pairs(GAutoEcolevoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarAutoEcole(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GAutoEcole) then
            GAutoEcole = RMenu:DeleteType("GAutoEcole", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'driving' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'driving' then 
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, AutoEcole.pos.garage.position.x, AutoEcole.pos.garage.position.y, AutoEcole.pos.garage.position.z)
            if dist3 <= 10.0 and AutoEcole.jeveuxmarker then
                Timer = 0
                DrawMarker(20, AutoEcole.pos.garage.position.x, AutoEcole.pos.garage.position.y, AutoEcole.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageAutoEcole()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarAutoEcole(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, AutoEcole.pos.spawnvoiture.position.x, AutoEcole.pos.spawnvoiture.position.y, AutoEcole.pos.spawnvoiture.position.z, AutoEcole.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "AutoEcole"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
    SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
    SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
    SetVehicleMaxMods(vehicle)
end

function SetVehicleMaxMods(vehicle)

    local props = {
      modEngine       = 2,
      modBrakes       = 2,
      modTransmission = 2,
      modSuspension   = 3,
      modTurbo        = true,
    }
  
    ESX.Game.SetVehicleProperties(vehicle, props)
  
  end

-- Coffre

function CoffreAutoEcole()
	local CAutoEcole = RageUI.CreateMenu("Coffre", "Auto-École")
        RageUI.Visible(CAutoEcole, not RageUI.Visible(CAutoEcole))
            while CAutoEcole do
            Wait(0)
            RageUI.IsVisible(CAutoEcole, true, true, true, function()

                RageUI.Separator("↓ Objet ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            AutoEcoleRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            AutoEcoleDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(CAutoEcole) then
            CAutoEcole = RMenu:DeleteType("CAutoEcole", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'driving' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'driving' then  
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, AutoEcole.pos.coffre.position.x, AutoEcole.pos.coffre.position.y, AutoEcole.pos.coffre.position.z)
            if jobdist <= 10.0 and AutoEcole.jeveuxmarker then
                Timer = 0
                DrawMarker(20, AutoEcole.pos.coffre.position.x, AutoEcole.pos.coffre.position.y, AutoEcole.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreAutoEcole()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

itemstock = {}
function AutoEcoleRetirerobjet()
	local StockAutoEcole = RageUI.CreateMenu("Coffre", "Auto-École")
	ESX.TriggerServerCallback('driving:getStockItems', function(items) 
	itemstock = items
	RageUI.Visible(StockAutoEcole, not RageUI.Visible(StockAutoEcole))
        while StockAutoEcole do
		    Wait(0)
		        RageUI.IsVisible(StockAutoEcole, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('driving:getStockItem', v.name, tonumber(count))
                                    AutoEcoleRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockAutoEcole) then
            StockAutoEcole = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function AutoEcoleDeposerobjet()
    local DepositAutoEcole = RageUI.CreateMenu("Coffre", "Auto-École")
    ESX.TriggerServerCallback('driving:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositAutoEcole, not RageUI.Visible(DepositAutoEcole))
    while DepositAutoEcole do
        Wait(0)
            RageUI.IsVisible(DepositAutoEcole, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('driving:putStockItems', item.name, tonumber(count))
                                            AutoEcoleDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositAutoEcole) then
                DepositAutoEcole = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

-- Vestiaire

function VestiaireAutoEcole()
	local VAutoEcole = RageUI.CreateMenu("Vestiaire", "Auto-École")
        RageUI.Visible(VAutoEcole, not RageUI.Visible(VAutoEcole))
            while VAutoEcole do
            Wait(0)
            RageUI.IsVisible(VAutoEcole, true, true, true, function()

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Uniforme",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformeAutoEcole()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_driving()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(VAutoEcole) then
            VAutoEcole = RMenu:DeleteType("VAutoEcole", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'driving' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'driving' then  
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, AutoEcole.pos.vestiaire.position.x, AutoEcole.pos.vestiaire.position.y, AutoEcole.pos.vestiaire.position.z)
            if jobdist <= 10.0 and AutoEcole.jeveuxmarker then
                Timer = 0
                DrawMarker(20, AutoEcole.pos.vestiaire.position.x, AutoEcole.pos.vestiaire.position.y, AutoEcole.pos.vestiaire.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au vestiaire", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            VestiaireAutoEcole()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

function vuniformeAutoEcole()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = AutoEcole.tenue.male
        else
            uniformObject = AutoEcole.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_driving()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end

-- Menu
function MenuAutoEcole()
    local MAutoEcole = RageUI.CreateMenu("Menu", "Auto-École")
    local MAutoEcoleSub = RageUI.CreateSubMenu(MAutoEcole, "Menu", "Auto-École")
    RageUI.Visible(MAutoEcole, not RageUI.Visible(MAutoEcole))
    while MAutoEcole do
        Wait(0)
            RageUI.IsVisible(MAutoEcole, true, true, true, function()
                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_driving', ('Auto-Ecole'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
				
  
                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('AnnonceDrivingOuvert')
                    end
                end)
            
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('AnnonceDrivingFermer')
                    end
                end)

                RageUI.ButtonWithStyle("Donner permis de conduire", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, MAutoEcoleSub)
			end, function()
			end)

            	RageUI.IsVisible(MAutoEcoleSub, true, true, true, function()
                
					RageUI.ButtonWithStyle("Permis de moto", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'drive_bike')
								ESX.ShowNotification('Permis attribuer avec suces.')
							else
								ESX.ShowNotification('Aucun joueurs à proximité')
							end
						end
					end)
			
					RageUI.ButtonWithStyle("Permis de voiture", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'drive')
								ESX.ShowNotification('Permis attribuer avec suces.')
							else
								ESX.ShowNotification('Aucun joueurs à proximité')
							end
						end
					end)
			
					RageUI.ButtonWithStyle("Permis de camion", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'drive_truck')
								ESX.ShowNotification('Permis attribuer avec suces.')
							else
								ESX.ShowNotification('Aucun joueurs à proximité')
							end
						end
					end)
				end, function()
				end)	

              if not RageUI.Visible(MAutoEcole) and not RageUI.Visible(MAutoEcoleSub) then
              MAutoEcole = RMenu:DeleteType("MAutoEcole", true)
        end
    end
end

Keys.Register('F6', 'menu', 'Ouvrir le menu F6', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'driving' then
        MenuAutoEcole()
    end
    end)

    function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
        AddTextEntry('FMMC_KEY_TIP1', TextEntry)
        blockinput = true
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
            Wait(0)
        end 
            
        if UpdateOnscreenKeyboard() ~= 2 then
            local result = GetOnscreenKeyboardResult()
            Wait(500)
            blockinput = false
            return result
        else
            Wait(500)
            blockinput = false
            return nil
        end
    end