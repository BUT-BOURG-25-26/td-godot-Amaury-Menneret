class_name Player
extends CharacterBody3D

var healthbar
@export var speed:float = 10
@export var jump_velocity:float = 4.5
@export var gravity:float = ProjectSettings.get_setting("physics/3d/default_gravity");

@export var friction:float = 5
@export var acceleration:float = 30

@export var fx_scene: PackedScene

@export var health: int = 5

var move_inputs: Vector2
var direction: Vector3

var _velocity: Vector3 = Vector3.ZERO

func check_height() -> void:
	if(global_position.y <= -1):
		global_position = Vector3(0, 1, 0)
		set_damage(1)

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health

func _process(delta:float) -> void:
	if Input.is_action_just_pressed("damage_player"):
		health -= 2
		healthbar.update(health)
		
	if health <= 0:
		GameManager.display_game_over(true)
	return

func _physics_process(delta: float) -> void:
	_velocity = velocity
	
	check_height()
	
	if(!is_on_floor()):
		_velocity.y -= gravity * delta
	
	read_move_inputs()
	direction = (transform.basis * Vector3(move_inputs.x, 0, move_inputs.y)).normalized()
	
	var horizontal_velocity = _velocity
	horizontal_velocity.y = 0
	
	if direction != Vector3.ZERO:
		var target_velocity = direction*speed
		horizontal_velocity = direction.lerp(target_velocity, acceleration*delta)
	else :
		horizontal_velocity = horizontal_velocity.lerp(Vector3.ZERO, friction * delta)
	
	_velocity.x = horizontal_velocity.x
	_velocity.z = horizontal_velocity.z	
	
	if (Input.is_action_just_pressed("jump") && is_on_floor()):
		_velocity.y = jump_velocity
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	velocity = _velocity
	move_and_slide()
	
	return

func read_move_inputs():
	move_inputs = Input.get_vector("left", "right", "forward", "backward")
	return

func set_damage(amount: int):
	health -= amount
	healthbar.update(health)
	return

func attack():
	var camera = get_viewport().get_camera_3d()
	if(camera):
		var screen_pos = get_viewport().get_mouse_position()
		var from = camera.project_ray_origin(screen_pos)
		var to = from + camera.project_ray_normal(screen_pos) * 1000.0
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(from, to)
		var result = space_state.intersect_ray(query)
		if result:
			var Fx: VFXAttack = fx_scene.instantiate()
			add_child(Fx)
			Fx.emit()
			Fx.global_position = result.position
			
