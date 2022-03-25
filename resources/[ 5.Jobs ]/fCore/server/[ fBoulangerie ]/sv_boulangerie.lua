ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('esx_phone:registerNumber', 'boulangerie', 'alerte boulangerie', true, true)
TriggerEvent('esx_society:registerSociety', 'boulangerie', 'boulangerie', 'society_boulangerie', 'society_boulangerie', 'society_boulangerie', {type = 'private'})


ESX.RegisterServerCallback('boulangerie:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_boulangerie', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('boulangerie:getStockItem')
AddEventHandler('boulangerie:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_boulangerie', function(inventory)
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

ESX.RegisterServerCallback('boulangerie:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('boulangerie:putStockItems')
AddEventHandler('boulangerie:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_boulangerie', function(inventory)
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

RegisterNetEvent('esx_boulangeriejob:message')
AddEventHandler('esx_boulangeriejob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)

RegisterNetEvent('AnnonceBoulangerieOuvert')
AddEventHandler('AnnonceBoulangerieOuvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Boulangerie', '~y~Annonce', 'Venez acheter le meilleur pain de la ville!', 'CHAR_PAIN', 8)
	end
end)

RegisterNetEvent('AnnonceBoulangerieFermer')
AddEventHandler('AnnonceBoulangerieFermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Boulangerie', '~y~Annonce', 'La boulangerie est désormais fermé à plus tard!', 'CHAR_PAIN', 8)
	end
end)

RegisterNetEvent('farine')
AddEventHandler('farine', function()
    local item = "farine"
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

RegisterNetEvent('painpremierprix')
AddEventHandler('painpremierprix', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local farine = xPlayer.getInventoryItem('farine').count
    local jus = xPlayer.getInventoryItem('painpremierprix').count

    if jus > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de pain premier prix...')
    elseif farine < 5 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de farine pour traiter...')
    else
        xPlayer.removeInventoryItem('farine', 5)
        xPlayer.addInventoryItem('painpremierprix', 2)    
    end
end)

RegisterNetEvent('ventepain')
AddEventHandler('ventepain', function()

    local money = math.random(10,50)
	local playerMoney  = math.random(1,5)
    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil
    local painpremierprix = 0

    if xPlayer.getInventoryItem('painpremierprix').count <= 0 then
        pain = 0
    else
        pain = 1
    end

    if pain == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de pain pour vendre...')
        return
    elseif xPlayer.getInventoryItem('painpremierprix').count <= 0 and argent == 0 then
        TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Pas assez de pain pour vendre...')
        pain = 0
        return
    elseif pain == 1 then
            local money = math.random(boulangerie.ventemin,boulangerie.ventemax)
            xPlayer.removeInventoryItem('painpremierprix', 1)
            local societyAccount = nil

            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_boulangerie', function(account)
                societyAccount = account
            end)
            if societyAccount ~= nil then
                societyAccount.addMoney(money)
				xPlayer.addAccountMoney('money', boulangerie.argentjoueur)
                TriggerClientEvent('esx:showNotification', source, "~g~Vendue avec sucess...")
            end
        end
        end) 
