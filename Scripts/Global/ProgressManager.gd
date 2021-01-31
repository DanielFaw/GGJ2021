extends Node

var visualShip;
var shipComplete = false;

#Item id's of all repairable parts
var repairableParts = [41,42,43,44,45,46]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func RepairPart(var partId:int) -> bool:

	#Check if it's already been reparied
	if(repairableParts.has(partId)):
		visualShip.RepairPart(partId);
		return true;

	return false;
	pass;

