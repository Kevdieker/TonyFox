extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = $AnimationPlayer
@onready var jumpAud = $JumpAud
@onready var sprite = $AnimatedSprite2D

func jump():
		jumpAud.play()
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		sprite.flip_h = true
	elif direction == 1:
		sprite.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
		if velocity.y > 0:
			anim.play("Fall")
	
	move_and_slide()


func _on_hurt_box_area_entered(area):
	if area.is_in_group("enemy"):
		print("OUCH")
