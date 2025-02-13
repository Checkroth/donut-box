extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
	pass # Replace with function body.
	
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MouseMode.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
