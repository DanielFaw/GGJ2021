extends Spatial

export var shadowSpritePath:NodePath;
var shadowSprite;

export var raycastPath:NodePath;
var raycast:RayCast;

export var maxSize:float;
export var disappearDist:float;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	raycast = get_node(raycastPath);
	shadowSprite = get_node(shadowSpritePath);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if(raycast.is_colliding()):
		shadowSprite.visible = true;
		shadowSprite.global_transform.origin = raycast.get_collision_point() + Vector3(0,0.1,0);
		(shadowSprite as Spatial).look_at(global_transform.origin + raycast.get_collision_normal(),raycast.get_collision_normal());
		var dist = abs((raycast.get_collision_point() - global_transform.origin).length());

		shadowSprite.scale = Vector3.ONE * lerp(maxSize,0, dist - disappearDist);
	else:
		shadowSprite.visible = false;
	
	pass
