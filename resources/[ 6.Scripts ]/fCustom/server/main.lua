ESX = nil
local Vehicles

local VehiclesInShop = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('fpwn_customs:refreshOwnedVehicle')
AddEventHandler('fpwn_customs:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				print(('fpwn_customs: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

ESX.RegisterServerCallback('fpwn_customs:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

RegisterNetEvent('fpwn_customs:checkVehicle')
AddEventHandler('fpwn_customs:checkVehicle', function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	--print("plate: " .. plate)
	for k, v in pairs(VehiclesInShop) do 
		--print("k: " .. k)
		--print("v['plate']: " .. v['plate'])
		if v.plate == plate and _source ~= k then
			--print("found it")
			TriggerClientEvent('fpwn_customs:resetVehicle', source, v)
			VehiclesInShop[xPlayer.identifier] = nil
			break
		end
	end
end)

RegisterNetEvent('fpwn_customs:saveVehicle')
AddEventHandler('fpwn_customs:saveVehicle', function(oldVehProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	--print("oldVehProps['plate']: " .. oldVehProps['plate'])
	if oldVehProps then
		VehiclesInShop[xPlayer.identifier] = oldVehProps
		--print("VehiclesInShop[_source][plate]: " .. VehiclesInShop[_source]['plate'])
	end
end)

RegisterNetEvent('fpwn_customs:finishPurchase')
AddEventHandler('fpwn_customs:finishPurchase', function(society, newVehProps, shopCart, playerId, shopProfit)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	local pid = playerId
	local isFinished = false
	local price, amount = calcFinalPrice(shopCart, shopProfit)

	if price <= 0 or amount <= 0 then
		TriggerClientEvent('fpwn_customs:cantBill', source)
		TriggerClientEvent('fpwn_customs:resetVehicle', source, VehiclesInShop[xPlayer.identifier])
		VehiclesInShop[xPlayer.identifier] = nil
		return
	end

	if Config.IsMechanicJobOnly then
		local societyAccount

		--protecao contra merdices do lado do cliente
		if society ~= 'society_hayes' then
			return
		end
		TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
			societyAccount = account
		end)

		local targetMoney = xTarget.getAccount('bank')
		if price < societyAccount.money then
			if targetMoney.money >= amount then
				TriggerClientEvent('mythic_notify:notify', source, 'success', _U('purchased'))
				TriggerClientEvent('fpwn_customs:canBill', source, amount, pid)
				societyAccount.addMoney(amount - price)
				xTarget.removeAccountMoney('bank', amount)
				TriggerEvent('fpwn_customs:refreshOwnedVehicle', newVehProps)
				isFinished = true
			else
				TriggerClientEvent('mythic_notify:notify', playerId, 'error', _U('not_enough_money'))
				isFinished = false
			end
		else
			TriggerClientEvent('mythic_notify:notify', source, 'error', _U('not_enough_money'))
			isFinished = false
		end
	else
		if price < xPlayer.getMoney() then
			TriggerClientEvent('fpwn_customs:notify', source, 'success', _U('purchased'))
			xPlayer.removeMoney(price)
			TriggerEvent('fpwn_customs:refreshOwnedVehicle', newVehProps)
			isFinished = true
		else
			TriggerClientEvent('fpwn_customs:notify', source, 'error', _U('not_enough_money'))
			isFinished = false
		end
	end

	if not isFinished then
		TriggerClientEvent('fpwn_customs:cantBill', source)
		TriggerClientEvent('fpwn_customs:resetVehicle', source, VehiclesInShop[xPlayer.identifier])
	end

	if VehiclesInShop[xPlayer.identifier] then VehiclesInShop[xPlayer.identifier] = nil end
end)