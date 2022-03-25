ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'motodealer', 'alerte motodealer', true, true)

TriggerEvent('esx_society:registerSociety', 'motodealer', 'Concessionnaire Moto', 'society_motodealer', 'society_motodealer', 'society_motodealer', {type = 'public'})

ESX.RegisterServerCallback('fellow_moto:getStockItems', function(source, cb)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motodealer', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterNetEvent('fellow_moto:getStockItem')
AddEventHandler('fellow_moto:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motodealer', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, 'Objet retiré', count, inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('fellow_moto:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterNetEvent('fellow_moto:putStockItems')
AddEventHandler('fellow_moto:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motodealer', function(inventory)
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

ESX.RegisterServerCallback('fellow_moto:recuperercategoriemoto', function(source, cb)
    local catemoto = {}

    MySQL.Async.fetchAll('SELECT * FROM moto_categories', {}, function(result)
        for i = 1, #result, 1 do
            table.insert(catemoto, {
                name = result[i].name,
                label = result[i].label
            })
        end

        cb(catemoto)
    end)
end)

ESX.RegisterServerCallback('fellow_moto:recupererlistemoto', function(source, cb, categoriemoto)
    local catemoto = categoriemoto
    local listemoto = {}

    MySQL.Async.fetchAll('SELECT * FROM vehicles WHERE category = @category', {
        ['@category'] = catemoto
    }, function(result)
        for i = 1, #result, 1 do
            table.insert(listemoto, {
                name = result[i].name,
                model = result[i].model,
                price = result[i].price
            })
        end

        cb(listemoto)
    end)
end)

ESX.RegisterServerCallback('fellow_moto:verifierplaquedispo', function (source, cb, plate)
    MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function (result)
        cb(result[1] ~= nil)
    end)
end)

RegisterNetEvent('fellow_moto:vendremotojoueur')
AddEventHandler('fellow_moto:vendremotojoueur', function (playerId, vehicleProps, prix, nom)
    local xPlayer = ESX.GetPlayerFromId(playerId) 
	local levendeur = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_motodealer', function (account)
            account.removeMoney(prix)
    end)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
    {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps),
    }, function (rowsChanged)
    TriggerClientEvent('esx:showNotification', xPlayer.source, "Tu as reçu la moto ~g~"..nom.."~s~ immatriculé ~g~"..vehicleProps.plate.." pour ~g~" ..prix.. "$")
	sendToDiscordWithSpecialURL("Concessionnaire Moto","Vente d'un véhicule:\n\n__Nom du véhicule vendu :__ "..nom.."\n\n__Avec l'immatriculation :__ "..vehicleProps.plate.." \n\n__L'acheteur :__ "..xPlayer.getName().." \n\n__L'employée :__ "..levendeur.getName(), 16744192, ConcessMoto.webhooks)
    end)
end)

RegisterNetEvent('shop:moto')
AddEventHandler('shop:moto', function(vehicleProps, prix, nom)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_motodealer', function (account)
        account.removeMoney(prix)
end)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps),
    }, function(rowsChange)
        TriggerClientEvent('esx:showNotification', xPlayer, "Tu as reçu la moto ~g~"..json.encode(vehicleProps).."~s~ immatriculé ~g~"..vehicleProps.plate.." pour ~g~" ..prix.. "$")
		sendToDiscordWithSpecialURL("Concessionnaire Moto","Achat d'un véhicule:\n\n__Nom du véhicule acheter :__ "..nom.."\n\n__Avec l'immatriculation :__ "..vehicleProps.plate.." \n\n__L'employée :__ "..xPlayer.getName(), 16744192, ConcessMoto.webhooks)
    end)
end)

ESX.RegisterServerCallback('fellow_moto:verifsousmoto', function(source, cb, prixvoiture)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_motodealer', function (account)
        if account.money >= prixvoiture then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterNetEvent('fConcessMoto:Ouvert')
AddEventHandler('fConcessMoto:Ouvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concessionnaire Moto', '~b~Annonce', 'Le Concessionnaire Moto est désormais ~g~Ouvert~s~ !', 'CHAR_FCONCESS', 8)
	end
end)

RegisterNetEvent('fConcessMoto:Fermer')
AddEventHandler('fConcessMoto:Fermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concessionnaire Moto', '~b~Annonce', 'Le Concessionnaire Moto est désormais ~r~Fermer~s~ !', 'CHAR_FCONCESS', 8)
	end
end)

RegisterNetEvent('fConcessMoto:Perso')
AddEventHandler('fConcessMoto:Perso', function(msg)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers    = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Concessionnaire Moto', '~b~Annonce', msg, 'CHAR_FCONCESS', 8)
    end
end)

function sendToDiscordWithSpecialURL (name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "fConcessMoto by Fellow & Rayan Waize",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(ConcessMoto.webhooks, function(err, text, headers) end, 'POST', json.encode({ username = "fConcessMoto Bot",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


---------------- Clef --------------------

--Supprésion au démarrage des double de clés
AddEventHandler('onMySQLReady', function()
	MySQL.Async.fetchAll(
			'SELECT * FROM open_car WHERE NB = @NB',
			{
			['@NB']   = 2
			},
			function(result)
	
	
			for i=1, #result, 1 do
				MySQL.Async.execute(
							'DELETE FROM open_car WHERE id = @id',
							{
								['@id'] = result[i].id
							}
						)
			end
		end)
	end)

ESX.RegisterServerCallback('ddx_vehiclelockmoto:mykey', function(source, cb, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE value = @plate AND identifier = @identifier', 
		{
			['@plate'] = plate,
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false
			if result[1] ~= nil then
				
				if xPlayer.identifier == result[1].identifier then 
					found = true
				end
			end
			if found then
				cb(true)
	
			else
				cb(false)
			end

		end
	)
end)


RegisterNetEvent('ddx_vehiclelockmoto:registerkey')
AddEventHandler('ddx_vehiclelockmoto:registerkey', function(plate, target)
local _source = source
local xPlayer = nil
if target == 'no' then
	 xPlayer = ESX.GetPlayerFromId(_source)
else
	 xPlayer = ESX.GetPlayerFromId(target)
end
MySQL.Async.execute(
		'INSERT INTO open_car (label, value, NB, got, identifier) VALUES (@label, @value, @NB, @got, @identifier)',
		{
			['@label']		  = 'Cles',
			['@value']  	  = plate,
			['@NB']   		  = 1,
			['@got']  		  = 'true',
			['@identifier']   = xPlayer.identifier

		},
		function(result)
			    TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Clef', 'Concessionnaire', "Vous avez un nouvelle pair de clés !", 'CHAR_FCONCESS', 2)
			    TriggerClientEvent('esx:showAdvancedNotification', _source, 'Clef', 'Concessionnaire', "Clés bien enregistrer ! ", 'CHAR_FCONCESS', 2)
		end)

end)


ESX.RegisterServerCallback('ddx_vehiclelockmoto:getVehiclesnokey', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
MySQL.Async.fetchAll(
		'SELECT * FROM open_car WHERE identifier = @owner',
		{
			['@owner'] = xPlayer.identifier
		},
		function(result2)

			MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles WHERE owner = @owner',
		{
			['@owner'] = xPlayer.identifier
		},
		function(result)

			local vehicles = {}
			
			for i=1, #result, 1 do
				local found = false
				local vehicleData = json.decode(result[i].vehicle)
				for j=1, #result2, 1 do
					if result2[j].value == vehicleData.plate then
						
						found = true
						
					end
				end

				if found ~= true then
					
					table.insert(vehicles, vehicleData)
				end

			end
			cb(vehicles)
		end
	)
		end
	)
end)