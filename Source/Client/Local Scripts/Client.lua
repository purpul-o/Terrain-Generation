--// Variables

local modules = script.Modules
local assets = script.Assets

local template = assets.Thread
local utility = modules.Utility

local configuration = require(utility.Configuration)

local noise = configuration.Noise
local terrain = configuration.Terrain
local other = configuration.Other

local resolution, frequency, amplitude = noise.Resolution, noise.Frequency, noise.Amplitude
local terrain_size, part_size = terrain.Terrain_Size, terrain.Part_Size
local actors, bottom_lerp, top_lerp = other.Actors, other.Bottom_Lerp, other.Top_Lerp

local chunk = (terrain_size / actors) / part_size

--// Functions

for i = 1, actors do
	local clone = template:Clone()
	clone.Parent = script
	
	local start = math.ceil((i - 1) * chunk + 1)
	local done = math.ceil(i * chunk)
	
	task.wait()
	
	clone:SendMessage("Handle", {
		Start = start,
		Done = done,
		Resolution = resolution,
		Frequency = frequency,
		Amplitude = amplitude,
		Terrain_Size = terrain_size,
		Part_Size = part_size,
		Top_Lerp = top_lerp,
		Bottom_Lerp = bottom_lerp
	})
end
