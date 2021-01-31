extends AnimatedSprite3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(StateController.currentState == 1):

		#Player will always face forward when mining or attacking
		if(Input.is_action_pressed("player_fire_left") || Input.is_action_pressed("player_fire_right")):
			animation = "front"
			flip_h = false;

		elif(Input.is_action_pressed("player_move_forward")):
			animation = "front"
			flip_h = false;
		elif(Input.is_action_pressed("player_move_back")):
			animation = "back"
			flip_h = false;
		elif(Input.is_action_pressed("player_move_right")):
			animation = "side"
			flip_h = true;
		elif(Input.is_action_pressed("player_move_left")):
			animation = "side"
			flip_h = false;
	
	
	pass
