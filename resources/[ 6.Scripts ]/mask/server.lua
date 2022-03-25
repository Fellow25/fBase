ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("dqp:SetNewMasque")
AddEventHandler("dqp:SetNewMasque", function(mask,variation,type,label)
  maskx = {mask_1=mask,mask_2=variation}
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  print(label)
 -- if label == nil then
  --label = type
  --end
  if xPlayer.getMoney() >= 50 then
    xPlayer.removeMoney(50)
  MySQL.Async.execute(
    'INSERT INTO user_accessories (identifier,mask,type,label) VALUES(@identifier,@mask,@type,@label)',
    {
      
      ['@mask'] = json.encode(maskx),
      ['@type'] = type,
      ['@label'] = label,
    ['@identifier'] =  xPlayer.identifier
    }
  )
  TriggerClientEvent("dqp:SyncAccess",source)
  TriggerClientEvent("esx:showNotification",source,"~g~Vous avez reçu un nouveau " .. type .."~n~~r~-50$" )
else
  TriggerClientEvent('esx:showNotification', _source, 'Pas assez d\'argent (50$)')
end
end)
RegisterNetEvent('dqp:GiveAccessories')
AddEventHandler('dqp:GiveAccessories', function(target,id,label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayer2 = ESX.GetPlayerFromId(target)
	MySQL.Async.execute(
		'UPDATE user_accessories SET identifier = @identifier WHERE id = @id',
		{
			['@identifier']   = xPlayer2.identifier,
			['@id'] = id

		}
	)
			TriggerClientEvent('esx:showNotification', _source, '~r~-1 '.. label)
			TriggerClientEvent('esx:showNotification', target, '~g~+1 '.. label)
		
			TriggerClientEvent("dqp:SyncAccess",source)
			TriggerClientEvent("dqp:SyncAccess",target)

end)


RegisterNetEvent('dqp:Delclo')
AddEventHandler('dqp:Delclo', function(id,label,data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

			

			
			MySQL.Async.execute(
				'DELETE FROM user_accessories where id = @id',
				{
					['@id']   = id,

		
				}
			)
			
			TriggerClientEvent('esx:showNotification', _source, '~r~-1 '.. label)
			


end)

RegisterNetEvent("dqp:RenameMasque")
AddEventHandler("dqp:RenameMasque", function(id,txt,type)
  MySQL.Async.execute(
    'UPDATE user_accessories SET label = @label WHERE id=@id',
    {
      ['@id'] = id,
      ['@label'] = txt

    }
  )
 -- TriggerClientEvent('dqp:MenuInvOpen',source)
  TriggerClientEvent("esx:showNotification",source,"Vous avez bien renommé votre "..type.." en "..txt)

end)

ESX.RegisterServerCallback('dqp:getMask', function(source, cb)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    
  
    MySQL.Async.fetchAll(
      'SELECT * FROM user_accessories WHERE identifier = @identifier',
      {
          ['@identifier'] = xPlayer.identifier
      },
      function(result)
  
        cb(result)
      --  --(json.encode(result))
  
    end )
  
  end)

  ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)
    local xPlayer = ESX.GetPlayerFromId(source)
  
    TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
      local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
      local skin = (store.get('skin') and store.get('skin') or {})
  
      cb(hasAccessory, skin)
    end)
  
  end)

  RegisterNetEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		store.set('has' .. accessory, true)

		local itemSkin = {}
		local item1 = string.lower(accessory) .. '_1'
		local item2 = string.lower(accessory) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]

		store.set('skin', itemSkin)
	end)
end)