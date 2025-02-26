"""
Script that is intended to be used with any rigidbody3d blender scene import.

It is important that the blender scene itself has a top-level object titled "object-rigid", and that
that object fully encapsulates the rigid body you want to operate on within the confines of the game.

Attach this script to the blender scene when importing it for it to take effect.

See whitebox_donut as hand-made example of what a blender scene would look like when being imported.
Replace the whitebox donut in donut.tscn with a blender import for a plug-and-play version.
"""
class_name RigidBlenderObject extends Node3D

@export var debug_option: bool = false

@onready var _rigid_body_node = $"object-rigid"

func get_rigid_body():
	return _rigid_body_node

func get_implementor():
	# We assume all blender scenes are going to be children of a scene that hanles our game logic.
	# This points to that implementor, instead of trying to call script funcs on the blender object directly.
	return get_parent()

func _ready():
	# Hideous! How do we add functionality to a rigid body from blender without doing some insane
	#    workaround? ¯\_(ツ)_/¯
	_rigid_body_node.set_meta("implementor", get_implementor())
