extends Control

func _ready() -> void:
	custom_minimum_size = Vector2(150,150)
	var imgFound = true
	var i = 0
	while imgFound:
		if FileAccess.file_exists("res://Level_img/level_pic_" + str(i) + ".png"):
			var level = load("res://MenuScenes/select_level_level.tscn")
			
			var instance = level.instantiate()
			instance.setup(i, "res://Level_img/level_pic_" + str(i) + ".png")

			get_node("FlowContainer").add_child(instance)
			i += 1
		else:
			imgFound = false
	var btn = Button.new()
	btn.pressed.connect(func(): goToMainMenu())
	btn.text = "Back"
	get_node("FlowContainer").add_child(btn)
	




func goToMainMenu():
	get_tree().change_scene_to_file("res://MenuScenes/main_menu.tscn")
