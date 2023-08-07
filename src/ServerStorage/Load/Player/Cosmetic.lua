local LoadModule = require(script.Parent.Parent)
local Event = LoadModule("Event")

local CLIENT = game:GetService("ReplicatedStorage"):WaitForChild("reCONSTRUCT")
local CusEnum = require(CLIENT.SharedStaticData.CustomEnum)
local Cosmetic = {}
Cosmetic.__index = Cosmetic

function Cosmetic.new(name, obj, parent, costype, extradata)
	local self = {}
	setmetatable(self, Cosmetic)
	
	self.obj = obj:Clone()
	self.ID = self.obj.Name
	self.Name = name
	self.Parent = parent	
	self.Equipped = false
	self.Type = costype
	
	self.OnEquip = Event.new()
	self.OnDequip = Event.new()
	
	if extradata then
		for key, value in pairs(extradata) do
			self[key] = value
		end
	end
	
	return self
end

function Cosmetic:Equip()
	if self.Type == CusEnum.CosmeticType.Head or self.Type == CusEnum.CosmeticType.Neck then
		self.obj.Parent = self.Parent.Character
		self.Equipped = true
		self.OnEquip:Fire()
	end
	if self.Type == CusEnum.CosmeticType.Face then
		self.Parent.Character.Head.face.Texture = self.obj.Texture
		self.Equipped = true
		self.OnEquip:Fire()
	end
end
function Cosmetic:Dequip()
	if self.Type == CusEnum.CosmeticType.Head or self.Type == CusEnum.CosmeticType.Neck then
		self.obj.Parent = nil
		self.Equipped = false
		self.OnDequip:Fire()
	end
	if self.Type == CusEnum.CosmeticType.Face then
		self.Parent.Character.Head.face.Texture = "rbxasset://textures/face.png"
		self.Equipped = false
		self.OnDequip:Fire()
	end
end

function Cosmetic:ReturnType()
	return self.Type
end

return Cosmetic
