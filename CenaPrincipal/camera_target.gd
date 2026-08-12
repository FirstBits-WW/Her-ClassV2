extends Node2D

var target: Node2D = null

func _physics_process(_delta: float) -> void:
	if target != null:

		global_position = target.global_position


func set_target(new_target: Node2D) -> void:
	target = new_target
	
	
