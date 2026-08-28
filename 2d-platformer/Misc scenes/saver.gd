extends Node2D

const save_location = "user://Savefile.json"

var completedScreens = []
var collectableCollected = []

var contentToSave = {}

func saveGame():
	contentToSave = {"completedScreens": completedScreens, "collectableCollected": collectableCollected, "PermTimer": ScreenHolder.permTimer}
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contentToSave.duplicate())
	file.close()


func loadGame():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		contentToSave = file.get_var()
		file.close()
		unPackSave()


func unPackSave():
	completedScreens = contentToSave["completedScreens"]
	collectableCollected = contentToSave["collectableCollected"]
	if contentToSave["PermTimer"]:
		ScreenHolder.permTimer = contentToSave["PermTimer"]


func deleteSave():
	ScreenHolder.permTimer = 0
	contentToSave = {"completedScreens": [-1], "collectableCollected": [-1], "PermTimer": ScreenHolder.permTimer}
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contentToSave.duplicate())
	file.close()
	completedScreens = [-1]
	collectableCollected = [-1]
