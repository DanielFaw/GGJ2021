extends Node

enum playerState {CRAFTING,WANDERING,PAUSED};

var currentState = playerState.WANDERING;


#Set by each script on start
var craftingUI;
var playerController;
var cameraController;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#Changes current GameState
#0:Crafting
#1:Wandering 
#2:Paused
func ChangeState(var newState:int):
	#Change new state
	match(newState):
		0:
			currentState = playerState.CRAFTING;
		1:
			currentState = playerState.WANDERING;
		2:
			currentState = playerState.PAUSED;

	if(currentState == playerState.CRAFTING):
		#Disable player Controller
		playerController.enabled = false;

		#Disable Camera Controller
		cameraController.enabled = false;
		
		#Show and unlock mouse
		cameraController.ToggleCursor(true);

		#Show crafting UI
		craftingUI.visible = true;

		pass;
	if(currentState == playerState.WANDERING):
		#Enable player Controller
		playerController.enabled = true;

		#Enable Camera Controller
		cameraController.enabled = true;

		#Hide and lock mouse
		cameraController.ToggleCursor(false);

		#Hide crafting UI
		craftingUI.visible = false;

		pass;
	if(currentState == playerState.PAUSED):

		pass;
	pass;
