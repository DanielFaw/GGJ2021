extends Control
var label;
var itemId;

signal buttonPressed(itemId);


# Called when the node enters the scene tree for the first time.
func _ready():
	label = find_node("Label",true);
	pass # Replace with function body.

func SetInfo(var labelText:String,var itemId:int):
	label.text = labelText;
	self.itemId = itemId;

func ButtonPressed():
	print("Clicked!");
	emit_signal("buttonPressed",itemId);
	pass # Replace with function body.
