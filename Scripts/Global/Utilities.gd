extends Node

var rng = RandomNumberGenerator.new();

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize();
	pass # Replace with function body.

#Corrects jitter when moving in _physics_proccess
#Based on video below
#https://www.youtube.com/watch?v=pqrD3B75yKo&ab_channel=Garbaj
func CorrectJitter(var delta:float,var movementDirection:Vector3, var visualObject:Spatial, var physicalObject:Spatial):
	var fps = Engine.get_frames_per_second();
	var lerpInterval = movementDirection/fps;
	var lerpPosition = physicalObject.global_transform.origin + lerpInterval;

	#WARNING Increasing this value will make mesh position closer to collider
	#	position, but will increase the amount of visible stutter
	var lagSpeed:float = 15;

	#Correct for jitter if needed
	if(fps > ProjectSettings.get_setting("physics/common/physics_fps")):
		visualObject.set_as_toplevel(true);
		visualObject.global_transform.origin = visualObject.global_transform.origin.linear_interpolate(lerpPosition,lagSpeed* delta);
	else:
		visualObject.global_transform = physicalObject.global_transform;
		visualObject.set_as_toplevel(false);

func GetRandomValue(var maxValue:float, var minValue:float):
	return rng.randf_range(minValue,maxValue);
