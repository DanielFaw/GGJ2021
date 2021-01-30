extends Spatial
var shadowChecked = false;

func _physics_process(delta):
	if(!shadowChecked):
		yield(get_tree().create_timer(.5), "timeout")
		if($RayCast.is_colliding()):
			$ShadowSprite.global_transform.origin = $RayCast.get_collision_point() + Vector3(0,0.4,0);
			($ShadowSprite as Spatial).look_at(global_transform.origin + $RayCast.get_collision_normal(),Vector3.UP);
		else:
			pass;
			$ShadowSprite.visible = false;

		shadowChecked = true;
		pass # Replace with function body.
