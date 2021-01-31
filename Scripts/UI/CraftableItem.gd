extends Control


var label;
var itemId;

# Called when the node enters the scene tree for the first time.
func _ready():
	label = find_node("Label",true);
	pass # Replace with function body.

func SetInfo(var labelText:String,var itemId:int):
	label.text = labelText;
	self.itemId = itemId;
