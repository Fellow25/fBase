ESX = nil
local started = false
local disableUI = false
local viewangle = false
local cost = 0
local cam = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
        Wait(0)
    end
    barber = GetHashKey("s_f_m_fembarber")
    if not HasModelLoaded(barber) then
        RequestModel(barber)
        Wait(200)
    end
end)

CreateThread(function()
    while true do
        Wait(19)
        local coords = GetEntityCoords(PlayerPedId())
        if (GetDistanceBetweenCoords(coords, 133.55, -1708.86, 29.29, true) < 0.5) then
            AddTextEntry(GetCurrentResourceName(), _U('started'))
            DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
            if (IsControlJustReleased(0, 38)) then
                ESX.TriggerServerCallback('barbershop:checkposition', function(result)
                    if result then
                        readyCutHair()-- 剪頭髮
                        createBarber()-- 召喚理髮師
                    else
                        TriggerEvent('esx:showNotification', _U('alreadyHair'), GetPlayerServerId(PlayerId()))
                    end
                end)
            end
        end
    end
end)


CreateThread(function()
    local blip = AddBlipForCoord(vector3(136.8, -1708.4, 28.3))
    SetBlipSprite(blip, 71)
    SetBlipColour(blip, 51)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(_U('bilpName'))
    EndTextCommandSetBlipName(blip)
end)


function readyCutHair()
    disableUI = true
    TriggerEvent('barbershop:disableUI')
    TaskPedSlideToCoord(PlayerPedId(), 137.12, -1709.45, 29.3, 205.75, 1.0)
    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do
        Wait(0)
    end
    SetEntityCoords(PlayerPedId(), 137.72, -1710.64, 28.60)
    SetEntityHeading(PlayerPedId(), 237.22)
    ClearPedTasks(PlayerPedId())
    BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
    TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", BehindPlayer['x'], BehindPlayer['y'], BehindPlayer['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
    Wait(1300)
    DoScreenFadeIn(5000)
end


function createBarber()
    Ped = CreatePed(1, barber, 141.48, -1705.59, 29.29 - 0.95, 0.0, true, true)-- 生成NPC
    SetEntityHeading(Ped, 123.37)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, true)
    TaskPedSlideToCoord(Ped, 137.15, -1710.50, 29.3, 205.75, 1.0)-- 讓npc移動到指定位置
    Wait(10000)
    FreezeEntityPosition(PlayerPedId(), true)
    started = true
    TriggerEvent('barbershop:start')
end


RegisterNetEvent('barbershop:start')
AddEventHandler('barbershop:start', function()
    CreateThread(function()
        while started do
            Wait(0)
            AddTextEntry(GetCurrentResourceName(), _U('buttom_Help', Config.hairCost, Config.eyebrowCost, Config.beardCost, cost))
            DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
            if (IsControlJustPressed(0, 215)) then
                FreezeEntityPosition(PlayerPedId(), false)
                viewangle = false
                started = false
                disableUI = false
                destorycam()
                SetEntityCoords(PlayerPedId(), 133.55, -1708.86, 28.29)
                SetEntityHeading(PlayerPedId(), 237.22)
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('barbershop:pay', GetPlayerServerId(PlayerId()), cost)
                Wait(500)
                TaskPedSlideToCoord(Ped, 141.48, -1705.59, 29.29 - 0.95, 123.37, 1.0)
                Wait(2000)
                DeletePed(Ped)
                cost = 0
            elseif (IsControlJustPressed(0, 112) or IsControlJustPressed(0, 107) or IsControlJustPressed(0, 117)) then
                started = false
                viewangle = true
                if IsControlJustPressed(0, 112) then
                    barberMenu('hairstyle')
                elseif IsControlJustPressed(0, 107) then
                    barberMenu('beardstyle')
                elseif IsControlJustPressed(0, 117) then
                    barberMenu('eyebrowstyle')
                end
                createcam(true)
                TriggerEvent('barbershop:viewangle')
            end
        end
    end)
end)

RegisterNetEvent('barbershop:viewangle')
AddEventHandler('barbershop:viewangle', function()
    CreateThread(function()
        while viewangle do
            Wait(0)
            AddTextEntry(GetCurrentResourceName(), _U('angle'))
            DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
            if (IsControlJustPressed(0, 89)) then
                createcam(true)
            elseif (IsControlJustPressed(0, 90)) then
                createcam(false)
            end
        end
    end)
end)

function createcam(default)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        if default then
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 138.45, -1711.05, 29.70, 0.0, 0.0, 45.00, 65.0, false, 0)
        else
            cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', 137.72, -1709.87, 29.90, 0.0, 0.0, 135.00, 85.0, false, 0)
        end
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
    end
end

function destorycam()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    TriggerServerEvent('barbershop:removeposition')
end

RegisterNetEvent('barbershop:disableUI')
AddEventHandler('barbershop:disableUI', function()
    CreateThread(function()
        while disableUI do
            Wait(0)
            HideHudComponentThisFrame(19)
            DisableControlAction(2, 37, true)
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(0, 106, true)
            if IsDisabledControlJustPressed(2, 37) or IsDisabledControlJustPressed(0, 106) then
                SetCurrentPedWeapon(player, GetHashKey("WEAPON_UNARMED"), true)
            end
        end
    end)
end)

barberMenu = function(style)
    TriggerEvent('skinchanger:getSkin', function(skin)
        lastSkin = skin
    end)
    
    local elements = {}
    local _components = {}
    TriggerEvent('skinchanger:getData', function(components, maxVals)
            -- Restrict menu
            if restrict == nil then
                for i = 1, #components, 1 do
                    _components[i] = components[i]
                end
            else
                for i = 1, #components, 1 do
                    local found = false
                    for j = 1, #restrict, 1 do
                        if components[i].name == restrict[j] then
                            found = true
                        end
                    end
                    
                    if found then
                        table.insert(_components, components[i])
                    end
                end
            end
            
            -- Insert elements
            for i = 1, #_components, 1 do
                local compname = _components[i].name
                local value = _components[i].value
                local componentId = _components[i].componentId
                if componentId == 0 then
                    value = GetPedPropIndex(playerPed, _components[i].componentId)
                end
                if style == 'hairstyle' then
                    if compname == 'hair_1' or compname == 'hair_2' or compname == 'hair_color_1' or compname == 'hair_color_2' then
                        local data = {
                            label = _components[i].label,
                            name = _components[i].name,
                            value = value,
                            min = _components[i].min,
                            textureof = _components[i].textureof,
                            type = 'slider'
                        }
                        
                        for k, v in pairs(maxVals) do
                            if k == _components[i].name then
                                data.max = v
                                break
                            end
                        end
                        table.insert(elements, data)
                    end
                elseif style == 'beardstyle' then
                    if compname == 'beard_1' or compname == 'beard_2' or compname == 'beard_3' or compname == 'beard_4' then
                        local data = {
                            label = _components[i].label,
                            name = _components[i].name,
                            value = value,
                            min = _components[i].min,
                            textureof = _components[i].textureof,
                            type = 'slider'
                        }
                        
                        for k, v in pairs(maxVals) do
                            if k == _components[i].name then
                                data.max = v
                                break
                            end
                        end
                        table.insert(elements, data)
                    end
                elseif style == 'eyebrowstyle' then
                    if compname == 'eyebrows_1' or compname == 'eyebrows_2' or compname == 'eyebrows_3' or compname == 'eyebrows_4' then
                        local data = {
                            label = _components[i].label,
                            name = _components[i].name,
                            value = value,
                            min = _components[i].min,
                            textureof = _components[i].textureof,
                            type = 'slider'
                        }
                        
                        for k, v in pairs(maxVals) do
                            if k == _components[i].name then
                                data.max = v
                                break
                            end
                        end
                        table.insert(elements, data)
                    end
                end
            end
    end)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin', {
        title = _U('menu_title'),
        align = 'top-right',
        elements = elements
    }, function(data, menu)
        menu.close()
        createcam(true)
        viewangle = false
        RequestAnimDict("misshair_shop@barbers")
        while not HasAnimDictLoaded("misshair_shop@barbers") do
            Wait(0)
        end
        TriggerEvent('skinchanger:getSkin', function(skin)
            TriggerServerEvent('esx_skin:save', skin)
        end)
        TaskPlayAnim(Ped, "misshair_shop@barbers", "keeper_idle_b", 8.0, 8.0, 15000, 0, 0, -1, -1, -1)
        TriggerEvent('skinchanger:getSkin', function(getSkin)
            skin = getSkin
        end)
        Wait(11500)
        if style == 'beardstyle' then
            cost = cost + Config.beardCost
        elseif style == 'eyebrowstyle' then
            cost = cost + Config.eyebrowCost
        else
            cost = cost + Config.hairCost
        end
        ESX.UI.Menu.CloseAll()
        started = true
        TriggerEvent('barbershop:start')
    end, function(data, menu)
        menu.close()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
        started = true
        viewangle = false
        TriggerEvent('barbershop:start')
    end, function(data, menu)
        local skin, components, maxVals
        TriggerEvent('skinchanger:getSkin', function(getSkin)
            skin = getSkin
        end)
        if skin[data.current.name] ~= data.current.value then
            TriggerEvent('skinchanger:change', data.current.name, data.current.value)
            TriggerEvent('skinchanger:getData', function(comp, max)
                components, maxVals = comp, max
            end)
            
            local newData = {}
            
            for i = 1, #elements, 1 do
                newData = {}
                newData.max = maxVals[elements[i].name]
                
                if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
                    newData.value = 0
                end
                
                menu.update({name = elements[i].name}, newData)
            end
            menu.refresh()
        end
    end, function(data, menu)
    end)
end
