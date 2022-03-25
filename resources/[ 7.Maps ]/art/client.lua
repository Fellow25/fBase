CreateThread(function()
	RequestIpl("k4mb1_artgallery_milo_")
	
-- Vault
	local interiorid = GetInteriorAtCoords(27.478, 143.0223, 97.945)
	
	-- ROOF WINWDOWS
	ActivateInteriorEntitySet(interiorid, "set_windows_normal")
	-- ActivateInteriorEntitySet(interiorid, "set_windows_cut")
	
	-- PAINTINGS
	ActivateInteriorEntitySet(interiorid, "set_painting_1")
	ActivateInteriorEntitySet(interiorid, "set_painting_2")
	ActivateInteriorEntitySet(interiorid, "set_painting_3")
	ActivateInteriorEntitySet(interiorid, "set_painting_4")
	ActivateInteriorEntitySet(interiorid, "set_painting_5")
	ActivateInteriorEntitySet(interiorid, "set_painting_6")
	ActivateInteriorEntitySet(interiorid, "set_painting_7")
	ActivateInteriorEntitySet(interiorid, "set_painting_8")
	ActivateInteriorEntitySet(interiorid, "set_painting_9")
	ActivateInteriorEntitySet(interiorid, "set_painting_10")
	
	-- SHUTTERS
	-- ActivateInteriorEntitySet(interiorid, "set_shutters")
	
	-- EGGS
	ActivateInteriorEntitySet(interiorid, "egg1") -- (Default with egg)
	-- ActivateInteriorEntitySet(interiorid, "egg2") -- (Egg with hole in glass)
	-- ActivateInteriorEntitySet(interiorid, "egg3") -- (No egg)
	
	-- SEC ROOM KEYPAD
	ActivateInteriorEntitySet(interiorid, "keypad_01")
	-- ActivateInteriorEntitySet(interiorid, "keypad_error")
	-- ActivateInteriorEntitySet(interiorid, "keypad_destroyed")

	-- ActivateInteriorEntitySet(interiorid, "slidedoors_open")
	ActivateInteriorEntitySet(interiorid, "slidedoors_unlocked")  -- (door slide animation when near door)
	-- ActivateInteriorEntitySet(interiorid, "slidedoors_locked") 

	RefreshInterior(interiorid)
	
end)
