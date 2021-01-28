extends KinematicBody

#Variables
export var moveSpeed:float = 40;
export var runSpeed:float = 40;
export var airMoveSpeed:float = 40;
export var acceleration:float = 20;
const gravity:float = 4.0;
const maxVerticalVelocity:float = 54.0;
var yVelocity:float;
var velocity = Vector3.ZERO;

export var jumpPower:float;

var input:Vector2;
var direction:Vector3 = Vector3.ZERO;

export var cameraPivotPath:NodePath;
var cameraPivot;

var visObject:Spatial;

export var cameraStatic:bool;
var mousePosScreen;
var rotY = 0;
var targetRotation = 0;
var colliding;

export var animationTreePath:NodePath;
var animationTree;
var stateMachine;

# Called when the node enters the scene tree for the first time.
func _ready():
	cameraPivot = get_node(cameraPivotPath);
	cameraStatic = (cameraPivot is Camera);
	visObject = $_VIS

func _process(delta):

	Utilities.CorrectJitter(delta,direction,visObject,self);

	#Is the camera static (Only a camera)
	if(cameraStatic):
		visObject.rotation.y = targetRotation;

	#Probably using a third person camera rig (Spatial node as root of camera rig)
	else:
		if(direction != Vector3.ZERO):
			#TODO: Fix terrible jitter when player slides along wall
			
			var targetPoint = visObject.global_transform.origin + Vector3(velocity.normalized().x,0,velocity.normalized().z);
			if(targetPoint != visObject.global_transform.origin):
				visObject.look_at(targetPoint,Vector3.UP);



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	HandleMovementCalculations(delta);
	move_and_slide(velocity,Vector3.UP);	
	if(cameraStatic):
		if(abs(direction.x) > 0.15 || abs(direction.z) > 0.15 && direction != Vector3.ZERO):
			rotY = atan2(direction.x,direction.z);
			targetRotation = lerp_angle(visObject.rotation.y,rotY + PI,delta * 10);


#Process for calculating movement
func HandleMovementCalculations(delta):
	HandleInput();

	#Calculate gravity
	velocity.y -= delta * gravity;

	if(Input.is_action_just_pressed("player_jump") && is_on_floor()):
		velocity.y = jumpPower;

	#Isolate x and z components
	var horizontalVelocity = velocity;
	horizontalVelocity.y = 0;


	var newPos;
	if(Input.is_action_pressed("player_sprint")):
		newPos =  direction * runSpeed;
	else:
		newPos =  direction * moveSpeed;

	horizontalVelocity = horizontalVelocity.linear_interpolate(newPos,acceleration * delta);

	#Combine x and z of horizontal velocity with y of gravity
	velocity.x = horizontalVelocity.x;
	velocity.z = horizontalVelocity.z;

	#Move body
	velocity = move_and_slide(velocity,Vector3.UP);

#Handles Directional Input
func HandleInput():
	direction = Vector3.ZERO;

	if(Input.is_action_pressed("player_move_forward")):
		direction -= cameraPivot.transform.basis.z;
	if(Input.is_action_pressed("player_move_back")):
		direction += cameraPivot.transform.basis.z;
	if(Input.is_action_pressed("player_move_left")):
		direction -= cameraPivot.transform.basis.x;
	if(Input.is_action_pressed("player_move_right")):
		direction += cameraPivot.transform.basis.x;
	
	direction = direction.normalized();
