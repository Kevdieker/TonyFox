extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const DASH_VELOCITY = 1500.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimationPlayer
@onready var jumpAud = $JumpAud
@onready var sprite = $AnimatedSprite2D
@onready var Resumebtn =$"../etc_menu/PauseMenu/PanelContainer/VBoxContainer/Resumebtn"
@onready var pauseMenu =$"../etc_menu/PauseMenu"
@onready var Checkpointbtn = $"../etc_menu/PauseMenu/PanelContainer/VBoxContainer/Checkpoint"

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")


var left = false

  
func jump():
	jumpAud.play()
	velocity.y = JUMP_VELOCITY
	if Game.inventory["sword"]:
		state_machine.travel("Jump_s")
	else:
		state_machine.travel("Jump")
		
func perform_sword_attack():
	state_machine.travel("sword_attack")
	
func dash():
	if left == false:
		velocity.x += DASH_VELOCITY
	else:
		velocity.x -= DASH_VELOCITY

func death():
	Resumebtn.hide()
	Checkpointbtn.hide()
	pauseMenu.show()
	pauseMenu.pause()

func _physics_process(delta):
	
	if Game.playerHP <= 0:
		death()
	
	set_collision_mask_value(9, true)	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("move_down"):
		set_collision_mask_value(9, false)
		
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		sprite.flip_h = true
		left = true
	elif direction == 1:
		sprite.flip_h = false
		left = false

	if Game.inventory["sword"]:
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
				
	if Game.inventory["boots"]:
		if Input.is_action_just_pressed("dash"):
			dash()
				
		
	
	move_and_slide()
	
func acquire_item(item_name: String):
	if item_name in Game.inventory:
		Game.inventory[item_name] = true

func _on_hurt_box_area_entered(area):
	if area.is_in_group("Boss"):
		print("Bossdamage")
		Game.playerHP -= 1
	if area.is_in_group("123"): #funktioniert mit enemy weeknessbox??
		print("Ouch")
		Game.playerHP -= 1
		print(Game.playerHP)
	if area.is_in_group("345"): #funktioniert mit enemy weeknessbox??
		print("weaknessbox")


func _on_sword_hit_box_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("hit")
	if body.is_in_group("123"):
		print("kevin")
		body.death()
