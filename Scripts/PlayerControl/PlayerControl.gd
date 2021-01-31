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

var animationTree;
var stateMachine;
var queueJump = false;

var enabled = true;

export var handsPath:NodePath;
var hands;
var handEndRot = Vector3.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	StateController.playerController = self;
	cameraPivot = get_node(cameraPivotPath);
	cameraStatic = (cameraPivot is Camera);
	hands = get_node(handsPath);
	visObject = $_VIS

func _process(delta):

	Utilities.CorrectJitter(delta,direction,visObject,self);
	if(enabled):
		#if(direction == Vector3.ZERO):
		#	#Match hands with camera
		#	hands.rotation = cameraPivot.rotation - visObject.rotation + handEndRot;
		#else:
		#	hands.look_at(hands.global_transform.origin + direction.normalized(),Vector3.UP);
		#	handEndRot = hands.rotation;

		#Register player jump
		if(Input.is_action_just_pressed("player_jump") && is_on_floor()):
			if(!queueJump):
				queueJump = true;


		if(Input.is_action_pressed("player_fire_left") || Input.is_action_pressed("player_fire_right")):
			var targetPoint = visObject.global_transform.origin - cameraPivot.global_transform.basis.z;

			if(targetPoint != visObject.global_transform.origin):
				visObject.look_at(targetPoint,Vector3.UP);

		#Look in direction
		if(direction != Vector3.ZERO):
			#TODO: Fix terrible jitter when player slides along wall
			
			var targetPoint = visObject.global_transform.origin + Vector3(velocity.normalized().x,0,velocity.normalized().z);
			if(targetPoint != visObject.global_transform.origin):
				visObject.look_at(targetPoint,Vector3.UP);



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(enabled):
		HandleMovementCalculations(delta);
		move_and_slide(velocity,Vector3.UP);	
	if(cameraStatic):
		if(abs(direction.x) > 0.15 || abs(direction.z) > 0.15 && direction != Vector3.ZERO):
			rotY = atan2(direction.x,direction.z);
			targetRotation = lerp_angle(visObject.rotation.y,rotY + PI,delta * 10);


#Process for calculating movement
func HandleMovementCalculations(delta):
	if(enabled):
		HandleInput();

	#Calculate gravity
	velocity.y -= delta * gravity;

	if(is_on_floor()):
		velocity.y = -0.2;
		if(queueJump):
			velocity.y = jumpPower;
			queueJump = false;
			

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
