extends Area2D

@onready var anim = $AnimatedSprite2D

func _on_body_entered(body):
	if body.name == "TonyFox":
		Game.position = self.position
		print("Checkpoint reached at position:", Game.position)
		anim.play("Activated")
		var current_scene = get_tree().current_scene
		Game.level = current_scene
		print("Level saved:", Game.level)
