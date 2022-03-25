CoESX = nil

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

function OpenBoulangerieVente()
    local BoulangerieVente = RageUI.CreateMenu("Vente du pain", "Boulangerie")
    
    RageUI.Visible(BoulangerieVente, not RageUI.Visible(BoulangerieVente))
    
    while BoulangerieVente do
        Wait(0)
        RageUI.IsVisible(BoulangerieVente, true, true, true, function()
                RageUI.ButtonWithStyle("Vendre le pain", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ventepain()
                    end
                end)
        end)
    
        if not RageUI.Visible(BoulangerieVente) then
            BoulangerieVente = RMenu:DeleteType("BoulangerieVente", true)
            end
        end
    end

    local ventepossible = false
    CreateThread(function()
            local playerPed = PlayerPedId()
            while true do
                local Timer = 500
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local playerCoords = GetEntityCoords(PlayerPedId())
                zoneDistance = GetDistanceBetweenCoords(playerCoords, boulangerie.pos.vente.position.x, boulangerie.pos.vente.position.y, boulangerie.pos.vente.position.z)
                    if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                        Timer = 0
                            if IsControlJustPressed(1, 51) then
                                OpenBoulangerieVente()
                            end
                end
                if zoneDistance ~= nil then
                    if zoneDistance > 1.5 then
                        ventepossible = false
                    end
                end
            Wait(Timer)
        end    
    end)

    function ventepain()
        if not ventepossible then
            ventepossible = true
        while ventepossible do
            Wait(2000)
            TriggerServerEvent('ventepain')
        end
        else
            ventepossible = false
        end
    end


CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'boulangerie' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, boulangerie.pos.vente.position.x, boulangerie.pos.vente.position.y, boulangerie.pos.vente.position.z)
        if dist3 <= 7.0 and boulangerie.jeveuxmarker then
            Timer = 0
            DrawMarker(20, boulangerie.pos.vente.position.x, boulangerie.pos.vente.position.y, boulangerie.pos.vente.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour vendre du pain", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            OpenBoulangerieVente()
                    end   
                end
            end 
        Wait(Timer)
    end
end)