ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Wait(5000) 
end)

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function OpenBoulangerieTransformation()
    local BoulangerieTransformation = RageUI.CreateMenu("Traiter farine", "Boulangerie")
    
    RageUI.Visible(BoulangerieTransformation, not RageUI.Visible(BoulangerieTransformation))
    
    while BoulangerieTransformation do
        Wait(0)
        RageUI.IsVisible(BoulangerieTransformation, true, true, true, function()
                RageUI.ButtonWithStyle("Traiter farine", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    transformationfarine()
                    end
                end)
        end)
    
        if not RageUI.Visible(BoulangerieTransformation) then
            BoulangerieTransformation = RMenu:DeleteType("BoulangerieTransformation", true)
            end
        end
    end

local transformationpossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, boulangerie.pos.transformation.position.x, boulangerie.pos.transformation.position.y, boulangerie.pos.transformation.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            OpenBoulangerieTransformation()
                        end
                    end
                    if zoneDistance ~= nil then
                        if zoneDistance > 1.5 then
                            transformationpossible = false
                        end
                    end
                Wait(Timer)
            end    
        end)

function transformationfarine()
    if not transformationpossible then
        transformationpossible = true
    while transformationpossible do
        Wait(2000)
        TriggerServerEvent('painpremierprix')
    end
    else
        transformationpossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'boulangerie' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, boulangerie.pos.transformation.position.x, boulangerie.pos.transformation.position.y, boulangerie.pos.transformation.position.z)
        if dist3 <= 10.0 and boulangerie.jeveuxmarker then
            Timer = 0
            DrawMarker(20, boulangerie.pos.transformation.position.x, boulangerie.pos.transformation.position.y, boulangerie.pos.transformation.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour traiter la farine", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenBoulangerieTransformation()
                    end   
                end
            end 
        Wait(Timer)
    end
end)