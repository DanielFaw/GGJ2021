extends Spatial

export var mainCamPath:NodePath;
var mainCam;

# Called when the node enters the scene tree for the first time.
func _ready():
	mainCam = get_node(mainCamPath);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	global_transform = mainCam.global_transform;
	pass
