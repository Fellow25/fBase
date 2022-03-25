ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'ammu', 'alerte ammu', true, true)

TriggerEvent('esx_society:registerSociety', 'ammu', 'ammu', 'society_ammu', 'society_ammu', 'society_ammu', {type = 'public'})

ESX.RegisterServerCallback('fammu:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammu', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('fammu:getStockItem')
AddEventHandler('fammu:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammu', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification("Vous avez retiré "..count.." "..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('fammu:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('fammu:putStockItems')
AddEventHandler('fammu:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ammu', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification("Vous avez déposé "..count.." "..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

RegisterNetEvent('fAmmu:Ouvert')
AddEventHandler('fAmmu:Ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammu-Nation', '~b~Informations', 'L\'Ammu-Nation est ouvert', 'CHAR_AMMUNATION', 2)
	end
end)

RegisterNetEvent('fAmmu:Fermer')
AddEventHandler('fAmmu:Fermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammu-Nation', '~b~Informations', 'L\'Ammu-Nation est fermé', 'CHAR_AMMUNATION', 2)
	end
end)

RegisterNetEvent('fAmmu:Recrute')
AddEventHandler('fAmmu:Recrute', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Ammu-Nation', '~b~Recrutement', 'L\'Ammu-Nation recrute ! Presentez vous à l\'acceuil du batiment', 'CHAR_AMMUNATION', 8)
	end
end)

RegisterNetEvent('craft:gg')
AddEventHandler('craft:gg', function(item, nbmetaux, nbmeche, nbcanon, nblevier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addInventoryItem(item, 1)
    xPlayer.removeInventoryItem('metaux', nbmetaux)
    xPlayer.removeInventoryItem('meche', nbmeche)
    xPlayer.removeInventoryItem('canon', nbcanon)
    xPlayer.removeInventoryItem('levier', nblevier)
end)

RegisterNetEvent('h4ci_craft:nonvalider')
AddEventHandler('h4ci_craft:nonvalider', function(nbmetaux, nbmeche, nbcanon, nblevier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.removeInventoryItem('metaux', nbmetaux)
    xPlayer.removeInventoryItem('meche', nbmeche)
    xPlayer.removeInventoryItem('canon', nbcanon)
    xPlayer.removeInventoryItem('levier', nblevier)
end)

RegisterNetEvent('metaux')
AddEventHandler('metaux', function()
    local item = "metaux"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('canon')
AddEventHandler('canon', function()
    local item = "canon"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('meche')
AddEventHandler('meche', function()
    local item = "meche"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('levier')
AddEventHandler('levier', function()
    local item = "levier"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)
