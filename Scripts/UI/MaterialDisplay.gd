extends Node


var label;
var amount;

# Called when the node enters the scene tree for the first time.
func _ready():
	amount = $CenterContainer/VBoxContainer/Amount;
	label = $CenterContainer/VBoxContainer/Type;
	pass # Replace with function body.

func UpdateAmount(var newAmount:int):
	amount.text = "x" + str(newAmount);

func SetLabel(var labelString):
	label.text = labelString;
