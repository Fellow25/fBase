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
if vagos.jeveuxblips then
    local vagosmap = AddBlipForCoord(334.75, -2039.65, 21.1)

    SetBlipSprite(vagosmap, 310)
    SetBlipColour(vagosmap, 5)
    SetBlipScale(vagosmap, 0.80)
    SetBlipAsShortRange(vagosmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier Vagos")
    EndTextCommandSetBlipName(vagosmap)
    end
end)


-- Garage

function GarageVagos()
  local GVagos = RageUI.CreateMenu("Garage", "Vagos")
    RageUI.Visible(GVagos, not RageUI.Visible(GVagos))
        while GVagos do
            Wait(0)
                RageUI.IsVisible(GVagos, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GVagosvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarVagos(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(GVagos) then
            GVagos = RMenu:DeleteType("GVagos", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vagos' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vagos' then 
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vagos.pos.garage.position.x, vagos.pos.garage.position.y, vagos.pos.garage.position.z)
            if dist3 <= 10.0 and vagos.jeveuxmarker then
                Timer = 0
                DrawMarker(20, vagos.pos.garage.position.x, vagos.pos.garage.position.y, vagos.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageVagos()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarVagos(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, vagos.pos.spawnvoiture.position.x, vagos.pos.spawnvoiture.position.y, vagos.pos.spawnvoiture.position.z, vagos.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "vagos"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
    SetVehicleCustomPrimaryColour(vehicle, 255, 255, 0)
    SetVehicleCustomSecondaryColour(vehicle, 255, 255, 0)
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

function CoffreVagos()
	local CVagos = RageUI.CreateMenu("Coffre", "Vagos")
        RageUI.Visible(CVagos, not RageUI.Visible(CVagos))
            while CVagos do
            Wait(0)
            RageUI.IsVisible(CVagos, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VagosRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VagosDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformevagos()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_vagos()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(CVagos) then
            CVagos = RMenu:DeleteType("CVagos", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vagos' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vagos' then  
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, vagos.pos.coffre.position.x, vagos.pos.coffre.position.y, vagos.pos.coffre.position.z)
            if jobdist <= 10.0 and vagos.jeveuxmarker then
                Timer = 0
                DrawMarker(20, vagos.pos.coffre.position.x, vagos.pos.coffre.position.y, vagos.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreVagos()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

itemstock = {}
function VagosRetirerobjet()
	local StockVagos = RageUI.CreateMenu("Coffre", "Vagos")
	ESX.TriggerServerCallback('vagos:getStockItems', function(items) 
	itemstock = items
	end)
	RageUI.Visible(StockVagos, not RageUI.Visible(StockVagos))
        while StockVagos do
		    Wait(0)
		        RageUI.IsVisible(StockVagos, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('vagos:getStockItem', v.name, tonumber(count))
                                    VagosRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockVagos) then
            StockVagos = RMenu:DeleteType("StockVagos", true)
        end
    end
end

local PlayersItem = {}
function VagosDeposerobjet()
    local DepositVagos = RageUI.CreateMenu("Coffre", "Vagos")
	ESX.TriggerServerCallback('vagos:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositVagos, not RageUI.Visible(DepositVagos))
    while DepositVagos do
        Wait(0)
            RageUI.IsVisible(DepositVagos, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('vagos:putStockItems', item.name, tonumber(count))
                                            VagosDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositVagos) then
                DepositVagos = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'vagos', 'Ouvrir le menu vagos', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vagos' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'vagos' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformevagos()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = vagos.tenue.male
        else
            uniformObject = vagos.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function vcivil_vagos()
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