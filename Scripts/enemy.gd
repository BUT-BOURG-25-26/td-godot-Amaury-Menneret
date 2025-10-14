class_name Enemy
extends CharacterBody3D

@onready var target:Player = get_tree().get_first_node_in_group("Player")
var move_speed:float = 3

func check_height() -> void:
	if(global_position.y <= -1):
		queue_free()
		
func _physics_process(delta: float):
	check_height()
	
	var direction = target.global_position - global_position
	direction = direction.normalized()
	
	var look_at_position = target.global_position
	look_at_position.y = global_position.y
	look_at(look_at_position)
	
	velocity = direction * move_speed
	velocity.y = get_gravity().y
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is Player:
			(collision.get_collider() as Player).set_damage(1)
			queue_free()
