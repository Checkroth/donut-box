extends Node3D

var invert_y = false
var invert_x = false
var mouse_sensitivity = 0.005

@onready var inner_gimbal = %InnerGimbal
@onready var target = %CSGBox3D2

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.relative.x != 0:
			var dir = 1 if invert_x else -1
			rotate_object_local(Vector3.UP, dir * event.relative.x * mouse_sensitivity)
		if event.relative.y != 0:
			var dir = 1 if invert_y else -1
			inner_gimbal.rotate_object_local(Vector3.RIGHT, dir * event.relative.y * mouse_sensitivity)
			
func _process(delta):
	inner_gimbal.rotation.x = clamp(inner_gimbal.rotation.x, -1.4, -0.01)
	# scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	# treglobal_transform.origin = target.global_transform.origin
	pass


# Original implementation for keyboard-based controls 
#  https://www.youtube.com/watch?app=desktop&v=4NLrfxNt3ps
# To be overwritten with mouse-based gimbal control.
