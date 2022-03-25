local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
isInShopMenu = false

local appellist = {}

function defESX()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end

CreateThread(function()
    defESX()
end)

local function getInfoReport()
    local info = {}
    ESX.TriggerServerCallback('fAmbulance:infoReport', function(info)
        appellist = info
    end)
end

CreateThread(function()
    if Ambulance.jeveuxblips then
        local ambulancemap = AddBlipForCoord(Ambulance.menu.blips.position.x, Ambulance.menu.blips.position.y, Ambulance.menu.blips.position.z)
    
        SetBlipSprite(ambulancemap, 61)
        SetBlipColour(ambulancemap, 6)
        SetBlipScale(ambulancemap, 0.80)
        SetBlipAsShortRange(ambulancemap, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Hôpital")
        EndTextCommandSetBlipName(ambulancemap)
    end
    end)

function F6Ambulance()
    local fAmbulancef6 = RageUI.CreateMenu("Ambulance", "Interactions")
    local fAmbulancef6Sub = RageUI.CreateSubMenu(fAmbulancef6, "Ambulance", "Interactions")
    local fAmbulancef6Annonces = RageUI.CreateSubMenu(fAmbulancef6, "Ambulance", "Annonces")
    local fAmbulanceappel = RageUI.CreateSubMenu(fAmbulancef6, "Appel EMS", "Interactions")
    local fAmbulanceappelinfo = RageUI.CreateSubMenu(fAmbulanceappel, "Appel EMS Info", "Interactions")
	fAmbulancef6:SetRectangleBanner(220,20, 60)
    fAmbulancef6Sub:SetRectangleBanner(220,20, 60)
    fAmbulancef6Annonces:SetRectangleBanner(220,20, 60)
    fAmbulanceappel:SetRectangleBanner(220,20, 60)
    fAmbulanceappelinfo:SetRectangleBanner(220,20, 60)
    getInfoReport()
    defESX()
    RageUI.Visible(fAmbulancef6, not RageUI.Visible(fAmbulancef6))
    while fAmbulancef6 do
        Wait(0)
            RageUI.IsVisible(fAmbulancef6, true, true, true, function()

                RageUI.Separator("~u~"..ESX.PlayerData.job.grade_label.." - "..GetPlayerName(PlayerId()))

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_ambulance', ('Ambulance'), montant)
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

				RageUI.ButtonWithStyle("Intéraction Citoyens", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                end, fAmbulancef6Sub)

                RageUI.Separator("")

                RageUI.ButtonWithStyle("Intéraction Appels", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                end, fAmbulanceappel)

                RageUI.Separator("")

                RageUI.ButtonWithStyle("Annonces", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                end, fAmbulancef6Annonces)

            end, function() 
            end)

                RageUI.IsVisible(fAmbulancef6Sub, true, true, true, function()

                    RageUI.ButtonWithStyle("Réanimer la Personne", nil, { RightBadge = RageUI.BadgeStyle.Heart },true, function(Hovered, Active, Selected)
                        if Selected then 
                            ESX.TriggerServerCallback("fAmbulance:checkitem", function(haveitem)
                                if haveitem then
                                    Canrevive = true
                                end
                            end, "medikit")
                    
                            if Canrevive then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestPlayer == -1 or closestDistance > 1.0 then
                                    ESX.ShowNotification('Aucune Personne à Proximité')
                                else
                                    TriggerServerEvent("fAmbulance:delitem", "medikit")
                                    revivePlayer(closestPlayer) 
                                end
                            else
                                ESX.ShowNotification('Vous n\'avez pas de ~r~kit médical')
                            end
                    
                        end
                    end)
	
                    RageUI.ButtonWithStyle("Soigner une petite blessure", nil, { RightBadge = RageUI.BadgeStyle.Heart },true, function(Hovered, Active, Selected)
                        if (Selected) then 
                    
                            ESX.TriggerServerCallback("fAmbulance:checkitem", function(haveitem)
                                if haveitem then
                                    Cansmallheal = true
                                end
                            end, "compresse")
                    
                            if Cansmallheal then
                    
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestPlayer == -1 or closestDistance > 1.0 then
                                    ESX.ShowNotification('Aucune Personne à Proximité')
                                else
                                            local closestPlayerPed = GetPlayerPed(closestPlayer)
                                            local health = GetEntityHealth(closestPlayerPed)
                    
                                            if health > 0 then
                                                local playerPed = PlayerPedId()
                                                TriggerServerEvent("fAmbulance:delitem", "compresse")
                    
                                                ESX.ShowNotification('Vous soignez...')
                                                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                                Wait(10000)
                                                ClearPedTasks(playerPed)
                    
                                                TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
                                                TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
                                                ESX.ShowNotification("Vous avez soigné ~r~"..GetPlayerName(closestPlayer))
                                            else
                                                ESX.ShowNotification('Cette personne est inconsciente!')
                                            end
                                end
                            else
                                ESX.ShowNotification('Vous n\'avez pas de ~r~compresse')
                            end
                        end
                    end)
	
                    RageUI.ButtonWithStyle("Soigner une plus grande blessure", nil, { RightBadge = RageUI.BadgeStyle.Heart },true, function(Hovered, Active, Selected)
                        if (Selected) then 
                    
                            ESX.TriggerServerCallback("fAmbulance:checkitem", function(haveitem)
                                if haveitem then
                                    Canheal = true
                                end
                            end, "bandage")
                    
                            if Canheal then
                    
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestPlayer == -1 or closestDistance > 1.0 then
                                    ESX.ShowNotification('Aucune Personne à Proximité')
                                else
                                            local closestPlayerPed = GetPlayerPed(closestPlayer)
                                            local health = GetEntityHealth(closestPlayerPed)
                    
                                            if health > 0 then
                                                local playerPed = PlayerPedId()
                                                TriggerServerEvent("fAmbulance:delitem", "bandage")
                    
                                                ESX.ShowNotification('vous soignez...')
                                                TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                                                Wait(10000)
                                                ClearPedTasks(playerPed)
                    
                                                TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
                                                ESX.ShowNotification("Vous avez soigné ~r~"..GetPlayerName(closestPlayer))
                                            else
                                                ESX.ShowNotification('Cette personne est inconsciente!')
                                            end
                                end
                            else
                                ESX.ShowNotification('Vous n\'avez pas de ~r~bandage')
                            end
                        end
                    end)
                    
                    end, function() 
                    end)

            RageUI.IsVisible(fAmbulancef6Annonces, true, true, true, function()

                RageUI.ButtonWithStyle("Disponible",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                      TriggerServerEvent('AmbulanceDispo')
                    end
                  end)
              
                  RageUI.ButtonWithStyle("Indisponible",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                      TriggerServerEvent('AmbulancePasDispo')
                    end
                  end)
              
                  RageUI.ButtonWithStyle("Recrutement",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                      TriggerServerEvent('AmbulanceRecrutement')
                    end
                  end)

                end, function() 
                end)
    
                RageUI.IsVisible(fAmbulanceappel, true, true, true, function()
                    if #appellist >= 1 then
                        RageUI.Separator("↓ Nouvelle Appel ↓")

                        for k,v in pairs(appellist) do
                            RageUI.ButtonWithStyle(k.." - Patient [~o~"..v.nom.."~s~] | Id : [~p~"..v.id.."~s~]", nil, {RightLabel = "→→"},true , function(_,_,s)
                                if s then
                                    nom = v.nom
                                    nbreport = k
                                    id = v.id
                                    raison = v.args
                                    gps = v.gps
                                end
                            end, fAmbulanceappelinfo)
                        end
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~o~Aucune Appel~s~")
                        RageUI.Separator("")
                    end
                    
                end, function() 
                end)

                RageUI.IsVisible(fAmbulanceappelinfo, true, true, true, function()

                    RageUI.Separator("Appel numéro : ~o~"..nbreport)
                    RageUI.Separator("Patient : ~o~"..nom.."~s~ [~o~"..id.."~s~]")
                    RageUI.Separator("Raison de Appel : ~o~"..raison)

                    RageUI.ButtonWithStyle("Avoir les coordonnées GPS", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            SetNewWaypoint(gps.x, gps.y)
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Supprime l'appel", nil, {RightLabel = "→→"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent('fAmbulance:CloseReport',nom, raison)
                            RageUI.CloseAll()
                        end
                    end)

                end, function() 
                end)

                if not RageUI.Visible(fAmbulancef6) and not RageUI.Visible(fAmbulancef6Sub) and not RageUI.Visible(fAmbulancef6Annonces) and not RageUI.Visible(fAmbulanceappel) and not RageUI.Visible(fAmbulanceappelinfo) then
                    fAmbulancef6 = RMenu:DeleteType("Ambulance", true)
        end
    end
end

Keys.Register('F6', 'Ambulance', 'Ouvrir le menu ambulance', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
    	F6Ambulance()
	end
end)

function GarageAmbulance()
	local GAmbulance = RageUI.CreateMenu("Garage", "Ambulance")
	GAmbulance:SetRectangleBanner(220,20, 60)
	  RageUI.Visible(GAmbulance, not RageUI.Visible(GAmbulance))
		  while GAmbulance do
			  Wait(0)
				  RageUI.IsVisible(GAmbulance, true, true, true, function()
					  RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
						  if (Selected) then   
						  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
						  if dist4 < 4 then
							  DeleteEntity(veh)
							  RageUI.CloseAll()
							  end 
						  end
					  end) 
  
					  for k,v in pairs(GAmbulancevoiture) do
					  RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
						  if (Selected) then
						  Wait(1)  
							  spawnuniCarAmbulance(v.modele)
							  RageUI.CloseAll()
							  end
						  end)
					  end
				  end, function()
				  end)
			  if not RageUI.Visible(GAmbulance) then
			  GAmbulance = RMenu:DeleteType("GAmbulance", true)
		  end
	  end
  end
  
CreateThread(function()
		while true do
			local Timer = 500
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
			local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Ambulance.menu.garage.position.x, Ambulance.menu.garage.position.y, Ambulance.menu.garage.position.z)
			if dist3 <= 10.0 and Ambulance.jeveuxmarker then
				Timer = 0
				DrawMarker(20, Ambulance.menu.garage.position.x, Ambulance.menu.garage.position.y, Ambulance.menu.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 220, 20, 60, 255, 0, 1, 2, 0, nil, nil, 0)
				end
				if dist3 <= 3.0 then
				Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au garage", time_display = 1 })
					if IsControlJustPressed(1,51) then           
						GarageAmbulance()
					end   
				end
			end 
		Wait(Timer)
	end
end)

function spawnuniCarAmbulance(car)
	local car = GetHashKey(car)

	RequestModel(car)
	while not HasModelLoaded(car) do
		RequestModel(car)
		Wait(0)
	end

	local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
	local vehicle = CreateVehicle(car, Ambulance.menu.spawnvoiture.position.x, Ambulance.menu.spawnvoiture.position.y, Ambulance.menu.spawnvoiture.position.z, Ambulance.menu.spawnvoiture.position.h, true, false)
	SetEntityAsMissionEntity(vehicle, true, true)
	local plaque = "Ambulance"..math.random(1,9)
	SetVehicleNumberPlateText(vehicle, plaque) 
	SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

  function CoffreAmbulance()
    local CAmbulance = RageUI.CreateMenu("Coffre", "Ambulance")
	CAmbulance:SetRectangleBanner(220,20, 60)
        RageUI.Visible(CAmbulance, not RageUI.Visible(CAmbulance))
            while CAmbulance do
            Wait(0)
            RageUI.IsVisible(CAmbulance, true, true, true, function()

                RageUI.Separator("~u~↓ Objet ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            AmbulanceRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            AmbulanceDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(CAmbulance) then
            CAmbulance = RMenu:DeleteType("CAmbulance", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Ambulance.menu.coffre.position.x, Ambulance.menu.coffre.position.y, Ambulance.menu.coffre.position.z)
            if jobdist <= 10.0 and Ambulance.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Ambulance.menu.coffre.position.x, Ambulance.menu.coffre.position.y, Ambulance.menu.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 220, 20, 60, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreAmbulance()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

function VestiaireAmbulance()
    local VAmbulance = RageUI.CreateMenu("Coffre", "Ambulance")
    VAmbulance:SetRectangleBanner(220,20, 60)
        RageUI.Visible(VAmbulance, not RageUI.Visible(VAmbulance))
            while VAmbulance do
            Wait(0)
            RageUI.IsVisible(VAmbulance, true, true, true, function()

                RageUI.Separator("~u~↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Uniforme",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformeambulance()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_ems()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(VAmbulance) then
            VAmbulance = RMenu:DeleteType("VAmbulance", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Ambulance.menu.vestiaire.position.x, Ambulance.menu.vestiaire.position.y, Ambulance.menu.vestiaire.position.z)
            if jobdist <= 10.0 and Ambulance.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Ambulance.menu.vestiaire.position.x, Ambulance.menu.vestiaire.position.y, Ambulance.menu.vestiaire.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 220, 20, 60, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder au vestiaire", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        VestiaireAmbulance()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

function PharmacieAmbulance()
    local PhAmbulance = RageUI.CreateMenu("Pharmacie", "Ambulance")
    PhAmbulance:SetRectangleBanner(220,20, 60)
        RageUI.Visible(PhAmbulance, not RageUI.Visible(PhAmbulance))
            while PhAmbulance do
            Wait(0)
            RageUI.IsVisible(PhAmbulance, true, true, true, function()

                    RageUI.ButtonWithStyle("Kit médical",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('fAmbulance:BuyKit')
                        end
                    end)

                    RageUI.ButtonWithStyle("Bandage",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('fAmbulance:BuyBandage')
                        end
                    end)

                    RageUI.ButtonWithStyle("Compresse",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('fAmbulance:BuyCompresse')
                        end
                    end)

                end, function()
                end)
            if not RageUI.Visible(PhAmbulance) then
                PhAmbulance = RMenu:DeleteType("PhAmbulance", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Ambulance.menu.pharmacie.position.x, Ambulance.menu.pharmacie.position.y, Ambulance.menu.pharmacie.position.z)
            if jobdist <= 10.0 and Ambulance.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Ambulance.menu.pharmacie.position.x, Ambulance.menu.pharmacie.position.y, Ambulance.menu.pharmacie.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 220, 20, 60, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~r~[E]~s~ pour accéder à la pharmacie", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                            PharmacieAmbulance()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

itemstock = {}
function AmbulanceRetirerobjet()
    local Stockbennys = RageUI.CreateMenu("Coffre", "Ambulance")
    Stockbennys:SetRectangleBanner(220,20, 60)
    ESX.TriggerServerCallback('fAmbulance:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockbennys, not RageUI.Visible(Stockbennys))
        while Stockbennys do
            Wait(0)
                RageUI.IsVisible(Stockbennys, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('fAmbulance:getStockItem', v.name, tonumber(count))
                                    AmbulanceRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockbennys) then
            Stockbennys = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function AmbulanceDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Ambulance")
    StockPlayer:SetRectangleBanner(220,20, 60)
    ESX.TriggerServerCallback('fAmbulance:getPlayerInventory', function(inventory)
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
                                            TriggerServerEvent('fAmbulance:putStockItems', item.name, tonumber(count))
                                            AmbulanceDeposerobjet()
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

function revivePlayer(closestPlayer)

			local closestPlayerPed = GetPlayerPed(closestPlayer)

			if IsPedDeadOrDying(closestPlayerPed, 1) then
				local playerPed = PlayerPedId()
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				ESX.ShowNotification('Réanimation en cours')

				for i=1, 15 do
					Wait(900)

					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
					end)
				end

				TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification('N\'est pas inconscient')
			end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification('Vous avez été soigné.')
	end
end)

function vuniformeambulance()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = Ambulance.tenue.male
        else
            uniformObject = Ambulance.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_ems()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end

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