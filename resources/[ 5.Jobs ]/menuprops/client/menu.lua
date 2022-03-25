ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(5000)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RMenu.Add('Police', 'main', RageUI.CreateMenu("Menu Props", " "))
RMenu:Get('Police', 'main'):SetSubtitle("Catégories :")
RMenu:Get('Police', 'main').EnableMouse = false
RMenu:Get('Police', 'main').Closed = function()
    -- TODO Perform action
end;


RMenu.Add('Police', 'object4', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('Police', 'objectlist', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Suppression d'objets", "~b~Suppression d'objets"))

object = {}
OtherItems = {}
local inventaire = false
local status = true

RageUI.CreateWhile(1.0, function()

    if RageUI.Visible(RMenu:Get('Police', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Police", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('Police', 'object4'))

            RageUI.Button("Mode suppression", "Supprimer des objets", { RightLabel = "XXX" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('Police', 'objectlist'))

        end, function()
            ---Panels
        end)
    end

-- Police
    if RageUI.Visible(RMenu:Get('Police', 'object4')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Cone", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_roadcone02a")
                end
            end)
            RageUI.Button("Barrière", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_barrier_work05")
                end
            end)
            
            RageUI.Button("Gros carton", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_boxpile_07d")
                end
            end)

            RageUI.Button("Herse", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("p_ld_stinger_s")
                end
            end)

            RageUI.Button("Cash", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("hei_prop_cash_crate_half_full")
                end
            end)

        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('Police', 'objectlist')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            for k,v in pairs(object) do
                if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                RageUI.Button("Object: "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        local entity = NetworkGetEntityFromNetworkId(v)
                        local ObjCoords = GetEntityCoords(entity)
                        DrawMarker(0, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                    end
                    if Selected then
                        RemoveObj(v, k)
                    end
                end)
            end
            
        end, function()
            ---Panels
        end)
    end

end, 1)

RegisterCommand('props', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
    RageUI.Visible(RMenu:Get('Police', 'main'), true)
else
    ESX.ShowNotification("Vous n'êtes pas policier pour utiliser cette commande")
end
end, false)