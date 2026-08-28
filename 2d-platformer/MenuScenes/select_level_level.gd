extends Button

var levelNum
var picture

@onready var cam = get_node("camara")


func _ready() -> void:
	if Saver.collectableCollected.has(levelNum):
		cam.self_modulate = Color(0.306, 0.306, 0.306, 0.5)
	
	
	var style = StyleBoxFlat.new()
	style.set_border_width_all(2)
	style.bg_color = Color(0.255, 0.255, 0.255, 0.447)
	if Saver.completedScreens.has(levelNum):
		style.border_color = Color(0.0, 1.0, 0.0, 1.0)
	elif Saver.completedScreens.has(levelNum-1):
		style.border_color = Color(1.0, 1.0, 0.0, 1.0)
	else:
		self.disabled = true
		style.border_color = Color(1.0, 0.0, 0.0, 1.0)
	
	self.add_theme_stylebox_override("normal", style)
	self.add_theme_stylebox_override("hover", style)
	self.add_theme_stylebox_override("pressed", style)
	
	self.icon = load_icon("res://Level_img/level_pic_" + str(levelNum) + ".png")
	self.text = "Level: " + str(levelNum)
	self.pressed.connect(func(): loadLevel(levelNum))

func setup(levelNumber, picturePath):
	levelNum = levelNumber
	picture = picturePath

func loadLevel(lvl):
	get_tree().change_scene_to_file("screens/level_" + str(lvl) + ".tscn")

func load_icon(path: String) -> Texture2D:
	var img = Image.load_from_file(path)
	img.resize(100,100)
	var tex = ImageTexture.create_from_image(img)
	return tex
