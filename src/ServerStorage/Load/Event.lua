--Credits to Artoshia

local Event = {}
Event.__index = Event

function Event.new()
	local self = setmetatable({}, Event)
	self.Callbacks = {}	


	return self
end

function Event:Fire(...)

	for Callback in pairs(self.Callbacks) do
		task.defer(Callback, ...)
	end
end


function Event:Connect(Callback)
	local callbacks = self.Callbacks
	callbacks[Callback] = true

	local EventConnection = {}

	function EventConnection:Disconnect()
		callbacks[Callback] = nil
	end
	EventConnection.Destroy = EventConnection.Disconnect
	EventConnection.disconnect = EventConnection.Disconnect

	return EventConnection
end

Event.connect = Event.Connect

return Event