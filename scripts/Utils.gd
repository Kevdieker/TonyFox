extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var data: Dictionary = {
			"playerHP": Game.playerHP,
			"inventory": Game.inventory,
			"coins": Game.coins,
			"level": Game.level,
			"position": Game.position
		}
		var jstr = JSON.stringify(data)
		file.store_line(jstr)
		file.close()
	else:
		print("Failed to open file for saving")

func loadGame():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			if not file.eof_reached():
				var current_line = JSON.parse_string(file.get_line())
				if current_line:
					Game.playerHP = current_line["playerHP"]
					Game.inventory = current_line["inventory"]
					Game.coins = current_line["coins"]
					Game.level = current_line["level"]
					Game.position = current_line["position"]
				file.close()
			else:
				print("Save file is empty or corrupted")
		else:
			print("Failed to open file for loading")
	else:
		print("Save file does not exist")
