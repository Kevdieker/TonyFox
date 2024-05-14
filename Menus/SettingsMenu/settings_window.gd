extends Window
@onready var resBtn = $Settings/MarginContainer/VBoxContainer/HBoxContainer2/OptionButton as OptionButton
@onready var window = $"." as Window

@onready var toggleSoundbtn = $"placeholder"

var masterbus = AudioServer.get_bus_index("Master")

const WINDOW_MODE_ARRAY : Array[String] = [
	"Windowed",
	"Full-Screen"
	]

func _ready():
	add_window_mode_items()
	resBtn.item_selected.connect(on_window_mode_selected)

func add_window_mode_items()->void:
	for window_mode in WINDOW_MODE_ARRAY:
		resBtn.add_item(window_mode)
	
func on_window_mode_selected(index:int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_size(Vector2i(1152,648))
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_confirm_btn_pressed():
	window.hide()

func _on_close_requested():
	window.hide()

func _on_toogle_sound_pressed():
	AudioServer.set_bus_mute(masterbus,not AudioServer.is_bus_mute(masterbus))

func _on_optionsbtn_pressed():
	window.show()
