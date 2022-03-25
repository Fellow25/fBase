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

function OpenVigneronTraitement()
    local VigneronTraitement = RageUI.CreateMenu("Traitement raisin", "Vigneron")
    
    RageUI.Visible(VigneronTraitement, not RageUI.Visible(VigneronTraitement))
    
    while VigneronTraitement do
        Wait(0)
        RageUI.IsVisible(VigneronTraitement, true, true, true, function()
                RageUI.ButtonWithStyle("Transformation du raisin", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    traitementraisin()
                    end
                end)
        end)
    
        if not RageUI.Visible(VigneronTraitement) then
            VigneronTraitement = RMenu:DeleteType("VigneronTraitement", true)
            end
        end
    end

local traitementpossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, vigneron.pos.traitement.position.x, vigneron.pos.traitement.position.y, vigneron.pos.traitement.position.z)

                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            OpenVigneronTraitement()
                        end
                        end
                        if zoneDistance ~= nil then
                            if zoneDistance > 1.5 then
                                traitementpossible = false
                            end
                        end
                    Wait(Timer)
                end    
            end)

function traitementraisin()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
        Wait(2000)
        TriggerServerEvent('jus')
    end
    else
        traitementpossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vigneron.pos.traitement.position.x, vigneron.pos.traitement.position.y, vigneron.pos.traitement.position.z)
        if dist3 <= 10.0 and vigneron.jeveuxmarker then
            Timer = 0
            DrawMarker(20, vigneron.pos.traitement.position.x, vigneron.pos.traitement.position.y, vigneron.pos.traitement.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 3, 200, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour traiter le raisin", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenVigneronTraitement()
                    end   
                end
            end 
        Wait(Timer)
    end
end)