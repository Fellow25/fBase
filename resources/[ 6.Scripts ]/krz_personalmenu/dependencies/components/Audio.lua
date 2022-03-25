---PlaySound
---@param Library string
---@param Sound string
---@param IsLooped boolean
---@return void
---@public
function PlaySound(Library, Sound, IsLooped, Audio)
	if not IsLooped then
		PlaySoundFrontend(-1, Sound, Library, true)
	else
		if not Audio.Id then
			CreateThread(function()
				Audio.Id = GetSoundId()
				PlaySoundFrontend(Audio.Id, Sound, Library, true)
				Wait(0.01)

				StopSound(Audio.Id)
				ReleaseSoundId(Audio.Id)
				Audio.Id = nil
			end)
		end
	end
end