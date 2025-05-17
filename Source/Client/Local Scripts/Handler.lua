--// Variables

local generated = workspace.Generated
local actor = script:GetActor()

--// Functions

actor:BindToMessageParallel("Handle", function(info: {any})
	local parts = {}
	
	local resolution, frequency, amplitude = info.Resolution, info.Frequency, info.Amplitude
	local terrain_size, part_size = info.Terrain_Size, info.Part_Size
	local bottom_lerp, top_lerp = info.Bottom_Lerp, info.Top_Lerp
	
	for x = info.Start, info.Done do
		for z = 1, terrain_size / part_size do
			local noise = math.noise(x / resolution * frequency, z / resolution * frequency)
			local clamp = math.clamp(noise, -0.5, 0.5)
			
			local convert = 1 - ((clamp + 0.5) / 1)
			local color = top_lerp:Lerp(bottom_lerp, convert)
			local part = Instance.new("Part")
			
			parts[part] = {
				Size = vector.create(part_size, part_size / 2, part_size),
				Position = Vector3.new(x * part_size, clamp * amplitude, z * part_size),
				Anchored = true,
				Color = color,
				Parent = generated
			}
		end
		
		task.wait()
	end
	
	task.synchronize()
	
	for part, properties in pairs(parts) do
		for property, value in pairs(properties) do
			part[property] = value
		end
	end
end)
