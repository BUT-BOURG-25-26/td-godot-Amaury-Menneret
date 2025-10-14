class_name Stats
extends Label

func update():
	text = 'kill count : ' + str(GameManager.kill_count)
	return
