extends Control

@onready var settingsWindow = $SettingsWindow

func _on_exit_button_pressed():
	get_tree().quit()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels/Lvl1 Sunny Grass Land/overworld.tscn")
