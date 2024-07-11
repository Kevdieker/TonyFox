extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var anim = $AnimationPlayer
@onready var jumpAud = $JumpAud
@onready var sprite = $AnimatedSprite2D

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")


var inventory = {
	"sword": true,
	"boots": false,
	"cloak": false
}

func jump():
	jumpAud.play()
	velocity.y = JUMP_VELOCITY
	if inventory["sword"]:
		state_machine.travel("Jump_s")
	else:
		state_machine.travel("Jump")
		
func perform_sword_attack():
	state_machine.travel("sword_attack")

func _physics_process(delta):
	set_collision_mask_value(9, true)	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("move_down"):
		set_collision_mask_value(9, false)
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		sprite.flip_h = true
	elif direction == 1:
		sprite.flip_h = false

	if inventory["sword"]:
		if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("attack") or direction:
			if Input.is_action_just_pressed("jump") and is_on_floor():
				jump()
			if Input.is_action_just_pressed("attack"):
				
				perform_sword_attack()
			
				
			if direction:
				velocity.x = direction * SPEED
				if velocity.y == 0:
					state_machine.travel("Run_s")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				state_machine.travel("Idle_s")
			elif velocity.y > 0:
				state_machine.travel("Fall_s")
	else:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			jump()
		if direction:
			velocity.x = direction * SPEED
			if velocity.y == 0:
				state_machine.travel("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				state_machine.travel("Idle")
			if velocity.y > 0:
				state_machine.travel("Fall")
	
	move_and_slide()
	
func acquire_item(item_name: String):
	if item_name in inventory:
		inventory[item_name] = true

func _on_hurt_box_area_entered(area):
	if area.is_in_group("enemy"):
		print("OUCH")

func _on_sword_hit_box_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
