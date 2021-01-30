extends Sprite3D

var backSprite = preload("res://sprites/dood-front.png")
var rightSprite = preload("res://sprites/dood-side.png")
var frontSprite = preload("res://sprites/dood-back.png")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Input.is_action_pressed("player_move_right")):
		texture = rightSprite;
		flip_h = true;
	elif(Input.is_action_pressed("player_move_left")):
		texture = rightSprite;
		flip_h = false;
		
	if(Input.is_action_pressed("player_move_forward")):
		texture = frontSprite;
		flip_h = false;
	if(Input.is_action_pressed("player_move_back")):
		texture = backSprite;
		flip_h = false;
	
	pass
