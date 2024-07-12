extends Area2D
@onready var gem = $"."
func _on_body_entered(body):
	if body.name == "TonyFox":
		Game.coins += 1
		var tween1 = gem.create_tween()
		var tween2 = gem.create_tween()
		tween1.tween_property(self,"position",position-Vector2(0,25),0.3)
		tween2.tween_property(self,"modulate",0,0.3)
		tween1.tween_callback(queue_free)
