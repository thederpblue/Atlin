extends Control
var tempTimer = 0
var permTimer = ScreenHolder.permTimer
var permHours
var permMinutes
var permSeconds
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tempTimer = ScreenHolder.tempTimer
	permTimer = ScreenHolder.permTimer

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tempTimer += delta
	permHours = str(round_to_dec(int(permTimer/3600),0)).split(".")[0]
	permMinutes = str(round_to_dec(int(permTimer/60),0)).split(".")[0]
	permSeconds = str(int(permTimer)%60)
	
	if permMinutes.length() == 1:
		permMinutes = "0" + permMinutes
	if permSeconds.length() == 1:
		permSeconds = "0" + permSeconds
	
	get_node("CanvasLayer/TempTimer").text = str(round_to_dec(tempTimer,0)).split(".")[0]
	permTimer += delta
	get_node("CanvasLayer/PermTimer").text = permHours + ":" + permMinutes + ":" + permSeconds
	
	
