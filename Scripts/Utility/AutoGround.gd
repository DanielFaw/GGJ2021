extends RayCast

var grounded = false;
func _physics_process(delta):
	if(!grounded):
		if(is_colliding()):
			get_parent().global_transform.origin = get_collision_point();
			grounded = true;
	else:
		#Remove this
		get_parent().remove_child(self)
	pass;
