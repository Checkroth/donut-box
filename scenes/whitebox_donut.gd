extends Node3D

@onready var donut_mesh = %solodono5

var is_dragging = false

func pick_up():
	is_dragging = true

func drop():
	is_dragging = false

func _process(delta):
	if not is_dragging:
		donut_mesh.apply_central_force(-donut_mesh.linear_velocity)
