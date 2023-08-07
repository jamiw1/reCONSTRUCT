# Welcome to reCONSTRUCT!
reCONSTRUCT is Roblox framework/engine (if you want to call it an engine) that allows anyone to create "classic-esque" games easily.
An example of a game using reCONSTRUCT is Untitled Plate Game

Below is the almost full documentation explaining how to use the reCONSTRUCT engine, and it's features.


# Player


Creating a player is easy!

Inside the Server script, get the player in some way, (usually by using Players.PlayerAdded)
> [!NOTE]
> Setting the PlayerData value to the new player is not required, but highly recommended to easily access data about a player.

Example:
```lua
PLRS.PlayerAdded:Connect(function(plr)
	Data.PlayerData[plr] = Services.Player.new( --Initializes new player object
		plr, --Sets the player inside the player object
		BrickColor.White(), --Sets players torso color
		{ --Cosmetic table with all cosmetics
			Services.Cosmetic.new(Data.CosmeticData["BurgerBob"].Name, Data.CosmeticData["BurgerBob"].Model, plr, Data.CosmeticData["BurgerBob"].Type), --Creates a cosmetic
			Services.Cosmetic.new(Data.CosmeticData["CheckIt"].Name, Data.CosmeticData["CheckIt"].Model, plr, Data.CosmeticData["CheckIt"].Type), --Creates a cosmetic
		}, 
		0 --Initial currency value
	)
end)
```

## Currency

The built-in currency system is simple. The Player object holds important info about the game currency, like the Value, Name, Symbol and Object.
The currency gets basic info from a module called CurrencyData. (`ReplicatedStorage.SharedStaticData.CurrencyData`)
This CurrencyData module contains static info about the in game currency, such as the currency name, and the currency symbol.

> [!IMPORTANT]
> Currently, it is advised to not change the Name or Symbol of the Currency outside of the CurrencyData module.
> It is important to only change the player's Currency using the methods provided. This ensures it will work with the rest of the modules.

_Default CurrencyData_
```lua
local CurrencyData = {
	Name = "Currency",
	Symbol = "",
}
```


### Methods
```lua
Player:GetCurrencyValue()
```
- Returns the player's current currency amount.
- returns CurrencyValue : Float
```lua
Player:SetCurrencyValue(value)
```
- Sets the value of the player's currency, and returns the old value, and then the new value
- returns OldCurrency : Float, NewCurrency : Float
```lua
Player:AddCurrency(value)
```
- Adds value currency to player's currency
- returns OldCurrency : Float, NewCurrency : Float
```lua
Player:TakeCurrency(value)
```
- Subtracts value currency to player's currency
- returns OldCurrency : Float, NewCurrency : Float

### Events
```lua
Player.OnCurrencyValueChange
```
- Fires whenever player's Currency is changed
- returns OldCurrency : Float, NewCurrency : Float

## Avatar

Modifying the player's avatar isn't difficult. When initializing the Player, you can to choose to add cosmetics in the table.

Example:
```lua
Player.new(
	game.Players["2048ping"],
	BrickColor.White(),
	{ --Cosmetic table with all cosmetics
		Services.Cosmetic.new(Data.CosmeticData["BurgerBob"].Name, Data.CosmeticData["BurgerBob"].Model, plr, Data.CosmeticData["BurgerBob"].Type), --Creates a cosmetic from the ID "BurgerBob"
		Services.Cosmetic.new(Data.CosmeticData["CheckIt"].Name, Data.CosmeticData["CheckIt"].Model, plr, Data.CosmeticData["CheckIt"].Type), --Creates a cosmetic from the ID "CheckIt"
	}, 
	0
)
```
You can also change the color of the player easily with only one line of code!

Example:
```lua
Player:SetColor(BrickColor.Green())
```
With reCONSTRUCT, player cosmetics are based on an ownership system. If the player has a cosmetic in it's `Player.Cosmetics` table,
then they are able to utilize it, by equipping and dequipping it.
You can easily spawn, or revoke cosmetics from individual players with `Player:SpawnCosmetic(cosmeticObj)`, and `Player:RevokeCosmetic(cosmeticID)`.
This is helpful if you have a player based cosmetic shop, where they can sell and buy cosmetics.

Getting cosmetics from the player is also possible (and neccessary if you don't save the cosmetic object in a variable)
Using `Player:GetCosmetics()`, you can get a table of all the player's owned cosmetics.
If you need to find a specific cosmetic, then it is possible to use `Player:FindCosmetic(cosmeticID)` to get the specific object.
> [!NOTE]
> We recommend using `Player:EquipCosmetic(cosmeticID)` and `Player:DequipCosmetic(cosmeticID)` for their respective purposes over finding the cosmetic.

You can dequip or equip all equipped/unequipped cosmetics, by using their respective methods (`Player:GetEquippedCosmetics()` and `Player:GetUnequippedCosmetics()`)

### Methods
```lua
Player:SetColor(brickcolor)
```
- Sets the player's color based on a BrickColor.
- returns OldBrickColor : BrickColor, NewBrickColor : BrickColor
```lua
Player:SpawnCosmetic(cosmeticObj)
```
- Spawns a new cosmetic into the player's Player.Cosmetics table. This allows them to utilize said cosmetic.
- returns nil
```lua
Player:RevokeCosmetic(cosmeticID)
```
- Revokes a cosmetic from the player's Player.Cosmetics table. This makes them unable to utilize this cosmetic anymore
- returns nil
```lua
Player:EquipCosmetic(cosmeticID)
```
- Equips cosmetic based on ID.
- returns nil
```lua
Player:DequipCosmetic(cosmeticID)
```
- Dequips cosmetic based on ID. If the cosmetic type is a face, then it will be replaced with the default ROBLOX smile.
- returns nil
```lua
Player:FindCosmetic(cosmeticID)
```
- Finds cosmetic in player's Player.Cosmetic table based on ID.
- returns Cosmetic : Cosmetic
```lua
Player:GetCosmetics()
```
- Returns all the player's currently owned cosmetic objects.
- returns {Cosmetic : Cosmetic, ...}
```lua
Player:GetEquippedCosmetics()
```
- Returns all the player's currently equipped cosmetic objects.
- returns {Cosmetic : Cosmetic, ...}
```lua
Player:GetUnequippedCosmetics()
```
- Returns all the player's currenctly unequipped cosmetic objects.
- returns {Cosmetic : Cosmetic, ...}

### Events
```lua
Player.OnCosmeticSpawned
```
- Fired whenever a cosmetic is spawned into the player's Player.Cosmetic table
- returns CosmeticSpawned : Cosmetic
```lua
Player.OnCosmeticRevoked
```
- Fired whenever a cosmetic is revoked from the player's Player.Cosmetic table based on ID
- returns CosmeticRevoked : Cosmetic
```lua
Player.OnCosmeticEquip
```
- Fired when a cosmetic is equipped
- returns CosmeticEquipped : Cosmetic
```lua
Player.OnCosmeticDequip
```
- Fired when a cosmetic is dequipped
- returns CosmeticDequipped : Cosmetic
```lua
Player.OnColorChange
```
- Fired when player's color is changed
- returns OldColor : BrickColor, NewColor : BrickColor


# Cosmetics


It is possible to create your own custom cosmetics with the reCONSTRUCT engine.
First, you need to find the CosmeticData module. It is located in `ServerStorage.reCONSTRUCT.Load`, or in the script Server, you can call `Data.CosmeticData`.
Now, creating a cosmetic from here is easy.
By default, CosmeticData is structured like this:
```lua
["CheckIt"] = { --Cosmetic ID
	Name = "Check It", --Visible cosmetic name (for guis and other stuff like that)
	Model = script.CheckIt, --The physical object (has to be an Accessory, or Decal)
	Type = CusEnum.CosmeticType.Face --The Cosmetic type (remember to set this! otherwise, the cosmetic will not work)
}
```
CustomEnum initially contains 1 EnumType, and 3 EnumValues, though it is possible to add more.

- CosmeticType
	- Head
	- Neck
	- Face

> [!IMPORTANT]
> It is easy to add new custom Enums, but remember to keep each value different!
> This ensures that no custom Enum can be equal to a different custom Enum.

Creating the cosmetic object is not difficult. Ensure you have the static data for the cosmetic located somewhere and available in the script.
We set the default module to be CosmeticData, but feel free to change the location and require it in some other way.

Grab the Cosmetic service, and use the `.new()` constructor to initialize the cosmetic. This is done by:
```lua
Cosmetic.new(name, obj, parent, cosmetictype, extradata)
```
We allow you to fully customize individual cosmetics, and allow you to add your own extra data in the form of a table.
Let's walk through initializing the cosmetic.

```lua
local ID = "BurgerBob" -- Easy access for the ID of the item we will create
local newCosmetic = Services.Cosmetic.new( -- Storing the cosmetic so we can equip/dequip it later on. It is also possible to insert it directly into the player
	Data.CosmeticData[ID].Name, -- First, we grab the cosmetic name from CosmeticData.
	Data.CosmeticData[ID].Model, -- Next, we grab the model for our cosmetic again from CosmeticData.
	plr, -- (reCONSTRUCT player object) We then set the player reference for the cosmetic here. This doesn't determine ownership, it only allows us to equip the cosmetic onto our player.
	Data.CosmeticData[ID].Type, -- Last, we set the type of our cosmetic. Depending on what you set the type to, it will change how it functions.
	{Exotic = false} -- You can add any custom data you like through a dictionary, like the example we have provided.
)

plr:SpawnCosmetic(newCosmetic) -- This adds the cosmetic to the player's Player.Cosmetics table, and allows us to utilize the cosmetic directly from the player object
```

### Methods
```lua
Cosmetic:Equip()
```
- Equips the cosmetic onto the Cosmetic.Parent
- returns nil
```lua
Cosmetic:Dequip()
```
- Dequips the cosmetic from the Cosmetic.Parent
- returns nil
```lua
Cosmetic:ReturnType()
```
- Returns the cosmetic's type
- returns cosmeticsType : CustomEnum.CosmeticType

### Events
```lua
Cosmetic.OnEquip
```
- Fires upon being equipped
- returns nil
```lua
Cosmetic.OnDequip
```
- Fires upon being dequipped
- returns nil


# Custom Services


Adding custom logic to your game

We have a built-in module loading system, provided to make it easier to require modules/services you may make.
To create a service, first create the ModuleScript under `ServerStorage.reCONSTRUCT.Load`
To use the service, you need to load it. Loading your service inside of the Server script can be done by locating the Services table,
and simply adding a new entry.

Example:
```lua
local Services = {
	Player = LoadModule("Player"),
	Cosmetic = LoadModule("Cosmetic"),
	CustomService = LoadModule("CustomServiceName")
}
```
From there, you can use any custom logic you like from your new service.
