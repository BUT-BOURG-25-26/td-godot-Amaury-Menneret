extends Node3D

@export var enemy_scene: PackedScene

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	
	var x = randf_range(-10, 10)
	var z = randf_range(-10, 10)
	

	add_child(enemy)
	
	enemy.global_position = Vector3(x, 1, z)
	
	return
