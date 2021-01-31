extends Node

export var repairedParts = [];

#Item id's of all repairable parts
var repairableParts = [1,2,3,4,5,6]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func RepairPart(var partId:int) -> bool:

	#Check if it's already been reparied
	if(repairedParts.has(partId)):
		return false;
		pass;
	else:
		#Repair the part - visually triggering it
		
		#Add it to the list of repaired parts
		repairedParts.append(partId);
		return true;
		pass;
	
	pass;


func CheckIfComplete():

	#Loop through all repairable parts

	for i in repairableParts:

		if(!repairedParts.has(i)):
			pass;
			#Not complete
			
	#If one is not complete, return falsereturn true;
	#Otherwise - Trigger end game

	pass;
