ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'mechanic', 'alerte mechanic', true, true)

TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'public'})

ESX.RegisterServerCallback('fbennys:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('fbennys:getStockItem')
AddEventHandler('fbennys:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
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

ESX.RegisterServerCallback('fbennys:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('fbennys:putStockItems')
AddEventHandler('fbennys:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
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

RegisterNetEvent('fBennys:Ouvert')
AddEventHandler('fBennys:Ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Benny\'s', '~y~Informations', 'Le Benny\'s est désormais ouvert!', 'CHAR_BENNYS', 2)
	end
end)

RegisterNetEvent('fBennys:Fermer')
AddEventHandler('fBennys:Fermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Benny\'s', '~y~Informations', 'Le Benny\'s est fermé!', 'CHAR_BENNYS', 2)
	end
end)

RegisterNetEvent('fBennys:Fabriquerkit')
AddEventHandler('fBennys:Fabriquerkit', function()
	local _source = source
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Benny\'s', '~y~Informations', 'Vous êtes en train de fabriquer un kit de réparation!', 'CHAR_BENNYS', 2)
end)

RegisterNetEvent('fBennys:Perso')
AddEventHandler('fBennys:Perso', function(msg)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Benny\'s', '~y~Annonce', msg, 'CHAR_BENNYS', 8)
    end
end)

RegisterNetEvent('fBennys:Fourriere')
AddEventHandler('fBennys:Fourriere', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'fourriere' then
            TriggerClientEvent('fBennys:Fourriere', xPlayers[i], _raison, name, message)
        end
		TriggerClientEvent('esx:showNotification', source, "Demande de dépanneur envoyer avec succès!")
    end
end)

RegisterNetEvent('fBennys:renfort')
AddEventHandler('fBennys:renfort', function(coords)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()

    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'fourriere' then
            TriggerClientEvent('fBennys:setBlip', xPlayers[i], coords)
        end
    end
end)

ESX.RegisterServerCallback('fBennys:checkkit', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local item = "fixkit"        
    local item_in_inventory = xPlayer.getInventoryItem(item).count
 
    if item_in_inventory > 0 then        
        cb(true)
    else
        TriggerClientEvent("esx:ShowNotification", source, "~r~Vous n'avez pas de kit sur vous !")
        cb(false)
    end
end)

RegisterNetEvent("fBennys:delkit")
AddEventHandler("fBennys:delkit", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("fixkit", 1)
end)

RegisterNetEvent('kit')
AddEventHandler('kit', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local ferraille = xPlayer.getInventoryItem('ferraille').count
    local fixkit = xPlayer.getInventoryItem('fixkit').count

    if fixkit > 5 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de kit de répration...')
    elseif ferraille < 5 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de ferraille...')
    else
        xPlayer.removeInventoryItem('ferraille', 5)
        xPlayer.addInventoryItem('fixkit', 1)    
    end
end)