extends Spatial

export var itemId:int;

const PLAYERCONTROLLER = preload("res://Scripts/PlayerControl/PlayerControl.gd");

func BodyEnter(var enter):
	if((enter as PLAYERCONTROLLER) != null):
		print("Player picked up item " + str(itemId));
		PlayerInventory.AddItem(1,itemId);
		queue_free();
	pass;
