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

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

CreateThread(function()
if crips.jeveuxblips then
    local cripsmap = AddBlipForCoord(crips.pos.blips.position.x, crips.pos.blips.position.y, crips.pos.blips.position.z)

    SetBlipSprite(cripsmap, 310)
    SetBlipColour(cripsmap, 57)
    SetBlipScale(cripsmap, 0.80)
    SetBlipAsShortRange(cripsmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier Crips")
    EndTextCommandSetBlipName(cripsmap)
end
end)

-- Garage

function GarageCrips()
  local GCrips = RageUI.CreateMenu("Garage", "Crips")
    RageUI.Visible(GCrips, not RageUI.Visible(GCrips))
        while GCrips do
            Wait(0)
                RageUI.IsVisible(GCrips, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GCripsvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarCrips(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GCrips) then
            GCrips = RMenu:DeleteType("GCrips", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'crips' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'crips' then 
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, crips.pos.garage.position.x, crips.pos.garage.position.y, crips.pos.garage.position.z)
            if dist3 <= 10.0 and crips.jeveuxmarker then
                Timer = 0
                DrawMarker(20, crips.pos.garage.position.x, crips.pos.garage.position.y, crips.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 100, 149, 237, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageCrips()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarCrips(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, crips.pos.spawnvoiture.position.x, crips.pos.spawnvoiture.position.y, crips.pos.spawnvoiture.position.z, crips.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "crips"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
    SetVehicleCustomPrimaryColour(vehicle, 100, 149, 237)
    SetVehicleCustomSecondaryColour(vehicle, 100, 149, 237)
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

function Coffrecrips()
	local Ccrips = RageUI.CreateMenu("Coffre", "Crips")
        RageUI.Visible(Ccrips, not RageUI.Visible(Ccrips))
            while Ccrips do
            Wait(0)
            RageUI.IsVisible(Ccrips, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            CripsRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            CripsDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformecrips()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_crips()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Ccrips) then
            Ccrips = RMenu:DeleteType("Ccrips", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'crips' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'crips' then  
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, crips.pos.coffre.position.x, crips.pos.coffre.position.y, crips.pos.coffre.position.z)
            if jobdist <= 10.0 and crips.jeveuxmarker then
                Timer = 0
                DrawMarker(20, crips.pos.coffre.position.x, crips.pos.coffre.position.y, crips.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 100, 149, 237, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrecrips()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

itemstock = {}
function CripsRetirerobjet()
	local StockCrips = RageUI.CreateMenu("Coffre", "Crips")
	ESX.TriggerServerCallback('crips:getStockItems', function(items) 
	itemstock = items
	RageUI.Visible(StockCrips, not RageUI.Visible(StockCrips))
        while StockCrips do
		    Wait(0)
		        RageUI.IsVisible(StockCrips, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('crips:getStockItem', v.name, tonumber(count))
                                    CripsRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockCrips) then
            StockCrips = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function CripsDeposerobjet()
    local DepositCrips = RageUI.CreateMenu("Coffre", "Crips")
    ESX.TriggerServerCallback('crips:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositCrips, not RageUI.Visible(DepositCrips))
    while DepositCrips do
        Wait(0)
            RageUI.IsVisible(DepositCrips, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('crips:putStockItems', item.name, tonumber(count))
                                            CripsDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositCrips) then
                DepositCrips = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'crips', 'Ouvrir le menu crips', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'crips' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'crips' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformecrips()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = crips.tenue.male
        else
            uniformObject = crips.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_crips()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end

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