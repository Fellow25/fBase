local HasAlreadyEnteredMarker, OnJob, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, IsDead, CurrentActionData = false, false, false, false, false, false, {}
local CurrentCustomer, CurrentCustomerBlip, DestinationBlip, targetCoords, LastZone, CurrentAction, CurrentActionMsg

function DrawSub(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, 1)
end

function ShowLoadingPromt(msg, time, type)
	CreateThread(function()
		Wait(0)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName(msg)
		EndTextCommandBusyspinnerOn(type)
		Wait(time)

		BusyspinnerOff()
	end)
end

function GetRandomWalkingNPC()
	local search = {}
	local peds   = ESX.Game.GetPeds()

	for i=1, #peds, 1 do
		if IsPedHuman(peds[i]) and IsPedWalking(peds[i]) and not IsPedAPlayer(peds[i]) then
			table.insert(search, peds[i])
		end
	end

	if #search > 0 then
		return search[GetRandomIntInRange(1, #search)]
	end

	for i=1, 250, 1 do
		local ped = GetRandomPedAtCoord(0.0, 0.0, 0.0, math.huge + 0.0, math.huge + 0.0, math.huge + 0.0, 26)

		if DoesEntityExist(ped) and IsPedHuman(ped) and IsPedWalking(ped) and not IsPedAPlayer(ped) then
			table.insert(search, ped)
		end
	end

	if #search > 0 then
		return search[GetRandomIntInRange(1, #search)]
	end
end

function ClearCurrentMission()
	if DoesBlipExist(CurrentCustomerBlip) then
		RemoveBlip(CurrentCustomerBlip)
	end

	if DoesBlipExist(DestinationBlip) then
		RemoveBlip(DestinationBlip)
	end

	CurrentCustomer           = nil
	CurrentCustomerBlip       = nil
	DestinationBlip           = nil
	IsNearCustomer            = false
	CustomerIsEnteringVehicle = false
	CustomerEnteredVehicle    = false
	targetCoords              = nil
end

function StartTaxiJob()
	ShowLoadingPromt(('prise de service : Taxi/Uber'), 5000, 3)
	ClearCurrentMission()

	OnJob = true
end

function StopTaxiJob()
	local playerPed = PlayerPedId()

	if IsPedInAnyVehicle(playerPed, false) and CurrentCustomer ~= nil then
		local vehicle = GetVehiclePedIsIn(playerPed,  false)
		TaskLeaveVehicle(CurrentCustomer,  vehicle,  0)

		if CustomerEnteredVehicle then
			TaskGoStraightToCoord(CurrentCustomer,  targetCoords.x,  targetCoords.y,  targetCoords.z,  1.0,  -1,  0.0,  0.0)
		end
	end

	ClearCurrentMission()
	OnJob = false
	DrawSub(('Mission terminée'), 5000)
end

--Menu F6
function Menuf6Taxi()
    local fTaxif6 = RageUI.CreateMenu("Taxi", "Interactions")
    RageUI.Visible(fTaxif6, not RageUI.Visible(fTaxif6))
    while fTaxif6 do
        Wait(0)
            RageUI.IsVisible(fTaxif6, true, true, true, function()

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_taxi', ('Taxi'), montant)
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

				RageUI.ButtonWithStyle("Start/Stop missions taxi",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if Selected then
						if OnJob then
							StopTaxiJob()
						else
							if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'taxi' then
								local playerPed = PlayerPedId()
								local vehicle   = GetVehiclePedIsIn(playerPed, false)
			
								if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
									if tonumber(ESX.PlayerData.job.grade) >= 3 then
										StartTaxiJob()
									else
										if IsInAuthorizedVehicle() then
											StartTaxiJob()
										else
											RageUI.Popup({
												message = "Tu dois être dans un taxi !"})
										end
									end
								else
									if tonumber(ESX.PlayerData.job.grade) >= 3 then
										ESX.ShowNotification('vous devez être dans un véhicule pour commencer la mission')
									else
										RageUI.Popup({
											message = "Tu dois être dans un taxi !"})
									end
								end
							end
						end
					end
				end)

                RageUI.Separator("↓ Annonce ↓")



                RageUI.ButtonWithStyle("Annonces d'ouverture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then       
                        TriggerServerEvent('fTaxi:Ouvert')
                    end
                end)
        
                RageUI.ButtonWithStyle("Annonces de fermeture",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then      
                        TriggerServerEvent('fTaxi:Fermer')
                    end
                end)
        
                RageUI.ButtonWithStyle("Recrutement",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                      TriggerServerEvent('fTaxi:Recrute')
                    end
                  end)
                end, function() 
                end)
    
                if not RageUI.Visible(fTaxif6) then
                    fTaxif6 = RMenu:DeleteType("Ammu-Nation", true)
        end
    end
end

Keys.Register('F6', 'Taxi', 'Ouvrir le menu Taxi', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' then
    	Menuf6Taxi()
	end
end)

--Garage
function GarageTaxi()
	local GTaxi = RageUI.CreateMenu("Garage", "Taxi")
	  RageUI.Visible(GTaxi, not RageUI.Visible(GTaxi))
		  while GTaxi do
			  Wait(0)
				  RageUI.IsVisible(GTaxi, true, true, true, function()
					  RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
						  if (Selected) then   
						  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
						  if dist4 < 4 then
							  DeleteEntity(veh)
							  RageUI.CloseAll()
							  end 
						  end
					  end) 
  
					  for k,v in pairs(fTaxi.AuthorizedVehicles) do
					  RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
						  if (Selected) then
						  Wait(1)  
							  spawnuniCaTaxi(v.model)
							  RageUI.CloseAll()
							  end
						  end)
					  end
				  end, function()
				  end)
			  if not RageUI.Visible(GTaxi) then
			  GTaxi = RMenu:DeleteType("GTaxi", true)
		  end
	  end
  end
  
  CreateThread(function()
		  while true do
			  local Timer = 500
			  if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'taxi' then 
			  local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
			  local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, fTaxi.pos.garage.position.x, fTaxi.pos.garage.position.y, fTaxi.pos.garage.position.z)
			  if dist3 <= 10.0 and fTaxi.jeveuxmarker then
				  Timer = 0
				  DrawMarker(20, fTaxi.pos.garage.position.x, fTaxi.pos.garage.position.y, fTaxi.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
				  end
				  if dist3 <= 3.0 then
				  Timer = 0   
					  RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
					  if IsControlJustPressed(1,51) then           
						  GarageTaxi()
					  end   
				  end
			  end 
		  Wait(Timer)
	   end
  end)
  
  function spawnuniCaTaxi(car)
	  local car = GetHashKey(car)
  
	  RequestModel(car)
	  while not HasModelLoaded(car) do
		  RequestModel(car)
		  Wait(0)
	  end
  
	  local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
	  local vehicle = CreateVehicle(car, fTaxi.pos.spawnvoiture.position.x, fTaxi.pos.spawnvoiture.position.y, fTaxi.pos.spawnvoiture.position.z, fTaxi.pos.spawnvoiture.position.h, true, false)
	  SetEntityAsMissionEntity(vehicle, true, true)
	  local plaque = "TAXI"..math.random(1,9)
	  SetVehicleNumberPlateText(vehicle, plaque) 
	  SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
	  SetVehicleCustomPrimaryColour(vehicle, 255, 255, 0)
	  SetVehicleCustomSecondaryColour(vehicle, 255, 255, 0)
	  SetVehicleMaxMods(vehicle)
  end
  
  function SetVehicleMaxMods(vehicle)
  
	  local props = {
		modEngine       = 2,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 3,
		modTurbo        = true,
	  }
	
	  ESX.Game.SetVehicleProperties(vehicle, props)
	
	end

function IsInAuthorizedVehicle()
	local playerPed = PlayerPedId()
	local vehModel  = GetEntityModel(GetVehiclePedIsIn(playerPed, false))

	for i=1, #fTaxi.AuthorizedVehicles, 1 do
		if vehModel == GetHashKey(fTaxi.AuthorizedVehicles[i].model) then
			return true
		end
	end
	
	return false
end

--Coffre
function CoffreTaxi()
	local CTaxi = RageUI.CreateMenu("Coffre", "Taxi")
        RageUI.Visible(CTaxi, not RageUI.Visible(CTaxi))
            while CTaxi do
            Wait(0)
            RageUI.IsVisible(CTaxi, true, true, true, function()

                RageUI.Separator("↓ Objet ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TaxiRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TaxiDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Chauffeur de taxi",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformetaxi()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_taxi()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(CTaxi) then
            CTaxi = RMenu:DeleteType("CTaxi", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'taxi' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'taxi' then  
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, fTaxi.pos.coffre.position.x, fTaxi.pos.coffre.position.y, fTaxi.pos.coffre.position.z)
            if jobdist <= 10.0 and fTaxi.jeveuxmarker then
                Timer = 0
                DrawMarker(20, fTaxi.pos.coffre.position.x, fTaxi.pos.coffre.position.y, fTaxi.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreTaxi()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)

itemstock = {}
function TaxiRetirerobjet()
	local StockTaxi = RageUI.CreateMenu("Coffre", "Taxi")
	ESX.TriggerServerCallback('taxi:getStockItems', function(items) 
	itemstock = items
	RageUI.Visible(StockTaxi, not RageUI.Visible(StockTaxi))
        while StockTaxi do
		    Wait(0)
		        RageUI.IsVisible(StockTaxi, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('taxi:getStockItem', v.name, tonumber(count))
                                    TaxiRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(StockTaxi) then
            StockTaxi = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function TaxiDeposerobjet()
    local DepositTaxi = RageUI.CreateMenu("Coffre", "Taxi")
    ESX.TriggerServerCallback('taxi:getPlayerInventory', function(inventory)
        RageUI.Visible(DepositTaxi, not RageUI.Visible(DepositTaxi))
    while DepositTaxi do
        Wait(0)
            RageUI.IsVisible(DepositTaxi, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('taxi:putStockItems', item.name, tonumber(count))
                                            TaxiDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(DepositTaxi) then
                DepositTaxi = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

function vuniformetaxi()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = fTaxi.tenue.male
        else
            uniformObject = fTaxi.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_taxi()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = ('taxi'),
		number     = 'taxi',
		base64Icon = 'data:image/png;base64,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',
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Create Blips
CreateThread(function()
	if fTaxi.jeveuxblips then
	local blip = AddBlipForCoord(fTaxi.pos.blip.position.x, fTaxi.pos.blip.position.y, fTaxi.pos.blip.position.z)

	SetBlipSprite (blip, 198)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Taxi')
	EndTextCommandSetBlipName(blip)
	end
end)

-- Taxi Job
CreateThread(function()
	while true do

		Wait(0)
		local playerPed = PlayerPedId()

		if OnJob then
			if CurrentCustomer == nil then
				DrawSub(('conduisez à la recherche de ~y~passagers'), 5000)

				if IsPedInAnyVehicle(playerPed, false) and GetEntitySpeed(playerPed) > 0 then
					local waitUntil = GetGameTimer() + GetRandomIntInRange(30000, 45000)

					while OnJob and waitUntil > GetGameTimer() do
						Wait(0)
					end

					if OnJob and IsPedInAnyVehicle(playerPed, false) and GetEntitySpeed(playerPed) > 0 then
						CurrentCustomer = GetRandomWalkingNPC()

						if CurrentCustomer ~= nil then
							CurrentCustomerBlip = AddBlipForEntity(CurrentCustomer)

							SetBlipAsFriendly(CurrentCustomerBlip, true)
							SetBlipColour(CurrentCustomerBlip, 2)
							SetBlipCategory(CurrentCustomerBlip, 3)
							SetBlipRoute(CurrentCustomerBlip, true)

							SetEntityAsMissionEntity(CurrentCustomer, true, false)
							ClearPedTasksImmediately(CurrentCustomer)
							SetBlockingOfNonTemporaryEvents(CurrentCustomer, true)

							local standTime = GetRandomIntInRange(60000, 180000)
							TaskStandStill(CurrentCustomer, standTime)

							ESX.ShowNotification('vous avez ~g~trouvé~s~ un client, conduisez jusqu\'à ce dernier')
						end
					end
				end
			else
				if IsPedFatallyInjured(CurrentCustomer) then
					ESX.ShowNotification('votre client est ~r~inconscient~s~. Cherchez-en un autre.')

					if DoesBlipExist(CurrentCustomerBlip) then
						RemoveBlip(CurrentCustomerBlip)
					end

					if DoesBlipExist(DestinationBlip) then
						RemoveBlip(DestinationBlip)
					end

					SetEntityAsMissionEntity(CurrentCustomer, false, true)

					CurrentCustomer, CurrentCustomerBlip, DestinationBlip, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, targetCoords = nil, nil, nil, false, false, false, nil
				end

				if IsPedInAnyVehicle(playerPed, false) then
					local vehicle          = GetVehiclePedIsIn(playerPed, false)
					local playerCoords     = GetEntityCoords(playerPed)
					local customerCoords   = GetEntityCoords(CurrentCustomer)
					local customerDistance = #(playerCoords - customerCoords)

					if IsPedSittingInVehicle(CurrentCustomer, vehicle) then
						if CustomerEnteredVehicle then
							local targetDistance = #(playerCoords - targetCoords)

							if targetDistance <= 10.0 then
								TaskLeaveVehicle(CurrentCustomer, vehicle, 0)

								ESX.ShowNotification('vous êtes ~g~arrivé~s~ à destination')

								TaskGoStraightToCoord(CurrentCustomer, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
								SetEntityAsMissionEntity(CurrentCustomer, false, true)
								TriggerServerEvent('esx_taxijob:success')
								RemoveBlip(DestinationBlip)

								local scope = function(customer)
									ESX.SetTimeout(60000, function()
										DeletePed(customer)
									end)
								end

								scope(CurrentCustomer)

								CurrentCustomer, CurrentCustomerBlip, DestinationBlip, IsNearCustomer, CustomerIsEnteringVehicle, CustomerEnteredVehicle, targetCoords = nil, nil, nil, false, false, false, nil
							end

							if targetCoords then
								DrawMarker(36, targetCoords.x, targetCoords.y, targetCoords.z + 1.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 234, 223, 72, 155, false, false, 2, true, nil, nil, false)
							end
						else
							RemoveBlip(CurrentCustomerBlip)
							CurrentCustomerBlip = nil
							targetCoords = fTaxi.JobLocations[GetRandomIntInRange(1, #fTaxi.JobLocations)]
							local distance = #(playerCoords - targetCoords)
							while distance < fTaxi.MinimumDistance do
								Wait(5)

								targetCoords = fTaxi.JobLocations[GetRandomIntInRange(1, #fTaxi.JobLocations)]
								distance = #(playerCoords - targetCoords)
							end

							local street = table.pack(GetStreetNameAtCoord(targetCoords.x, targetCoords.y, targetCoords.z))
							local msg    = nil

							if street[2] ~= 0 and street[2] ~= nil then
								msg = ('~s~Emmenez-moi à~y~ %s~s~, près de~y~ %s'):format(GetStreetNameFromHashKey(street[1]), GetStreetNameFromHashKey(street[2]))
							else
								msg = ('~s~Emmenez-moi à~y~ %s'):format(GetStreetNameFromHashKey(street[1]))
							end

							ESX.ShowNotification(msg)

							DestinationBlip = AddBlipForCoord(targetCoords.x, targetCoords.y, targetCoords.z)

							BeginTextCommandSetBlipName('STRING')
							AddTextComponentSubstringPlayerName('Destination')
							EndTextCommandSetBlipName(blip)
							SetBlipRoute(DestinationBlip, true)

							CustomerEnteredVehicle = true
						end
					else
						DrawMarker(36, customerCoords.x, customerCoords.y, customerCoords.z + 1.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 234, 223, 72, 155, false, false, 2, true, nil, nil, false)

						if not CustomerEnteredVehicle then
							if customerDistance <= 40.0 then

								if not IsNearCustomer then
									ESX.ShowNotification('vous êtes à proximité du client, approchez-vous de lui')
									IsNearCustomer = true
								end

							end

							if customerDistance <= 20.0 then
								if not CustomerIsEnteringVehicle then
									ClearPedTasksImmediately(CurrentCustomer)

									local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

									for i=maxSeats - 1, 0, -1 do
										if IsVehicleSeatFree(vehicle, i) then
											freeSeat = i
											break
										end
									end

									if freeSeat then
										TaskEnterVehicle(CurrentCustomer, vehicle, -1, freeSeat, 2.0, 0)
										CustomerIsEnteringVehicle = true
									end
								end
							end
						end
					end
				else
					DrawSub(('veuillez remonter dans votre véhicule pour continuer la mission'), 5000)
				end
			end
		else
			Wait(500)
		end
	end
end)

CreateThread(function()
	while onJob do
		Wait(10000)
		if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade < 3 then
			if not IsInAuthorizedVehicle() then
				ClearCurrentMission()
				OnJob = false
				ESX.ShowNotification('veuillez remonter dans votre véhicule pour continuer la mission')
			end
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	IsDead = false
end)