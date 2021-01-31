extends Control

const INVENTORYITEM = preload("res://Prefabs/UIPrefabs/InventoryItem.tscn");
var openSlots = [];
var filledSlots = {};

export var descriptionPath:NodePath;
var descriptionObject;

var descriptionTitle;
var descriptionDescription;

var currentHoveredItem;

var container;
# Called when the node enters the scene tree for the first time.
func _ready():

	container = $GridContainer;
	StateController.inventoryUI = self;
	PlayerInventory.connect("ItemUpdate",self,"_ItemUpdate");
	descriptionObject = get_node(descriptionPath);

	descriptionTitle = descriptionObject.find_node("Name",true,true);
	descriptionDescription = descriptionObject.find_node("Description",true,true);
	#Add 42 slots to openSlots

	for i in range(42):
		var newItem = INVENTORYITEM.instance();
		container.add_child(newItem);
		openSlots.append(newItem);
		pass;

	pass # Replace with function body.

func _process(delta):

	if(currentHoveredItem == null || StateController.currentState == 2 || StateController.currentState == 3):
		descriptionObject.visible = false;
	else:
		descriptionObject.visible = true;
		descriptionObject.rect_position = get_viewport().get_mouse_position() + Vector2(10,10);

	#Open inventory
	if(Input.is_action_just_pressed("player_inventory") && StateController.currentState == 2):
		StateController.ChangeState(1);
		SeatInventory();


	elif(Input.is_action_just_pressed("player_inventory") && StateController.currentState == 1):
		StateController.ChangeState(2)

func HideItemDescription(var itemIdIn):
	currentHoveredItem = null;
	pass;

func ShowItemDescription(var itemIdIn):
	currentHoveredItem = itemIdIn;
	descriptionTitle.text = GlobalItemList.RetrieveItemName(itemIdIn);
	descriptionDescription.text = GlobalItemList.RetrieveItemDescription(itemIdIn);
	pass;

func _ItemUpdate(var itemId:int, var newAmount:int):

	if(filledSlots.keys().has(itemId)):
		if(newAmount != 0):
			filledSlots[itemId].UpdateAmount(newAmount);
		else:
			#Move back to openSlots
		
			if(filledSlots[itemId] != null):
				filledSlots[itemId].ClearData();

				#Disconnect the signals
				if(filledSlots[itemId].get_signal_connection_list("mouseHovered").has(self)):
					filledSlots[itemId].disconnect("mouseHovered",self,"ShowItemDescription");

				if(filledSlots[itemId].get_signal_connection_list("mouseExited").has(self)):
					filledSlots[itemId].disconnect("mouseExited",self,"HideItemDescription");

				#Add back into openSlots
				openSlots.push_front(filledSlots[itemId]);
				filledSlots.erase(itemId);
				
			

			
	else:

		#Add new slot
		var newSlot = openSlots.pop_front();
		var texture = GlobalItemList.RetrieveItemTexture(itemId);
		newSlot.SetInfo(itemId,newAmount,texture);
		filledSlots[itemId] = newSlot;

		newSlot.connect("mouseHovered",self,"ShowItemDescription");
		newSlot.connect("mouseExited",self,"HideItemDescription");
		
	pass;
	
	
func SeatInventory():
	var pInv = PlayerInventory.InvToArray();
	var counter = 1;
	for i in range(PlayerInventory.InventoryCount()):
		_ItemUpdate(pInv[counter], pInv[counter - 1]);
		counter += 2;
	pass;
	
