extends RigidBody3D

var is_dragging = false

func pick_up():
	is_dragging = true

func drop():
	is_dragging = false

func _process(delta):
	if not is_dragging:
		apply_central_force(-linear_velocity)

