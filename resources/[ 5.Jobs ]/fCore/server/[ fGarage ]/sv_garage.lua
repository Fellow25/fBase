ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- liste véhicule
ESX.RegisterServerCallback('fellow_garage:listevoiture', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND `stored` = @stored', { -- job = NULL
			['@owner'] = xPlayer.identifier,
			['@Type'] = 'car',
			['@stored'] = true
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate})
			end
			cb(ownedCars)
		end)
end)

--état sortie véhicule
RegisterNetEvent('fellow_garage:etatvehiculesortie')
AddEventHandler('fellow_garage:etatvehiculesortie', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('esx_advancedgarage: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)

--ranger véhicule
ESX.RegisterServerCallback('fellow_garage:rangervoiture', function (source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function (rowsChanged)
					if rowsChanged == 0 then
						print(('fellow_garage : tente de ranger un véhicule non à lui '):format(xPlayer.identifier))
					end
					cb(true)
				end)
			else
				print(('fellow_garage: %s Tentative de chat! Tente de ranger: ' .. vehiclemodel .. '. Voiture d\'origine: '.. originalvehprops.model):format(xPlayer.identifier))
				cb(false)
			end
		else
			print(('fellow_garage : tente de ranger un véhicule non à lui '):format(xPlayer.identifier))
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('fellow_garage:verifsous', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= garagepublic.cleanveh then
        cb(true)
    else
        cb(false)
    end
end)

--fait payer joueur pour fourriere
RegisterNetEvent('fellow_garage:payechacal')
AddEventHandler('fellow_garage:payechacal', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(garagepublic.cleanveh)
    TriggerClientEvent('esx:showNotification', source, "Tu as payer $" .. garagepublic.cleanveh)
end)