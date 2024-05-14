extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = $PlaceHolder
@onready var anim = $AnimatedSprite2D
@onready var deathAud = $DeathSound
var chase = false
var SPEED = 50

func _ready():
	anim.play("Idle")
	
func _physics_process(delta):
	
	velocity.y += gravity * delta
	if chase == true:
		anim.play("Jump")
		
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if anim.animation != "Death":
			anim.play("Idle")
		velocity.x = 0
	move_and_slide()
			
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_weakness_box_body_entered(body):
	if body.name == "Player":
		player.jump()
		death()
		
func death():
	deathAud.play()
	chase = false
	anim.play("Death")
	await anim.animation_finished
	self.queue_free()
