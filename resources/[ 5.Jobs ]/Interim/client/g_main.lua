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
        BlipsJob()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	BlipsJob()
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	BlipsJob()
end)

local inWork = false
local state = 0
local SetStateWaypoint = false
    
function BlipsJob()
CreateThread(function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ferrailleur' then
    local ferraillemap = AddBlipForCoord(config.Feraille.PedPos.x, config.Feraille.PedPos.y, config.Feraille.PedPos.z)

    SetBlipSprite(ferraillemap, 566)
    SetBlipColour(ferraillemap, 40)
    SetBlipScale(ferraillemap, 0.65)
    SetBlipAsShortRange(ferraillemap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Ferrailleur")
    EndTextCommandSetBlipName(ferraillemap)
end
end)
end

CreateThread(function()
    ---------------------- PED ------------------------
    local Spawnpedname = GetHashKey(config.Feraille.ped)
    while not HasModelLoaded(Spawnpedname) do
        RequestModel(Spawnpedname)
        Wait(60)
    end
    local Spawnpos = vector3(config.Feraille.PedPos.x,config.Feraille.PedPos.y,config.Feraille.PedPos.z - 1)
    local heading = config.Feraille.PedHeading

    local Spawnped = CreatePed(9, Spawnpedname, Spawnpos, heading, false, false)

    SetEntityInvincible(Spawnped, true)
    SetBlockingOfNonTemporaryEvents(Spawnped, true)
    FreezeEntityPosition(Spawnped, true)

---------------------- Actions Ped ------------------------
    
   
    while true do
        local interval = 1000
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ferrailleur' then
            if not inWork then
            
                pos = GetEntityCoords(PlayerPedId())
                distance = GetDistanceBetweenCoords(pos, vector3(config.Feraille.PedPos.x,config.Feraille.PedPos.y,config.Feraille.PedPos.z - 1), true)
                
                if distance < 2 then
                    interval = 1
                    DrawScreenText("[~g~E~s~] Pour commencer une tournée",1)
                    if IsControlJustReleased(0, 51) then
                        inWork = true
                        Trajet()
                    end
                else
                    interval = 200
                end
            end
        end
        Wait(interval)
    end

end) 


function SetWaypoint()
    if state + 1 <= #config.Feraille.state then
        blip = AddBlipForCoord(config.Feraille.state[state + 1].x,config.Feraille.state[state + 1].y,config.Feraille.state[state + 1].z)
        SetBlipSprite(blip, config.Feraille.blip)
        SetBlipColour(blip, config.Feraille.blip_color)
        SetStateWaypoint = true
    else
        blip = AddBlipForCoord(config.Feraille.PedPos.x,config.Feraille.PedPos.y,config.Feraille.PedPos.z)
        SetBlipSprite(blip, 38)
        SetBlipColour(blip, 1)
        SetStateWaypoint = true
    end
end

function FutWaypoint()
    RemoveBlip(blip)
    state = state + 1
    SetStateWaypoint = false
end



function Trajet()
    while inWork do 
        local interval = 500
        local pos = GetEntityCoords(PlayerPedId())
        if state + 1 <= #config.Feraille.state  then
            dest = vector3(config.Feraille.state[state + 1].x,config.Feraille.state[state + 1].y,config.Feraille.state[state + 1].z)
        else
            dest = vector3(config.Feraille.PedPos.x,config.Feraille.PedPos.y,config.Feraille.PedPos.z)

        end
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if not SetStateWaypoint then
            SetWaypoint()
        else
            if distance < 2 then
                interval = 1
                if state + 1 <= #config.Feraille.state then
                    DrawMarker(2, config.Feraille.state[state + 1].x,config.Feraille.state[state + 1].y,config.Feraille.state[state + 1].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 245, 190, 112, 170, 0, 1, 2, 0, nil, nil, 0)
                    DrawScreenText("Appuyez sur [~g~E~s~] pour rammasez",1)

                    if IsControlJustPressed(1, 51) then
                        RequestAnimDict("random@domestic")
                        while not HasAnimDictLoaded("random@domestic")do 
                            Wait(0) 
                        end
                        Wait(100)
                        TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 2.0, 2.0, -1, 0, 0, false, false, false)
                        Wait(3000)
                        TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 2.0, 2.0, -1, 0, 0, false, false, false)
                        Wait(3000)
                        TriggerServerEvent("Interim:giveitem", "ferraille")
                        ClearPedTasks(PlayerPedId())
                        FutWaypoint()
                    end
                else
                    DrawScreenText("Appuyez sur [~r~E~s~] pour finir le travail",1)

                    if IsControlJustPressed(1, 51) then
                        Wait(1000)
                        Notif("~g~Très bon travail, dirige-toi vers le mécano pour vendre la ferraille.")
                        SetStateWaypoint = false
                        inWork = false
			state = 0
                        RemoveBlip(blip)
                    end
                end
                
                
            end
        end
        Wait(1.0)
    end 
end
