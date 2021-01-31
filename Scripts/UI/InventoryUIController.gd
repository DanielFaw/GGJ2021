extends Control

const INVENTORYITEM = preload("res://Prefabs/UIPrefabs/InventoryItem.tscn");

var openSlots = [];
var filledSlots = {};

var container;
# Called when the node enters the scene tree for the first time.
func _ready():

	container = $GridContainer;
	PlayerInventory.connect("ItemUpdate",self,"_ItemUpdate");
	#Add 42 slots to openSlots

	for i in range(42):
		print(i);
		var newItem = INVENTORYITEM.instance();
		container.add_child(newItem);
		openSlots.append(newItem);
		pass;

	print("Created " + str(openSlots.size()) + " inventory slots");
	pass # Replace with function body.


func _ItemUpdate(var itemId:int, var newAmount:int):

	if(filledSlots.keys().has(itemId)):
		filledSlots[itemId].UpdateAmount(newAmount);
	else:
		var newSlot = 
	pass;