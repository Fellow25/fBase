ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rcoke')
AddEventHandler('rcoke', function()
    local item = "coke"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tcoke')
AddEventHandler('tcoke', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local coke = xPlayer.getInventoryItem('coke').count
    local coke_pooch = xPlayer.getInventoryItem('coke_pooch').count

    if coke_pooch > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets de coke .. Vas les vendre')
    elseif coke < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de coke pour traiter')
    else
        xPlayer.removeInventoryItem('coke', 5)
        xPlayer.addInventoryItem('coke_pooch', 1)    
    end
end)

RegisterNetEvent('rmeth')
AddEventHandler('rmeth', function()
    local item = "meth"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tmeth')
AddEventHandler('tmeth', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local meth = xPlayer.getInventoryItem('meth').count
    local meth_pooch = xPlayer.getInventoryItem('meth_pooch').count

    if meth_pooch > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets de meth .. Vas les vendre')
    elseif meth < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de meth pour traiter')
    else
        xPlayer.removeInventoryItem('meth', 5)
        xPlayer.addInventoryItem('meth_pooch', 1)    
    end
end)

RegisterNetEvent('ropium')
AddEventHandler('ropium', function()
    local item = "opium"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('topium')
AddEventHandler('topium', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local opium = xPlayer.getInventoryItem('opium').count
    local opium_pooch = xPlayer.getInventoryItem('opium_pooch').count

    if opium_pooch > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets d\'opium .. Vas les vendre')
    elseif opium < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'opium pour traiter')
    else
        xPlayer.removeInventoryItem('opium', 5)
        xPlayer.addInventoryItem('opium_pooch', 1)    
    end
end)

RegisterNetEvent('rweed')
AddEventHandler('rweed', function()
    local item = "weed"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tweed')
AddEventHandler('tweed', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local weed = xPlayer.getInventoryItem('weed').count
    local weed_pooch = xPlayer.getInventoryItem('weed_pooch').count

    if weed_pooch > 20 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets de weed .. Vas les vendre')
    elseif weed < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de weed pour traiter')
    else
        xPlayer.removeInventoryItem('weed', 5)
        xPlayer.addInventoryItem('weed_pooch', 1)    
    end
end)

RegisterNetEvent('recstasy')
AddEventHandler('recstasy', function()
    local item = "ecstasy"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tecstasy')
AddEventHandler('tecstasy', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local ecstasy = xPlayer.getInventoryItem('ecstasy').count
    local ecstasy_pooch = xPlayer.getInventoryItem('ecstasy_pooch').count

    if ecstasy_pooch > 20 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets d\'ecstasy .. Vas les vendre')
    elseif ecstasy < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez d\'ecstasy pour traiter')
    else
        xPlayer.removeInventoryItem('ecstasy', 5)
        xPlayer.addInventoryItem('ecstasy_pooch', 1)    
    end
end)

RegisterNetEvent('rlsd')
AddEventHandler('rlsd', function()
    local item = "lsd"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "Ta pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('tlsd')
AddEventHandler('tlsd', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local lsd = xPlayer.getInventoryItem('lsd').count
    local lsd_pooch = xPlayer.getInventoryItem('lsd_pooch').count

    if lsd_pooch > 20 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de sachets de LSD .. Vas les vendre')
    elseif lsd < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de LSD pour traiter')
    else
        xPlayer.removeInventoryItem('lsd', 5)
        xPlayer.addInventoryItem('lsd_pooch', 1)    
    end
end)

RegisterCommand('dealer', function(source, args, rawcommand)
    xPlayer = ESX.GetPlayerFromId(source)
    drugToSell = {
        type = '',
        label = '',
        count = 0,
        i = 0,
        price = 0,
    }
    for k, v in pairs(fDrugs.drugs) do
        item = xPlayer.getInventoryItem(k)
            
        if item == nil then
            return        
        end
            
        count = item.count
        drugToSell.i = drugToSell.i + 1
        drugToSell.type = k
        drugToSell.label = item.label
        
        if count >= 5 then
            drugToSell.count = math.random(1, 5)
        elseif count > 0 then
            drugToSell.count = math.random(1, count)
        end

        if drugToSell.count ~= 0 then
            drugToSell.price = drugToSell.count * v + math.random(1, 300)
            TriggerClientEvent('stasiek_selldrugsv2:findClient', source, drugToSell)
            break
        end
        
        if ESX.Table.SizeOf(fDrugs.drugs) == drugToSell.i and drugToSell.count == 0 then
            xPlayer.showNotification(fDrugs.notify.nodrugs, 6)
        end
    end
end, false)

RegisterNetEvent('stasiek_selldrugsv2:pay')
AddEventHandler('stasiek_selldrugsv2:pay', function(drugToSell)
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(drugToSell.type, drugToSell.count)
    if fDrugs.account == 'money' then
        xPlayer.addMoney(drugToSell.price)
    else
        xPlayer.addAccountMoney(fDrugs.account, drugToSell.price)
    end
end)

RegisterNetEvent('stasiek_selldrugsv2:notifycops')
AddEventHandler('stasiek_selldrugsv2:notifycops', function(drugToSell)
    TriggerClientEvent('stasiek_selldrugsv2:notifyPolice', -1, drugToSell.coords)
end)

ESX.RegisterServerCallback('stasiek_selldrugsv2:getPoliceCount', function(source, cb)
    count = 0

    for _, playerId in pairs(ESX.GetPlayers()) do
        xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer.job.name == 'police' then
            count = count + 1
        end
    end

    cb(count)
end)