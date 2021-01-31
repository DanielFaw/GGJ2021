extends Node

const PLAYERCONTROLLER = preload("res://Scripts/PlayerControl/PlayerControl.gd");

export var signPath:NodePath;
var repairSign;

var playerInRepairArea = false;

var partsIds = [41,42,43,44,45,46]

var partsToRepair = [];
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(playerInRepairArea && partsToRepair != null):
		if(Input.is_action_just_pressed("player_interact")):
			for p in partsToRepair:

				partsIds.remove(p);
				#Repair the part and remove from players inventory
				ProgressManager.RepairPart(p);
				PlayerInventory.RemoveItem(p,1);

func bodyEntered(body):
	if((body as PLAYERCONTROLLER) != null):
		playerInRepairArea = true;
		CheckForRepairableParts()
	pass # Replace with function body.
	

func bodyExit(var bodyExited):
	if((bodyExited as PLAYERCONTROLLER) != null):
		playerInRepairArea = false;
		repairSign.visible = true;
	pass;


func CheckForRepairableParts():
	partsToRepair.clear();	
	for p in partsIds:
		if(PlayerInventory.GetAmountOfItem(p) > 0):
			partsToRepair.append(p);
	
	if(partsToRepair.size() != 0):
		repairSign.visible = true;
	
	

