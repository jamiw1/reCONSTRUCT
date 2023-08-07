local LoadModule = require(script.Parent)
local Event = LoadModule("Event")

local CLIENT = game:GetService("ReplicatedStorage"):WaitForChild("reCONSTRUCT")
local CurrencyData = require(CLIENT.SharedStaticData.CurrencyData)

local Player = {}
Player.__index = Player

function Player.new(playerObj, brickcolor, cosmetics, startingCurrency, extradata)
	local self = {}
	setmetatable(self, Player)
	
	self.OBJ = playerObj
	self.Character = self.OBJ.Character or self.OBJ.CharacterAdded:Wait()
	self.Color = brickcolor
	self.Cosmetics = cosmetics
	self.Currency = table.clone(CurrencyData)
	
	local LDRSTS = Instance.new("Folder")
	LDRSTS.Name = "leaderstats"
	LDRSTS.Parent = self.OBJ
	self.Currency.Object = Instance.new("StringValue")
	self.Currency.Object.Name = self.Currency.Name
	self.Currency.Object.Parent = LDRSTS
	
	self.Character:WaitForChild("Torso").BrickColor = self.Color
	
	self.OnCosmeticSpawned = Event.new()
	self.OnCosmeticRevoked = Event.new()
	
	self.OnCosmeticEquip = Event.new()
	self.OnCosmeticDequip = Event.new()
	self.OnColorChange = Event.new()
	
	self.OnCurrencyValueChange = Event.new()
	self:SetCurrencyValue(startingCurrency)
	
	if extradata then
		for key, value in pairs(extradata) do
			self[key] = value
		end
	end
	
	self.OBJ.CharacterAdded:Connect(function(obj)
		self.Character = obj
		self.Character.Torso.BrickColor = self.Color
		for _, cosm in pairs(self:GetEquippedCosmetics()) do
			cosm:Equip()
		end
	end)

	return self
end

-------------------------
------ [ Methods ] ------
-------------------------

function Player:formatCurrency()
	if self.Currency.SideLeft then
		return self.Currency.Symbol..tostring(self.Currency.Value)
	else
		return tostring(self.Currency.Value)..self.Currency.Symbol
	end
end

function Player:GetCurrencyValue()
	return self.Currency.Value
end

function Player:SetCurrencyValue(value)
	local oldValue = self.Currency.Value
	self.Currency.Value = value
	self.Currency.Object.Value = self:formatCurrency()
	self.OnCurrencyValueChange:Fire(oldValue, value)
	return oldValue, value
end

function Player:AddCurrency(value)
	local oldValue = self.Currency.Value
	self.Currency.Value += value
	self.Currency.Object.Value = self:formatCurrency()
	self.OnCurrencyValueChange:Fire(oldValue, self.Currency.Value)
	return oldValue, self.Currency.Value
end

function Player:TakeCurrency(value)
	local oldValue = self.Currency.Value
	self.Currency.Value -= value
	self.Currency.Object.Value = self:formatCurrency()
	self.OnCurrencyValueChange:Fire(oldValue, self.Currency.Value)
	return oldValue, self.Currency.Value
end


function Player:SetColor(brickcolor)
	local oldColor = self.Color
	self.Color = brickcolor
	self.Character:WaitForChild("Torso").BrickColor = self.Color
	self.OnColorChange:Fire(oldColor, brickcolor)
	return oldColor, brickcolor
end

function Player:SpawnCosmetic(cosmeticObj)
	if cosmeticObj then
		cosmeticObj.Parent = self
		table.insert(self.Cosmetics, cosmeticObj)
		self.OnCosmeticSpawned:Fire(cosmeticObj)
	else
		warn("Forgot to enter cosmeticObj when spawning cosmetic")
	end
	
end
function Player:RevokeCosmetic(cosmeticID)
	for k, cosmetic in pairs(self.Cosmetics) do
		if cosmeticID then
			cosmetic.Parent = nil
			self.Cosmetics[k] = nil
			self.OnCosmeticRevoked:Fire(cosmetic)
		end
	end
	if not cosmeticID then
		warn("Forgot to enter cosmeticID when revoking cosmetic")
	end
end


function Player:EquipCosmetic(cosmeticID)
	for k, cosmetic in pairs(self.Cosmetics) do
		if cosmetic.ID == cosmeticID then
			self.Cosmetics[k]:Equip()
			self.OnCosmeticEquip:Fire(cosmetic)
		end
	end
end
function Player:DequipCosmetic(cosmeticID)
	for k, cosmetic in pairs(self.Cosmetics) do
		if cosmetic.ID == cosmeticID then
			self.Cosmetics[k]:Dequip()
			self.OnCosmeticDequip:Fire(cosmetic)
		end
	end
end

function Player:FindCosmetic(cosmeticID)
	for k, cosmetic in pairs(self.Cosmetics) do
		if cosmetic.ID == cosmeticID then
			return cosmeticID
		end
	end
	return warn("Could not find cosmetic "..cosmeticID.." on player "..self.OBJ.Name)
end

function Player:GetCosmetics()
	return self.Cosmetics
end


function Player:GetEquippedCosmetics()
	local equippedCosm = {}
	for k, cosmetic in pairs(self.Cosmetics) do
		if cosmetic.Equipped then
			table.insert(equippedCosm, cosmetic)
		end
	end
	return equippedCosm
end
function Player:GetUnequippedCosmetics()
	local unequippedCosm = {}
	for k, cosmetic in pairs(self.Cosmetics) do
		if not cosmetic.Equipped then
			table.insert(unequippedCosm, cosmetic)
		end
	end
	return unequippedCosm
end

return Player
