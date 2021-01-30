extends Node

export var partDictionary = {};

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func RepairPart(var partToRepair:String):

	if(partDictionary.has(partToRepair)):
		#Repair part
		partDictionary[partToRepair].visible = true;
		#Add to list of repaired parts
		print("Has part");

		return true;
	else:
		return false;
