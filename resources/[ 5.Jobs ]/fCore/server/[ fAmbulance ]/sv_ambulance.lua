ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local playersHealing, deadPlayers = {}, {}

TriggerEvent('esx_phone:registerNumber', 'ambulance', ('Alerte ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(playerId)
	playerId = tonumber(playerId)
	if source == '' and GetInvokingResource() == 'monitor' then -- txAdmin support
        local xTarget = ESX.GetPlayerFromId(playerId)
        if xTarget then
            if deadPlayers[playerId] then
                print('vous avez réanimé ~r~%s~s~', xTarget.name)
                xTarget.triggerEvent('esx_ambulancejob:revive')
            else
                print('n\'est pas inconscient')
            end
        else
            print('ce joueur n\'est plus en ligne')
        end
	else
		local xPlayer = source and ESX.GetPlayerFromId(source)

		if xPlayer and xPlayer.job.name == 'ambulance' then
			local xTarget = ESX.GetPlayerFromId(playerId)

			if xTarget then
				if deadPlayers[playerId] then
					if Ambulance.ReviveReward > 0 then
						xPlayer.showNotification("vous avez réannimé ~r~"..xTarget.name.."~s~, ~g~"..Ambulance.ReviveReward)
						xPlayer.addMoney(Ambulance.ReviveReward)
						xTarget.triggerEvent('esx_ambulancejob:revive')
					else
						xPlayer.showNotification("vous avez réannimé ~r~"..xTarget.name)
						xTarget.triggerEvent('esx_ambulancejob:revive')
					end
				else
					xPlayer.showNotification('n\'est pas inconscient')
				end
			else
				xPlayer.showNotification('ce joueur n\'est plus en ligne')
			end
		end
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
end)

RegisterNetEvent('esx_ambulancejob:svsearch')
AddEventHandler('esx_ambulancejob:svsearch', function()
  TriggerClientEvent('esx_ambulancejob:clsearch', -1, source)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function()
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Ambulance.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Ambulance.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Ambulance.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		CreateThread(function()
			Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Ambulance.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Ambulance.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Ambulance.EarlyRespawnFineAmount

		xPlayer.showNotification('vous avez payé ~r~$%s~s~ pour être réanimer.', ESX.Math.GroupDigits(fineAmount))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_ambulancejob:revive')
end, true, {help = 'revive un joueur', validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
				
		if isDead then
			print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted combat logging'):format(xPlayer.identifier))
		end

		cb(isDead)
	end)
end)

RegisterNetEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isDead) == 'boolean' then
		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

ESX.RegisterServerCallback('fAmbulance:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('fAmbulance:putStockItems')
AddEventHandler('fAmbulance:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(_U('have_deposited', count, inventoryItem.name))
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('fAmbulance:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('fAmbulance:getStockItem')
AddEventHandler('fAmbulance:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

RegisterNetEvent('AmbulanceDispo')
AddEventHandler('AmbulanceDispo', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ambulance', '~b~Informations', 'Un ambulancier a pris son service ! EMS ~g~disponile', 'CHAR_EMS', 2)
	end
end)

RegisterNetEvent('AmbulancePasDispo')
AddEventHandler('AmbulancePasDispo', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ambulance', '~b~Informations', 'Un ambulancier à quitter son service ! EMS ~r~non disponible', 'CHAR_EMS', 2)
	end
end)

RegisterNetEvent('AmbulanceRecrutement')
AddEventHandler('AmbulanceRecrutement', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ambulance', '~b~Recrutement', 'Le service national de santé recrute ! Presentez vous à l\'acceuil du batiment', 'CHAR_EMS', 8)
	end
end)

local appelTable = {}

RegisterNetEvent('fAmbulance:envoyersingal')
AddEventHandler('fAmbulance:envoyersingal', function(coords)
    local xPlayer = ESX.GetPlayerFromId(source)
    local NomDuMec = xPlayer.getName()
    local idDuMec = source
    table.insert(appelTable, {
        id = source,
        nom = NomDuMec,
        args = "Appel EMS",
        gps = coords
    })
end)

ESX.RegisterServerCallback('fAmbulance:infoReport', function(source, cb)
    cb(appelTable)
end)

RegisterNetEvent("fAmbulance:emsAppel")
AddEventHandler("fAmbulance:emsAppel", function()
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'ambulance' then
            TriggerClientEvent("fAmbulance:envoielanotif", xPlayers[i])
        end
end
end)

RegisterNetEvent("fAmbulance:CloseReport")
AddEventHandler("fAmbulance:CloseReport", function(nom, raison)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'ambulance' then
            TriggerClientEvent("fAmbulance:envoielanotifclose", xPlayers[i], nom)
        end
end
    table.remove(appelTable, id, nom, args, gps)
end)

ESX.RegisterServerCallback('fAmbulance:checkitem', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)

    local item = item   
    
    local item_in_inventory = xPlayer.getInventoryItem(item).count

        
    if item_in_inventory > 0 then        
        cb(true)
    else
        TriggerClientEvent("esx:ShowNotification", xPlayer, "~r~Vous n'en n'avez pas sur vous !")
        cb(false)
    end

end)

RegisterNetEvent("fAmbulance:delitem")
AddEventHandler("fAmbulance:delitem", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, 1)
end)

RegisterNetEvent('fAmbulance:BuyKit')
AddEventHandler('fAmbulance:BuyKit', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.addInventoryItem('medikit', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Kit médical~w~ retirer!")
end)

RegisterNetEvent('fAmbulance:BuyBandage')
AddEventHandler('fAmbulance:BuyBandage', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.addInventoryItem('bandage', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Bandage~w~ retirer!")
end)

RegisterNetEvent('fAmbulance:BuyCompresse')
AddEventHandler('fAmbulance:BuyCompresse', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.addInventoryItem('compresse', 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Compresse~w~ retirer!")
end)