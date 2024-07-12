extends Area2D

@onready var anim = $AnimatedSprite2D

func _on_body_exited(body):
	if body.name == "TonyFox":
		Game.position = self.position
		print("Checkpoint reached at position:", Game.position)
		anim.play("Activated")
