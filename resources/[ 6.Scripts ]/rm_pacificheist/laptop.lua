local a = {"SENTINEL"}
cachedScaleform = nil
function ScaleformLabel(b)
    BeginTextCommandScaleformString(b)
    EndTextCommandScaleformString()
end
local c = 3
local d
local e = false
local f = false
local g = false
StartComputer = function()
    CreateThread(
        function()
            InitializeBruteForce = function(h)
                local h = RequestScaleformMovieInteractive(h)
                while not HasScaleformMovieLoaded(h) do
                    Wait(0)
                end
                local i = "hack"
                local j = 0
                while HasAdditionalTextLoaded(j) and not HasThisAdditionalTextLoaded(i, j) do
                    Wait(0)
                    j = j + 1
                end
                if not HasThisAdditionalTextLoaded(i, j) then
                    ClearAdditionalText(j, true)
                    RequestAdditionalText(i, j)
                    while not HasThisAdditionalTextLoaded(i, j) do
                        Wait(0)
                    end
                end
                PushScaleformMovieFunction(h, "SET_LABELS")
                PushScaleformMovieFunctionParameterString("Local (C:)")
                PushScaleformMovieFunctionParameterString("Global Network")
                PushScaleformMovieFunctionParameterString("External Device (J:)")
                PushScaleformMovieFunctionParameterString("HackConnect.exe")
                PushScaleformMovieFunctionParameterString("BruteForce.exe")
                ScaleformLabel("H_ICON_6")
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_BACKGROUND")
                PushScaleformMovieFunctionParameterInt(1)
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "ADD_PROGRAM")
                PushScaleformMovieFunctionParameterFloat(1.0)
                PushScaleformMovieFunctionParameterFloat(4.0)
                PushScaleformMovieFunctionParameterString("My Computer")
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "ADD_PROGRAM")
                PushScaleformMovieFunctionParameterFloat(6.0)
                PushScaleformMovieFunctionParameterFloat(6.0)
                PushScaleformMovieFunctionParameterString("Power Off")
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_LIVES")
                PushScaleformMovieFunctionParameterInt(c)
                PushScaleformMovieFunctionParameterInt(5)
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_LIVES")
                PushScaleformMovieFunctionParameterInt(c)
                PushScaleformMovieFunctionParameterInt(5)
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(0)
                PushScaleformMovieFunctionParameterInt(math.random(220, 240))
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(1)
                PushScaleformMovieFunctionParameterInt(math.random(220, 240))
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(2)
                PushScaleformMovieFunctionParameterInt(math.random(220, 240))
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(3)
                PushScaleformMovieFunctionParameterInt(math.random(220, 240))
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(4)
                PushScaleformMovieFunctionParameterInt(math.random(220, 240))
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(5)
                PushScaleformMovieFunctionParameterInt(math.random(220, 240))
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(6)
                PushScaleformMovieFunctionParameterInt(math.random(220, 240))
                PopScaleformMovieFunctionVoid()
                PushScaleformMovieFunction(h, "SET_COLUMN_SPEED")
                PushScaleformMovieFunctionParameterInt(7)
                PushScaleformMovieFunctionParameterInt(math.random(220, 240))
                PopScaleformMovieFunctionVoid()
                return h
            end
            cachedScaleform = InitializeBruteForce("HACKING_PC")
            g = true
            while g do
                Wait(0)
                DisableControlAction(0, 1, true)
                DisableControlAction(0, 2, true)
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 25, true)
                DisableControlAction(0, 263, true)
                DisableControlAction(0, 31, true)
                DisableControlAction(0, 30, true)
                DisableControlAction(0, 59, true)
                DisableControlAction(0, 71, true)
                DisableControlAction(0, 72, true)
                DisableControlAction(0, 46, true)
                DisableControlAction(0, 264, true)
                DisableControlAction(0, 257, true)
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true)
                DisableControlAction(0, 142, true)
                DisableControlAction(0, 143, true)
                DisableControlAction(0, 75, true)
                DisableControlAction(27, 75, true)
                if g then
                    DrawScaleformMovieFullscreen(cachedScaleform, 255, 255, 255, 255, 0)
                    PushScaleformMovieFunction(cachedScaleform, "SET_CURSOR")
                    PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
                    PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
                    PopScaleformMovieFunctionVoid()
                    if IsDisabledControlJustPressed(0, 24) and not e then
                        PushScaleformMovieFunction(cachedScaleform, "SET_INPUT_EVENT_SELECT")
                        d = PopScaleformMovieFunction()
                        PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
                    elseif IsDisabledControlJustPressed(0, 25) and not f and not e then
                        PushScaleformMovieFunction(cachedScaleform, "SET_INPUT_EVENT_BACK")
                        PopScaleformMovieFunctionVoid()
                        PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
                    end
                end
            end
        end
    )
end
CreateThread(
    function()
        while true do
            local k = 1000
            if HasScaleformMovieLoaded(cachedScaleform) and g then
                k = 1
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                if GetScaleformMovieFunctionReturnBool(d) then
                    ProgramID = GetScaleformMovieFunctionReturnInt(d)
                    if ProgramID == 83 and not f then
                        c = 3
                        PushScaleformMovieFunction(cachedScaleform, "SET_LIVES")
                        PushScaleformMovieFunctionParameterInt(c)
                        PushScaleformMovieFunctionParameterInt(5)
                        PopScaleformMovieFunctionVoid()
                        PushScaleformMovieFunction(cachedScaleform, "OPEN_APP")
                        PushScaleformMovieFunctionParameterFloat(1.0)
                        PopScaleformMovieFunctionVoid()
                        PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_WORD")
                        PushScaleformMovieFunctionParameterString(a[math.random(#a)])
                        PopScaleformMovieFunctionVoid()
                        f = true
                    elseif f and ProgramID == 87 then
                        c = c - 1
                        PushScaleformMovieFunction(cachedScaleform, "SET_LIVES")
                        PushScaleformMovieFunctionParameterInt(c)
                        PushScaleformMovieFunctionParameterInt(5)
                        PopScaleformMovieFunctionVoid()
                        PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                    elseif f and ProgramID == 92 then
                        PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
                    elseif f and ProgramID == 86 then
                        e = true
                        PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                        PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(true)
                        ScaleformLabel("WINBRUTE")
                        PopScaleformMovieFunctionVoid()
                        Wait(5000)
                        PushScaleformMovieFunction(cachedScaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        SetScaleformMovieAsNoLongerNeeded(cachedScaleform)
                        g = false
                        f = false
                        e = false
                        HackingCompleted(true)
                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                    elseif ProgramID == 6 then
                        g = false
                        SetScaleformMovieAsNoLongerNeeded(cachedScaleform)
                        HackingCompleted(false)
                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                    end
                    if f then
                        PushScaleformMovieFunction(cachedScaleform, "SHOW_LIVES")
                        PushScaleformMovieFunctionParameterBool(true)
                        PopScaleformMovieFunctionVoid()
                        if c <= 0 then
                            e = true
                            PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                            PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_OUTCOME")
                            PushScaleformMovieFunctionParameterBool(false)
                            ScaleformLabel("LOSEBRUTE")
                            PopScaleformMovieFunctionVoid()
                            Wait(5000)
                            PushScaleformMovieFunction(cachedScaleform, "CLOSE_APP")
                            PopScaleformMovieFunctionVoid()
                            SetScaleformMovieAsNoLongerNeeded(cachedScaleform)
                            f = false
                            e = false
                            g = false
                            HackingCompleted(false)
                            DisableControlAction(0, 24, false)
                            DisableControlAction(0, 25, false)
                        end
                    end
                end
            end
            Wait(k)
        end
    end
)

function HackingCompleted(status)
    hackFinished = true
    hackStatus = status
end