extends Control

func _ready() -> void:
	var imgFound = true
	var i = 0
	while imgFound:
		if FileAccess.file_exists("res://Level_img/level_pic_" + str(i) + ".png"):
			var btn = Button.new()
			btn.icon_alignment =HORIZONTAL_ALIGNMENT_CENTER
			btn.vertical_icon_alignment =VERTICAL_ALIGNMENT_TOP
			var style = StyleBoxFlat.new()
			style.set_border_width_all(2)
			style.bg_color = Color(0.255, 0.255, 0.255, 0.447)
			if Saver.completedScreens.has(i):
				style.border_color = Color(0.0, 1.0, 0.0, 1.0)
			elif Saver.completedScreens.has(i-1):
				style.border_color = Color(1.0, 1.0, 0.0, 1.0)
			else:
				btn.disabled = true
				style.border_color = Color(1.0, 0.0, 0.0, 1.0)
			
			btn.add_theme_stylebox_override("normal", style)
			btn.add_theme_stylebox_override("hover", style)
			btn.add_theme_stylebox_override("pressed", style)
			
			btn.icon = load_icon("res://Level_img/level_pic_" + str(i) + ".png")
			btn.text = "Level: " + str(i)
			btn.pressed.connect(func(): loadLevel(i))
			get_node("FlowContainer").add_child(btn)
			i += 1
		else:
			imgFound = false
	var btn = Button.new()
	btn.pressed.connect(func(): goToMainMenu())
	btn.text = "Back"
	get_node("FlowContainer").add_child(btn)
	
func loadLevel(lvl):
	get_tree().change_scene_to_file("screens/level_" + str(lvl) + ".tscn")


func load_icon(path: String) -> Texture2D:
	var img = Image.load_from_file(path)
	img.resize(100,100)
	var tex = ImageTexture.create_from_image(img)
	return tex

func goToMainMenu():
	get_tree().change_scene_to_file("res://MenuScenes/main_menu.tscn")
