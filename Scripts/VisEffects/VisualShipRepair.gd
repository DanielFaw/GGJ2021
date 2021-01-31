extends Spatial

export var repariableParts = {};
var firstPartRepaired = false;

var brokenShip;
var repairedShip;
# Called when the node enters the scene tree for the first time.
func _ready():
	brokenShip = $Broken;
	repairedShip = $Repaired
	ProgressManager.visualShip = self;
	pass # Replace with function body.


func RepairPart(var itemId):

	#Swap ShipModels
	if(!firstPartRepaired):
		brokenShip.visible = false;
		repairedShip.visible = true;
		pass;

	if(repariableParts.keys().has(itemId)):
		get_node(repariableParts[itemId]).visible = true;
		pass;
