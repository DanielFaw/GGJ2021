extends Control

const CRAFTABLEITEMINFO = preload("res://Scripts/UI/CraftableItem.gd");
const CRAFTABLEITEMDISPLAY = preload("res://Prefabs/UIPrefabs/ItemDisplay.tscn");

var craftableItems;
var craftableDisplay = [];
func _ready():
	StateController.craftingUI = self;
	craftableItems = $CraftableItems/VBoxContainer/ScrollContainer/VBoxContainer;
	UpdateCraftables();

	#DEBUG
	PlayerInventory.AddItem(10,1);
	PlayerInventory.AddItem(10,2);
	pass # Replace with function body.
#TODO: Add UI logic
func UpdateCraftables():

	#Clear oldOnes
	for i in craftableDisplay:
		craftableItems.remove_child(i);

	var playerInventory = PlayerInventory.Inventory;
	var craftableItems = Crafter.CheckCraftingArray(playerInventory);

	print(" Craftable items:" + str(craftableItems.size()));
	

	for c in craftableItems:
		var itemId = c;
		print(str(itemId));
		var newCraftable = CRAFTABLEITEMDISPLAY.instance();
		var craftableItem = (newCraftable as CRAFTABLEITEMINFO);
		craftableItem.SetInfo(GlobalItemList.RetrieveItemName(c),itemId);
		craftableItems.add_child(newCraftable);

		craftableDisplay.append(newCraftable);
		

	pass # Replace with function body.
