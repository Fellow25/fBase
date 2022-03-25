ESX = nil

Peds = {
    cantine = {hash = "s_m_m_linecook", coords = vector4(658.028, 126.8552, 79.75455, -20)},
    cantine1 = {hash = "s_m_m_linecook", coords = vector4(660.8313, 125.7546, 79.75455, -20)},
    arme = {hash = "s_m_y_prismuscl_01", coords = vector4(704.3461, 92.26684, 79.75455, 100)},
    sortie = {hash = "s_m_m_prisguard_01", coords = vector4(722.42, 140.27, 79.75, 59.49)},
}
Positions = {
    positionrecyclerie = { x =677.46 , y =180.67, z =80.48 },
    positionPrison = { x =728.86 , y =150.80, z =79.74 },
    positionTenueCivil = { x =731.61 , y =156.31, z =79.74 }
}


local quitMenu = RageUI.CreateMenu("Sortie","~y~Prisonnier : ")
local subMenu =  RageUI.CreateSubMenu(quitMenu, "Sortie", " ")



local ctMenu = RageUI.CreateMenu("Cantine", "~y~Prisonnier : ")
local wpMenu = RageUI.CreateMenu("Isayah", "Acheter une arme")


ActiverMarkerPrisonTenu = true -- false si vous ne voulez pas les Markers aux sols
local menu = RageUI.CreateMenu("Entrée Prison", "~y~Prisonnier : ")	 
ActiverMarkerCivil = true -- false si vous ne voulez pas les Markers aux sols
local menu1 = RageUI.CreateMenu("Prison Tenue", "~y~Prisonnier : ")	 

local menu3= RageUI.CreateMenu("Prison Recyclerie","~y~Prisonnier : ")
ActiverMarker = true -- false si vous ne voulez pas les Markers aux sols

local recolerbnj = false
local maitem = false
local tekst = 0


CreateThread(function()
	local sleep = 1
	local hash = GetHashKey("s_m_y_cop_01")
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
	end 
	ped = CreatePed("0x5E3DA4A4", hash,735.53,147.73,79.71,56.75, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)	
	SetEntityHeading(ped, 56.75)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
    for _,v in pairs (Peds) do
        while not HasModelLoaded(v.hash) do
            RequestModel(v.hash)
            Wait(20)
        end
        ped1 = CreatePed("PED_TYPE_CIVFEMALE", v.hash, v.coords, false, true)
        SetBlockingOfNonTemporaryEvents(ped1, true)
        SetEntityInvincible(ped1, true)
        FreezeEntityPosition(ped1, true)
    end
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
    while (true) do
        if Vdist2(GetEntityCoords(PlayerPedId(), false), Peds.sortie.coords) < 3 then
            ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour sortir')
            if IsControlJustPressed(1, 51) then
                RageUI.Visible(quitMenu, not RageUI.Visible(quitMenu))
            end
        end
        if Vdist2(GetEntityCoords(PlayerPedId(), false), Peds.cantine.coords) < 7 or Vdist2(GetEntityCoords(PlayerPedId(), false), Peds.cantine1.coords) < 7 then
            ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour acheter à manger')
            if IsControlJustPressed(1, 51) then
                RageUI.Visible(ctMenu, not RageUI.Visible(ctMenu))
            end
        end
        if Vdist2(GetEntityCoords(PlayerPedId(), false), Peds.arme.coords) < 3 then
            ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour parler a Isayah')
            if IsControlJustPressed(1, 51) then
                RageUI.Visible(wpMenu, not RageUI.Visible(wpMenu))
            end
        end
        if Vdist2(GetEntityCoords(PlayerPedId(), false), Positions.positionPrison.x, Positions.positionPrison.y, Positions.positionPrison.z) < 3 then
            DrawMarker(27, Positions.positionPrison.x, Positions.positionPrison.y, Positions.positionPrison.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.75, 1.75, 1.75, 0, 204, 0, 100, false, true, 2, false, false, false, false)
            ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour déposer vos affaires et vous changer')
            if IsControlJustPressed(1, 51) then
                RageUI.Visible(menu, not RageUI.Visible(menu))
            end
        end
        if Vdist2(GetEntityCoords(PlayerPedId(), false), Positions.positionTenueCivil.x, Positions.positionTenueCivil.y, Positions.positionTenueCivil.z) < 3 then
            DrawMarker(27, Positions.positionTenueCivil.x, Positions.positionTenueCivil.y, Positions.positionTenueCivil.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.75, 1.75, 1.75, 0, 204, 0, 100, false, true, 2, false, false, false, false)
            ESX.ShowHelpNotification('Appuyez sur ~INPUT_TALK~ pour reprendre votre tenue civil')
            if IsControlJustPressed(1, 51) then
                RageUI.Visible(menu1, not RageUI.Visible(menu1))
            end
		end
		if Vdist2(GetEntityCoords(PlayerPedId(), false), Positions.positionrecyclerie.x, Positions.positionrecyclerie.y, Positions.positionrecyclerie.z) < 3 then
            DrawMarker(27, Positions.positionrecyclerie.x, Positions.positionrecyclerie.y, Positions.positionrecyclerie.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.75, 1.75, 1.75, 0, 204, 0, 100, false, true, 2, false, false, false, false)
            ESX.ShowHelpNotification('Appuyez sur ~INPUT_TALK~ pour vendre les pièces a recycler')
            if IsControlJustPressed(1, 51) then
                RageUI.Visible(menu3, not RageUI.Visible(menu3))
            end
		end
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, 693.10,173.76,80.74, true) < 2.0 then
			ESX.Game.Utils.DrawText3D({ x = 693.17, y = 173.77, z =80.74 }, '~y~[E] ~w~Collecte d\'objets', 0.6)
			if IsControlJustPressed(1, 38)  then
				if recolerbnj == false and maitem == false then
					collecter()
				end
			end					
		end
		if GetDistanceBetweenCoords(coords, 704.81,169.24,80.72, true) < 2.0 then
			ESX.Game.Utils.DrawText3D({ x = 704.81, y = 169.24, z = 80.72}, '~y~[E] ~w~Collecte d\'objet', 0.6)
			if recolerbnj == false and maitem == false then
				collecter()
			end					
		end
		

        RageUI.IsVisible(quitMenu, function()

            RageUI.Button('Demander la permission de sortir', nil, { RightLabel = "→→→" }, true, {
            },subMenu);

            RageUI.Separator("Tickets requis: ~r~150")
            
            end, function()
        end)
        RageUI.IsVisible(ctMenu, function()
            RageUI.Button('Pain', nil, { RightLabel = "~y~20 Tickets" }, true, {
                onSelected = function()
                    TriggerServerEvent('bnj:GivePrsnPain')
                end,
            });
            RageUI.Button('Eau', nil, { RightLabel = "~b~20 Tickets" }, true, {
                onSelected = function()
                    TriggerServerEvent('bnj:GivePrsnEau')
                end,
            });
            end, function()
        end)
        RageUI.IsVisible(wpMenu, function()

            RageUI.Button('Poignard', nil, { RightLabel = "~b~30 Tickets" }, true, {
                onSelected = function()
                    --TriggerServerEvent('bnj:GivePrsnCouteau', "weapon_dagger", 30)
                    TriggerServerEvent('bnj:GivePrsnCouteau', "dagger", 30)
                end,
            });
            RageUI.Button('Pied de biche', nil, { RightLabel = "~b~40 Tickets" }, true, {
                onSelected = function()
                   -- TriggerServerEvent('bnj:GivePrsnCouteau', "weapon_crowbar", 40)
                    TriggerServerEvent('bnj:GivePrsnCouteau', "crowbar", 40)
                end,
            });
            end, function()
        end)
        RageUI.IsVisible(subMenu, function()
            local inventory = ESX.GetPlayerData().inventory
            local count = 0
            for i=1, #inventory, 1 do
                if inventory[i].name == 'ticket' then
                    count = inventory[i].count
                    
                end
            end
            RageUI.Separator("Nombre de tickets en possession: ~g~"..count)
            RageUI.Button('Sortir', nil, {}, true, {
                onHovered = function()
                end,
                onSelected = function()
					TriggerServerEvent('bnj:hasItem')
                    RageUI.CloseAll()
                end,
            });
            end, function()
        end)
        RageUI.IsVisible(menu, function()
			RageUI.Button('Déposer ses affaires et ce changer ', nil,  { RightBadge = RageUI.BadgeStyle.Clothes},  true, {
				onSelected = function()
					OnEsPartit()
					RageUI.CloseAll()
				end,
			});
			end, function()
		end)
		RageUI.IsVisible(menu3, function()
			RageUI.Button('Vendre les pièces', nil,  { RightBadge = RageUI.BadgeStyle.Car},  true, {
				onSelected = function()
					skup()
					RageUI.CloseAll()
				end,
			});
			end, function()
		end)
        RageUI.IsVisible(menu1, function()
			RageUI.Button('Remettre ca tenue civil ', nil,  { RightBadge = RageUI.BadgeStyle.Clothes},  true, {
				onSelected = function()
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
						playAnim('mp_clothing@female@shirt', 'try_shirt_positive_a', Config.Animation1.Time)
						Wait(4000)
						TriggerEvent('skinchanger:loadSkin', skin)
						TriggerEvent('esx:restoreLoadout')
			
					
					end)
					RageUI.CloseAll()
				end,
			});
			end, function()
		end)
        Wait(sleep)
    end

end)
RegisterCommand("coords", function() print(GetEntityCoords(PlayerPedId())) end)


function collecter()
	TriggerServerEvent('bnj:collectionner')
	recolerbnj = true
end

function OnEsPartit()
	function StartMusicEvent(event)
		PrepareMusicEvent(event)
		return TriggerMusicEvent(event) == 1
	end
	StartMusicEvent("FM_INTRO_START")
	DoScreenFadeOut(1500)
	medkit = CreateObject(GetHashKey("prop_med_bag_01b"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(medkit, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
	Wait(1300)
	RenderScriptCams(0, 1, 500, 1, 1)
	local Camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	ShakeCam(Camera,"HAND_SHAKE",0.3)
	SetCamActive(Camera, true)
	RenderScriptCams(true, true, 10, true, true)
	SetCamFov(Camera,50.0)
	SetCamCoord(Camera, 734.47,153.94,81.08)
	PointCamAtEntity(Camera,PlayerPedId())
	DoScreenFadeIn(3500)
	local dir = vector3(734.20,148.36,80.71)
	TaskGoToCoordAnyMeans(PlayerPedId(), dir, 1.0, 0, 0, 786603, 0xbf800000)
	Wait(5500)
	ExecuteCommand('me Tiens prend ta merde !')
	print("^9BrownyProd ^4| ^6BNJ Homme Efficace")
	playAnim('mp_cop_armoury', 'pistol_on_counter_cop', Config.Animation.Time)
	Wait(Config.Animation.Time)
	DeleteEntity(medkit)
	TaskPlayAnim(ped, "mp_cop_armoury", "rifle_on_counter_cop", 2.0, 2.0, -1, 0, 0, false, false, false)
	Wait(3000)	
	medkitbnj = CreateObject(GetHashKey("p_t_shirt_pile_s"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(medkitbnj, ped, GetPedBoneIndex(ped, 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
	playAnim('mp_common', 'givetake1_a', Config.Animation.Time)
	medkitbnjbnj = CreateObject(GetHashKey("p_t_shirt_pile_s"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(medkitbnjbnj, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
	Wait(2500)
	DeleteEntity(medkitbnjbnj)
	ESX.ShowHelpNotification("~g~Gardien : ~s~Change toi ici")
	playAnim('mp_clothing@female@shirt', 'try_shirt_positive_a', Config.Animation1.Time)
	Wait(2500)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.prison_vetement.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.prison_vetement.female)
		end
	end)
	Wait(2500)
	DoScreenFadeOut(850)
	Wait(2500)
	RenderScriptCams(0, 1, 500, 1, 1)
	RenderScriptCams(true, true, 10, true, true)
	DoScreenFadeIn(3500)

	RenderScriptCams(false, true, 2000, true, true)
	DestroyCam(Camera)
	StartMusicEvent("FM_SUDDEN_DEATH_STOP_MUSIC")
end 



function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end



RegisterNetEvent('bnj:sortiePrison')
AddEventHandler('bnj:sortiePrison', function(entity)
	local dir = vector3(736.883, 136.4163, 80.756)
	TaskGoToCoordAnyMeans(PlayerPedId(), dir, 1.0, 0, 0, 786603, 0xbf800000)
	DoScreenFadeOut(3000)
	Wait(3500)
    DoScreenFadeIn(6000)
	SetEntityCoords(PlayerPedId(),739.13,136.96,79.73)
	local dir = vector3(743.61,134.59,80.24)
	TaskGoToCoordAnyMeans(PlayerPedId(), dir, 1.0, 0, 0, 786603, 0xbf800000)
      
  
  

 

end)



function skup()
	TriggerServerEvent('bnj:skup')
	Wait(3500)
	Wait(13000)
	FreezeEntityPosition(PlayerPedId(), false)
	recolerbnj = false
end



RegisterNetEvent('bnj:traitement')
AddEventHandler('bnj:traitement', function()
	playerPed = PlayerPedId()	
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(playerPed, true)
end)
RegisterNetEvent('bnj:collecte')
AddEventHandler('bnj:collecte', function()
	playerPed = PlayerPedId()
	FreezeEntityPosition(playerPed, false)
	ClearPedTasks(PlayerPedId())
	maitem = true
	Wait(1000)
	recolerbnj = false
	TriggerEvent('bnj:prop')
end)

RegisterNetEvent('bnj:craft')
AddEventHandler('bnj:craft', function()
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
	Wait(2000)
end)

RegisterNetEvent('bnj:prop')
AddEventHandler('bnj:prop', function()
	function loadAnimDict(dict)
		while (not HasAnimDictLoaded(dict)) do
			RequestAnimDict(dict)
			Wait(5)
		end
	end
	local ad = "anim@heists@box_carry@"
	loadAnimDict( ad )
	TaskPlayAnim( PlayerPedId(), ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	local bnj = math.random(1,3)
	if bnj == 1 then
		bagModel = 'prop_car_door_04'
		porte = CreateObject(GetHashKey(bagModel), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(porte, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.00, 0.355, -75.0, 470.0, 0.0, true, true, false, true, 1, true)
		Wait(10000)

	elseif bnj == 2 then
		bagModel = 'prop_car_door_04'
		porte = CreateObject(GetHashKey(bagModel), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(porte, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, 0.00, 0.355, -045.0, 480.0, 0.0, true, true, false, true, 1, true)
		Wait(10000)

	else	
		bagModel = 'prop_car_door_04'
		porte = CreateObject(GetHashKey(bagModel), x, y, z,  true,  true, true)
		AttachEntityToEntity(porte, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.125, -0.50, 0.355, -045.0, 410.0, 0.0, true, true, false, true, 1, true)
		Wait(10000)
	end
end)

RegisterNetEvent('bnj:propa')
AddEventHandler('bnj:propa', function()
	DetachEntity(porte, 1, 1)
	DeleteObject(porte)
	maitem = false
	ClearPedSecondaryTask(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), false)
end)

local UI = { 
	x =  0.000 ,	
	y = -0.001 ,
}

RegisterNetEvent('bnj:craft2')
AddEventHandler('bnj:craft2', function()
	while true do
		Wait(1)
		if recolerbnj == true then
		drawTxt(UI.x + 0.9605, UI.y + 0.962, 1.0,0.98,0.4, "~y~[~w~".. tekst .. "%~y~]", 255, 255, 255, 255)
		end
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('bnj:notif')
AddEventHandler('bnj:notif', function()
	recolerbnj = false
end)
RegisterNetEvent('traitement')
AddEventHandler('traitement', function()
	for v = 1,101 do
		Wait(37)
		tekst = tekst + 1
	end
	Wait(1500)
	tekst = 0
end)

 ------------------------
----------Douche----------
 ------------------------
 local changepas = false 
 local douche = { 
     ["Douche1"] = { ["x"] = 649.96, ["y"] =90.00, ["z"] = 82.94, ["h"] = 331.51}, 
     ["Douche2"] = { ["x"] = 647.61, ["y"] =90.84, ["z"] =82.94, ["h"] = 334.94}, 
     ["Douche3"] = { ["x"] = 645.53, ["y"] =91.64, ["z"] =82.94, ["h"] = 339.72}, 
     ["Douche4"] = { ["x"] = 643.69, ["y"] =92.28, ["z"] =82.94, ["h"] = 341.35}, 
     ["Douche5"] = { ["x"] = 645.62, ["y"] =99.15, ["z"] =82.94, ["h"] = 175.30}, 
     ["Douche6"] = { ["x"] = 647.93, ["y"] =99.12, ["z"] =82.94, ["h"] = 177.57}, 
     ["Douche7"] = { ["x"] = 650.31, ["y"] =99.07, ["z"] =82.94, ["h"] = 177.78}
 
 
 } 
 
 RegisterNetEvent('bnj:sync')
 AddEventHandler('bnj:sync', function(ped, stop)
         local Player = ped
         local PlayerPed = PlayerPedId()
         local particleDictionary = "core"
         local particleName = "ent_amb_fly_swarm"
 
         RequestNamedPtfxAsset(particleDictionary)
 
         while not HasNamedPtfxAssetLoaded(particleDictionary) do
             Wait(0)
         end
 
         SetPtfxAssetNextCall(particleDictionary)
         BNJ_BronwyProd = GetPedBoneIndex(PlayerPed, 11816)
         Wait(25)
         effect2 = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, BNJ_BronwyProd, 2.2, false, false, false)
         Wait(25)
         effect3 = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.0, -0.6, 0.0, 0.0, 20.0, BNJ_BronwyProd, 2.2, false, false, false)
         Wait(25)
         effect4 = StartParticleFxLoopedOnPedBone("exp_grd_bzgas_smoke", PlayerPed, 0.0, -0.6, -0.2, 0.0, 0.0, 20.0, BNJ_BronwyProd, 0.7, false, false, false)
         Wait(25)
         StopParticleFxLooped(effect2, 0)
         Wait(25)
         StopParticleFxLooped(effect3, 0)
         Wait(25)
         StopParticleFxLooped(effect4, 0)
 end)
 
 CreateThread(function()
     while true do
       
     Wait(5)
       
         local coords = GetEntityCoords(PlayerPedId())
         for k, v in pairs(douche) do
             if GetDistanceBetweenCoords(coords, v["x"], v["y"], v["z"], true) < 1.5 then
                     ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour prendre votre douche')
                     if IsControlPressed(0, 38) then
                         changepas = false
                         local hashSkin = GetHashKey("mp_m_freemode_01") 	
                         SetEntityCoords(PlayerPedId(), v["x"], v["y"], v["z"])
                         SetEntityHeading(PlayerPedId(), v["h"])
                         FreezeEntityPosition(PlayerPedId(), true)
                         if GetEntityModel(PlayerPedId()) == hashSkin then 
                                 print("^9BrownyProd ^4| ^6BNJ Homme Efficace")
                             TriggerEvent('skinchanger:getSkin', function(skin)
                                 local clothesSkin = {
                                 ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                                 ['torso_1'] = 15, ['torso_2'] = 0,
                                 ['arms'] = 15,
                                 ['pants_1'] = 61, ['pants_2'] = 5,
                                 ['shoes_1'] = 34, ['shoes_2'] = 0,
                             }
                             TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
 
                         end)
                         else
                             print("^9BrownyProd ^4| ^6BNJ Homme Efficace")
                             TriggerEvent('skinchanger:getSkin', function(skin)
                                 local clothesSkin = {
                                 ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                                 ['torso_1'] = 15, ['torso_2'] = 0,
                                 ['arms'] = 15,
                                 ['pants_1'] = 15, ['pants_2'] = 0,
                                 ['shoes_1'] = 35, ['shoes_2'] = 0,
                             }
                             TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
 
                             end)
                         end
                         Wait(500)
                         TriggerEvent('bnj:supersync',PlayerPedId(), 'bnj', v["x"], v["y"], v["z"])
                         Wait(2500)
                         Wait(1000)
                         TriggerEvent('bnj:supersync', PlayerPedId(), 'bnj1')
                         Wait(6500)
                         FreezeEntityPosition(PlayerPedId(), false)
                     end
                 end
             end 
         end
     end)
 
 RegisterNetEvent('bnj:syncdouche')
 AddEventHandler('bnj:syncdouche', function(ped, x, y, z)
         local Player = ped
         local PlayerPed =PlayerPedId()
         local particleDictionary = "core"
         local particleName = "exp_sht_steam"
         local animDictionary = 'mp_safehouseshower@male@'
         local animDictionary2 = 'mp_safehouseshower@female@'
         local animName = 'male_shower_towel_dry_to_get_dressed'
         prop_name = prop_name or 'v_res_fa_sponge01'
         local playerPed = PlayerPedId()
         local x,y,z = table.unpack(GetEntityCoords(playerPed))
         local propsuper = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
         local boneIndex = GetPedBoneIndex(playerPed, 18905)
         AttachEntityToEntity(propsuper, playerPed, boneIndex, 0.12, 0.035, 0.009, -30.0, -240.0, -120.0, true, true, false, true, 1, true)
         RequestAnimDict(animDictionary)
 
         while not HasAnimDictLoaded(animDictionary) do
             Wait(0)
         end
         
         local hashSkin = GetHashKey("mp_m_freemode_01") 
         RequestAnimDict(animDictionary2)
 
         while not HasAnimDictLoaded(animDictionary2) do
             Wait(0)
         end		
         TaskPlayAnim(PlayerPed, animDictionary, animName, 8.0, -8.0, -1, 0, 0, false, false, false)
         
         RequestNamedPtfxAsset(particleDictionary)
 
         while not HasNamedPtfxAssetLoaded(particleDictionary) do
             Wait(0)
         end
 
         SetPtfxAssetNextCall(particleDictionary)
         
         local coords = GetEntityCoords(playerPed)
         local effect = StartParticleFxLoopedAtCoord(particleName, x, y, z+1.3, 0.0, 180.0, 0.0, 1.0, false, false, false, false)
         Wait(25)
         Wait(10000)
         DeleteEntity(propsuper)
         while not DoesParticleFxLoopedExist(effect) do
         Wait(5)
         end
         StopParticleFxLooped(effect, 0)
         Wait(25)
         StopParticleFxLooped(effect, 0)
         ClearPedTasks(PlayerPed)
         ClearPedBloodDamage(PlayerPed)
         ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
             if skin.sex == 0 then
                 TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.prison_vetement.male)
             else
                 TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms.prison_vetement.female)
             end
         Wait(25)
         StopParticleFxLooped(effect, 0)
         end)
        SetPedWetnessHeight(PlayerPed, 1.0)
      end)
 
 

      
--Douche 
AddEventHandler('bnj:supersync', function(player, sync, x, y, z)
	if sync == 'bnj1' then
		TriggerEvent('bnj:sync', -1, player)
	elseif sync == 'bnj' then
		TriggerEvent('bnj:syncdouche', -1, player, x, y, z)

	end
end)


CreateThread(function()

    local prisonmap = AddBlipForCoord(729.49, 144.08, 20.8)

    SetBlipSprite(prisonmap, 285)
    SetBlipColour(prisonmap, 49)
    SetBlipScale(prisonmap, 0.82)
    SetBlipAsShortRange(prisonmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Prison Fédérale")
    EndTextCommandSetBlipName(prisonmap)
end)
