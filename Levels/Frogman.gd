extends Sprite2D

var playername = "TonyFox"

func _process(delta):
	if Game.killedfrog == true:
		$".".queue_free()

func _on_area_2d_body_entered(body):
	if body.name == playername:
		Game.inventory["sword"] = true
		Game.inventory["boots"] = true
