extends Node3D

@export var donut_resource: PackedScene
var default_mouse_mode = Input.MouseMode.MOUSE_MODE_CONFINED
	
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if default_mouse_mode == Input.MouseMode.MOUSE_MODE_CONFINED:
			default_mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE
		else:
			default_mouse_mode = Input.MouseMode.MOUSE_MODE_CONFINED
	if event is InputEventMouseButton and event.is_double_click():
		print("DOUBLE CLICK")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func __process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.mouse_mode = Input.MouseMode.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = default_mouse_mode
