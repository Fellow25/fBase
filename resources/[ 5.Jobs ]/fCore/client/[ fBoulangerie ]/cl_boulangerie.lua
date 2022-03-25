ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

CreateThread(function()
    if boulangerie.jeveuxblips then
    local boulangeriemap = AddBlipForCoord(boulangerie.pos.blips.position.x, boulangerie.pos.blips.position.y, boulangerie.pos.blips.position.z)

    SetBlipSprite(boulangeriemap, 106)
    SetBlipColour(boulangeriemap, 46)
    SetBlipScale(boulangeriemap, 0.65)
    SetBlipAsShortRange(boulangeriemap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Boulangerie")
    EndTextCommandSetBlipName(boulangeriemap)
end
end)


function Menuf6Boulangerie()
    local Boulangerief6 = RageUI.CreateMenu("Boulangerie", "Interactions")
    local Boulangerief6sub = RageUI.CreateSubMenu(Boulangerief6, "Boulangerie", "Interactions")
    RageUI.Visible(Boulangerief6, not RageUI.Visible(Boulangerief6))
    while Boulangerief6 do
        Wait(0)
            RageUI.IsVisible(Boulangerief6, true, true, true, function()

                RageUI.Separator("↓ Facture ↓")

                RageUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_boulangerie', ('Boulangerie'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)


                RageUI.Separator("↓ Annonce ↓")



                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('AnnonceBoulangerieOuvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('AnnonceBoulangerieFermer')
                    end
                end)
                RageUI.Separator("")

                RageUI.ButtonWithStyle("Menu travail", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, Boulangerief6sub)


                end, function() 
                end)
    
                RageUI.IsVisible(Boulangerief6sub, true, true, true, function()

                RageUI.ButtonWithStyle("Récolte farine",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(boulangerie.pos.recolte.position.x, boulangerie.pos.recolte.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Traiter farine",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(boulangerie.pos.transformation.position.x, boulangerie.pos.transformation.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Vente pain",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(boulangerie.pos.vente.position.x, boulangerie.pos.vente.position.y)
                    end
                end)
            end, function() 
            end)
    
                if not RageUI.Visible(Boulangerief6) and not RageUI.Visible(Boulangerief6sub) then
                    Boulangerief6 = RMenu:DeleteType("Boulangerief6", true)
        end
    end
end


Keys.Register('F6', 'Boulangerie', 'Ouvrir le menu Boulangerie', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'boulangerie' then
    	Menuf6Boulangerie()
	end
end)

function Coffreboulangerie()
    local Cboulangerie = RageUI.CreateMenu("Coffre", "Boulangerie")
        RageUI.Visible(Cboulangerie, not RageUI.Visible(Cboulangerie))
            while Cboulangerie do
            Wait(0)
            RageUI.IsVisible(Cboulangerie, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            boulangerieRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            boulangerieDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Boulangerie",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenueboulangerie()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil()
                            RageUI.CloseAll()
                        end
                    end)

                end, function()
                end)
            if not RageUI.Visible(Cboulangerie) then
            Cboulangerie = RMenu:DeleteType("Cboulangerie", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'boulangerie' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, boulangerie.pos.coffre.position.x, boulangerie.pos.coffre.position.y, boulangerie.pos.coffre.position.z)
            if jobdist <= 10.0 and boulangerie.jeveuxmarker then
                Timer = 0
                DrawMarker(20, boulangerie.pos.coffre.position.x, boulangerie.pos.coffre.position.y, boulangerie.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffreboulangerie()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


function Garageboulangerie()
    local Gboulangerie = RageUI.CreateMenu("Garage", "Boulangerie")
      RageUI.Visible(Gboulangerie, not RageUI.Visible(Gboulangerie))
          while Gboulangerie do
              Wait(0)
                  RageUI.IsVisible(Gboulangerie, true, true, true, function()
                      RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then   
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              RageUI.CloseAll()
                              end 
                          end
                      end) 
  
                      for k,v in pairs(Gboulangerievoiture) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Wait(1)  
                              spawnuniCarboulangerie(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(Gboulangerie) then
              Gboulangerie = RMenu:DeleteType("Garage", true)
          end
      end
  end
  
  CreateThread(function()
          while true do
              local Timer = 500
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'boulangerie' then
              local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
              local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, boulangerie.pos.garage.position.x, boulangerie.pos.garage.position.y, boulangerie.pos.garage.position.z)
              if dist3 <= 10.0 and boulangerie.jeveuxmarker then
                  Timer = 0
                  DrawMarker(20, boulangerie.pos.garage.position.x, boulangerie.pos.garage.position.y, boulangerie.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                  end
                  if dist3 <= 3.0 then
                  Timer = 0   
                      RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                      if IsControlJustPressed(1,51) then           
                          Garageboulangerie()
                      end   
                  end
              end 
          Wait(Timer)
       end
  end)
  
  function spawnuniCarboulangerie(car)
      local car = GetHashKey(car)
  
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Wait(0)
      end
  
      local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
      local vehicle = CreateVehicle(car, boulangerie.pos.spawnvoiture.position.x, boulangerie.pos.spawnvoiture.position.y, boulangerie.pos.spawnvoiture.position.z, boulangerie.pos.spawnvoiture.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "boulangerie"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
  end



function tenueboulangerie()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = boulangerie.Uniforms.male
        else
            uniformObject = boulangerie.Uniforms.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end


function vcivil()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end

itemstock = {}
function boulangerieRetirerobjet()
    local StockBoulangerie = RageUI.CreateMenu("Coffre", "Boulangerie")
    ESX.TriggerServerCallback('boulangerie:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StockBoulangerie, not RageUI.Visible(StockBoulangerie))
        while StockBoulangerie do
            Wait(0)
                RageUI.IsVisible(StockBoulangerie, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('boulangerie:getStockItem', v.name, tonumber(count))
                                    boulangerieRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockBoulangerie) then
            StockBoulangerie = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function boulangerieDeposerobjet()
    local DepositBoulangerie = RageUI.CreateMenu("Coffre", "Boulangerie")
    ESX.TriggerServerCallback('boulangerie:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositBoulangerie, not RageUI.Visible(DepositBoulangerie))
    while DepositBoulangerie do
        Wait(0)
            RageUI.IsVisible(DepositBoulangerie, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('boulangerie:putStockItems', item.name, tonumber(count))
                                            boulangerieDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositBoulangerie) then
                DepositBoulangerie = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end
