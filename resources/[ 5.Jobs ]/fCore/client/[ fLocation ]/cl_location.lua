ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

function OpenLocation()
    local Location = RageUI.CreateMenu("Location", "Séléctionne un véhicule")
  
    RageUI.Visible(Location, not RageUI.Visible(Location))
  
    while Location do
        Wait(0)
        RageUI.IsVisible(Location, true, true, true, function()
  
            RageUI.ButtonWithStyle("BMX", nil, {RightLabel = "~g~50€"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('fellow:locationBMX',50)
                    RageUI.CloseAll()
                end
            end)

            RageUI.ButtonWithStyle("Scooter", nil, {RightLabel = "~g~200€"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('fellow:locationScooter',200)
                    RageUI.CloseAll()
                end
            end)

            RageUI.ButtonWithStyle("Voiture", nil, {RightLabel = "~g~500€"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('fellow:locationVoiture',500)
                    RageUI.CloseAll()
                end
            end)
  
  end, function()
  end)
        if not RageUI.Visible(Location) then
            Location = RMenu:DeleteType("Location", true)
        end
    end
  end

local position = {
    {x = -288.26,   y = -1031.70,  z = 30.38}
    }    



CreateThread(function()
    local hash = GetHashKey("s_m_m_highsec_02")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_highsec_02", -288.26, -1031.70, 29.38, 341.45, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

CreateThread(function()
    for k, v in pairs(position) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 38)
        SetBlipScale (blip, 0.6)
        SetBlipColour(blip, 24)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Location')
        EndTextCommandSetBlipName(blip)
    end
end)    
    
 CreateThread(function()
    while true do
        local sleep = 500
            for k in pairs(position) do
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
                    if dist <= 1.0 then
                    sleep = 0
                    RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour louer un véhicule", time_display = 1 })
                    if IsControlJustPressed(1,51) then
                        OpenLocation()
                    end
                end
            end
        Wait(sleep)
    end
end)

RegisterNetEvent('g:spawnCar')
AddEventHandler('g:spawnCar', function(car)  
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, -286.77, -1022.85, 30.20, 248.43, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "fLocation"
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end)