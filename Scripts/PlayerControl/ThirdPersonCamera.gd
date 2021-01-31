extends Spatial

#Variables
export var xMouseSensitivity:float = 10;
export var yMouseSensitivity:float = 10;
var mouseInput:Vector2;

export var moveSpeed:float = 1.0;

var xRot:float;
var yRot:float;

const aimOffset:int = 1;

export var pivotObjectPath:NodePath;
var pivotObject:Spatial;
export var minYAngle:float;
export var maxYAngle:float;

var cam:Camera;

export var tweenNodePath:NodePath;
var tweenNode:Tween;

var enabled = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	StateController.cameraController = self;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pivotObject = get_node(pivotObjectPath);
	cam = $SpringArm/Offset/NoCull;

	if(pivotObject != null):
		global_transform.origin = pivotObject.global_transform.origin;
		translation = pivotObject.translation;
		rotation.y = pivotObject.rotation.y + PI;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(enabled):
		#Move with pivot object
		translation = translation.linear_interpolate(pivotObject.translation,delta * moveSpeed);

		#Rotate camera around pivot
		xRot += -mouseInput.y * yMouseSensitivity * delta;
		xRot = clamp(xRot,minYAngle,maxYAngle);
		yRot -= deg2rad(mouseInput.x * xMouseSensitivity * delta);
		var xClamped:float = clamp(xRot,minYAngle,maxYAngle);
		rotation = Vector3(deg2rad(xClamped),yRot,0);
		mouseInput = Vector2.ZERO


#func ShakeCamera():
#	tweenNode.interpolate_property(cam,"translation:z",0,-0.2,0.15,Tween.TRANS_LINEAR,Tween.EASE_OUT);
#	tweenNode.start();
#
#	tweenNode.interpolate_property(cam,"translation:z",-0.2,0,0.2,Tween.TRANS_BOUNCE,Tween.EASE_OUT);
#	tweenNode.start();

func _input(event):
	if(event is InputEventMouseMotion):
		mouseInput = event.relative
	
	if(event is InputEventMouseButton):
		if(event.button_index == BUTTON_LEFT && event.pressed && StateController.currentState == 2):
			ToggleCursor(false);
	
	if(event is InputEventKey):
		if(event.scancode == KEY_ESCAPE && event.pressed):
			ToggleCursor(true)

#Shows/Hides the cursor
func ToggleCursor(var shouldShowCursor:bool):
	if(shouldShowCursor):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
