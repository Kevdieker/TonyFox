extends Control
@onready var optionsMenu = $"../../SettingsWindow"
@onready var pauseMenu = $"."
@onready var Resumebtn = $PanelContainer/VBoxContainer/Resumebtn

func resume():
	get_tree().paused = false
	
func pause():
	get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pauseMenu.show()
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()
		pauseMenu.hide()
		
func _process(delta):
	testEsc()
	
func _on_resumebtn_pressed():
	resume()
	pauseMenu.hide()

func _on_restartbtn_pressed():
	Resumebtn.show()
	resume()
	Game.playerHP = 5
	get_tree().reload_current_scene()
	
	

func _on_optionsbtn_pressed():
	optionsMenu.show()

func _on_back_to_menubtn_pressed():
	Resumebtn.show()
	resume()
	get_tree().change_scene_to_file("res://Menus/MainMenu/main_menu.tscn")


func _on_death_area_body_entered(body):
	if body.name == "TonyFox":
		Resumebtn.hide()
		pauseMenu.show()
		pause()


func _on_lvl_2_teleporter_body_entered(body):
	if body.name == "TonyFox":
		get_tree().change_scene_to_file("res://Levels/Lvl2 Cave/cave.tscn")


func _on_lvl_1_teleporter_body_entered(body):
	get_tree().change_scene_to_file("res://Levels/Lvl1 Sunny Grass Land/overworld.tscn")


func _on_lv_1_teleporter_body_entered(body):
	get_tree().change_scene_to_file("res://Levels/Lvl1 Sunny Grass Land/overworld.tscn")


func _on_lv_3_teleporter_body_entered(body):
	get_tree().change_scene_to_file("res://Levels/Lvl3 Castle/castle.tscn")


func _on_checkpoint_pressed():
	$"../../TonyFox".position =  Game.position
