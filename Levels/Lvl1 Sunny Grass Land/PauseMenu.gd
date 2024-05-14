extends Control
@onready var optionsMenu = $"../../SettingsWindow"
@onready var pauseMenu = $"."

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
	resume()
	get_tree().reload_current_scene()

func _on_optionsbtn_pressed():
	optionsMenu.show()

func _on_back_to_menubtn_pressed():
	resume()
	get_tree().change_scene_to_file("res://Menus/MainMenu/main_menu.tscn")
