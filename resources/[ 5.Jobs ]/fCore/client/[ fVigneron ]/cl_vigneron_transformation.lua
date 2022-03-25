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

function OpenVigneronTransformation()
    local VigneronTransformation = RageUI.CreateMenu("Transformation jus raisin", "Vigneron")
    
    RageUI.Visible(VigneronTransformation, not RageUI.Visible(VigneronTransformation))
    
    while VigneronTransformation do
        Wait(0)
        RageUI.IsVisible(VigneronTransformation, true, true, true, function()
                RageUI.ButtonWithStyle("Transformation jus raisin", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    transformationraisin()
                    end
                end)
        end)
    
        if not RageUI.Visible(VigneronTransformation) then
            VigneronTransformation = RMenu:DeleteType("VigneronTransformation", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, vigneron.pos.transformation.position.x, vigneron.pos.transformation.position.y, vigneron.pos.transformation.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            OpenVigneronTransformation()
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

function transformationraisin()
    if not transformationpossible then
        transformationpossible = true
    while transformationpossible do
        Wait(2000)
        TriggerServerEvent('vin')
    end
    else
        transformationpossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vigneron.pos.transformation.position.x, vigneron.pos.transformation.position.y, vigneron.pos.transformation.position.z)
        if dist3 <= 10.0 and vigneron.jeveuxmarker then
            Timer = 0
            DrawMarker(20, vigneron.pos.transformation.position.x, vigneron.pos.transformation.position.y, vigneron.pos.transformation.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 3, 200, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour transformer le jus de raisin", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenVigneronTransformation()
                    end   
                end
            end 
        Wait(Timer)
    end
end)