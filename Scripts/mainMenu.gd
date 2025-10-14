extends CanvasLayer

@onready var start_level: PackedScene = preload("res://Scenes/main_scene.tscn")

func _on_play_button_pressed() -> void:
	visible = false
	get_tree().change_scene_to_packed(start_level)

func _on_quit_button_pressed() -> void:
	GameManager.quit()
