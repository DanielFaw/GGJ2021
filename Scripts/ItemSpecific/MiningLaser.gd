extends Spatial

const RESOURCE = preload("res://Scripts/InventoryAndCrafting/MineableItem.cs");

export var miningPower:float = 1;

var previousResource;
var currentResource;

var beamEffectObject;

# Called when the node enters the scene tree for the first time.
func _ready():
	beamEffectObject = $Beam
	pass # Replace with function body.


func _process(delta):
	
	if(currentResource != null && currentResource.isMining):
		beamEffectObject.visible = true;
	else:
		beamEffectObject.visible = false;

	if(Input.is_action_just_pressed("player_fire_left")):
		if(currentResource != null):
			#Start mining the resource
			currentResource.MineResource(miningPower);
		else:
			#Prevent player from mining resource after walking away
			if(previousResource != null):
				if(previousResource.isMining):
					previousResource.StopMining();
					pass;

	elif(!Input.is_action_pressed("player_fire_left") && currentResource != null):
		currentResource.StopMining();


#TODO - Add weapon Durability
func TakeDamage():
	print("Laser Took damage!");

func ResourceDestroyed():
	currentResource.disconnect("ResourceDepleted",self,"ResourcedDestroyed");
	currentResource.disconnect("ResourceMined",self,"TakeDamage");


func BodyEnter(var body):

	var parent = body.get_parent();
	if((parent as RESOURCE) != null && currentResource == null):
		currentResource = (parent as RESOURCE);
		currentResource.connect("ResourceMined",self,"TakeDamage");
		currentResource.connect("tree_exiting",self,"ResourcedDestroyed");
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
