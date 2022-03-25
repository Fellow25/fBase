ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local service = false
local bouclier = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Wait(5000) 
end)

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

CreateThread(function()
    local policemap = AddBlipForCoord(rPolice.pos.blips.position.x, rPolice.pos.blips.position.y, rPolice.pos.blips.position.z)
    SetBlipSprite(policemap, 60)
    SetBlipColour(policemap, 29)
    SetBlipScale(policemap, 0.65)
    SetBlipAsShortRange(policemap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Police")
    EndTextCommandSetBlipName(policemap)
end)

function Menuf6police()
    local rPolicef5 = RageUI.CreateMenu("Police", "Interactions")
    local rPolicef5Renfort = RageUI.CreateSubMenu(rPolicef5, "Police", "Renfort")
    local rPolicef5Soutien = RageUI.CreateSubMenu(rPolicef5, "Police", "Soutien")
    local rPolicef5Chien = RageUI.CreateSubMenu(rPolicef5, "Police", "Chien")
    RageUI.Visible(rPolicef5, not RageUI.Visible(rPolicef5))
    while rPolicef5 do
        Wait(0)
            RageUI.IsVisible(rPolicef5, true, true, true, function()

                RageUI.Checkbox("Prendre/Quitter son service",nil, service,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then

                        service = Checked

                        if Checked then
                            etatservice = true
                            RageUI.Popup({message = "Vous avez pris votre service !"})
                            TriggerServerEvent('rPolice:prisedeservice')
                        else
                            etatservice = false
                            RageUI.Popup({message = "Vous avez quitter votre service !"})
                            TriggerServerEvent('rPolice:quitteleservice')
                        end
                    end
                end)

                if etatservice then

                RageUI.Separator("~r~"..ESX.PlayerData.job.grade_label.." - "..GetPlayerName(PlayerId()))


                RageUI.ButtonWithStyle("Facture / Amende",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_police', ('Police'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~b~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)

            RageUI.ButtonWithStyle("Interagir avec le citoyen",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then                
                    TriggerEvent('fellow:MenuFouille')
                end
            end)

    if ESX.PlayerData.job.grade_name == 'boss' then
        RageUI.ButtonWithStyle("Donner le PPA", "Pour donner le permis port d'arme à quelqu'un", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'weapon')
                    ESX.ShowNotification('Vous avez donner le ppa')
             else
                ESX.ShowNotification('Aucun joueurs à proximité')
            end
        end
        end)
    end
                  RageUI.Separator('~r~↓ Intéractions sur véhicules ↓')

            RageUI.ButtonWithStyle("Mettre véhicule en fourriere",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        local playerPed = PlayerPedId()

                        if IsPedSittingInAnyVehicle(playerPed) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
            
                            if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                                ESX.ShowNotification('la voiture a été mis en fourrière')
                                ESX.Game.DeleteVehicle(vehicle)
                               
                            else
                                ESX.ShowNotification('Mais toi place conducteur, ou sortez de la voiture.')
                            end
                        else
                            local vehicle = ESX.Game.GetVehicleInDirection()
            
                            if DoesEntityExist(vehicle) then
                                TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_CLIPBOARD', 0, true)
                                Wait(5000)
                                ClearPedTasks(playerPed)
                                ESX.ShowNotification('La voiture à été placer en fourriere.')
                                ESX.Game.DeleteVehicle(vehicle)
            
                            else
                                ESX.ShowNotification('Aucune voitures autour')
                            end
                        end
                        end
                    end)

                    RageUI.ButtonWithStyle("Rechercher une plaque",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local numplaque = KeyboardInput("Combien ?", "", 10)
                            local length = string.len(numplaque)
                            if not numplaque or length < 2 or length > 8 then
                                ESX.ShowNotification("Ce n'est ~r~pas~s~ un ~y~numéro d'enregistrement valide~s~")
                            else
                                Rechercherplaquevoiture(numplaque)
                                RageUI.CloseAll()
                            end
                        end
                    end)


                RageUI.ButtonWithStyle("Poser/Prendre Radar",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        RageUI.CloseAll()       
                        TriggerEvent('police:POLICE_radar')
                    end
                end)

                  RageUI.Separator('~r~↓ Autres ↓')

                  RageUI.Checkbox("Bouclier",nil, bouclier,{},function(Hovered,Ative,Selected,Checked)
                    if Selected then
    
                        bouclier = Checked
    
    
                        if Checked then
                            EnableShield()
                            
                        else
                            DisableShield()
                        end
                    end
                end)


                RageUI.ButtonWithStyle("Menu Chien", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                end, rPolicef5Chien)

                  RageUI.ButtonWithStyle("Menu Props",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ExecuteCommand('props')
                            RageUI.CloseAll()
                        end
                    end)
				
		          RageUI.ButtonWithStyle("Demande de renfort", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                  end, rPolicef5Renfort)
                  
                  RageUI.ButtonWithStyle("Soutien Police", nil,  {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                  end, rPolicef5Soutien)
                end

                end, function() 
                end)

                RageUI.IsVisible(rPolicef5Renfort, true, true, true, function()

                    RageUI.ButtonWithStyle("Petite demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local raison = 'petit'
                            local elements  = {}
                            local playerPed = PlayerPedId()
                            local coords  = GetEntityCoords(playerPed)
                            local name = GetPlayerName(PlayerId())
                        TriggerServerEvent('renfort', coords, raison)
                    end
                end)
            
                RageUI.ButtonWithStyle("Moyenne demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if Selected then
                        local raison = 'importante'
                        local elements  = {}
                        local playerPed = PlayerPedId()
                        local coords  = GetEntityCoords(playerPed)
                        local name = GetPlayerName(PlayerId())
                    TriggerServerEvent('renfort', coords, raison)
                end
            end)
            
            RageUI.ButtonWithStyle("Grosse demande",nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    local raison = 'omgad'
                    local elements  = {}
                    local playerPed = PlayerPedId()
                    local coords  = GetEntityCoords(playerPed)
                    local name = GetPlayerName(PlayerId())
                TriggerServerEvent('renfort', coords, raison)
            end
            end)
            
                end, function()
                end)

                RageUI.IsVisible(rPolicef5Soutien, true, true, true, function()

                    RageUI.ButtonWithStyle("Émeute de sécurité",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SpawnVehicle1()
                        end
                        end)
            
                    RageUI.ButtonWithStyle("Moto de sécurité",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SpawnVehicle2()
                        end
                        end)
                    RageUI.ButtonWithStyle("Camion de sécurité",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SpawnVehicle3()
                        end
                        end)
                    RageUI.ButtonWithStyle("Vélo de sécurité",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                            SpawnVehicle4()
                        end
                        end)
            
                    RageUI.ButtonWithStyle("Sécurité Hélico",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        SpawnVehicle5()
                    end
                    end)
            
                    RageUI.ButtonWithStyle("Donne des armes",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then 
                        GiveWeaponToPed(chasePed, rPolice.weapon1, 250, false, true)
                        GiveWeaponToPed(chasePed2, rPolice.weapon2, 250, false, true)
                        GiveWeaponToPed(chasePed3, rPolice.weapon3, 250, false, true)
                        GiveWeaponToPed(chasePed4, rPolice.weapon4, 250, false, true)
                    end
                end)
            
                RageUI.ButtonWithStyle("Attaque le joueur le plus proche",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        closestPlayer = ESX.Game.GetClosestPlayer()
                        target = GetPlayerPed(closestPlayer)
                        TaskShootAtEntity(chasePed, target, 60, 0xD6FF6D61);
                        TaskCombatPed(chasePed, target, 0, 16)
                        SetEntityAsMissionEntity(chasePed, true, true)
                        SetPedHearingRange(chasePed, 15.0)
                        SetPedSeeingRange(chasePed, 15.0)
                        SetPedAlertness(chasePed, 15.0)
                        SetPedFleeAttributes(chasePed, 0, 0)
                        SetPedCombatAttributes(chasePed, 46, true)
                        SetPedFleeAttributes(chasePed, 0, 0)
                        TaskShootAtEntity(chasePed2, target, 60, 0xD6FF6D61);
                        TaskCombatPed(chasePed2, target, 0, 16)
                        SetEntityAsMissionEntity(chasePed2, true, true)
                        SetPedHearingRange(chasePed2, 15.0)
                        SetPedSeeingRange(chasePed2, 15.0)
                        SetPedAlertness(chasePed2, 15.0)
                        SetPedFleeAttributes(chasePed2, 0, 0)
                        SetPedCombatAttributes(chasePed2, 46, true)
                        SetPedFleeAttributes(chasePed2, 0, 0) 
                        TaskShootAtEntity(chasePed3, target, 60, 0xD6FF6D61);
                        TaskCombatPed(chasePed3, target, 0, 16)
                        SetEntityAsMissionEntity(chasePed3, true, true)
                        SetPedHearingRange(chasePed3, 15.0)
                        SetPedSeeingRange(chasePed3, 15.0)
                        SetPedAlertness(chasePed3, 15.0)
                        SetPedFleeAttributes(chasePed3, 0, 0)
                        SetPedCombatAttributes(chasePed3, 46, true)
                        SetPedFleeAttributes(chasePed3, 0, 0)  
                        TaskShootAtEntity(chasePed4, target, 60, 0xD6FF6D61);
                        TaskCombatPed(chasePed4, target, 0, 16)
                        SetEntityAsMissionEntity(chasePed4, true, true)
                        SetPedHearingRange(chasePed4, 15.0)
                        SetPedSeeingRange(chasePed4, 15.0)
                        SetPedAlertness(chasePed4, 15.0)
                        SetPedFleeAttributes(chasePed4, 0, 0)
                        SetPedCombatAttributes(chasePed4, 46, true)
                        SetPedFleeAttributes(chasePed4, 0, 0)
                end
            end)
            
                RageUI.ButtonWithStyle("Suivez-moi",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        local playerPed = PlayerPedId()
                        TaskVehicleFollow(chasePed, chaseVehicle, playerPed, 50.0, 1, 5)
                        TaskVehicleFollow(chasePed2, chaseVehicle2, playerPed, 50.0, 1, 5)
                        TaskVehicleFollow(chasePed3, chaseVehicle3, playerPed, 50.0, 1, 5)
                        TaskVehicleFollow(chasePed4, chaseVehicle4, playerPed, 50.0, 1, 5)
                        TaskVehicleFollow(chasePed5, chaseVehicle5, playerPed, 50.0, 1, 5)
                        PlayAmbientSpeech1(chasePed, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
                        PlayAmbientSpeech1(chasePed2, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
                        PlayAmbientSpeech1(chasePed3, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
                        PlayAmbientSpeech1(chasePed4, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
                        PlayAmbientSpeech1(chasePed5, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
                end
            end)
            
                RageUI.ButtonWithStyle("Supprimer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then 
                        local playerPed = PlayerPedId()
                        DeleteVehicle(chaseVehicle)
                        DeletePed(chasePed)
                        DeleteVehicle(chaseVehicle2)
                        DeletePed(chasePed2)
                        DeleteVehicle(chaseVehicle3)
                        DeletePed(chasePed3)
                        DeleteVehicle(chaseVehicle4)
                        DeletePed(chasePed4)
                        DeleteVehicle(chaseVehicle5)
                        DeletePed(chasePed5)
                end
            end)
            
            end, function()
            end)


            RageUI.IsVisible(rPolicef5Chien, true, true, true, function()

                RageUI.ButtonWithStyle("Sortir/Rentrer le chien",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if not DoesEntityExist(policeDog) then
                            RequestModel(351016938)
                            while not HasModelLoaded(351016938) do Wait(0) end
                            policeDog = CreatePed(4, 351016938, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.98), 0.0, true, false)
                            SetEntityAsMissionEntity(policeDog, true, true)
                            ESX.ShowNotification('~g~Chien Spawn')
                        else
                            ESX.ShowNotification('~r~Chien Rentrer')
                            DeleteEntity(policeDog)
                        end
                    end
                end)

                RageUI.ButtonWithStyle("Assis",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if DoesEntityExist(policeDog) then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                                if IsEntityPlayingAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 3) then
                                    ClearPedTasks(policeDog)
                                else
                                    loadDict('rcmnigel1c')
                                    TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
                                    Wait(2000)
                                    loadDict("creatures@rottweiler@amb@world_dog_sitting@base")
                                    TaskPlayAnim(policeDog, "creatures@rottweiler@amb@world_dog_sitting@base", "base", 8.0, -8, -1, 1, 0, false, false, false)
                                end
                            else
                                ESX.ShowNotification('~r~Le chien est trop loin de vous !')
                            end
                        else
                            ESX.ShowNotification('~r~Vous n\'avez pas de chien !')
                        end
                    end
                end)

                RageUI.ButtonWithStyle("Dire d'attaquer",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if DoesEntityExist(policeDog) then
                            if not IsPedDeadOrDying(policeDog) then
                                if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                    local player, distance = ESX.Game.GetClosestPlayer()
                                    if distance ~= -1 then
                                        if distance <= 3.0 then
                                            local playerPed = GetPlayerPed(player)
                                            if not IsPedInCombat(policeDog, playerPed) then
                                                if not IsPedInAnyVehicle(playerPed, true) then
                                                    TaskCombatPed(policeDog, playerPed, 0, 16)
                                                end
                                            else
                                                ClearPedTasksImmediately(policeDog)
                                            end
                                        end
                                    else
                                        ESX.ShowNotification("~r~Probleme~s~: Aucuns joueurs proche")
                                    end
                                else
                                    ESX.ShowNotification('~r~Le chien est trop loin de vous !')
                                end
                            else
                                ESX.ShowNotification('Votre chien est mort !')
                            end
                        else
                            ESX.ShowNotification('~r~Vous n\'avez pas de chien')
                    end
                end
            end)
        

            RageUI.ButtonWithStyle("Monter/sortir du véhicule",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    if DoesEntityExist(policeDog) then
                    if not IsPedInAnyVehicle(policeDog, false) then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog)) <= 10.0 then
                            local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 7.5, 0, 70)
                            print(vehicle)
                            if DoesEntityExist(vehicle) then
                                for i = 0, GetVehicleMaxNumberOfPassengers(vehicle) do
                                    if IsVehicleSeatFree(vehicle, i) then
                                        TaskEnterVehicle(policeDog, vehicle, 15.0, i, 1.0, 1, 0)
                                        break
                                    end
                                end
                            else
                                ESX.ShowNotification('~r~vous n\'avez pas de véhicule !')
                            end
                        else
                            ESX.ShowNotification('~r~Le chien est trop loin de vous !')
                        end
                    else
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog)) <= 5.0 then
                            TaskLeaveVehicle(policeDog, GetVehiclePedIsIn(policeDog, false), 0)
                        else
                            ESX.ShowNotification('~r~Le chien est trop loin de vous !')
                        end
                    end
                else
                    ESX.ShowNotification('~r~Vous n\'avez pas de chien !')
                end
                end
            end)

            RageUI.ButtonWithStyle("Suis-moi",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    local playerPed = PlayerPedId()
                    if DoesEntityExist(policeDog) then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                            TaskGoToEntity(policeDog, playerPed, -1, 1.0, 10.0, 1073741824, 1)
                        else
                            ESX.ShowNotification('~r~Le chien est trop loin de vous !')
                        end
                    else
                        ESX.ShowNotification('~r~Vous n\'avez pas de chien !')
                    end
                end
            end)
            end, function()
            end)
                if not RageUI.Visible(rPolicef5) and not RageUI.Visible(rPolicef5Renfort) and not RageUI.Visible(rPolicef5Soutien) and not RageUI.Visible(rPolicef5Chien) then
                    rPolicef5 = RMenu:DeleteType("Police", true)
        end
    end
end


Keys.Register('F6', 'Police', 'Ouvrir le menu Police', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
    	Menuf6police()
	end
end)

function Rechercherplaquevoiture(plaquerechercher)
    local PlaqueMenu = RageUI.CreateMenu("plaque d'immatriculation", "Informations")
    ESX.TriggerServerCallback('rPolice:getVehicleInfos', function(retrivedInfo)
    RageUI.Visible(PlaqueMenu, not RageUI.Visible(PlaqueMenu))
        while PlaqueMenu do
            Wait(0)
                RageUI.IsVisible(PlaqueMenu, true, true, true, function()
                    local hashvoiture = retrivedInfo.vehicle.model
                    local nomvoituremodele = GetDisplayNameFromVehicleModel(hashvoiture)
                    local nomvoituretexte  = GetLabelText(nomvoituremodele)
                            RageUI.ButtonWithStyle("Numéro de plaque : ", nil, {RightLabel = retrivedInfo.plate}, true, function(Hovered, Active, Selected)
                                if Selected then
                                end
                            end)

                            if not retrivedInfo.owner then
                                RageUI.ButtonWithStyle("Propriétaire : ", nil, {RightLabel = "Inconnu"}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                    end
                                end)
                            else
                                RageUI.ButtonWithStyle("Propriétaire : ", nil, {RightLabel = retrivedInfo.owner}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                    end
                                end)
                                
                                RageUI.ButtonWithStyle("Modèle du véhicule : ", nil, {RightLabel = nomvoituretexte}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                    end
                                end)
                            end
                end, function()
                end)
            if not RageUI.Visible(PlaqueMenu) then
            PlaqueMenu = RMenu:DeleteType("plaque d'immatriculation", true)
        end
    end
end, plaquerechercher)
end

function OpenPrendreMenuPolice()
    local PrendreMenu = RageUI.CreateMenu("Police", "Arsenal")
        RageUI.Visible(PrendreMenu, not RageUI.Visible(PrendreMenu))
    while PrendreMenu do
        Wait(0)
            RageUI.IsVisible(PrendreMenu, true, true, true, function()

            RageUI.ButtonWithStyle("Déposer les armes",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                    TriggerServerEvent('rPolice:arsenalvide')
                end
            end)

            RageUI.Separator('~r~↓ Voici les armes disponible ↓')

            for k,v in pairs(Arsenal.Police) do
                RageUI.ButtonWithStyle(v.Label.. ' Prix: ' .. v.Price .. '€', nil, { RightBadge = RageUI.BadgeStyle.Gun }, true, function(Hovered, Active, Selected)
                  if (Selected) then
                      TriggerServerEvent('rPolice:arsenal', v.Name, v.Price)
                    end
                end)
            end
                end, function() 
                end)
    
                if not RageUI.Visible(PrendreMenu) then
                    PrendreMenu = RMenu:DeleteType("Police", true)
        end
    end
end


CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
        local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, rPolice.pos.MenuPrendre.position.x, rPolice.pos.MenuPrendre.position.y, rPolice.pos.MenuPrendre.position.z)
        if dist3 <= 7.0 and rPolice.jeveuxmarker then
            Timer = 0
            DrawMarker(20, rPolice.pos.MenuPrendre.position.x, rPolice.pos.MenuPrendre.position.y, rPolice.pos.MenuPrendre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder à l'arsenal", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenPrendreMenuPolice()
                    end   
                end
            end 
        Wait(Timer)
    end
end)

function Coffrepolice()
    local Cpolice = RageUI.CreateMenu("Coffre", "Police")
        RageUI.Visible(Cpolice, not RageUI.Visible(Cpolice))
            while Cpolice do
            Wait(0)
            RageUI.IsVisible(Cpolice, true, true, true, function()

                RageUI.Separator("~y~↓ Objet ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            PoliceRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            PoliceDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cpolice) then
            Cpolice = RMenu:DeleteType("Cpolice", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, rPolice.pos.coffre.position.x, rPolice.pos.coffre.position.y, rPolice.pos.coffre.position.z)
            if jobdist <= 10.0 and rPolice.jeveuxmarker then
                Timer = 0
                DrawMarker(20, rPolice.pos.coffre.position.x, rPolice.pos.coffre.position.y, rPolice.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrepolice()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


--- vestiaire


function vestiairepolice()
    local Vpolice = RageUI.CreateMenu("Vestiaire", "Police")
        RageUI.Visible(Vpolice, not RageUI.Visible(Vpolice))
            while Vpolice do
            Wait(0)
            RageUI.IsVisible(Vpolice, true, true, true, function()
                RageUI.Separator("~y~↓ Votre Tenue ↓")
                    if ESX.PlayerData.job.grade_name == 'recruit' then
                    RageUI.ButtonWithStyle("Tenue Recrue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenuerecrue()
                            RageUI.CloseAll()
                        end
                    end)
                end
                    if ESX.PlayerData.job.grade_name == 'officer' then
                    RageUI.ButtonWithStyle("Tenue Officier",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenueofficier()
                            RageUI.CloseAll()
                        end
                    end)
                end
                    if ESX.PlayerData.job.grade_name == 'sergeant' then
                    RageUI.ButtonWithStyle("Tenue Sergent",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenuesergeant()
                            RageUI.CloseAll()
                        end
                    end)
                end
                    if ESX.PlayerData.job.grade_name == 'lieutenant' then
                    RageUI.ButtonWithStyle("Tenue Lieutenant",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenuelieutenant()
                            RageUI.CloseAll()
                        end
                    end)
                end
                    if ESX.PlayerData.job.grade_name == 'boss' then
                    RageUI.ButtonWithStyle("Tenue Commandant",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tenueboss()
                            RageUI.CloseAll()
                        end
                    end)
                end

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_police()
                            RageUI.CloseAll()
                        end
                    end)

            RageUI.Separator("~g~↓ Gilet par balle ↓")

            RageUI.ButtonWithStyle("Mettre",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    mettrebullet_wear()
                    SetPedArmour(PlayerPedId(), 100)
                end
            end)

            RageUI.ButtonWithStyle("Enlever",nil, {nil}, true, function(Hovered, Active, Selected)
                if Selected then
                    enleverbullet_wear()
                    SetPedArmour(PlayerPedId(), 0)
                end
            end)
                end, function()
                end)
            if not RageUI.Visible(Vpolice) then
            Vpolice = RMenu:DeleteType("Vestiaire", true)
        end
    end
end

function tenuerecrue()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = rPolice.Uniforms.recruit.male
        else
            uniformObject = rPolice.Uniforms.recruit.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function tenueofficier()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = rPolice.Uniforms.officer.male
        else
            uniformObject = rPolice.Uniforms.officer.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function tenuesergeant()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = rPolice.Uniforms.sergeant.male
        else
            uniformObject = rPolice.Uniforms.sergeant.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function tenuelieutenant()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = rPolice.Uniforms.lieutenant.male
        else
            uniformObject = rPolice.Uniforms.lieutenant.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function tenueboss()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = rPolice.Uniforms.boss.male
        else
            uniformObject = rPolice.Uniforms.boss.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function mettrebullet_wear()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = rPolice.Uniforms.bullet_wear.male
        else
            uniformObject = rPolice.Uniforms.bullet_wear.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function enleverbullet_wear()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = rPolice.Uniforms.bullet_wearno.male
        else
            uniformObject = rPolice.Uniforms.bullet_wearno.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end


function vcivil_police()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end


CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, rPolice.pos.vestiaire.position.x, rPolice.pos.vestiaire.position.y, rPolice.pos.vestiaire.position.z)
            if jobdist <= 10.0 and rPolice.jeveuxmarker then
                Timer = 0
                DrawMarker(20, rPolice.pos.vestiaire.position.x, rPolice.pos.vestiaire.position.y, rPolice.pos.vestiaire.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder au vestiaire", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        vestiairepolice()
                    end   
                end
            end 
        Wait(Timer)   
    end
end)


--- fin



-- Garage

function Garagepolice()
  local Gpolice = RageUI.CreateMenu("Garage", "Police")
    RageUI.Visible(Gpolice, not RageUI.Visible(Gpolice))
        while Gpolice do
            Wait(0)
                RageUI.IsVisible(Gpolice, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gpolicevoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Wait(1)  
                            spawnuniCarpolice(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gpolice) then
            Gpolice = RMenu:DeleteType("Garage", true)
        end
    end
end

CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, rPolice.pos.garage.position.x, rPolice.pos.garage.position.y, rPolice.pos.garage.position.z)
            if dist3 <= 10.0 and rPolice.jeveuxmarker then
                Timer = 0
                DrawMarker(20, rPolice.pos.garage.position.x, rPolice.pos.garage.position.y, rPolice.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagepolice()
                    end   
                end
            end 
        Wait(Timer)
     end
end)

function spawnuniCarpolice(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, rPolice.pos.spawnvoiture.position.x, rPolice.pos.spawnvoiture.position.y, rPolice.pos.spawnvoiture.position.z, rPolice.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "POLICE"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

function Helipolice()
    local Hpolice = RageUI.CreateMenu("Garage", "Police")
      RageUI.Visible(Hpolice, not RageUI.Visible(Hpolice))
          while Hpolice do
              Wait(0)
                  RageUI.IsVisible(Hpolice, true, true, true, function()
                      RageUI.ButtonWithStyle("Ranger le hélicoptère", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then   
                          local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                          if dist4 < 4 then
                              DeleteEntity(veh)
                              RageUI.CloseAll()
                              end 
                          end
                      end) 
  
                      for k,v in pairs(Hpoliceheli) do
                      RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                          if (Selected) then
                          Wait(1)  
                            spawnuniCarheli(v.modele)
                              RageUI.CloseAll()
                              end
                          end)
                      end
                  end, function()
                  end)
              if not RageUI.Visible(Hpolice) then
              Hpolice = RMenu:DeleteType("Garage", true)
          end
      end
end
  
CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
            local plyCoords3 = GetEntityCoords(PlayerPedId(), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, rPolice.pos.garageheli.position.x, rPolice.pos.garageheli.position.y, rPolice.pos.garageheli.position.z)
            if dist3 <= 10.0 and rPolice.jeveuxmarker then
                Timer = 0
                DrawMarker(20, rPolice.pos.garageheli.position.x, rPolice.pos.garageheli.position.y, rPolice.pos.garageheli.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour accéder au garage des hélicoptères", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Helipolice()
                    end   
                end
            end 
        Wait(Timer)
    end
end)
  
function spawnuniCarheli(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, rPolice.pos.spawnheli.position.x, rPolice.pos.spawnheli.position.y, rPolice.pos.spawnheli.position.z, rPolice.pos.spawnheli.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "POLICE"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

itemstock = {}
function PoliceRetirerobjet()
    local Stockpolice = RageUI.CreateMenu("Coffre", "Police")
    ESX.TriggerServerCallback('rPolice:getStockItems', function(items) 
    itemstock = items
   
    RageUI.Visible(Stockpolice, not RageUI.Visible(Stockpolice))
        while Stockpolice do
            Wait(0)
                RageUI.IsVisible(Stockpolice, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", 2)
                                    TriggerServerEvent('rPolice:getStockItem', v.name, tonumber(count))
                                    PoliceRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockpolice) then
            Stockpolice = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end



function PoliceDeposerobjet()
    local StockPlayer = RageUI.CreateMenu("Coffre", "Police")
    ESX.TriggerServerCallback('rPolice:getPlayerInventory', function(inventory)
        RageUI.Visible(StockPlayer, not RageUI.Visible(StockPlayer))
    while StockPlayer do
        Wait(0)
            RageUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('rPolice:putStockItems', item.name, tonumber(count))
                                            PoliceDeposerobjet()
                                        end
                                    end)
                            end
                    end
                end
                    end, function()
                    end)
                if not RageUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end



function plaintepolice()
    local Ppolice = RageUI.CreateMenu("Plainte", "Police")
        RageUI.Visible(Ppolice, not RageUI.Visible(Ppolice))
            while Ppolice do
            Wait(0)
            RageUI.IsVisible(Ppolice, true, true, true, function()

                    RageUI.ButtonWithStyle("Porter plainte",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Msg = KeyboardInput("Message", '' , 50)
                            TriggerServerEvent('gaming:plainte',Msg)
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Ppolice) then
            Ppolice = RMenu:DeleteType("Ppolice", true)
        end
    end
end


CreateThread(function()
        while true do
            local Timer = 500
            local plycrdjob = GetEntityCoords(PlayerPedId(), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, rPolice.pos.plainte.position.x, rPolice.pos.plainte.position.y, rPolice.pos.plainte.position.z)
            if jobdist <= 10.0 and rPolice.jeveuxmarker then
                Timer = 0
                DrawMarker(20, rPolice.pos.plainte.position.x, rPolice.pos.plainte.position.y, rPolice.pos.plainte.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~b~[E]~s~ pour porter plainte", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        plaintepolice()   
                end
            end 
        Wait(Timer)   
    end
end)

RegisterNetEvent('renfort:setBlip')
AddEventHandler('renfort:setBlip', function(coords, raison)
	if raison == 'petit' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-2\n~w~Importance: ~g~Légère.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
	elseif raison == 'importante' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-3\n~w~Importance: ~o~Importante.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
	elseif raison == 'omgad' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-99\n~w~Importance: ~r~URGENTE !\nDANGER IMPORTANT', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
		color = 1
	end
	local blipId = AddBlipForCoord(coords)
	SetBlipSprite(blipId, 161)
	SetBlipScale(blipId, 1.2)
	SetBlipColour(blipId, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Demande renfort')
	EndTextCommandSetBlipName(blipId)
	Wait(80 * 1000)
	RemoveBlip(blipId)
end)

RegisterNetEvent('police:InfoService')
AddEventHandler('police:InfoService', function(service, nom)
	if service == 'prise' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Prise de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-8\n~w~Information: ~g~Prise de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'fin' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Fin de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-10\n~w~Information: ~g~Fin de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'pause' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Pause de service', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-6\n~w~Information: ~g~Pause de service.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'standby' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Mise en standby', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-12\n~w~Information: ~g~Standby, en attente de dispatch.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'control' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Control routier', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-48\n~w~Information: ~g~Control routier en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'refus' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Refus d\'obtemperer', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-30\n~w~Information: ~g~Refus d\'obtemperer / Delit de fuite en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'crime' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('POLICE INFORMATIONS', '~b~Crime en cours', 'Agent: ~g~'..nom..'\n~w~Code: ~g~10-31\n~w~Information: ~g~Crime en cours / poursuite en cours.', 'CHAR_CALL911', 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	end
end)

local shieldActive = false
local shieldEntity = nil

-- ANIM
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = "prop_ballistic_shield"

function EnableShield()
    shieldActive = true
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped, false)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(250)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Wait(250)
    end

    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))
    SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = PlayerPedId()
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))
    SetEnableHandcuffs(ped, false)
    shieldActive = false
end

CreateThread(function()
    while true do
        if shieldActive then
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Wait(100)
                end
            
                TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
        end
        Wait(500)
    end
end)


----- Soutien Police

function SpawnVehicle1()
	local playerPed = PlayerPedId()
	local PedPosition = GetEntityCoords(playerPed)
	hashKey = GetHashKey(rPolice.ped1)
	pedType = GetPedType(hashKey)
	RequestModel(hashKey)
	while not HasModelLoaded(hashKey) do
	  RequestModel(hashKey)
	  Wait(100)
	end
	chasePed = CreatePed(pedType, hashKey, PedPosition.x + 2,  PedPosition.y,  PedPosition.z, 250.00, 1, 1)
	ESX.Game.SpawnVehicle(rPolice.vehicle1, {
	  x = PedPosition.x + 10 ,
	  y = PedPosition.y,
	  z = PedPosition.z
	},120, function(callback_vehicle)
	  chaseVehicle = callback_vehicle
	  local vehicle = GetVehiclePedIsIn(PlayerPed, true)
	  SetVehicleUndriveable(chaseVehicle, false)
	  SetVehicleEngineOn(chaseVehicle, true, true)
	  while not chasePed do Wait(100) end;
	  PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
	  TaskWarpPedIntoVehicle(chasePed, chaseVehicle, -1)
	  TaskVehicleFollow(chasePed, chaseVehicle, playerPed, 50.0, 1, 5)
	  SetDriveTaskDrivingStyle(chasePed, 786468)
	  SetVehicleSiren(chaseVehicle, true)
	end)
end

function SpawnVehicle2()
local playerPed = PlayerPedId()
local PedPosition = GetEntityCoords(playerPed)
hashKey2 = GetHashKey(rPolice.ped2)
pedType2 = GetPedType(hashKey)
RequestModel(hashKey2)
while not HasModelLoaded(hashKey2) do
    RequestModel(hashKey2)
    Wait(100)
end
chasePed2 = CreatePed(pedType2, hashKey2, PedPosition.x + 4,  PedPosition.y,  PedPosition.z, 250.00, 1, 1)
ESX.Game.SpawnVehicle(rPolice.vehicle2, {
    x = PedPosition.x + 15 ,
    y = PedPosition.y,
    z = PedPosition.z
},120, function(callback_vehicle2)
    chaseVehicle2 = callback_vehicle2
    local vehicle = GetVehiclePedIsIn(PlayerPed, true)
    SetVehicleUndriveable(chaseVehicle2, false)
    SetVehicleEngineOn(chaseVehicle2, true, true)
    while not chasePed2 do Wait(100) end;
    while not chaseVehicle2 do Wait(100) end;
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
    TaskWarpPedIntoVehicle(chasePed2, chaseVehicle2, -1)
    TaskVehicleFollow(chasePed2, chaseVehicle2, playerPed, 50.0, 1, 5)
    SetDriveTaskDrivingStyle(chasePed2, 786468)
    SetVehicleSiren(chaseVehicle2, true)
end)
end

function SpawnVehicle3()
local playerPed = PlayerPedId()
local PedPosition = GetEntityCoords(playerPed)
hashKey3 = GetHashKey(rPolice.ped3)
pedType3 = GetPedType(hashKey)
RequestModel(hashKey3)
while not HasModelLoaded(hashKey3) do
    RequestModel(hashKey3)
    Wait(100)
end
chasePed3 = CreatePed(pedType3, hashKey3, PedPosition.x + 2,  PedPosition.y,  PedPosition.z, 250.00, 1, 1)
ESX.Game.SpawnVehicle(rPolice.vehicle3, {
    x = PedPosition.x + 10 ,
    y = PedPosition.y,
    z = PedPosition.z
},120, function(callback_vehicle3)
    chaseVehicle3 = callback_vehicle3
    local vehicle = GetVehiclePedIsIn(PlayerPed, true)
    SetVehicleUndriveable(chaseVehicle3, false)
    SetVehicleEngineOn(chaseVehicle3, true, true)
    while not chasePed3 do Wait(100) end;
    while not chaseVehicle3 do Wait(100) end;
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
    TaskWarpPedIntoVehicle(chasePed3, chaseVehicle3, -1)
    TaskVehicleFollow(chasePed3, chaseVehicle3, playerPed, 50.0, 1, 5)
    SetDriveTaskDrivingStyle(chasePed3, 786468)
    SetVehicleSiren(chaseVehicle3, true)
end)
end

function SpawnVehicle4()
local playerPed = PlayerPedId()
local PedPosition = GetEntityCoords(playerPed)
hashKey4 = GetHashKey(rPolice.ped4)
pedType4 = GetPedType(hashKey)
RequestModel(hashKey4)
while not HasModelLoaded(hashKey4) do
    RequestModel(hashKey4)
    Wait(100)
end
chasePed4 = CreatePed(pedType4, hashKey4, PedPosition.x + 2,  PedPosition.y,  PedPosition.z, 250.00, 1, 1)
ESX.Game.SpawnVehicle(rPolice.vehicle4, {
    x = PedPosition.x + 10 ,
    y = PedPosition.y,
    z = PedPosition.z
},120, function(callback_vehicle4)
    chaseVehicle4 = callback_vehicle4
    local vehicle = GetVehiclePedIsIn(PlayerPed, true)
    SetVehicleUndriveable(chaseVehicle4, false)
    SetVehicleEngineOn(chaseVehicle4, true, true)
    while not chasePed4 do Wait(100) end;
    while not chaseVehicle4 do Wait(100) end;
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
    TaskWarpPedIntoVehicle(chasePed4, chaseVehicle4, -1)
    TaskVehicleFollow(chasePed4, chaseVehicle4, playerPed, 50.0, 1, 5)
    SetDriveTaskDrivingStyle(chasePed4, 786468)
    SetVehicleSiren(chaseVehicle4, true)
end)
end

function SpawnVehicle5()
local playerPed = PlayerPedId()
local PedPosition = GetEntityCoords(playerPed)
hashKey5 = GetHashKey(rPolice.ped5)
pedType5 = GetPedType(hashKey)
RequestModel(hashKey5)
while not HasModelLoaded(hashKey5) do
    RequestModel(hashKey5)
    Wait(100)
end
chasePed5 = CreatePed(pedType5, hashKey5, PedPosition.x + 2,  PedPosition.y,  PedPosition.z, 250.00, 1, 1)
ESX.Game.SpawnVehicle(rPolice.vehicle5, {
    x = PedPosition.x + 10 ,
    y = PedPosition.y,
    z = PedPosition.z
},120, function(callback_vehicle5)
    chaseVehicle5 = callback_vehicle5
    local vehicle = GetVehiclePedIsIn(PlayerPed, true)
    SetVehicleUndriveable(chaseVehicle5, false)
    SetVehicleEngineOn(chaseVehicle5, true, true)
    while not chasePed5 do Wait(100) end;
    while not chaseVehicle5 do Wait(100) end;
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
    TaskWarpPedIntoVehicle(chasePed5, chaseVehicle5, freeSeat)
    TaskVehicleFollow(chasePed5, chaseVehicle5, playerPed, 50.0, 1, 5)
    SetDriveTaskDrivingStyle(chasePed5, 786468)
    SetVehicleSiren(chaseVehicle5, false)
end)
end


loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
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
