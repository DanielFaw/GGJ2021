extends Control

var itemId;
var label;
var amount;
var sprite;
var textureDisplay;

signal mouseHovered(itemIdOut);
signal mouseExited(itemIdOut);


# Called when the node enters the scene tree for the first time.
func _ready():
	amount = $Amount;
	textureDisplay = $Control/TextureDisplay
	pass # Replace with function body.

func UpdateAmount(var newAmount:int):
	amount.text = "x" + str(newAmount);

func SetInfo(var itemIdIN:int,var amountOfItem:int, var itemTexture:Texture):
	itemId = itemIdIN;
	UpdateAmount(amountOfItem);
	textureDisplay.texture = itemTexture;

func mouse_entered():
	if(itemId != null):
		emit_signal("mouseHovered",itemId);
	pass;

func mouse_exited():
	if(itemId != null):
		emit_signal("mouseExited",itemId);
	pass;

func ClearData():
	itemId = 0;
	UpdateAmount(0);
	textureDisplay.texture = null;
