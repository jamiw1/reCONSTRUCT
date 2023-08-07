---------------------------------------------
------ [ DO NOT TOUCH ANYTHING BELOW ] ------
---------------------------------------------

local SERVER = game:GetService("ServerStorage"):WaitForChild("reCONSTRUCT")
local CLIENT = game:GetService("ReplicatedStorage"):WaitForChild("reCONSTRUCT")
local PLRS = game:GetService("Players")

local LoadModule = require(SERVER.Load)
local Services = {
	Player = LoadModule("Player"),
	Cosmetic = LoadModule("Cosmetic"),
}

local Data = {
	PlayerData = LoadModule("PlayerData"),
	CosmeticData = LoadModule("CosmeticData"),
	CustomEnum = require(CLIENT.SharedStaticData.CustomEnum)
}

-------------------------------------------------------------------------------
------ [ DO NOT TOUCH ANYTHING ABOVE UNLESS YOU KNOW WHAT YOU'RE DOING ] ------
-------------------------------------------------------------------------------

PLRS.PlayerAdded:Connect(function(plr)
	Data.PlayerData[plr] = Services.Player.new( --Creates new player object
		plr,
		BrickColor.White(),
		{}, 
		0
	)
end)