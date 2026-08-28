extends Control
var paused = false

func _on_play_button_down() -> void:
	Saver.loadGame()
	get_tree().change_scene_to_file("res://MenuScenes/select_level.tscn")


func _on_exit_button_down() -> void:
	Saver.saveGame()
	get_tree().quit()


func _on_options_button_down() -> void:
	get_tree().change_scene_to_file("res://MenuScenes/options.tscn")


func _on_reset_save_button_down() -> void:
	Saver.deleteSave()
