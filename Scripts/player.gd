class_name Player
extends CharacterBody3D

var healthbar
@export var move_speed:float = 5
@export var health: int = 3

var move_inputs: Vector2

func _ready() -> void:
	healthbar = $RigidBody3D/SubViewport/HealthBar
	healthbar.max_value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		health -= 1
		healthbar.update(health)
		
	if health <= 0:
		get_tree().reload_current_scene()
		

func _physics_process(delta: float) -> void:
	read_move_inputs()
	move_inputs *= move_speed * delta
	if move_inputs != Vector2.ZERO:
		global_position += Vector3(move_inputs.x, 0.0, move_inputs.y)
	velocity.y += get_gravity().y * delta
	return

func read_move_inputs():
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	print(move_inputs)
	return

func setDamage(amount: int):
	print("AIE")
	health -= amount
	healthbar.update(health)
	
