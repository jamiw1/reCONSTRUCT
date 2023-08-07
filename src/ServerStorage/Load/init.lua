local Loaded = {}

return function(name, clone)
	local module = script:FindFirstChild(name, true)

	if not Loaded[name] then
		local bind = Instance.new("BindableEvent")
		Loaded[name] = bind.Event
		
		coroutine.wrap(function()
			require(module)

			Loaded[name] = true
			bind:Fire()
			
			bind:Destroy()
			bind = nil
		end)()
	end
	
	if clone then
		local result = {}
		
		if Loaded[name] == true then
			setmetatable(result, { __index = require(module), __newindex = require(module) })
		else
			Loaded[name]:Connect(function()
				setmetatable(result, { __index = require(module), __newindex = require(module) })
			end)
		end
		
		return result
	end
	
	if Loaded[name] ~= true then
		Loaded[name]:Wait()
	end
	
	return require(module)
end