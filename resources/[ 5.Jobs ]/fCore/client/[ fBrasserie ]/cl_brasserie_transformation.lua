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

function OpenBrasserieTransformation()
    local BrasserieTransformation = RageUI.CreateMenu("Transformer malt", "Brasserie")
    BrasserieTransformation:SetRectangleBanner(0, 150, 0)
    
    RageUI.Visible(BrasserieTransformation, not RageUI.Visible(BrasserieTransformation))
    
    while BrasserieTransformation do
        Wait(0)
        RageUI.IsVisible(BrasserieTransformation, true, true, true, function()
                RageUI.ButtonWithStyle("Transformer malt", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    transformationmalt()
                    end
                end)
        end)
    
        if not RageUI.Visible(BrasserieTransformation) then
            BrasserieTransformation = RMenu:DeleteType("BrasserieTransformation", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, brasserie.pos.transformation.position.x, brasserie.pos.transformation.position.y, brasserie.pos.transformation.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            OpenBrasserieTransformation()
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

function transformationmalt()
    if not transformationpossible then
        transformationpossible = true
    while transformationpossible do
        Wait(2000)
        TriggerServerEvent('biere')
    end
    else
        transformationpossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brasserie' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, brasserie.pos.transformation.position.x, brasserie.pos.transformation.position.y, brasserie.pos.transformation.position.z)
        if dist3 <= 10.0 and brasserie.jeveuxmarker then
            Timer = 0
            DrawMarker(20, brasserie.pos.transformation.position.x, brasserie.pos.transformation.position.y, brasserie.pos.transformation.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 150, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour transformer le malt", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenBrasserieTransformation()
                    end   
                end
            end 
        Wait(Timer)
    end
end)