extends Control

const INVENTORYITEM = preload("res://Prefabs/UIPrefabs/InventoryItem.tscn");

var openSlots = [];
var filledSlots = {};

var container;
# Called when the node enters the scene tree for the first time.
func _ready():

	container = $GridContainer;
	StateController.inventoryUI = self;
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

func _process(delta):
	#Open inventory
	if(Input.is_action_just_pressed("player_inventory") && StateController.currentState == 2):
		print("Opened inventory");
		StateController.ChangeState(1);

	elif(Input.is_action_just_pressed("player_inventory") && StateController.currentState == 1):
		print("Opened inventory");
		StateController.ChangeState(2)


func _ItemUpdate(var itemId:int, var newAmount:int):

	if(filledSlots.keys().has(itemId)):
		if(newAmount != 0):
			filledSlots[itemId].UpdateAmount(newAmount);
		else:
			#Move back to openSlots
			filledSlots[itemId].ClearData();
			openSlots.push_front(filledSlots[itemId]);
			filledSlots.erase(itemId);
	else:
		var newSlot = openSlots[0];
		var texture = GlobalItemList.RetrieveItemTexture(itemId);
		newSlot.SetInfo(itemId,newAmount,texture);
	pass;