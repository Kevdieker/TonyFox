extends Node

const SAVE_PATH = "res://savegame.bin"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var data: Dictionary = {
			"playerHP": Game.playerHP,
			"inventory": Game.inventory,
			"coins": Game.coins,
			"level": Game.level,
			"position": {"x": Game.position.x, "y": Game.position.y}  # Convert Vector2 to dictionary
		}
		var jstr = JSON.stringify(data)
		file.store_line(jstr)
		file.close()
	else:
		print("Failed to open file for saving")

func load_game():
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
					var pos = current_line["position"]
					Game.position = Vector2(pos["x"], pos["y"])  # Convert dictionary back to Vector2
				file.close()
			
				# Load the scene specified in Game.level
				var scene_path = "res://Levels/" + Game.level + ".tscn"
				get_tree().change_scene_to_file(scene_path)
				
			else:
				print("Save file is empty or corrupted")
		else:
			print("Failed to open file for loading")
	else:
		print("Save file does not exist")
