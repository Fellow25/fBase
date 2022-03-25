ESX = nil


CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(100)
	end
end)


fellowgarage = {
    listevoiture = {},
}


--blip garage
CreateThread(function()
     for k,v in pairs(garagepublic.zone) do
        local blip = AddBlipForCoord(v.sortie.x, v.sortie.y, v.sortie.z)
        SetBlipSprite(blip, 290)
        SetBlipColour(blip, 49)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.65)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Garage")
        EndTextCommandSetBlipName(blip)
    end
end)

--sortir véhicule
function ouvrirpublicgar()
    local OuvrirGarage = RageUI.CreateMenu("Garage", "Public")
      RageUI.Visible(OuvrirGarage, not RageUI.Visible(OuvrirGarage))
          while OuvrirGarage do
              Wait(0)
                RageUI.IsVisible(OuvrirGarage, true, true, true, function()
                    for i = 1, #fellowgarage.listevoiture, 1 do
                    local hashvoiture = fellowgarage.listevoiture[i].vehicle.model
                    local modelevoiturespawn = fellowgarage.listevoiture[i].vehicle
                    local nomvoituremodele = GetDisplayNameFromVehicleModel(hashvoiture)
                    local nomvoituretexte  = GetLabelText(nomvoituremodele)
                    local plaque = fellowgarage.listevoiture[i].plate
                RageUI.ButtonWithStyle(plaque.." | "..nomvoituretexte, "Pour sortir votre véhicule", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then   
                	    sortirvoitures(modelevoiturespawn, plaque)
                	    RageUI.CloseAll()
                        publicgarage = false
                    end
                end)
            end

        end, function()
        end)
        if not RageUI.Visible(OuvrirGarage) then
            OuvrirGarage = RMenu:DeleteType("OuvrirGarage", true)
        end
    end
end
----------------------------------
-- faire spawn voiture
function sortirvoitures(vehicle, plate)
	x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = x,
		y = y,
		z = z 
	}, GetEntityHeading(PlayerPedId()), function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
	end)

	TriggerServerEvent('fellow_garage:etatvehiculesortie', plate, false)
end

--ranger voiture
function rangervoiture()
    local playerPed  = PlayerPedId()
    if IsPedInAnyVehicle(playerPed,  false) then
        local playerPed    = PlayerPedId()
        local coords       = GetEntityCoords(playerPed)
        local vehicle      = GetVehiclePedIsIn(playerPed, false)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        local current        = GetPlayersLastVehicle(PlayerPedId(), true)
        local engineHealth = GetVehicleEngineHealth(current)
        local plate        = vehicleProps.plate
        local valid2       = false

        ESX.TriggerServerCallback('fellow_garage:rangervoiture', function(valid)
            if engineHealth < 990 then
                valid2 = true
                    ESX.ShowNotification('Véhicule endomagé, veulliez contacter le garagiste.')
                    Reparaisvoiture()
            elseif valid then
                valid2 = true
                etatrangervoiture(vehicle, vehicleProps, engineHealth)
            end
            if valid2 == false then 
                ESX.ShowNotification('Ce véhicule vous appartient pas.')
            end
        end, vehicleProps)
    else
        ESX.ShowNotification('Il n\'y a pas de véhicule à ranger dans le garage.')
    end
end

function etatrangervoiture(vehicle, vehicleProps)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('fellow_garage:etatvehiculesortie', vehicleProps.plate, true)
	ESX.ShowNotification('Votre véhicule est ranger dans le garage.')
end

    --ouvrir menu sortir véhicule
    CreateThread(function()
        while true do
            local Timer = 500
            for k,v in pairs(garagepublic.zone) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.sortie.x, v.sortie.y, v.sortie.z)
            if dist <= 10.0 then
                Timer = 0
                DrawMarker(garagepublic.Type, v.sortie.x, v.sortie.y, v.sortie.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, garagepublic.Size.x, garagepublic.Size.y, garagepublic.Size.z, garagepublic.Color.r, garagepublic.Color.g, garagepublic.Color.b, 100, false, true, 2, false, false, false, false)
            end
                if dist <= 8.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then   
                        ESX.TriggerServerCallback('fellow_garage:listevoiture', function(ownedCars)
                            fellowgarage.listevoiture = ownedCars
                        end)        
                        ouvrirpublicgar()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

    --ranger voiture bouton
    CreateThread(function()
        while true do
            local Timer = 500
            for k,v in pairs(garagepublic.zone) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.ranger.x, v.ranger.y, v.ranger.z)
            if dist <= 10.0 then
                Timer = 0
                DrawMarker(garagepublic.Type, v.ranger.x, v.ranger.y, v.ranger.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, garagepublic.Size.x, garagepublic.Size.y, garagepublic.Size.z, garagepublic.Color2.r, garagepublic.Color2.g, garagepublic.Color2.b, 100, false, true, 2, false, false, false, false)
            end
                if dist <= 8.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~b~E~w~ pour ranger un véhicule", time_display = 1 })
                    if IsControlJustPressed(1,51) then   
                        rangervoiture()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function Reparaisvoiture()
    local Rgarage = RageUI.CreateMenu("Garage", "Garage")
    ESX.TriggerServerCallback('fellow_garage:verifsous', function(suffisantsous)
        RageUI.Visible(Rgarage, not RageUI.Visible(Rgarage))
            while Rgarage do
            Wait(0)
            RageUI.IsVisible(Rgarage, true, true, true, function()

                RageUI.ButtonWithStyle("Réparer le véhicule",nil, {RightLabel = garagepublic.cleanveh.." $"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if suffisantsous then
                            TriggerServerEvent('fellow_garage:payechacal')
                            local plyVeh = GetVehiclePedIsIn(PlayerPedId(), false)
                            SetVehicleFixed(plyVeh)
                            SetVehicleDirtLevel(plyVeh, 0.0)
                            RageUI.CloseAll() 
                        else
                            ESX.ShowNotification('Tu n\'as pas assez d argent!')
                            RageUI.CloseAll()
                        end
                    end
                end)

                end, function()
                end)
            if not RageUI.Visible(Rgarage) then
            Rgarage = RMenu:DeleteType("Garage", true)
        end
    end
end)
end

