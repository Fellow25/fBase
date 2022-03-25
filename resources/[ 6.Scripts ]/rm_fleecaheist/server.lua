ESX = nil
lastRob = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
}
discord = {
    ['webhook'] = 'DISCORDCHANNELWEBHOOKLINK',
    ['name'] = 'rm_fleecaheist',
    ['image'] = 'https://cdn.discordapp.com/avatars/869260464775921675/dea34d25f883049a798a241c8d94020c.png?size=1024'
}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterServerCallback('fleecaheist:server:checkPoliceCount', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local policeCount = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            policeCount = policeCount + 1
        end
    end

    if policeCount >= Config['FleecaMain']['requiredPoliceCount'] then
        cb(true)
    else
        cb(false)
        TriggerClientEvent('fleecaheist:client:showNotification', src, Strings['need_police'])
    end
end)

ESX.RegisterServerCallback('fleecaheist:server:checkTime', function(source, cb, index)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if (os.time() - lastRob[index]) < Config['FleecaHeist'][index]['nextRob'] and lastRob[index] ~= 0 then
        local seconds = Config['FleecaHeist'][index]['nextRob'] - (os.time() - lastRob[index])
        TriggerClientEvent('fleecaheist:client:showNotification', src, Strings['wait_nextheist'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
        cb(false)
    else
        lastRob[index] = os.time()
        discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' started the Fleeca Heist!')
        cb(true)
    end
end)

ESX.RegisterServerCallback('fleecaheist:server:hasItem', function(source, cb, item)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local playerItem = player.getInventoryItem(item)

    if player and playerItem ~= nil then
        if playerItem.count >= 1 then
            cb(true, playerItem.label)
        else
            cb(false, playerItem.label)
        end
    else
        print('[rm_fleecaheist] you need add required items to server database')
    end
end)

RegisterNetEvent('fleecaheist:server:policeAlert')
AddEventHandler('fleecaheist:server:policeAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'police' then
            TriggerClientEvent('fleecaheist:client:policeAlert', players[i], coords)
        end
    end
end)

RegisterNetEvent('fleecaheist:server:rewardItem')
AddEventHandler('fleecaheist:server:rewardItem', function(reward, count)
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        if reward.item ~= nil then
            if count ~= nil then
                player.addInventoryItem(reward.item, count)
            else
                player.addInventoryItem(reward.item, reward.count)
            end
        else
            if count ~= nil then
                --player.addMoney(count)
                player.addAccountMoney('black_money', count)
            else
                --player.addMoney(reward.count)
                player.addAccountMoney('black_money', reward.count)
            end
        end
    end
end)

RegisterNetEvent('fleecaheist:server:sellRewardItems')
AddEventHandler('fleecaheist:server:sellRewardItems', function()
    local src = source
    local player = ESX.GetPlayerFromId(src)

    if player then
        local totalMoney = 0
        local rewardItems = Config['FleecaMain']['rewardItems']
        local diamondCount = player.getInventoryItem(rewardItems['diamondTrolly']['item']).count
        local goldCount = player.getInventoryItem(rewardItems['goldTrolly']['item']).count

        if diamondCount > 0 then
            player.removeInventoryItem(rewardItems['diamondTrolly']['item'], diamondCount)
            --player.addMoney(rewardItems['diamondTrolly']['sellPrice'] * diamondCount)
            player.addAccountMoney('black_money', rewardItems['diamondTrolly']['sellPrice'] * diamondCount)
            totalMoney = totalMoney + (rewardItems['diamondTrolly']['sellPrice'] * diamondCount)
        end
        if goldCount > 0 then
            player.removeInventoryItem(rewardItems['goldTrolly']['item'], goldCount)
           -- player.addMoney(rewardItems['goldTrolly']['sellPrice'] * goldCount)
           player.addAccountMoney('black_money', rewardItems['goldTrolly']['sellPrice'] * goldCount)
            totalMoney = totalMoney + (rewardItems['goldTrolly']['sellPrice'] * goldCount)
        end

        discordLog(player.getName() ..  ' - ' .. player.getIdentifier(), ' Gain $' .. totalMoney .. ' on the Fleeca Heist Buyer!')
        TriggerClientEvent('fleecaheist:client:showNotification', src, Strings['total_money'] .. ' $' .. totalMoney)
    end
end)

RegisterNetEvent('fleecaheist:server:doorSync')
AddEventHandler('fleecaheist:server:doorSync', function(index)
    TriggerClientEvent('fleecaheist:client:doorSync', -1, index)
end)

RegisterNetEvent('fleecaheist:server:lootSync')
AddEventHandler('fleecaheist:server:lootSync', function(index, type, k)
    TriggerClientEvent('fleecaheist:client:lootSync', -1, index, type, k)
end)

RegisterNetEvent('fleecaheist:server:modelSync')
AddEventHandler('fleecaheist:server:modelSync', function(index, k, model)
    TriggerClientEvent('fleecaheist:client:modelSync', -1, index, k, model)
end)

RegisterNetEvent('fleecaheist:server:grabSync')
AddEventHandler('fleecaheist:server:grabSync', function(index, k, model)
    TriggerClientEvent('fleecaheist:client:grabSync', -1, index, k, model)
end)

RegisterNetEvent('fleecaheist:server:resetHeist')
AddEventHandler('fleecaheist:server:resetHeist', function(index)
    TriggerClientEvent('fleecaheist:client:resetHeist', -1, index)
end)

RegisterCommand('pdfleeca', function(source, args)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    
    if player then
        if player['job']['name'] == 'police' then
            TriggerClientEvent('fleecaheist:client:nearBank', src)
        else
            TriggerClientEvent('fleecaheist:client:showNotification', src, 'You are not cop!')
        end
    end
end)

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end