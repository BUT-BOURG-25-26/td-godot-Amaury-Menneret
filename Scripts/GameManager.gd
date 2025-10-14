extends Node

var kill_count : int = 0

func display_game_over(display : bool):
	var game_over_menu = get_tree().get_first_node_in_group("game_over")
	if(game_over_menu):
		game_over_menu.visible = display
	if display:
		Engine.time_scale = 0

func restart():
	get_tree().reload_current_scene()
	display_game_over(false)
	Engine.time_scale = 1

func quit():
	get_tree().quit()
