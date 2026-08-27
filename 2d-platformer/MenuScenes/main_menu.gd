extends Control

func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://Misc scenes/select_level.tscn")


func _on_exit_button_down() -> void:
	Saver.saveGame()
	get_tree().quit()


func _on_options_button_down() -> void:
	get_tree().change_scene_to_file("res://MenuScenes/options.tscn")
