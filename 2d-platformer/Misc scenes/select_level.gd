extends Control

func _ready() -> void:
	for i in range(3):
		var btn = Button.new()
		btn.text = "Load level: " + str(i)
		btn.pressed.connect(func(): loadLevel(i))
		
		get_node("MarginContainer").add_child(btn)
	
func loadLevel(lvl):
	get_tree().change_scene_to_file("screens/level_" + str(lvl) + ".tscn")
