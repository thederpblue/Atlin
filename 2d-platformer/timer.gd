extends Control
var tempTimer = 0
var permTimer = ScreenHolder.permTimer
var permHours
var permMinutes
var permSeconds
var tempHours
var tempMinutes
var tempSeconds
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tempTimer = ScreenHolder.tempTimer
	permTimer = ScreenHolder.permTimer

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	tempHours = str(round_to_dec(int(tempTimer/3600),0)).split(".")[0]
	tempMinutes = str(round_to_dec(int(tempTimer/60),0)).split(".")[0]
	tempSeconds = str(int(tempTimer)%60)
	
	permHours = str(round_to_dec(int(permTimer/3600),0)).split(".")[0]
	permMinutes = str(round_to_dec(int(permTimer/60),0)).split(".")[0]
	permSeconds = str(int(permTimer)%60)
	
	if tempMinutes.length() == 1:
		permMinutes = "0" + tempMinutes
	if tempSeconds.length() == 1:
		tempSeconds = "0" + tempSeconds
	
	if permMinutes.length() == 1:
		permMinutes = "0" + permMinutes
	if permSeconds.length() == 1:
		permSeconds = "0" + permSeconds
	
	
	
	
	
	get_node("CanvasLayer/TempTimer").text = tempHours + ":" + tempMinutes + ":" + tempSeconds
	get_node("CanvasLayer/PermTimer").text = permHours + ":" + permMinutes + ":" + permSeconds
	permTimer += delta
	tempTimer = ScreenHolder.tempTimer 
