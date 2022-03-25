ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rPoleEmploi:setjob')
AddEventHandler('rPoleEmploi:setjob', function(setjob, Nom)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob(setjob, 0)
    if setjob == "unemployed" then
    TriggerClientEvent('esx:showAdvancedNotification', source, 'Pôle emploi', '~b~Informations~w~ !', "Vous êtes au ~r~Chômage", 'CHAR_POLEEMPLOI', 8)
    else
    TriggerClientEvent('esx:showAdvancedNotification', source, 'Pôle emploi', '~b~Félicitation~w~ !', "Vous êtes embauché chez les ~b~"..Nom.."~w~ en tant que ~g~Intérimaire.", 'CHAR_POLEEMPLOI', 8)
    end
    sendToDiscordWithSpecialURL("Pôle emploi"," __Nouvelle embauche :__\n\nChez : __"..Nom.."__\nL'employé : __"..xPlayer.getName().."__", 16744192, rPoleEmploi.webhooks)
end)

RegisterNetEvent('rPoleEmploi:jobwhitelist')
AddEventHandler('rPoleEmploi:jobwhitelist', function(Nom)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx:showAdvancedNotification', source, 'Pôle emploi', '~r~Informations', "Pour intégrer les "..Nom.." veuillez rédiger une ~b~candidature~w~ sur ~g~Discord~w~", 'CHAR_POLEEMPLOI', 8)
end)


function sendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "rPoleEmploi by Rayan Waize#7272",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = "Pôle emploi Bot",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end