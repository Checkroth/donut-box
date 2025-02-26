extends Node3D

# Add a new child to this scene from your donut .blend file and replace donut_scene with a reference to that.
# You should also delete or hide the whitebox donut from the scene tree.
@onready var donut_scene = %WhiteboxDonut

var is_dragging = false

func pick_up():
	is_dragging = true

func drop():
	is_dragging = false
	
func _ready():
	donut_scene.get_rigid_body().add_to_group("donuts")
	

func _process(delta):
	if not is_dragging:
		var donut_body = donut_scene.get_rigid_body()
		donut_body.apply_central_force(-donut_body.linear_velocity)
