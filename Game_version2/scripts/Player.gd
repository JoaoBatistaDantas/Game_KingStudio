extends KinematicBody2D

const up = Vector2(0,-1)
export var gravidade = 50
export var velocidade = 200
export var velocidade_max = 100
export var jump_force = -400
var movimento = Vector2() 
var double_jump = 0
var climbing = false
var stamina = 10
export var stamina_max = 10

func _physics_process(_delta):
	climb()
	movimento.y += gravidade
	move_state()
	stamina_recovery()
	check_floor()
	dash()
	

func move_state():
	if Input.is_action_pressed("ui_right"): 
		movimento.x = velocidade 
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"): 
		movimento.x = -velocidade
		$Sprite.play("walk")
		$Sprite.flip_h = true 
	else:
		movimento.x = 0
		$Sprite.play("idle")
	if climbing == true:
		stamina -= 0.1 
		if Input.is_action_pressed("ui_up"):
			movimento.y = -velocidade/1.5 
		elif Input.is_action_pressed("ui_down"):
			movimento.y = velocidade/1.5 
		else: movimento.y = 0
	if is_on_floor():
		double_jump = 0
	if Input.is_action_just_pressed("ui_up") and double_jump <2:
			movimento.y = jump_force
			$Sprite.play('jump')
			double_jump += 1
	movimento = move_and_slide(movimento, up)
func climb():	
	if ($R1.is_colliding() or $R2.is_colliding()) and Input.is_action_pressed("climb") and stamina > 0:
		gravidade = 0
		climbing = true
	else:
		gravidade = 20
		climbing = false
func stamina_recovery():
	if is_on_floor() and stamina < stamina_max:
		stamina += 0.1
func check_floor():
	if is_on_floor():
		$Sprite.play('idle')

func dash():
	if Input.is_action_just_pressed('dash'):
		velocidade = 600
		$Timer.start()
func _on_Timer_timeout():
	velocidade = 200
