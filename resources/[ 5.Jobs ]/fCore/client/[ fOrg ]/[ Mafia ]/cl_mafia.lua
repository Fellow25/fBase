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
	
	RegisterNetEvent('esx:setJob2')
	AddEventHandler('esx:setJob2', function(job2)
		ESX.PlayerData.job2 = job2
	end)

CreateThread(function()
    if Mafia.jeveuxblips then
        local mafiamap = AddBlipForCoord(Mafia.pos.blips.position.x, Mafia.pos.blips.position.y, Mafia.pos.blips.position.z)
    
        SetBlipSprite(mafiamap, 310)
        SetBlipColour(mafiamap, 0)
        SetBlipScale(mafiamap, 0.80)
        SetBlipAsShortRange(mafiamap, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Quartier Mafia")
        EndTextCommandSetBlipName(mafiamap)
    end
    end)

function Coffremafia()
    local Cmafia = RageUI.CreateMenu("Coffre", "Mafia")
        RageUI.Visible(Cmafia, not RageUI.Visible(Cmafia))
            while Cmafia do
            Wait(0)
            RageUI.IsVisible(Cmafia, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            MafiaRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            MafiaDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cmafia) then
            Cmafia = RMenu:DeleteType("Cmafia", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Mafia.pos.coffre.position.x, Mafia.pos.coffre.position.y, Mafia.pos.coffre.position.z)
            if jobdist <= 10.0 and Mafia.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Mafia.pos.coffre.position.x, Mafia.pos.coffre.position.y, Mafia.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffremafia()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


-- Garage

function Garagemafia()
  local Gmafia = RageUI.CreateMenu("Garage", "Mafia")
    RageUI.Visible(Gmafia, not RageUI.Visible(Gmafia))
        while Gmafia do
            Wait(0)
                RageUI.IsVisible(Gmafia, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gmafiavoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarmafia(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gmafia) then
            Gmafia = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Mafia.pos.garage.position.x, Mafia.pos.garage.position.y, Mafia.pos.garage.position.z)
            if dist3 <= 10.0 and Mafia.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Mafia.pos.garage.position.x, Mafia.pos.garage.position.y, Mafia.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagemafia()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarmafia(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Mafia.pos.spawnvoiture.position.x, Mafia.pos.spawnvoiture.position.y, Mafia.pos.spawnvoiture.position.z, Mafia.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Mafia"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
    SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
    SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
    SetVehicleMaxMods(vehicle)
end

itemstock = {}
function MafiaRetirerobjet()
    local Stockmafia = RageUI.CreateMenu("Coffre", "Mafia")
    ESX.TriggerServerCallback('fmafia:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockmafia, not RageUI.Visible(Stockmafia))
        while Stockmafia do
            Wait(0)
                RageUI.IsVisible(Stockmafia, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fmafia:getStockItem', v.name, tonumber(count))
                                    MafiaRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockmafia) then
            Stockmafia = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function MafiaDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Mafia")
    ESX.TriggerServerCallback('fmafia:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('fmafia:putStockItems', item.name, tonumber(count))
                                            MafiaDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'mafia', 'Ouvrir le menu mafia', function()
    if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then    
    TriggerEvent('fellow:MenuFouille')
end
end)

function Theoriemafia()
    local Tmafia = RageUI.CreateMenu("Craft Théorie", "Mafia")
      RageUI.Visible(Tmafia, not RageUI.Visible(Tmafia))
          while Tmafia do
              Wait(0)
                  RageUI.IsVisible(Tmafia, true, true, true, function()
                    for k,v in pairs(Mafia.craft) do
                        RageUI.ButtonWithStyle(v.name, nil, {RightLabel = "?"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                            RageUI.Popup({message = "Pour craft le/la "..v.name.." vous avez besoin de :"})
                            if v.metaux ~= nil then
                            RageUI.Popup({message = "x"..v.metaux.. " Métaux"})
                            end
                            if v.poudre ~= nil then
                            RageUI.Popup({message = "x"..v.poudre.. "Poudre à canon"})
                            end
                            if v.meche ~= nil then
                            RageUI.Popup({message = "x"..v.meche.. " Mèche"})
                            end
                            if v.ruban ~= nil then
                            RageUI.Popup({message = "x"..v.ruban.. " Ruban adhésif"})
                            end
                            end
                        end)
                    end
                end, function()
                end)
              if not RageUI.Visible(Tmafia) then
              Tmafia = RMenu:DeleteType("Craft Théorie", true)
          end
      end
  end

CreateThread(function()
while true do
    local Timer = 500
    if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then
    local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
    local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Mafia.pos.theorie.position.x, Mafia.pos.theorie.position.y, Mafia.pos.theorie.position.z)
    if dist3 <= 10.0 and Mafia.jeveuxmarker then
        Timer = 0
        DrawMarker(20, Mafia.pos.theorie.position.x, Mafia.pos.theorie.position.y, Mafia.pos.theorie.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
        end
        if dist3 <= 3.0 then
        Timer = 0   
            RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour interagir avec la table", time_display = 1 })
            if IsControlJustPressed(1,51) then           
                Theoriemafia()
            end   
        end
    end 
Wait(Timer)
end
end)

function MenuCraftmafia()
    local Craftmafia = RageUI.CreateMenu("Craft Théorie", "Mafia")
    local Craftmafiasub = RageUI.CreateSubMenu(Craftmafia, "Craft Théorie", "Mafia")
    ESX.TriggerServerCallback('fmafia:getPlayerInventory', function(inventory)
    choixnbmet = 0
    choixnbmeche = 0
    choixnbpoudre = 0
    choixnbruban = 0
      RageUI.Visible(Craftmafia, not RageUI.Visible(Craftmafia))
          while Craftmafia do
              Wait(0)
                  RageUI.IsVisible(Craftmafia, true, true, true, function()
                    for v = 1, #inventory.items, 1 do
                        if inventory.items[v].name == "metaux" or inventory.items[v].name == "poudre" or inventory.items[v].name == "meche" or inventory.items[v].name == "ruban" then
                            RageUI.ButtonWithStyle(inventory.items[v].label.." ["..inventory.items[v].count.."]", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    if inventory.items[v].name == "metaux" then
                                        nbmetaux = KeyboardInput('Veuillez choisir le nombre de métaux pour le craft', '', 2)
                                        if tonumber(nbmetaux) then
                                            if inventory.items[v].count >= tonumber(nbmetaux) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbmet = nbmetaux
                                            else
                                            RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbmet = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbmetaux = 0
                                        end
                                    end
                                    if inventory.items[v].name == "meche" then
                                        nbmeche = KeyboardInput('Veuillez choisir le nombre de mèche pour le craft', '', 2)
                                        if tonumber(nbmeche) then
                                            if inventory.items[v].count >= tonumber(nbmeche) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbmeche = nbmeche
                                            else
                                                RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbmeche = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbmeche = 0
                                        end
                                    end
                                    if inventory.items[v].name == "poudre" then
                                        nbpoudre = KeyboardInput('Veuillez choisir le nombre de poudre pour le craft', '', 2)
                                        if tonumber(nbpoudre) then
                                            if inventory.items[v].count >= tonumber(nbpoudre) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbpoudre = nbpoudre
                                            else
                                        RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbpoudre = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbpoudre = 0
                                        end
                                    end
                                    if inventory.items[v].name == "ruban" then
                                        nbruban = KeyboardInput('Veuillez choisir le nombre de ruban adhésif pour le craft', '', 2)
                                        if tonumber(nbruban) then
                                            if inventory.items[v].count >= tonumber(nbruban) then
                                                RageUI.Popup({message = "~g~Montant validé"})
                                                choixnbruban = nbruban
                                            else
                                        RageUI.Popup({message = "Montant invalide, veuillez recommencer..."})
                                                choixnbruban = 0
                                            end
                                        else
                                            RageUI.Popup({message = "Vous n'avez pas saisi de nombre"})
                                            nbruban = 0
                                        end
                                    end
                                end
                            end)
                        end
                    end
                    RageUI.ButtonWithStyle("Passer au craft", nil, {RightLabel = "→→", Color = {BackgroundColor = RageUI.ItemsColour.Green}},true, function()
                    end, Craftmafiasub)
                        end, function()
                        end)
                        RageUI.IsVisible(Craftmafiasub, true, true, true, function()
                        RageUI.Separator('~b~Résumé :')
                        RageUI.Separator('x'..choixnbmet.." Métaux")
                        RageUI.Separator('x'..choixnbruban.." Ruban adhésif")
                        RageUI.Separator('x'..choixnbmeche.." Mèche")
                        RageUI.Separator('x'..choixnbpoudre.." Poudre à canon")
                        RageUI.ButtonWithStyle("Valider le craft", nil, {RightLabel = "→→→", Color = {BackgroundColor = RageUI.ItemsColour.Green}}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            if tonumber(choixnbmet) == Mafia.craft[1].metaux and tonumber(choixnbmeche) == Mafia.craft[1].meche and tonumber(choixnbpoudre) == Mafia.craft[1].poudre and tonumber(choixnbruban) == Mafia.craft[1].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[1].weapon
                                TriggerServerEvent('mafiacraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[2].metaux and tonumber(choixnbmeche) == Mafia.craft[2].meche and tonumber(choixnbpoudre) == Mafia.craft[2].poudre and tonumber(choixnbruban) == Mafia.craft[2].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[2].weapon
                                TriggerServerEvent('mafiacraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[3].metaux and tonumber(choixnbmeche) == Mafia.craft[3].meche and tonumber(choixnbpoudre) == Mafia.craft[3].poudre and tonumber(choixnbruban) == Mafia.craft[3].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[3].weapon
                                TriggerServerEvent('mafiacraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[4].metaux and tonumber(choixnbmeche) == Mafia.craft[4].meche and tonumber(choixnbpoudre) == Mafia.craft[4].poudre and tonumber(choixnbruban) == Mafia.craft[4].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[4].weapon
                                TriggerServerEvent('mafiacraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[5].metaux and tonumber(choixnbmeche) == Mafia.craft[5].meche and tonumber(choixnbpoudre) == Mafia.craft[5].poudre and tonumber(choixnbruban) == Mafia.craft[5].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[5].weapon
                                TriggerServerEvent('mafiacraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[6].metaux and tonumber(choixnbmeche) == Mafia.craft[6].meche and tonumber(choixnbpoudre) == Mafia.craft[6].poudre and tonumber(choixnbruban) == Mafia.craft[6].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[6].weapon
                                TriggerServerEvent('mafiacraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[7].metaux and tonumber(choixnbmeche) == Mafia.craft[7].meche and tonumber(choixnbpoudre) == Mafia.craft[7].poudre and tonumber(choixnbruban) == Mafia.craft[7].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[7].weapon
                                TriggerServerEvent('mafiacraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[8].metaux and tonumber(choixnbmeche) == Mafia.craft[8].meche and tonumber(choixnbpoudre) == Mafia.craft[8].poudre and tonumber(choixnbruban) == Mafia.craft[8].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[8].weapon
                                TriggerServerEvent('mafiacraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[9].metaux and tonumber(choixnbmeche) == Mafia.craft[9].meche and tonumber(choixnbpoudre) == Mafia.craft[9].poudre and tonumber(choixnbruban) == Mafia.craft[9].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[9].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[10].metaux and tonumber(choixnbmeche) == Mafia.craft[10].meche and tonumber(choixnbpoudre) == Mafia.craft[10].poudre and tonumber(choixnbruban) == Mafia.craft[10].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[10].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            elseif tonumber(choixnbmet) == Mafia.craft[11].metaux and tonumber(choixnbmeche) == Mafia.craft[11].meche and tonumber(choixnbpoudre) == Mafia.craft[11].poudre and tonumber(choixnbruban) == Mafia.craft[11].ruban then
                                RageUI.Popup({message = "~g~Le craft a réussi, vous avez perdu tout les matériaux utilisé et vous avez reçu votre arme"})
                                local item = Mafia.craft[11].weapon
                                TriggerServerEvent('cartelcraft:gg', item, tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            else
                                RageUI.Popup({message = "~r~Craft non réussi, vous avez perdu tout les matériaux utilisé!"})
                                TriggerServerEvent('mafia_craft:nonvalider', tonumber(choixnbmet), tonumber(choixnbmeche), tonumber(choixnbpoudre), tonumber(choixnbruban))
                            end
                            RageUI.GoBack()
                            choixnbmet = 0
                            choixnbmeche = 0
                            choixnbpoudre = 0
                            choixnbruban = 0
                            choixnbpou = 0
                        end
                        end)
                        RageUI.ButtonWithStyle("~r~Réinitialiser et retourner en arrière", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            choixnbmet = 0
                            choixnbmeche = 0
                            choixnbpoudre = 0
                            choixnbruban = 0
                            choixnbpou = 0
                            RageUI.GoBack()
                        end
                        end)
                        end, function()
                        end)
              if not RageUI.Visible(Craftmafia) and not RageUI.Visible(Craftmafiasub) then
              Craftmafia = RMenu:DeleteType("Craft Théorie", true)
          end
      end
    end)
  end

CreateThread(function()
while true do
    local Timer = 500
    if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then
    local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
    local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Mafia.pos.craftmenu.position.x, Mafia.pos.craftmenu.position.y, Mafia.pos.craftmenu.position.z)
    if dist3 <= 10.0 and Mafia.jeveuxmarker then
        Timer = 0
        DrawMarker(20, Mafia.pos.craftmenu.position.x, Mafia.pos.craftmenu.position.y, Mafia.pos.craftmenu.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
        end
        if dist3 <= 3.0 then
        Timer = 0   
            RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour craft", time_display = 1 })
            if IsControlJustPressed(1,51) then         
                MenuCraftmafia()
            end   
        end
    end 
Wait(Timer)
end
end)

function mafiaRecolteMetaux()
    local ARM = RageUI.CreateMenu("Recolte métaux", "Mafia")
    
    RageUI.Visible(ARM, not RageUI.Visible(ARM))
    
    while ARM do
        Wait(0)
        RageUI.IsVisible(ARM, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de métaux", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltemetaux()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARM) then
            ARM = RMenu:DeleteType("ARM", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Mafia.farm.metaux.position.x, Mafia.farm.metaux.position.y, Mafia.farm.metaux.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            mafiaRecolteMetaux()
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

function recoltemetaux()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('metaux')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Mafia.farm.metaux.position.x, Mafia.farm.metaux.position.y, Mafia.farm.metaux.position.z)
        if dist3 <= 10.0 and Mafia.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Mafia.farm.metaux.position.x, Mafia.farm.metaux.position.y, Mafia.farm.metaux.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour récolter des métaux", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            mafiaRecolteMetaux()
                    end   
                end
            end 
        Wait(Timer)
    end
end)
------------------------------------
function mafiaRecoltepoudre()
    local ARC = RageUI.CreateMenu("Recolte poudre à canon", "Mafia")
    
    RageUI.Visible(ARC, not RageUI.Visible(ARC))
    
    while ARC do
        Wait(0)
        RageUI.IsVisible(ARC, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de poudre à canon", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltepoudre()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARC) then
            ARC = RMenu:DeleteType("ARC", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Mafia.farm.poudre.position.x, Mafia.farm.poudre.position.y, Mafia.farm.poudre.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            mafiaRecoltepoudre()
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

function recoltepoudre()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('poudre')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Mafia.farm.poudre.position.x, Mafia.farm.poudre.position.y, Mafia.farm.poudre.position.z)
        if dist3 <= 10.0 and Mafia.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Mafia.farm.poudre.position.x, Mafia.farm.poudre.position.y, Mafia.farm.poudre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour récolter de la poudre à canon", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            mafiaRecoltepoudre()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

--------------------------------
function mafiaRecolteMeche()
    local ARM = RageUI.CreateMenu("Recolte mèche", "Mafia")
    
    RageUI.Visible(ARM, not RageUI.Visible(ARM))
    
    while ARM do
        Wait(0)
        RageUI.IsVisible(ARM, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de mèche", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recoltemeche()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARM) then
            ARM = RMenu:DeleteType("ARM", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Mafia.farm.meche.position.x, Mafia.farm.meche.position.y, Mafia.farm.meche.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            mafiaRecolteMeche()
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

function recoltemeche()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('meche')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Mafia.farm.meche.position.x, Mafia.farm.meche.position.y, Mafia.farm.meche.position.z)
        if dist3 <= 10.0 and Mafia.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Mafia.farm.meche.position.x, Mafia.farm.meche.position.y, Mafia.farm.meche.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour récolter des mèches", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            mafiaRecolteMeche()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

--------------------------------
function mafiaRecolteruban()
    local ARL = RageUI.CreateMenu("Recolte ruban adhésif", "Mafia")
    
    RageUI.Visible(ARL, not RageUI.Visible(ARL))
    
    while ARL do
        Wait(0)
        RageUI.IsVisible(ARL, true, true, true, function()
                RageUI.ButtonWithStyle("Récolte de ruban adhésif", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    RageUI.CloseAll()
                    recolteruban()
                    end
                end)
        end)
    
        if not RageUI.Visible(ARL) then
            ARL = RMenu:DeleteType("ARL", true)
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
            zoneDistance = GetDistanceBetweenCoords(playerCoords, Mafia.farm.ruban.position.x, Mafia.farm.ruban.position.y, Mafia.farm.ruban.position.z)
                if IsEntityAtCoord(PlayerPedId(), 0.0, -0.0, -0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 
                    Timer = 0
                        if IsControlJustPressed(1, 51) then
                            mafiaRecolteruban()
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

function recolteruban()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(2000)
        TriggerServerEvent('ruban')
    end
    else
        recoltepossible = false
    end
end

CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'mafia' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Mafia.farm.ruban.position.x, Mafia.farm.ruban.position.y, Mafia.farm.ruban.position.z)
        if dist3 <= 10.0 and Mafia.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Mafia.farm.ruban.position.x, Mafia.farm.ruban.position.y, Mafia.farm.ruban.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 1.5 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~u~[E]~s~ pour récolter des ruban adhésif", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            mafiaRecolteruban()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end
