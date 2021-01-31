extends Control

const CRAFTABLEITEMINFO = preload("res://Scripts/UI/CraftableItem.gd");
const CRAFTABLEITEMDISPLAY = preload("res://Prefabs/UIPrefabs/ItemDisplay.tscn");

export var craftableItemsPath:NodePath;
var craftableItems;
var craftableDisplay = [];

var currentlySelectedItem:int;
var craftButtonHovered = false;
func _ready():
	StateController.craftingUI = self;
	craftableItems = get_node(craftableItemsPath) as VBoxContainer;
	UpdateCraftables();

	#DEBUG
	PlayerInventory.AddItem(10,1);
	PlayerInventory.AddItem(10,2);
	pass # Replace with function body.
#TODO: Add UI logic


func ButtonClicked(var itemId):
	currentlySelectedItem = itemId;

func CraftButtonClicked():
	if(currentlySelectedItem != null):
		PlayerInventory.CraftItem(currentlySelectedItem);

func UpdateCraftables():

	#Clear oldOnes
	for i in craftableDisplay:
		if(i != null):
			i.queue_free();

	var playerInventory = PlayerInventory.Inventory;
	var itemsToCraft = Crafter.CheckCraftingArray(playerInventory);

	#print(" Craftable items:" + str(itemsToCraft.size()));
	

	for c in itemsToCraft:
		var itemId = c;
		print(str(itemId));
		var newCraftable = CRAFTABLEITEMDISPLAY.instance();
		var craftableItem = (newCraftable as CRAFTABLEITEMINFO);
		craftableItems.add_child(newCraftable);
		craftableItem.SetInfo(GlobalItemList.RetrieveItemName(c),itemId);
		
		#Selectable items
		craftableItem.connect("buttonPressed",self,"ButtonClicked");

		craftableDisplay.append(newCraftable);
		

	pass # Replace with function body.
