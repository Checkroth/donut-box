# Script to handle mouse clicks "grabbing" something
# Pulled from https://github.com/derdrache/tutorial_library/blob/main/3D/dragAndDrop3D.gd
# As a part of this tutorial: https://www.youtube.com/watch?v=QsPP0uueedA
extends Node3D

var draggingCollider
var mousePosition
var doDrag = false
@export var grab_strength = 4.0

const FEAT_DRAG_AND_THROW = true

func _input(event):
	var intersect
	
	if event is InputEventMouse:
		intersect = get_mouse_intersect(event.position)
		if intersect: mousePosition = intersect.position 
		#snap on collider
		#if intersect: mousePosition = intersect.collider.global_position
		
	if event is InputEventMouseButton:
		var leftButtonPressed = event.button_index == MOUSE_BUTTON_LEFT && event.pressed
		var leftButtonReleased = event.button_index == MOUSE_BUTTON_LEFT && !event.pressed
		
		if leftButtonReleased:
			doDrag = false
			drag_and_throw(intersect)
		elif leftButtonPressed:
			doDrag = true
			drag_and_throw(intersect)
			if draggingCollider:
				get_viewport().set_input_as_handled()


func _process(delta):
	if draggingCollider:
		if FEAT_DRAG_AND_THROW:
			var position_dif = mousePosition - draggingCollider.global_position
			draggingCollider.apply_force(position_dif * grab_strength, mousePosition)
		else:
			draggingCollider.global_position = draggingCollider.global_position.lerp(mousePosition, delta * 4.0)

func drag_and_throw(intersect):
	var canMove = intersect.collider in get_tree().get_nodes_in_group("donuts")
	if !draggingCollider && doDrag && canMove:
		draggingCollider = intersect.collider
		draggingCollider.pick_up()
	elif draggingCollider:
		draggingCollider.drop()
		draggingCollider = null
	
func get_mouse_intersect(mousePosition):
	var currentCamera = get_viewport().get_camera_3d()
	var params = PhysicsRayQueryParameters3D.new()
	
	params.from = currentCamera.project_ray_origin(mousePosition)
	params.to = currentCamera.project_position(mousePosition, 100)
	if draggingCollider: params.exclude = [draggingCollider]
	
	var worldspace = get_world_3d().direct_space_state
	var result = worldspace.intersect_ray(params)
	
	return result
