extends Node2D

const save_location = "user://Savefile.json"

var completedScreens = []
var collectableCollected = []

var contentToSave = {}


func saveGame():
	contentToSave = {"completedScreens": completedScreens, "collectableCollected": collectableCollected}
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(contentToSave.duplicate())
	file.close()


func loadGame():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		contentToSave = data.duplication()
