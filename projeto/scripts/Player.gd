extends KinematicBody2D

const up = Vector2(0,-1)
export var gravity = 20
export var speed = 200
export var jump_force = -500
var move = Vector2() 


func _physics_process(_delta): 
	
	move.y += gravity
	

	if Input.is_action_pressed("ui_right"): 
		move.x = speed 
		$Sprite.play("run")
		$Sprite.set_flip_h(false)
	elif Input.is_action_pressed("ui_left"): 
		move.x = -speed
		$Sprite.play("run")
		$Sprite.set_flip_h(true)
	else:
		move.x = 0
		$Sprite.play("idle")
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			move.y = jump_force
	else:
		$Sprite.play("up")
	if Input.is_action_pressed('shield'):
		$Sprite.play("shield")
	move = move_and_slide(move, up)

