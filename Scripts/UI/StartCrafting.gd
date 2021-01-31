extends Spatial

const PLAYERCONTROLLER = preload("res://Scripts/PlayerControl/PlayerControl.gd");

export var signPath:NodePath;
var startSign;

var playerInCraftingArea = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	startSign = get_node(signPath);
	startSign.visible = false;
	pass # Replace with function body.

func _process(delta):

	#Start Crafting
	if(playerInCraftingArea && StateController.currentState == 0 ||StateController.currentState == 1):
		if(Input.is_action_just_pressed("player_interact")):
			#You need to 'reseat' the inventory here, like i did in InventoryUIController
			StateController.ChangeState(2);

	#Stop Crafting
	elif(playerInCraftingArea && StateController.currentState == 2):
		if(Input.is_action_just_pressed("player_interact") || Input.is_action_just_pressed("ui_cancel")):
			StateController.ChangeState(0);
		pass;


func bodyEntered(body):
	if((body as PLAYERCONTROLLER) != null):
		startSign.visible = true;
		playerInCraftingArea = true;
	pass # Replace with function body.
	

func bodyExit(var bodyExited):
	if((bodyExited as PLAYERCONTROLLER) != null):
		startSign.visible = false;
		playerInCraftingArea = false;
	pass;
	


