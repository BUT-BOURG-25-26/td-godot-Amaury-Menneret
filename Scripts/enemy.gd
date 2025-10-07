class_name Enemy
extends RigidBody3D

@onready var target:Player = $"../Player"
var move_speed:float = 3

func _physics_process(delta: float):
	position += position.direction_to(target.position) * move_speed * delta
	if(target.position.distance_to(position) <= 1.5):
		damage()

func damage():
	target.setDamage(1)
	position -= position.direction_to(target.position) * move_speed * 2
	
