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

function OpenBrasserieRecolte()
    local BrasserieRecolte = RageUI.CreateMenu("Recolte malt", "Brasserie")
    BrasserieRecolte:SetRectangleBanner(0, 150, 0)
    
    RageUI.Visible(BrasserieRecolte, not RageUI.Visible(BrasserieRecolte))
    
    while BrasserieRecolte do
        Wait(0)
        RageUI.IsVisible(BrasserieRecolte, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte malt", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltemalt()
                    end
                end)
        end)
    
        if not RageUI.Visible(BrasserieRecolte) then
            BrasserieRecolte = RMenu:DeleteType("BrasserieRecolte", true)
            end
        end
    end

local recoltepossible = false
CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            local Timer = 500
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local playerCoords = GetEntityCoords(PlayerPedId())
            zoneDistance = GetDistanceBetweenCoords(playerCoords, brasserie.pos.recolte.position.x, brasserie.pos.recolte.position.y, brasserie.pos.recolte.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            OpenBrasserieRecolte()
                        end
            end
            if zoneDistance ~= nil then
                if zoneDistance > 1.5 then
                    recoltepossible = false
                end
            end
        Wait(Timer)
    end    
end)

function recoltemalt()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('malt')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brasserie' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, brasserie.pos.recolte.position.x, brasserie.pos.recolte.position.y, brasserie.pos.recolte.position.z)
        if dist3 <= 10.0 and brasserie.jeveuxmarker then
            Timer = 0
            DrawMarker(20, brasserie.pos.recolte.position.x, brasserie.pos.recolte.position.y, brasserie.pos.recolte.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 150, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour récolter le malt", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenBrasserieRecolte()
                    end   
                end
            end 
        Wait(Timer)
    end
end)