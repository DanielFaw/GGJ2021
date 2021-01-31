extends Control


export var materialDict = {};

const MATERIALUI = preload("res://Scripts/UI/MaterialDisplay.gd");
const CRAFTABLEITEMINFO = preload("res://Scripts/UI/CraftableItem.gd");
const CRAFTABLEITEMDISPLAY = preload("res://Prefabs/UIPrefabs/ItemDisplay.tscn");

var craftableItems;

func _ready():
	StateController.craftingUI = self;
	craftableItems = $CraftableItems/VBoxContainer/ScrollContainer/VBoxContainer;
	UpdateCraftables();
	
	pass # Replace with function body.

#TODO: Add UI logic
func UpdateCraftables():

	var playerInventory = PlayerInventory.Inventory;
	##Populate Materials items
	#for i in materialDict.keys():
	#	var materialDisplay = (get_node(materialDict[i]) as MATERIALUI);
	#	materialDisplay.SetLabel(GlobalItemList.RetrieveItemName(i));
	#	materialDisplay.UpdateAmount(PlayerInventory.GetAmountOfItem(i));


	var craftableItems = Crafter.CheckCrafting(playerInventory);

	for c in craftableItems:
		var itemId = c;
		var newCraftable = CRAFTABLEITEMDISPLAY.instance();
		var craftableDisplay = (newCraftable as CRAFTABLEITEMINFO);
		craftableItems.SetData(GlobalItemList.RetrieveItemName(itemId),PlayerInventory.GetAmountOfItem(itemId));
		craftableItems.add_child(newCraftable);
		

	pass # Replace with function body.
