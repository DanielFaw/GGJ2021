extends Spatial

const RESOURCE = preload("res://Scripts/InventoryAndCrafting/MineableItem.cs");

const BEAMOBJECT = preload("res://Objects/Misc/LaserBeamEffect.tscn");

export var miningPower:float = 1;


var previousResource;
var currentResource;
var beamEffectObject;


# Called when the node enters the scene tree for the first time.
func _ready():
	beamEffectObject = $LaserTip/Beam
	pass # Replace with function body.


func _process(delta):

	#Beam effect
	if(currentResource != null && currentResource.isMining):
		beamEffectObject.visible = true;
	else:
		beamEffectObject.visible = false;


	if(Input.is_action_just_pressed("player_fire_right")):
		if(currentResource != null):
			#Start mining the resource
			currentResource.MineResource(miningPower);
		
		
		else:
			#Prevent player from mining resource after walking away
			if(previousResource != null):
				if(previousResource.isMining):
					previousResource.StopMining();
					pass;
	elif(!Input.is_action_pressed("player_fire_right") && currentResource != null):
		currentResource.StopMining();

func TakeDamage():
	print("Laser Took damage!");

func BodyEnter(var body):

	var parent = body.get_parent();
	if((parent as RESOURCE) != null && currentResource == null):
		currentResource = (parent as RESOURCE);
		currentResource.connect("ResourceMined",self,"TakeDamage");
		if(previousResource == null):
			previousResource = currentResource;
	pass;

func BodyExit(var body):
	var parent = body.get_parent();
	if((parent as RESOURCE) != null && currentResource != null):

		#No longer take damage when "mining" this resource
		currentResource.disconnect("ResourceMined",self,"TakeDamage");
		previousResource = currentResource;
		currentResource = null;
	pass;
