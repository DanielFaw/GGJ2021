extends Spatial
var shadowChecked = false;
func _physics_process(delta):
	if(!shadowChecked):
		if($RayCast.is_colliding()):
			$ShadowSprite.global_transform.origin = $RayCast.get_collision_point() + Vector3(0,0.12,0);
			($ShadowSprite as Spatial).look_at(global_transform.origin + $RayCast.get_collision_normal(),Vector3.UP);
		else:
			$ShadowSprite.visible = false;

		shadowChecked = true;
		pass # Replace with function body.
