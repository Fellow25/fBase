ESX = nil

local reportTable = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

--Argent cash
RegisterServerEvent("fAdmin:GiveArgentCash")
AddEventHandler("fAdmin:GiveArgentCash", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addMoney((total))
    envoyerdiscord("fAdmin","__Give d'argent cash :__ "..total.."€ \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

--Argent sale
RegisterServerEvent("fAdmin:GiveArgentSale")
AddEventHandler("fAdmin:GiveArgentSale", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('black_money', total)
    envoyerdiscord("fAdmin","__Give d'argent sale :__ "..total.."€ \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

--Argent banque
RegisterServerEvent("fAdmin:GiveArgentBanque")
AddEventHandler("fAdmin:GiveArgentBanque", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('bank', total)
    envoyerdiscord("fAdmin","__Give d'argent banque :__ "..total.."€ \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

--Kick
RegisterServerEvent('fAdmin:kickjoueur')
AddEventHandler('fAdmin:kickjoueur', function(id, raison)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tragetxPlayer = ESX.GetPlayerFromId(id)
    local reason = "Vous avez été kick par "..xPlayer.getName().." pour la raison suivante : "..raison
    DropPlayer(id, reason)
    envoyerdiscord("fAdmin","__Kick :__ "..tragetxPlayer.getName().." \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

--Give véhicule avec clées
RegisterServerEvent('fAdmin:vehicule')
AddEventHandler('fAdmin:vehicule', function(vehicleProps, plate, veh)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
    end)
    envoyerdiscord("fAdmin","__Give de véhicule :__ "..veh.." \n\n__Staff :__ "..xPlayer.getName().."", 16744192, fAdmin.webhooks)
end)

RegisterServerEvent('fAdmin:vehiculejoueur')
AddEventHandler('fAdmin:vehiculejoueur', function(vehicleProps, plate, IdSelected, veh)
    local xPlayer = ESX.GetPlayerFromId(IdSelected)
    local lestaff = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = plate,
        ['@vehicle'] = json.encode(vehicleProps)
    }, function(rowsChange)
    end)
    envoyerdiscord("fAdmin","__Give de véhicule joueur :__ "..xPlayer.getName().."\n\n__Véhicule :__ "..veh.."\n\n__Staff :__ "..lestaff.getName().."", 16744192, fAdmin.webhooks)
end)

--Report
ESX.RegisterServerCallback('fAdmin:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

RegisterCommand('report', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    local NomDuMec = xPlayer.getName()
    local idDuMec = source
    local RaisonDuMec = table.concat(args, " ")
    if #RaisonDuMec <= 1 then
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez rentrer une raison valable")
    elseif #RaisonDuMec >= 20 then
        TriggerClientEvent("esx:showNotification", source, "~r~Veuillez rentrer une raison moins longue")
    else
        TriggerClientEvent("esx:showNotification", source, "~g~Votre report a bien était envoyer")
        TriggerClientEvent("fAdmin:Open/CloseReport", -1, 1)
        table.insert(reportTable, {
            id = idDuMec,
            nom = NomDuMec,
            args = RaisonDuMec,
        })
    end
end, false)

RegisterServerEvent("fAdmin:CloseReport")
AddEventHandler("fAdmin:CloseReport", function(nomMec, raisonMec)
    TriggerClientEvent("fAdmin:Open/CloseReport", -1, 2, nomMec, raisonMec)
    table.remove(reportTable, id, nom, args)
end)

ESX.RegisterServerCallback('fAdmin:infoReport', function(source, cb)
    cb(reportTable)
end)

RegisterServerEvent("fAdmin:bring")
AddEventHandler("fAdmin:bring",function(IdDuMec, plyPedCoords, lequel)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "help" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "admin" then
        if lequel == "bring" then
            TriggerClientEvent("fAdmin:bring", IdDuMec, plyPedCoords)
        else
            TriggerClientEvent("fAdmin:bring", plyPedCoords, IdDuMec)
        end
    else
        print('Tu peux pas !')
    end
end)

RegisterNetEvent("fAdmin:Message")
AddEventHandler("fAdmin:Message", function(id, type)
    TriggerClientEvent("fAdmin:envoyer", id, type)
end)

-- Ban

Text               = {}
BanList            = {}
BanListLoad        = false
BanListHistory     = {}
BanListHistoryLoad = false
Text = Config.TextFr

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


CreateThread(function()
	while true do
		Wait(1000)
        if BanListLoad == false then
			loadBanList()
			if BanList ~= {} then
				print("Passage sous New ESX By Yamsoo.")
				print(Text.banlistloaded)
				BanListLoad = true
			else
				print(Text.starterror)
			end
		end
		if BanListHistoryLoad == false then
			loadBanListHistory()
            if BanListHistory ~= {} then
				print(Text.historyloaded)
				BanListHistoryLoad = true
			else
				print(Text.starterror)
			end
		end
	end
end)

CreateThread(function()
	while Config.MultiServerSync do
		Wait(30000)
		MySQL.Async.fetchAll(
		'SELECT * FROM banlist',
		{},
		function (data)
			if #data ~= #BanList then
			  BanList = {}

			  for i=1, #data, 1 do
				table.insert(BanList, {
					license    = data[i].license,
					identifier = data[i].identifier,
					liveid     = data[i].liveid,
					xblid      = data[i].xblid,
					discord    = data[i].discord,
					playerip   = data[i].playerip,
					reason     = data[i].reason,
					added      = data[i].added,
					expiration = data[i].expiration,
					permanent  = data[i].permanent
				  })
			  end
			loadBanListHistory()
			TriggerClientEvent('BanSql:Respond', -1)
			end
		end
		)
	end
end)


ESX.RegisterCommand('sqlban', Config.Permission, function(source, args, user)
	cmdban(source, args)
end, true)

ESX.RegisterCommand('sqlunban', Config.Permission, function(source, args, user)
	cmdunban(source, args)
end, true)

ESX.RegisterCommand('sqlbanoffline', Config.Permission, function(source, args, user)
	cmdbanoffline(source, args)
end, true)

ESX.RegisterCommand('sqlbanhistory', Config.Permission, function(source, args, user)
	cmdbanhistory(source, args)
end, true)

ESX.RegisterCommand('sqlbanreload', Config.Permission, function(source, args, user)
	BanListLoad        = false
	BanListHistoryLoad = false
	Wait(5000)
	if BanListLoad == true then
	  TriggerEvent('bansql:sendMessage', source, Text.banlistloaded)
	  if BanListHistoryLoad == true then
		  TriggerEvent('bansql:sendMessage', source, Text.historyloaded)
	  end
	else
	  TriggerEvent('bansql:sendMessage', source, Text.loaderror)
	end
end, true)


--TriggerEvent('es:addGroupCommand', 'sqlsearch', Config.Permission, function (source, args, user)
--	cmdsearch(source, args)
--end, function(source, args, user)
--	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
--end, {help = Text.bansearch, params = {{name = "name", help = Text.steamname}}})


--TriggerEvent('es:addGroupCommand', 'sqlbanhistory', Config.Permission, function (source, args, user)
--	cmdbanhistory(source, args)
--end, function(source, args, user)
--	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
--end, {help = Text.history, params = {{name = "name", help = Text.steamname}, }})


--How to use from server side : TriggerEvent("BanSql:ICheat", "Auto-Cheat Custom Reason",TargetId)
RegisterServerEvent('BanSql:ICheat')
AddEventHandler('BanSql:ICheat', function(reason,servertarget)
	local license,identifier,liveid,xblid,discord,playerip,target
	local duree     = 0
	local reason    = reason

	if not reason then reason = "Pffff t cramé mon reuf..." end

	if tostring(source) == "" then
		target = tonumber(servertarget)
	else
		target = source
	end

	if target and target > 0 then
		local ping = GetPlayerPing(target)
	
		if ping and ping > 0 then
			if duree and duree < 365 then
				local sourceplayername = "Anti-Cheat-System"
				local targetplayername = GetPlayerName(target)
					for k,v in ipairs(GetPlayerIdentifiers(target))do
						if string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
						elseif string.sub(v, 1, string.len("live:")) == "live:" then
							liveid = v
						elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
							xblid  = v
						elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
							discord = v
						elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
							playerip = v
						end
					end
			
				if duree > 0 then
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
					DropPlayer(target, Text.yourban .. reason)
				else
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
					DropPlayer(target, Text.yourpermban .. reason)
				end
			
			else
				print("BanSql Error : Auto-Cheat-Ban time invalid.")
			end	
		else
			print("BanSql Error : Auto-Cheat-Ban target are not online.")
		end
	else
		print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
	end
end)

RegisterServerEvent('BanSql:CheckMe')
AddEventHandler('BanSql:CheckMe', function()
	doublecheck(source)
end)

-- console / rcon can also utilize es:command events, but breaks since the source isn't a connected player, ending up in error messages
AddEventHandler('bansql:sendMessage', function(source, message)
	print('[New Version] SqlBan: ' .. message)
end)

AddEventHandler('playerConnecting', function (playerName,setKickReason)
	local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	--Si Banlist pas chargée
	if (Banlist == {}) then
		Wait(1000)
	end

    if steamID == "n/a" and Config.ForceSteam then
		setKickReason(Text.invalidsteam)
		CancelEvent()
    end

	for i = 1, #BanList, 1 do
		if 
			  ((tostring(BanList[i].license)) == tostring(license) 
			or (tostring(BanList[i].identifier)) == tostring(steamID) 
			or (tostring(BanList[i].liveid)) == tostring(liveid) 
			or (tostring(BanList[i].xblid)) == tostring(xblid) 
			or (tostring(BanList[i].discord)) == tostring(discord) 
			or (tostring(BanList[i].playerip)) == tostring(playerip)) 
		then

			if (tonumber(BanList[i].permanent)) == 1 then

				setKickReason(Text.yourpermban .. BanList[i].reason)
				CancelEvent()
				break

			elseif (tonumber(BanList[i].expiration)) > os.time() then

				local tempsrestant     = (((tonumber(BanList[i].expiration)) - os.time())/60)
				if tempsrestant >= 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = (day - math.floor(day)) * 24
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day ..txthrs .. Text.hour ..txtminutes .. Text.minute)
						CancelEvent()
						break
				elseif tempsrestant >= 60 and tempsrestant < 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = tempsrestant / 60
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day .. txthrs .. Text.hour .. txtminutes .. Text.minute)
						CancelEvent()
						break
				elseif tempsrestant < 60 then
					local txtday     = 0
					local txthrs     = 0
					local txtminutes = math.ceil(tempsrestant)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day .. txthrs .. Text.hour .. txtminutes .. Text.minute)
						CancelEvent()
						break
				end

			elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then

				deletebanned(license)
				break
			end
		end
	end
end)

AddEventHandler('esx:playerLoaded', function(xPlayer)
	CreateThread(function()
	Wait(5000)
		local license,steamID,liveid,xblid,discord,playerip
		local playername = GetPlayerName(xPlayer)

		for k,v in ipairs(GetPlayerIdentifiers(xPlayer))do
			if string.sub(v, 1, string.len("license:")) == "license:" then
				license = v
			elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
				steamID = v
			elseif string.sub(v, 1, string.len("live:")) == "live:" then
				liveid = v
			elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
				xblid  = v
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
				discord = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
				playerip = v
			end
		end

		MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {
			['@license'] = license
		}, function(data)
		local found = false
			for i=1, #data, 1 do
				if data[i].license == license then
					found = true
				end
			end
			if not found then
				MySQL.Async.execute('INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername)', 
					{ 
					['@license']    = license,
					['@identifier'] = steamID,
					['@liveid']     = liveid,
					['@xblid']      = xblid,
					['@discord']    = discord,
					['@playerip']   = playerip,
					['@playername'] = playername
					},
					function ()
				end)
			else
				MySQL.Async.execute('UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername WHERE `license` = @license', 
					{ 
					['@license']    = license,
					['@identifier'] = steamID,
					['@liveid']     = liveid,
					['@xblid']      = xblid,
					['@discord']    = discord,
					['@playerip']   = playerip,
					['@playername'] = playername
					},
					function ()
				end)
			end
		end)
		if Config.MultiServerSync then
			doublecheck(xPlayer)
		end
	end)
end)

-- Wipe

RegisterNetEvent("fAdmin:WipePlayer")
AddEventHandler("fAdmin:WipePlayer", function(player)
    WipePlayer(source, player)
end)

function WipePlayer(id, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    local steam = xPlayer.getIdentifier()

    DropPlayer(target, "Vous vous êtes fait wipe !")

    MySQL.Async.execute([[ 
		DELETE FROM billing WHERE identifier = @wipeID;
		DELETE FROM billing WHERE sender = @wipeID;
		DELETE FROM open_car WHERE identifier = @wipeID;
		DELETE FROM owned_vehicles WHERE owner = @wipeID;
 		DELETE FROM users WHERE identifier = @wipeID;	]], {
		['@wipeID'] = steam,
    }, function(rowsChanged)
        print("^5Wipe effectuer ! SteamID :"..steam.."^0")
    end)
end


-- Announce

RegisterServerEvent('fAdmin:sendAnnounce')
AddEventHandler('fAdmin:sendAnnounce', function(target, text, author)
    local xPlayer = ESX.GetPlayerFromId(source)
    local NomDuStaff = xPlayer.getName()
		if (author == nil and target ~= -1) then
			author = GetPlayerName(source);
		end

		TriggerClientEvent('fAdmin:sendAnnounce', target, text, author);
        envoyerdiscord("fAdmin","__Une announce :__ "..text.." \n\n__Staff :__ "..NomDuStaff.."", 16744192, fAdmin.webhooks)
end)


-- Discord

function envoyerdiscord(name,message,color,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "fAdmin by Fellow",
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(fAdmin.webhooks, function(err, text, headers) end, 'POST', json.encode({ username = "fAdmin Bot",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end