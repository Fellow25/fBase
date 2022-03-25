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
    if brasserie.jeveuxblips then
    local brasseriemap = AddBlipForCoord(brasserie.pos.blips.position.x, brasserie.pos.blips.position.y, brasserie.pos.blips.position.z)

    SetBlipSprite(brasseriemap, 93)
    SetBlipColour(brasseriemap, 2)
    SetBlipScale(brasseriemap, 0.65)
    SetBlipAsShortRange(brasseriemap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Brasserie")
    EndTextCommandSetBlipName(brasseriemap)
end
end)


function Menuf6Brasserie()
    local Brasserief6 = RageUI.CreateMenu("Brasserie", "Interactions")
    Brasserief6:SetRectangleBanner(0, 150, 0)
    RageUI.Visible(Brasserief6, not RageUI.Visible(Brasserief6))
    while Brasserief6 do
        Wait(0)
            RageUI.IsVisible(Brasserief6, true, true, true, function()

                RageUI.ButtonWithStyle("Passer une facture",nil, {RightLabel = "→"}, true, function(_,_,s)
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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_brasserie', ('Brasserie'), montant)
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


                RageUI.Separator("")

                RageUI.Checkbox("Passer une annonce",nil, annonce,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        annonce = Checked;
    
                        if Checked then
                            annonce = true
                        else
                            annonce = false
                        end
                    end
                end)

                if annonce then
                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('AnnonceBrasserieOuvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('AnnonceBrasserieFermer')
                    end
                end)
            end

            RageUI.Separator("")

                RageUI.Checkbox("Activer le gps",nil, gps,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
                            gps = Checked;
        
                            if Checked then
                                gps = true
                            else
                                gps = false
                            end
                        end
                    end)

                    if gps then
                RageUI.ButtonWithStyle("Récolte malt",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(brasserie.pos.recolte.position.x, brasserie.pos.recolte.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Transformation malt",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(brasserie.pos.transformation.position.x, brasserie.pos.transformation.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Vente bière",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(brasserie.pos.vente.position.x, brasserie.pos.vente.position.y)
                    end
                end)
            end
            end, function() 
            end)
    
                if not RageUI.Visible(Brasserief6) then
                    Brasserief6 = RMenu:DeleteType("Brasserief6", true)
        end
    end
end


Keys.Register('F6', 'Brasserie', 'Ouvrir le menu Brasserie', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brasserie' then
    	Menuf6Brasserie()
	end
end)




function Coffrebrasserie()
    local Cbrasserie = RageUI.CreateMenu("Coffre", "Brasserie")
    Cbrasserie:SetRectangleBanner(0, 150, 0)
        RageUI.Visible(Cbrasserie, not RageUI.Visible(Cbrasserie))
            while Cbrasserie do
            Wait(0)
            RageUI.IsVisible(Cbrasserie, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            brasserieRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            brasserieDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Brasserie",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenuebrasserie()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_brasserie()
                            RageUI.CloseAll()
                        end
                    end)

                end, function()
                end)
            if not RageUI.Visible(Cbrasserie) then
            Cbrasserie = RMenu:DeleteType("Cbrasserie", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brasserie' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, brasserie.pos.coffre.position.x, brasserie.pos.coffre.position.y, brasserie.pos.coffre.position.z)
            if jobdist <= 10.0 and brasserie.jeveuxmarker then
                Timer = 0
                DrawMarker(20, brasserie.pos.coffre.position.x, brasserie.pos.coffre.position.y, brasserie.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 150, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrebrasserie()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


function Garagebrasserie()
    local Gbrasserie = RageUI.CreateMenu("Garage", "Brasserie")
    Gbrasserie:SetRectangleBanner(0, 150, 0)
      RageUI.Visible(Gbrasserie, not RageUI.Visible(Gbrasserie))
          while Gbrasserie do
              Wait(0)
                  RageUI.IsVisible(Gbrasserie, true, true, true, function()
                      RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then   
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              RageUI.CloseAll()
                              end 
                          end
                      end) 
  
                      for k,v in pairs(Gbrasserievoiture) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Wait(1)  
                              spawnuniCarbrasserie(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(Gbrasserie) then
              Gbrasserie = RMenu:DeleteType("Garage", true)
          end
      end
  end
  
  CreateThread(function()
          while true do
              local Timer = 500
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'brasserie' then
              local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
              local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, brasserie.pos.garage.position.x, brasserie.pos.garage.position.y, brasserie.pos.garage.position.z)
              if dist3 <= 10.0 and brasserie.jeveuxmarker then
                  Timer = 0
                  DrawMarker(20, brasserie.pos.garage.position.x, brasserie.pos.garage.position.y, brasserie.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 150, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                  end
                  if dist3 <= 3.0 then
                  Timer = 0   
                      RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                      if IsControlJustPressed(1,51) then           
                          Garagebrasserie()
                      end   
                  end
              end 
          Wait(Timer)
       end
  end)
  
  function spawnuniCarbrasserie(car)
      local car = GetHashKey(car)
  
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Wait(0)
      end
  
      local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
      local vehicle = CreateVehicle(car, brasserie.pos.spawnvoiture.position.x, brasserie.pos.spawnvoiture.position.y, brasserie.pos.spawnvoiture.position.z, brasserie.pos.spawnvoiture.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "brasserie"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
  end



function tenuebrasserie()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = brasserie.Uniforms.male
        else
            uniformObject = brasserie.Uniforms.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end


function vcivil_brasserie()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end

itemstock = {}
function brasserieRetirerobjet()
    local Stockbrasserie = RageUI.CreateMenu("Coffre", "Brasserie")
    Stockbrasserie:SetRectangleBanner(0, 150, 0)
    ESX.TriggerServerCallback('brasserie:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(Stockbrasserie, not RageUI.Visible(Stockbrasserie))
        while Stockbrasserie do
            Wait(0)
                RageUI.IsVisible(Stockbrasserie, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('brasserie:getStockItem', v.name, tonumber(count))
                                    brasserieRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockbrasserie) then
            Stockbrasserie = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function brasserieDeposerobjet()
    local Depositbrasserie = RageUI.CreateMenu("Coffre", "Brasserie")
    Depositbrasserie:SetRectangleBanner(0, 150, 0)
    ESX.TriggerServerCallback('brasserie:getPlayerInventory', function(inventory)
        RageUI.Visible(Depositbrasserie, not RageUI.Visible(Depositbrasserie))
    while Depositbrasserie do
        Wait(0)
            RageUI.IsVisible(Depositbrasserie, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('brasserie:putStockItems', item.name, tonumber(count))
                                            brasserieDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Depositbrasserie) then
                Depositbrasserie = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end