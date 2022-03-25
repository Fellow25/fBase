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

function OpenTabacVente()
    local TabacVente = RageUI.CreateMenu("Vente du tabac", "Tabac")
    
    RageUI.Visible(TabacVente, not RageUI.Visible(TabacVente))
    
    while TabacVente do
        Wait(0)
        RageUI.IsVisible(TabacVente, true, true, true, function()
                RageUI.ButtonWithStyle("Vendre le tabac", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    ventetabac()
                    end
                end)
    end)  

        if not RageUI.Visible(TabacVente) then
            TabacVente = RMenu:DeleteType("TabacVente", true)
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
                zoneDistance = GetDistanceBetweenCoords(playerCoords, tabac.pos.vente.position.x, tabac.pos.vente.position.y, tabac.pos.vente.position.z)
                    if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                        Timer = 0
                            if IsControlJustPressed(1, 51) then
                                OpenTabacVente()
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

    function ventetabac()
        if not ventepossible then
            ventepossible = true
        while ventepossible do
            Wait(2000)
            TriggerServerEvent('ventemalboro')
        end
        else
            ventepossible = false
        end
    end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tabac' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, tabac.pos.vente.position.x, tabac.pos.vente.position.y, tabac.pos.vente.position.z)
        if dist3 <= 7.0 and tabac.jeveuxmarker then
            Timer = 0
            DrawMarker(20, tabac.pos.vente.position.x, tabac.pos.vente.position.y, tabac.pos.vente.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 75, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour vendre le tabac", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            OpenTabacVente()
                    end   
                end
            end 
        Wait(Timer)
    end
end)