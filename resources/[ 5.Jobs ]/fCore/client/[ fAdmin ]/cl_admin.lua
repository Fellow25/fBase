--[[ 
	
Ajouter admin, mod ou help

if playergroup == "admin" then
		LE BUTTON
end

Si tu veut ajouter plusieurs group

if playergroup == "admin" or playergroup == "mod" then
		LE BUTTON
end

]]

ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end
	ESX.TriggerServerCallback('fAdmin:getUsergroup', function(group)
        playergroup = group
    end)
	SetNuiFocus(false, false)
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

local crossthemap = false
local fastSprint = false
local ServersIdSession = {}
local pos_before_assist,assisting,assist_target,last_assist,IsFirstSpawn = nil, false, nil, nil, true
local grade = "inconnu"
local onlinePlayers = GetNumberOfPlayers()
local gamerTags = {}
local spectating = false

CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(ServersIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(ServersIdSession, GetPlayerServerId(v))
            end
        end
    end
end)

CreateThread(function()
	while true do
		Wait(200)

		if invisible then
			SetEntityVisible(PlayerPedId(), 0, 0)
			NetworkSetEntityInvisibleToNetwork(pPed, 1)
		else
			SetEntityVisible(PlayerPedId(), 1, 0)
			NetworkSetEntityInvisibleToNetwork(pPed, 0)
		end

		if ShowName then
			local pCoords = GetEntityCoords(PlayerPedId(), false)
			for _, v in pairs(GetActivePlayers()) do
				local otherPed = GetPlayerPed(v)
			
				if otherPed ~= pPed then
					if #(pCoords - GetEntityCoords(otherPed, false)) < 250.0 then
						gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
						SetMpGamerTagVisibility(gamerTags[v], 4, 1)
					else
						RemoveMpGamerTag(gamerTags[v])
						gamerTags[v] = nil
					end
				end
			end
		else
			for _, v in pairs(GetActivePlayers()) do
				RemoveMpGamerTag(gamerTags[v])
			end
		end
    end
end)

function defESX()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end

CreateThread(function()
    defESX()
end)

function Notification(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end

RegisterNetEvent("fAdmin:Notification")
AddEventHandler("fAdmin:Notification", function(msg) 
	Notification(msg) 
end)

RegisterNetEvent("fAdmin:Open/CloseReport")
AddEventHandler("fAdmin:Open/CloseReport", function(type, nomdumec, raisondumec)
    if type == 1 then
        ESX.TriggerServerCallback('fAdmin:getUsergroup', function(group)
            if group == 'admin' or group == 'mod' or group == 'help' then
                ESX.ShowNotification('Un nouveau report à été effectué !')
            end
        end)
    elseif type == 2 then
        ESX.TriggerServerCallback('fAdmin:getUsergroup', function(group)
            if group == 'admin' or group == 'mod' or group == 'help' then
                ESX.ShowNotification('Le report de ~b~'..nomdumec..'~s~ à été fermé !')
            end
        end)
    end
end)

function setpsurlemec(iddumec) 
    if iddumec then
        local PlayerPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(iddumec)))
        SetEntityCoords(PlayerPedId(), PlayerPos.x, PlayerPos.y, PlayerPos.z)
    end
end

function tplemecsurmoi(iddugars)
    if iddugars then
        local plyPedCoords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('fAdmin:bring', iddugars, plyPedCoords, "bring")
    end
end

RegisterNetEvent('fAdmin:bring')
AddEventHandler('fAdmin:bring', function(plyPedCoords)
    plyPed = PlayerPedId()
	SetEntityCoords(plyPed, plyPedCoords)
end)

local function getInfoReport()
    local info = {}
    ESX.TriggerServerCallback('fAdmin:infoReport', function(info)
        reportlist = info
    end)
end

-- Menu
function fAdminMenu()
    local fAdmin = RageUI.CreateMenu("Menu Admin", "by Fellow")
    local fAdminActionsPerso = RageUI.CreateSubMenu(fAdmin, "Menu Admin", "Personnel")
	local fAdminActionsServeur = RageUI.CreateSubMenu(fAdmin, "Menu Admin", "Serveur")
    local fAdminGive = RageUI.CreateSubMenu(fAdminActionsPerso, "Menu Admin", "Personnel")
    local fAdminJoueurs = RageUI.CreateSubMenu(fAdmin, "Menu Admin", "Joueurs en ligne")
    local fAdminOptions = RageUI.CreateSubMenu(fAdminJoueurs, "Menu Admin", "Joueurs en ligne")
    local fAdminVehicule = RageUI.CreateSubMenu(fAdmin, "Menu Admin", "Véhicule")
    local fAdminVehiculeCouleur = RageUI.CreateSubMenu(fAdminVehicule, "Menu Admin", "Véhicule")
    local fAdminPed = RageUI.CreateSubMenu(fAdmin, "Menu Admin", "Personnage")
	local fAdminTemps = RageUI.CreateSubMenu(fAdminActionsServeur, "Menu Admin", "Gestion temps")
	local fAdminReport = RageUI.CreateSubMenu(fAdmin, "Menu Admin", "Reports")
	local fAdminTeleport = RageUI.CreateSubMenu(fAdmin, "Menu Admin", "Teleportation")
	local fAdminInfo = RageUI.CreateSubMenu(fAdminReport, "Menu Admin", "Reports")
	
    fAdmin:SetRectangleBanner(105, 105, 105, 15)
    fAdminActionsPerso:SetRectangleBanner(105, 105, 105, 15)
	fAdminActionsServeur:SetRectangleBanner(105, 105, 105, 15)
    fAdminGive:SetRectangleBanner(105, 105, 105, 15)
    fAdminJoueurs:SetRectangleBanner(105, 105, 105, 15)
    fAdminOptions:SetRectangleBanner(105, 105, 105, 15)
    fAdminVehicule:SetRectangleBanner(105, 105, 105, 15)
    fAdminVehiculeCouleur:SetRectangleBanner(105, 105, 105, 15)
    fAdminPed:SetRectangleBanner(105, 105, 105, 15)
	fAdminTemps:SetRectangleBanner(105, 105, 105, 15)
	fAdminReport:SetRectangleBanner(105, 105, 105, 15)
	fAdminTeleport:SetRectangleBanner(105, 105, 105, 15)
	fAdminInfo:SetRectangleBanner(105, 105, 105, 15)
	defESX()
	getInfoReport()

	if playergroup == "admin" then
		grade = "Administrateur"
	end

	if playergroup == "mod" then
		grade = "Modérateur"
	end

	if playergroup == "help" then
		grade = "Helpeur"
	end

    RageUI.Visible(fAdmin, not RageUI.Visible(fAdmin))
    while fAdmin do
        Wait(0)
            RageUI.IsVisible(fAdmin, true, true, true, function()

                RageUI.Separator("~r~["..grade.."] ~y~"..GetPlayerName(PlayerId()))

				players = {}
				for _, player in ipairs(GetActivePlayers()) do
					local ped = GetPlayerPed(player)
					table.insert( players, player )
				end

				RageUI.Separator("Total de joueurs en ligne: " ..#players)

                RageUI.ButtonWithStyle("Actions personnel", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fAdminActionsPerso)

				RageUI.ButtonWithStyle("Actions sur les véhicules", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fAdminVehicule)


                RageUI.ButtonWithStyle("Actions sur les joueurs", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fAdminJoueurs)

				if playergroup == "admin" then
					RageUI.ButtonWithStyle("Actions sur le serveur", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					end, fAdminActionsServeur)
				end

				if playergroup == "admin" then
					RageUI.ButtonWithStyle("Changer de personnage", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					end, fAdminPed)
				end

				RageUI.ButtonWithStyle("Teleportation", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fAdminTeleport)

				RageUI.ButtonWithStyle("Ouvrir les reports", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fAdminReport)

            end, function()
			end)

            RageUI.IsVisible(fAdminActionsPerso, true, true, true, function()

				RageUI.ButtonWithStyle("Téléporter sur coordonnées", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then 
						local street = GetStreetNameAtCoord(x, y, z)
						local street2 = GetStreetNameFromHashKey(street)  
						local x = fAdminKeyboardInput("Entrer la position X", "", 10)
						local y = fAdminKeyboardInput("Entrer la position Y", "", 10)
						local z = fAdminKeyboardInput("Entrer la position Z", "", 10)
						if x and y and z then
							ExecuteCommand("setcoords "..x.." "..y.." "..z)
							ESX.ShowNotification("Vous venez de vous rendre à "..street2)
						else
							RageUI.CloseAll()	
						end	
					end
				end)

                                RageUI.ButtonWithStyle("Téléporter sur son marqueur", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        ExecuteCommand("tpm")
                        end
                end)

                RageUI.ButtonWithStyle("Afficher/Cacher coordonnées", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    Admin.showcoords = not Admin.showcoords    
                    end   
                end)

				if playergroup == "admin" then
					RageUI.ButtonWithStyle("Give", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					end, fAdminGive)
				end

				RageUI.Checkbox("Afficher id + noms", description, affichername,{},function(Hovered,Ative,Selected,Checked)
					if Selected then
						affichername = Checked
						if Checked then
							ShowName = true
						else
							ShowName = false
						end
					end
				end)

                RageUI.Checkbox("Noclip", nil, crossthemap,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        crossthemap = Checked
                        if Checked then
                            fNoClip()
                        else
                            fNoClip()
                        end
                    end
                end)

                RageUI.Checkbox("Super Sprint", description, fastSprint,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        fastSprint = Checked
                        if Checked then
                            SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
                        else
                            SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
                        end
                    end
                end)

				RageUI.Checkbox("Invincible", description, godmode,{},function(Hovered,Ative,Selected,Checked)
					if (Selected) then       
						godmode = Checked
                        if Checked then
							SetEntityInvincible(PlayerPedId(), true)
							ESX.ShowNotification('Invicible ~g~ON')
						else
							SetEntityInvincible(PlayerPedId(), false)
							ESX.ShowNotification('Invicible ~r~OFF')
						end
					end
				end)

                end, function()
                end)

				RageUI.IsVisible(fAdminActionsServeur, true, true, true, function()

					RageUI.ButtonWithStyle("Faire une annonce", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local AnnounceText = fAdminKeyboardInput("Message", "", 150)
							TriggerServerEvent('fAdmin:sendAnnounce', -1, AnnounceText)
							RageUI.CloseAll()
						end
					end)

					RageUI.ButtonWithStyle("Supprimer les pnj", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
			
							ClearAreaOfPeds(x,y,z, 50.0, 1)
							
							return x,y,z
							
						end
					end)
		
					RageUI.ButtonWithStyle("Supprimer les véhicules", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("dv 500")
						end
					end)


				RageUI.ButtonWithStyle("Gestion temps", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, fAdminTemps)

				end, function()
				end)

                RageUI.IsVisible(fAdminGive, true, true, true, function()

                RageUI.ButtonWithStyle("Vie", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        TriggerEvent('esx_status:set', 'hunger', 1000000)
	                    TriggerEvent('esx_status:set', 'thirst', 1000000)
						ESX.ShowNotification("~g~Heal effectué~w~")
                        end   
                    end)

                RageUI.ButtonWithStyle("Blindage", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        SetPedArmour(PlayerPedId(), 200)
                        ESX.ShowNotification("~g~Blindage effectué~w~")
                        end   
                    end)

				RageUI.ButtonWithStyle("Give un item/arme", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						local item = fAdminKeyboardInput("Item oú arme", "", 10)
						local amount = fAdminKeyboardInput("Nombre", "", 10)
						if item and amount then
							ExecuteCommand("giveitem "..GetPlayerServerId(PlayerId()).. " " ..item.. " " ..amount)
							ESX.ShowNotification("Vous venez de recevoir ~g~"..amount.. " " .. item .. "~y~ !")	
						else
							RageUI.CloseAll()	
						end			
					end
				end)

                RageUI.ButtonWithStyle("Argent cash", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        GiveArgentCash()
                        end   
                    end)

                RageUI.ButtonWithStyle("Argent sale", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        GiveArgentSale()  
                        end   
                    end)

                RageUI.ButtonWithStyle("Argent banque", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                    if (Selected) then   
                        GiveArgentBanque()  
                        end   
                    end)

            end, function()
			end)

                RageUI.IsVisible(fAdminJoueurs, true, true, true, function()

                players = {}
                for _, player in ipairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(player)
                    table.insert( players, player )
                end

					RageUI.Separator("Total de joueurs: " ..#players)

                    for k,v in ipairs(ServersIdSession) do
						if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(ServersIdSession, k) end
						RageUI.ButtonWithStyle("[~r~"..v.."~s~] " ..GetPlayerName(GetPlayerFromServerId(v)), nil, {}, true, function(Hovered, Active, Selected)
							if (Selected) then
								IdSelected = v
							end
						end, fAdminOptions)
					end
				end, function()
				end)

                RageUI.IsVisible(fAdminOptions, true, true, true, function()

                    RageUI.Separator("↓ Intéraction possible sur ~y~"..GetPlayerName(GetPlayerFromServerId(IdSelected)).. "~s~ ↓", nil, {}, true, function(_, _, _)
					end)

					RageUI.ButtonWithStyle("Spectate", nil, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
						local playerId = GetPlayerFromServerId(IdSelected)
                            SpectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
						end
					end)
					
                    RageUI.ButtonWithStyle("Envoyer un message", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local msg = fAdminKeyboardInput("Raison", "", 100)

                            if msg ~= nil then
                                msg = tostring(msg)
                        
                                if type(msg) == 'string' then
                                    TriggerServerEvent("fAdmin:Message", IdSelected, msg)
                                    RageUI.CloseAll()
                                end
                            end
                            ESX.ShowNotification("Vous venez d'envoyer le message à ~b~" .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
                        end
                    end)

                    RageUI.ButtonWithStyle("Téléporter sur le joueur", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("goto "..IdSelected)
							ESX.ShowNotification("~b~Vous venez de vous téléporter à l\'ID : ~s~ " ..IdSelected)
						end
					end)

                    RageUI.ButtonWithStyle("Téléporter à vous", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected, target)
						if (Selected) then
							ExecuteCommand("bring "..IdSelected)
							ESX.ShowNotification("~b~Vous venez de téléporter l\'ID :~s~ " ..IdSelected.. " ~b~à vous~s~ !")
						end
					end)

                    RageUI.ButtonWithStyle("Setjob", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local job = fAdminKeyboardInput("Entrer le job que vous souhaiter", "", 10)
                            local grade = fAdminKeyboardInput("Entrer le grade que vous souhaiter", "", 10)
                            if job and grade then
                                ExecuteCommand("setjob "..IdSelected.. " " ..job.. " " ..grade)
                                ESX.ShowNotification("Vous venez de setjob ~g~"..job.. " " .. grade .. " l\'ID : " ..IdSelected)
                            else
                                RageUI.CloseAll()	
                            end	
                        end
                    end)

					RageUI.ButtonWithStyle("Setjob 2", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local job = fAdminKeyboardInput("Entrer le gang/orga que vous souhaiter", "", 10)
                            local grade = fAdminKeyboardInput("Entrer le grade que vous souhaiter", "", 10)
                            if job and grade then
                                ExecuteCommand("setjob2 "..IdSelected.. " " ..job.. " " ..grade)
                                ESX.ShowNotification("Vous venez de setjob2 ~g~"..job.. " " .. grade .. " l\'ID : " ..IdSelected)
                            else
                                RageUI.CloseAll()	
                            end	
                        end
                    end)


					RageUI.ButtonWithStyle("Give véhicule (avec clé)", nil, {RightLabel =  "→"}, true, function(_, Active, Selected)
                        if Selected then
            
                            local ped = GetPlayerPed(tgt)
                            local ModelName = fAdminKeyboardInput("Véhicule", "", 100)
            
                            if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                                RequestModel(ModelName)
                                while not HasModelLoaded(ModelName) do
                                    Wait(0)
                                end
                                    --local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
                                    --TaskWarpPedIntoVehicle(GetPlayerPed(IdSelected), veh, -1)
                                    give_vehijoueur(ModelName, IdSelected)
                                    Wait(50)
                            else
                                ShowNotification("Erreur !")
                            end
                        end
                        end)

                    RageUI.ButtonWithStyle("Heal", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							if IdSelected then
								ExecuteCommand("heal "..IdSelected)
								ESX.ShowNotification("~g~Heal de l'ID "..IdSelected.." effectué~w~")
							else
								RageUI.CloseAll()	
							end
						end
					end)

                    RageUI.ButtonWithStyle("Revive une personne",description, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand('revive '..IdSelected)
							end      
						end)

					if playergroup == "admin" then
						RageUI.ButtonWithStyle("Give un item/arme", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
							if (Selected) then
								local item = fAdminKeyboardInput("Item oú arme", "", 10)
								local amount = fAdminKeyboardInput("Nombre", "", 10)
								if item and amount then
									ExecuteCommand("giveitem "..IdSelected.. " " ..item.. " " ..amount)
									ESX.ShowNotification("Vous venez de donner ~g~"..amount.. " " .. item .. " ~w~à ".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~y~ !")	
								else
									RageUI.CloseAll()	
								end			
							end
						end)
					end

					RageUI.ButtonWithStyle("Wipe l'inventaire", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("clearinventory "..IdSelected)
							ESX.ShowNotification("Vous venez d'enlever tout les items de ~b~".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~y~ !")
						end
					end)

                    RageUI.Checkbox("~g~Freeze / Unfreeze",nil, service,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
        
                            service = Checked
        
        
                            if Checked then
                                ExecuteCommand('freeze '..IdSelected)
                                
                            else
                                ExecuteCommand('unfreeze '..IdSelected)
                            end
                        end
                    end)

					RageUI.ButtonWithStyle("~b~Wipe ~s~le joueur", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local reason = fAdminKeyboardInput("Oui pour valider le wipe", "", 100)
							if reason == "oui" then
							TriggerServerEvent("fAdmin:WipePlayer", IdSelected)
							ESX.ShowNotification("Vous avez bien wipe ~y~".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~s~ !")			
						else 
								ESX.ShowNotification("La commande de wipe à été annulée")
                            RageUI.CloseAll()
							end
						end
					end)

                    RageUI.ButtonWithStyle("~r~Kick ~s~le joueur", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local reason = fAdminKeyboardInput("Raison du kick", "", 100)
							if reason then
								TriggerServerEvent("fAdmin:kickjoueur", IdSelected, reason)
								RageUI.CloseAll()	
							end	
						end
					end)

                    RageUI.ButtonWithStyle("~r~Ban ~s~le joueur", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							if IdSelected then
								local time = fAdminKeyboardInput("Temps de ban", "", 10)
                            	local raison = fAdminKeyboardInput("Raison de ban", "", 10)
								ExecuteCommand("sqlban "..IdSelected.. " " ..time.. " " ..raison)
                            	RageUI.CloseAll()
							end
						end
					end)

                end, function()
				end)

                RageUI.IsVisible(fAdminVehicule, true, true, true, function()

                    RageUI.ButtonWithStyle("Faire apparaître un véhicule", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
					if Selected then
		
						local ped = GetPlayerPed(tgt)
						local ModelName = fAdminKeyboardInput("Véhicule", "", 100)
		
						if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
							RequestModel(ModelName)
							while not HasModelLoaded(ModelName) do
								Wait(0)
							end
								local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
								TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
								Wait(50)
						else
							ShowNotification("Erreur !")
						end
					end
					end)

                    RageUI.ButtonWithStyle("Réparer", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local plyVeh = GetVehiclePedIsIn(PlayerPedId(), false)
					        SetVehicleFixed(plyVeh)
					        SetVehicleDirtLevel(plyVeh, 0.0) 
						end   
					end)   
					
					RageUI.ButtonWithStyle("Custom au maximum", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						FullVehicleBoost()
						end   
					end) 

					RageUI.ButtonWithStyle("Changer la plaque", nil, {RightLabel =  "→"}, true, function(_, Active, Selected)
					if Selected then
						if IsPedSittingInAnyVehicle(PlayerPedId()) then
							local plaqueVehicule = fAdminKeyboardInput("Plaque", "", 8)
							SetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false) , plaqueVehicule)
							ESX.ShowNotification("La plaque du véhicule est désormais : ~g~"..plaqueVehicule)
						else
							ESX.ShowNotification("~r~Erreur\n~s~Vous n'êtes pas dans un véhicule !")
						end
					end
					end)

					RageUI.ButtonWithStyle("Mettre en Fourrière", nil, {RightLabel =  "→"}, true, function(_, Active, Selected)
                        if Selected then
                            local playerPed = PlayerPedId()
    
                            if IsPedSittingInAnyVehicle(playerPed) then
                                local vehicle = GetVehiclePedIsIn(playerPed, false)
                
                                if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                                    ESX.ShowNotification('Le véhicule a été mis en fourrière.')
                                    ESX.Game.DeleteVehicle(vehicle)
                                   
                                else
                                    ESX.ShowNotification('Mettez vous place conducteur ou sortez de la voiture.')
                                end
                            else
                                local vehicle = ESX.Game.GetVehicleInDirection()
                
                                if DoesEntityExist(vehicle) then
                                    ClearPedTasks(playerPed)
                                    ESX.ShowNotification('Le véhicule à été placer en fourrière.')
                                    ESX.Game.DeleteVehicle(vehicle)
                
                                else
                                    ESX.ShowNotification('Aucune voitures autour')
                                end
                            end
                            end
                        end)

					if playergroup == "admin" then
						RageUI.ButtonWithStyle("Give véhicule (avec clé)", nil, {RightLabel =  "→"}, true, function(_, Active, Selected)
							if Selected then
				
								local ped = GetPlayerPed(tgt)
								local ModelName = fAdminKeyboardInput("Véhicule", "", 100)
				
								if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
									RequestModel(ModelName)
									while not HasModelLoaded(ModelName) do
										Wait(0)
									end
										--local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, true)
										TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
										give_vehi(ModelName)
										Wait(50)
								else
									ShowNotification("Erreur !")
								end
							end
						end)
					end

                        RageUI.ButtonWithStyle("Changer la couleur du véhicule", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        end, fAdminVehiculeCouleur)

                end, function()
				end)

                RageUI.IsVisible(fAdminVehiculeCouleur, true, true, true, function()

                    RageUI.ButtonWithStyle("Bleu", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 0, 0, 255)
						SetVehicleCustomSecondaryColour(vehicle, 0, 0, 255)
						end      
					end)
					RageUI.ButtonWithStyle("Rouge", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 255, 0, 0)
						SetVehicleCustomSecondaryColour(vehicle, 255, 0, 0)
						end      
					end)
					RageUI.ButtonWithStyle("Vert", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 0, 255, 0)
						SetVehicleCustomSecondaryColour(vehicle, 0, 255, 0)
						end      
					end)
					RageUI.ButtonWithStyle("Noir", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
						SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
						end      
					end)
					RageUI.ButtonWithStyle("Rose", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 100, 0, 60)
						SetVehicleCustomSecondaryColour(vehicle, 100, 0, 60)
						end      
					end)
					RageUI.ButtonWithStyle("Blanc", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
						SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
						end      
					end)
				 
			   end, function()
				end)

                RageUI.IsVisible(fAdminPed, true, true, true, function()

                    RageUI.ButtonWithStyle("Reprendre son personnage", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
							local isMale = skin.sex == 0
		
		
							TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
								ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
									TriggerEvent('skinchanger:loadSkin', skin)
									TriggerEvent('esx:restoreLoadout')
							end)
							end)
							end)
					end
					end)

					RageUI.ButtonWithStyle("Entrer un ped custom", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local newped = fAdminKeyboardInput('Entrer le nom de votre Ped', '', 45)
						local p1 = GetHashKey(newped)
						RequestModel(p1)
						while not HasModelLoaded(p1) do
						  Wait(100)
						 end
						 SetPlayerModel(j1, p1)
						 SetModelAsNoLongerNeeded(p1)
						end      
					end)

					RageUI.Separator("↓ ~y~Sélection rapide ~s~↓")
				
					RageUI.ButtonWithStyle("Travailleur", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('s_m_y_airworker')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
							Wait(100)
							end
							SetPlayerModel(j1, p1)
							SetModelAsNoLongerNeeded(p1)
						end      
					end)

					RageUI.ButtonWithStyle("Chirurgien", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('s_m_y_factory_01')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
							Wait(100)
							end
							SetPlayerModel(j1, p1)
							SetModelAsNoLongerNeeded(p1)
						end      
					end)

					RageUI.ButtonWithStyle("Strip-teaseuse", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('s_f_y_stripperlite')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
							Wait(100)
							end
							SetPlayerModel(j1, p1)
							SetModelAsNoLongerNeeded(p1)
						end      
					end)

					 RageUI.ButtonWithStyle("Alien", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('s_m_m_movalien_01')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
							Wait(100)
							end
							SetPlayerModel(j1, p1)
							SetModelAsNoLongerNeeded(p1)
						end      
					end)

					 RageUI.ButtonWithStyle("Chat", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('a_c_cat_01')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
						  Wait(100)
						 end
						 SetPlayerModel(j1, p1)
						 SetModelAsNoLongerNeeded(p1)
						end      
					end)

					 RageUI.ButtonWithStyle("Aigle", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('a_c_chickenhawk')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
						  Wait(100)
						 end
						 SetPlayerModel(j1, p1)
						 SetModelAsNoLongerNeeded(p1)
						end      
					end)

					 RageUI.ButtonWithStyle("Coyote", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local p1 = GetHashKey('a_c_coyote')
						RequestModel(p1)
						while not HasModelLoaded(p1) do
						  Wait(100)
						 end
						 SetPlayerModel(j1, p1)
						 SetModelAsNoLongerNeeded(p1)
						end      
					end)

				end, function()
				end)

				RageUI.IsVisible(fAdminTemps, true, true, true, function()

					RageUI.ButtonWithStyle("Choisir une heure", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
						local heure = fAdminKeyboardInput('Entrer l\'heure que vous souhaiter (Example 23 00)', '', 45)
							ExecuteCommand("time "..heure)
						end
					end)

					RageUI.ButtonWithStyle("Bloqué le temps", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("freezetime")
						end
					end)
			
					RageUI.ButtonWithStyle("Soleil plein", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weather EXTRASUNNY")
						end
					end)

					RageUI.ButtonWithStyle("Temps dégagé", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weather CLEAR")
						end
					end)

					RageUI.ButtonWithStyle("Temps neutre", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						  if (Selected) then
							ExecuteCommand("weather NEUTRAL")
						  end
					  end)

					RageUI.ButtonWithStyle("Temps halloween", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weather HALLOWEEN")
						end
					end)

					RageUI.ButtonWithStyle("Temps de neige", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weather XMAS")
						end
					end)


					RageUI.ButtonWithStyle("Temps de pluit", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weather RAIN")
						end
					end)

					RageUI.ButtonWithStyle("Temps nuageux", nil, {RightLabel =  "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weather CLOUDS")
						end
					end)
			  
			 end, function()
			  end)

			  RageUI.IsVisible(fAdminReport, true, true, true, function()

				if #reportlist >= 1 then
					RageUI.Separator("↓ Nouveaux Report ↓")

					for k,v in pairs(reportlist) do
						RageUI.ButtonWithStyle(k.." - Report de [~y~"..v.nom.."~s~] | Id : [~p~"..v.id.."~s~]", nil, {RightLabel = "→→"},true , function(_,_,s)
							if s then
								nom = v.nom
								nbreport = k
								id = v.id
								raison = v.args
							end
						end, fAdminInfo)
					end
				else
					RageUI.Separator("")
					RageUI.Separator("~y~Aucun Report~s~")
					RageUI.Separator("")
				end
				
			end, function()
			end)

			RageUI.IsVisible(fAdminTeleport, true, true, true, function()

				
                RageUI.Checkbox("Lieux publics",nil, lieux,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
                        lieux = Checked;
    
                        if Checked then
                            lieux = true
                        else
                            lieux = false
                        end
                    end
                end)

                if lieux then
					RageUI.ButtonWithStyle("~m~Aéroport", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -1038.26 -2739.16 20.17")
						end
					end)
					RageUI.ButtonWithStyle("~m~Banque principal", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 222.19 209.25 105.5")
						end
					end)     
					RageUI.ButtonWithStyle("~m~Parking central", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords  216.17 -810.17 30.72")
						end
					end)   
				end

				RageUI.Checkbox("Service public",nil, servicepublique,{},function(Hovered,Ative,Selected,Checked)
					if Selected then
						servicepublique = Checked;

						if Checked then
							servicepublique = true
						else
							servicepublique = false
						end
					end
				end)

				if servicepublique then
					RageUI.ButtonWithStyle("~m~Fourrière", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 415.61 -1632.47 29.29")
						end
					end)   
					RageUI.ButtonWithStyle("~m~Hôpital", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 281.91 -586.55 43.29")
						end
					end)   
					RageUI.ButtonWithStyle("~m~Police", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 423.41 -980.02 30.71")
						end
					end)
					RageUI.ButtonWithStyle("~m~Pompier", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 1201.65 -1460.39 34.77")
						end
					end)
					RageUI.ButtonWithStyle("~m~Taxi", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 914.56 -179.67 74.14")
						end
					end)   
				end   

				RageUI.Checkbox("Jobs",nil, jobs,{},function(Hovered,Ative,Selected,Checked)
					if Selected then
						jobs = Checked;

						if Checked then
							jobs = true
						else
							jobs = false
						end
					end
				end)

				if jobs then
					RageUI.ButtonWithStyle("~m~Ammu-Nation", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 811.96 -2147.6 29.51")
						end
					end)   
					RageUI.ButtonWithStyle("~m~Auto-École", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -43.48 -219.65 45.45")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Boulangerie", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 396.21 -793.3 29.29")
						end
					end)   
					RageUI.ButtonWithStyle("~m~Brasserie", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -509.37 -21.46 45.61")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Concessionnaire Auto", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -57.0 -1099.44 26.42")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Concessionnaire Moto", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 286.8 -1146.12 29.29")
						end
					end)   
					RageUI.ButtonWithStyle("~m~MC Donalds", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 79.99 270.45 109.85")
						end
					end)     
					RageUI.ButtonWithStyle("~m~Mécanicien", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -206.48 -1303.52 31.25")
						end
					end)     
				end

				RageUI.Separator("")

				RageUI.Checkbox("Bar",nil, bar,{},function(Hovered,Ative,Selected,Checked)
					if Selected then
						bar = Checked;

						if Checked then
							bar = true
						else
							bar = false
						end
					end
				end)

				if bar then
					RageUI.ButtonWithStyle("~m~Bahamas", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -1391.2 -583.38 30.23")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Tequila", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -565.17 270.17 83.02")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Unicorn", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 143.66 -1308.21 29.18")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Vigneron", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -1893.23 2037.2 140.75")
						end
					end) 
					RageUI.ButtonWithStyle("~m~Split Sides", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -430.44 259.48 82.99")
						end
					end) 
				end
  
     
				RageUI.Checkbox("Gang / Org",nil, jobsorg,{},function(Hovered,Ative,Selected,Checked)
					if Selected then
						jobsorg = Checked;

						if Checked then
							jobsorg = true
						else
							jobsorg = false
						end
					end
				end)

				if jobsorg then
					RageUI.ButtonWithStyle("~m~Ballas", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 92.74 -1931.62 20.18")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Blanchisseur", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 1144.17 -986.39 45.92")
						end
					end)     
					RageUI.ButtonWithStyle("~m~Families", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords -129.3 -1591.84 34.21")
						end
					end)   		
					RageUI.ButtonWithStyle("~m~Marabunta", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 1436.31 -1495.74 63.22")
						end
					end) 
					RageUI.ButtonWithStyle("~m~Vagos", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 329.78 -2035.86 20.99")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Mafia", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 386.27 3.24 91.27")
						end
					end)  
					RageUI.ButtonWithStyle("~m~Cartel", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("setcoords 1401.47 1118.92 114.84")
						end
					end) 
				end
   
				end, function()
				end)  

			RageUI.IsVisible(fAdminInfo, true, true, true, function()

				RageUI.Separator("Report numéro : ~y~"..nbreport)
                    RageUI.Separator("Auteur : ~y~"..nom.."~s~ [~y~"..id.."~s~]")
                    RageUI.Separator("Raison du report : ~y~"..raison)

                    RageUI.ButtonWithStyle("Se téléporter", nil, {RightLabel = "→"}, true, function(_,_,s)
                        if s then
                            setpsurlemec(id)
                        end
                    end)

                    RageUI.ButtonWithStyle("Téléporter sur moi", nil, {RightLabel = "→"}, true, function(_,_,s)
                        if s then
                            tplemecsurmoi(id)
                        end
                    end)

					RageUI.Checkbox("~g~Freeze / Unfreeze",nil, service,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
        
                            service = Checked
        
        
                            if Checked then
                                ExecuteCommand('freeze '..id)
                                
                            else
                                ExecuteCommand('unfreeze '..id)
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("~g~Répondre au report", nil, {RightLabel = "→"}, true, function(_, _, s)
                        if s then 
                            local reponse = fAdminKeyboardInput('~c~Entrez le message ici :', nil, 30)
                            local reponseReport = GetOnscreenKeyboardResult(reponse)
                            if reponseReport == "" then
                                Notification("~y~Admin\n~r~Vous n'avez pas fourni de message")
                            else
                                if reponseReport then
                                    Notification("Le message : ~b~"..reponseReport.."~s~ a été envoyer à ~y~"..GetPlayerName(GetPlayerFromServerId(id))) 
                                    TriggerServerEvent("fAdmin:message", id, "~y~Staff~s~\n"..reponseReport)
                                end
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("~r~Fermer le report", nil, {RightLabel = "→"}, true, function(_,_,s)
                        if s then
                            TriggerServerEvent('fAdmin:CloseReport', nom, raison)
                            TriggerServerEvent("fAdmin:message", id, "~y~Staff~s~\nVotre report à été fermé !")
                            RageUI.CloseAll()
                            reportMenu = false
                        end
                    end)
                    
                end, function()
				end)

              if not RageUI.Visible(fAdmin) and not RageUI.Visible(fAdminActionsPerso) and not RageUI.Visible(fAdminGive) and not RageUI.Visible(fAdminJoueurs) and not RageUI.Visible(fAdminOptions) and not RageUI.Visible(fAdminVehicule) and not RageUI.Visible(fAdminVehiculeCouleur) and not RageUI.Visible(fAdminPed) and not RageUI.Visible(fAdminTemps) and not RageUI.Visible(fAdminReport) and not RageUI.Visible(fAdminInfo) and not RageUI.Visible(fAdminActionsServeur)  and not RageUI.Visible(fAdminTeleport) then
              fAdmin = RMenu:DeleteType("fAdmin", true)
        end
    end
end

Keys.Register('F10', 'fAdmin', 'Ouvrir le menu F10', function()
    ESX.TriggerServerCallback('fAdmin:getUsergroup', function(group)
        if group == 'admin' or group == 'mod' or group == 'help' then
    		fAdminMenu()
        end
    end)
end)

-- Coords
CreateThread(function()
    while true do
    	if Admin.showcoords then
            x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
            roundx=tonumber(string.format("%.2f",x))
            roundy=tonumber(string.format("%.2f",y))
            roundz=tonumber(string.format("%.2f",z))
            DrawTxt("~r~X:~s~ "..roundx,0.05,0.00)
            DrawTxt("     ~r~Y:~s~ "..roundy,0.11,0.00)
            DrawTxt("        ~r~Z:~s~ "..roundz,0.17,0.00)
            DrawTxt("             ~r~Angle:~s~ "..GetEntityHeading(PlayerPedId()),0.21,0.00)
        end
        if Admin.showcrosshair then
            DrawTxt('+', 0.495, 0.484, 1.0, 0.3, MainColor)
        end
    	Wait(0)
    end
end)

Admin = {
	showcoords = false,
}
MainColor = {
	r = 225, 
	g = 55, 
	b = 55,
	a = 255
}

--DrawTxt
function DrawTxt(text,r,z)
    SetTextColour(MainColor.r, MainColor.g, MainColor.b, 255)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0,0.4)
    SetTextDropshadow(1,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(r,z)
 end

 --Argent cash
 function GiveArgentCash()
	local amount = fAdminKeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('fAdmin:GiveArgentCash', amount)
            ESX.ShowNotification("~g~Give argent cash effectué~w~ "..amount.." €")
		end
	end
end

 --Argent sale
 function GiveArgentSale()
	local amount = fAdminKeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('fAdmin:GiveArgentSale', amount)
            ESX.ShowNotification("~g~Give argent sale effectué~w~ "..amount.." €")
		end
	end
end

 --Argent banque
 function GiveArgentBanque()
	local amount = fAdminKeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then
			TriggerServerEvent('fAdmin:GiveArgentBanque', amount)
            ESX.ShowNotification("~g~Give argent banque effectué~w~ "..amount.." €")
		end
	end
end

--NoClip
local noclip = false
local noclip_speed = 1.0

function fNoClip()
  noclip = not noclip
  local ped = PlayerPedId()
  if noclip then -- activé
    SetEntityInvincible(ped, true)
	SetEntityVisible(ped, false, false)
	invisible = true
	Notify("Noclip ~g~activé")
  else -- désactivé
    SetEntityInvincible(ped, false)
	SetEntityVisible(ped, true, false)
	invisible = false
	Notify("Noclip ~r~désactivé")
  end
end

function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    return x,y,z
  end
  
  function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(PlayerPedId())
    local pitch = GetGameplayCamRelativePitch()
  
    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)
  
    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
      x = x/len
      y = y/len
      z = z/len
    end
  
    return x,y,z
  end
  
  function isNoclip()
    return noclip
  end
  
  CreateThread(function()
      while true do
        local Timer = 500
        if noclip then
          local ped = PlayerPedId()
          local x,y,z = getPosition()
          local dx,dy,dz = getCamDirection()
          local speed = noclip_speed
    
          -- reset du velocity
          SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
          Timer = 0  
          -- aller vers le haut
          if IsControlPressed(0,32) then -- MOVE UP
            x = x+speed*dx
            y = y+speed*dy
            z = z+speed*dz
          end
    
          -- aller vers le bas
          if IsControlPressed(0,269) then -- MOVE DOWN
            x = x-speed*dx
            y = y-speed*dy
            z = z-speed*dz
          end
    
          SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
        end
        Wait(Timer)
      end
    end)

--Message
RegisterNetEvent("fAdmin:envoyer")
AddEventHandler("fAdmin:envoyer", function(msg)
    PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    local head = RegisterPedheadshot(PlayerPedId())
    while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
        Wait(1)
    end
    headshot = GetPedheadshotTxdString(head)
    ESX.ShowAdvancedNotification('Message du Staff', '~r~Informations', '~r~Raison ~w~: ' ..msg, headshot, 3)
end)

--Give véhicule avec clées
local voituregive = {}

function give_vehi(veh)
    local plyCoords = GetEntityCoords(PlayerPedId(), false)
    
    Wait(10)
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
            local plate = GeneratePlate()
            table.insert(voituregive, vehicle)        
            --print(plate)
            local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
            vehicleProps.plate = plate
            SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
            TriggerServerEvent('fAdmin:vehicule', vehicleProps, plate, veh)
        
    end)
end

local voituregivejoueur = {}

function give_vehijoueur(veh, IdSelected)
    local plyCoords = GetEntityCoords(PlayerPedId(), false)
    
    Wait(10)
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
            local plate = GeneratePlate()
            table.insert(voituregivejoueur, vehicle)        
            --print(plate)
            local vehicleProps = ESX.Game.GetVehicleProperties(voituregivejoueur[#voituregivejoueur])
            vehicleProps.plate = plate
            SetVehicleNumberPlateText(voituregivejoueur[#voituregivejoueur] , plate)
            TriggerServerEvent('fAdmin:vehiculejoueur', vehicleProps, plate, IdSelected, veh)
        
    end)
end

--Custom véhicule
function FullVehicleBoost()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		SetVehicleModKit(vehicle, 0)
		SetVehicleMod(vehicle, 14, 0, true)
		SetVehicleNumberPlateTextIndex(vehicle, 5)
		ToggleVehicleMod(vehicle, 18, true)
		SetVehicleColours(vehicle, 0, 0)
		SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
		SetVehicleModColor_2(vehicle, 5, 0)
		SetVehicleExtraColours(vehicle, 111, 111)
		SetVehicleWindowTint(vehicle, 2)
		ToggleVehicleMod(vehicle, 22, true)
		SetVehicleMod(vehicle, 23, 11, false)
		SetVehicleMod(vehicle, 24, 11, false)
		SetVehicleWheelType(vehicle, 12) 
		SetVehicleWindowTint(vehicle, 3)
		ToggleVehicleMod(vehicle, 20, true)
		SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
		LowerConvertibleRoof(vehicle, true)
		SetVehicleIsStolen(vehicle, false)
		SetVehicleIsWanted(vehicle, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetCanResprayVehicle(vehicle, true)
		SetPlayersLastVehicle(vehicle)
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleTyresCanBurst(vehicle, false)
		SetVehicleWheelsCanBreak(vehicle, false)
		SetVehicleCanBeTargetted(vehicle, false)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
		SetVehicleHasStrongAxles(vehicle, true)
		SetVehicleDirtLevel(vehicle, 0)
		SetVehicleCanBeVisiblyDamaged(vehicle, false)
		IsVehicleDriveable(vehicle, true)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleStrong(vehicle, true)
		RollDownWindow(vehicle, 0)
		RollDownWindow(vehicle, 1)
		SetVehicleNeonLightEnabled(vehicle, 0, true)
		SetVehicleNeonLightEnabled(vehicle, 1, true)
		SetVehicleNeonLightEnabled(vehicle, 2, true)
		SetVehicleNeonLightEnabled(vehicle, 3, true)
		SetVehicleNeonLightsColour(vehicle, 0, 0, 255)
		SetPedCanBeDraggedOut(PlayerPedId(), false)
		SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
		SetPedRagdollOnCollision(PlayerPedId(), false)
		ResetPedVisibleDamage(PlayerPedId())
		ClearPedDecorations(PlayerPedId())
		SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
		for i = 0,14 do
			SetVehicleExtra(veh, i, 0)
		end
		SetVehicleModKit(veh, 0)
		for i = 0,49 do
			local custom = GetNumVehicleMods(veh, i)
			for j = 1,custom do
				SetVehicleMod(veh, i, math.random(1,j), 1)
			end
		end
	end
end

---- Announce

RegisterNetEvent('fAdmin:sendAnnounce')
AddEventHandler('fAdmin:sendAnnounce', function(text, author)
    if author == nil then
        author = 'Annonce Staff'
    end

    author = '~r~ ' .. author.. ' ~w~'

    local text = text;
    CreateThread(function()
        local show = true;
        PlaySoundFrontend(-1, "5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset", 1)

        CreateThread(function()
            while show do
                DrawRect(0.494, 0.200, 5.185, 0.050, 0, 0, 0, 150);
                DrawAdvancedTextCNN(0.588, 0.14, 0.005, 0.0028, 0.8, author, 255, 255, 255, 255, 1, 0);
                DrawAdvancedTextCNN(0.586, 0.199, 0.005, 0.0028, 0.6, text, 255, 255, 255, 255, 7, 0);
                Wait(1);
            end
        end)
        
        Wait(5000);
        show = false;
    end)
end)

function DrawAdvancedTextCNN (x, y, w, h, sc, text, r, g, b, a, font, jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
    N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1 + w, y - 0.02 + h)
end

function fAdminKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

-- Eliminer véhicule

RegisterNetEvent("fAdmin:delveh")
AddEventHandler("fAdmin:delveh", function ()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
end)

-- Spectacte

function DrawPlayerInfo(target)
    drawTarget = target
    drawInfo = true
end

function StopDrawPlayerInfo()
    drawInfo = false
    drawTarget = 0
end

CreateThread( function()
    while true do
        Wait(0)
        if drawInfo then
            local text = {}
            local targetPed = GetPlayerPed(drawTarget)
            table.insert(text,"E pour stop spectate")     
            for i,theText in pairs(text) do
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.30)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(theText)
                EndTextCommandDisplayText(0.3, 0.7+(i/30))
            end     
            if IsControlJustPressed(0,103) then
                local targetPed = PlayerPedId()
                local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
                RequestCollisionAtCoord(targetx,targety,targetz)
                NetworkSetInSpectatorMode(false, targetPed)
                StopDrawPlayerInfo()    
            end  
        end
    end
end)

function SpectatePlayer(targetPed,target,name)
    local playerPed = PlayerPedId() -- yourself
    enable = true
    if targetPed == playerPed then enable = false end
    if(enable)then
		 local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(true, targetPed)
        DrawPlayerInfo(target)
        ESX.ShowNotification('~g~Mode spectateur en cours')
    else
        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(false, targetPed)
        StopDrawPlayerInfo()
        ESX.ShowNotification('~b~Mode spectateur arrêtée')
    end
end