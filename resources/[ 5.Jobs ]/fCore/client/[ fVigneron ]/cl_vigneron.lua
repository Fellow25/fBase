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
    if vigneron.jeveuxblips then
    local vigneronmap = AddBlipForCoord(vigneron.pos.blips.position.x, vigneron.pos.blips.position.y, vigneron.pos.blips.position.z)

    SetBlipSprite(vigneronmap, 93)
    SetBlipColour(vigneronmap, 7)
    SetBlipScale(vigneronmap, 0.65)
    SetBlipAsShortRange(vigneronmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Vigneron")
    EndTextCommandSetBlipName(vigneronmap)
end
end)


function Menuf6Vigneron()
    local Vigneronf6 = RageUI.CreateMenu("Vigneron", "Interactions")
    RageUI.Visible(Vigneronf6, not RageUI.Visible(Vigneronf6))
    while Vigneronf6 do
        Wait(0)
            RageUI.IsVisible(Vigneronf6, true, true, true, function()

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_vigneron', ('Vigneron'), montant)
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
                        TriggerServerEvent('AnnonceVigneOuvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('AnnonceVigneFermer')
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

                RageUI.ButtonWithStyle("Récolte raisin",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(vigneron.pos.recolte.position.x, vigneron.pos.recolte.position.y, vigneron.pos.recolte.position.z)
                    end
                end)

                RageUI.ButtonWithStyle("Traitement raisin",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(vigneron.pos.traitement.position.x, vigneron.pos.traitement.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Transformation raisin",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(vigneron.pos.transformation.position.x, vigneron.pos.transformation.position.y)
                    end
                end)

                RageUI.ButtonWithStyle("Vente vin",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        SetNewWaypoint(vigneron.pos.vente.position.x, vigneron.pos.vente.position.y)
                    end
                end)
            end
            end, function() 
            end)

                if not RageUI.Visible(Vigneronf6) then
                    Vigneronf6 = RMenu:DeleteType("Vigneronf6", true)
        end
    end
end


Keys.Register('F6', 'Vigneron', 'Ouvrir le menu Vigneron', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
    	Menuf6Vigneron()
	end
end)




function Coffrevigneron()
    local Cvigneron = RageUI.CreateMenu("Coffre", "Vigneron")
        RageUI.Visible(Cvigneron, not RageUI.Visible(Cvigneron))
            while Cvigneron do
            Wait(0)
            RageUI.IsVisible(Cvigneron, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VigneronRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            VigneronDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Vigneron",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenuevigneron()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_vigneron()
                            RageUI.CloseAll()
                        end
                    end)

                end, function()
                end)
            if not RageUI.Visible(Cvigneron) then
            Cvigneron = RMenu:DeleteType("Cvigneron", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, vigneron.pos.coffre.position.x, vigneron.pos.coffre.position.y, vigneron.pos.coffre.position.z)
            if jobdist <= 10.0 and vigneron.jeveuxmarker then
                Timer = 0
                DrawMarker(20, vigneron.pos.coffre.position.x, vigneron.pos.coffre.position.y, vigneron.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 3, 200, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrevigneron()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


function Garagevigneron()
    local Gvigneron = RageUI.CreateMenu("Garage", "Vigneron")
      RageUI.Visible(Gvigneron, not RageUI.Visible(Gvigneron))
          while Gvigneron do
              Wait(0)
                  RageUI.IsVisible(Gvigneron, true, true, true, function()
                      RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then   
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              RageUI.CloseAll()
                              end 
                          end
                      end) 
  
                      for k,v in pairs(Gvigneronvoiture) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Wait(1)  
                              spawnuniCarvigneron(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(Gvigneron) then
              Gvigneron = RMenu:DeleteType("Garage", true)
          end
      end
  end
  
  CreateThread(function()
          while true do
              local Timer = 500
              if ESX.PlayerData.job and ESX.PlayerData.job.name == 'vigneron' then
              local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
              local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, vigneron.pos.garage.position.x, vigneron.pos.garage.position.y, vigneron.pos.garage.position.z)
              if dist3 <= 10.0 and vigneron.jeveuxmarker then
                  Timer = 0
                  DrawMarker(20, vigneron.pos.garage.position.x, vigneron.pos.garage.position.y, vigneron.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 3, 200, 255, 0, 1, 2, 0, nil, nil, 0)
                  end
                  if dist3 <= 3.0 then
                  Timer = 0   
                      RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                      if IsControlJustPressed(1,51) then           
                          Garagevigneron()
                      end   
                  end
              end 
          Wait(Timer)
       end
  end)
  
  function spawnuniCarvigneron(car)
      local car = GetHashKey(car)
  
      RequestModel(car)
      while not HasModelLoaded(car) do
          RequestModel(car)
          Wait(0)
      end
  
      local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
      local vehicle = CreateVehicle(car, vigneron.pos.spawnvoiture.position.x, vigneron.pos.spawnvoiture.position.y, vigneron.pos.spawnvoiture.position.z, vigneron.pos.spawnvoiture.position.h, true, false)
      SetEntityAsMissionEntity(vehicle, true, true)
      local plaque = "vigneron"..math.random(1,9)
      SetVehicleNumberPlateText(vehicle, plaque) 
      SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
  end



function tenuevigneron()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = vigneron.Uniforms.male
        else
            uniformObject = vigneron.Uniforms.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end


function vcivil_vigneron()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
       end)
    end

itemstock = {}
function VigneronRetirerobjet()
    local StockVigneron = RageUI.CreateMenu("Coffre", "Vigneron")
    ESX.TriggerServerCallback('vigneron:getStockItems', function(items) 
    itemstock = items
    RageUI.Visible(StockVigneron, not RageUI.Visible(StockVigneron))
        while StockVigneron do
            Wait(0)
                RageUI.IsVisible(StockVigneron, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('vigneron:getStockItem', v.name, tonumber(count))
                                    VigneronRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockVigneron) then
            StockVigneron = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function VigneronDeposerobjet()
    local DepositVigneron = RageUI.CreateMenu("Coffre", "Vigneron")
    ESX.TriggerServerCallback('vigneron:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositVigneron, not RageUI.Visible(DepositVigneron))
    while DepositVigneron do
        Wait(0)
            RageUI.IsVisible(DepositVigneron, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                            local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('vigneron:putStockItems', item.name, tonumber(count))
                                            VigneronDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositVigneron) then
                DepositVigneron = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end