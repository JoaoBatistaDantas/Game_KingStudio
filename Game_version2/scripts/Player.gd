extends KinematicBody2D

# Declaração de variáveis
const up = Vector2(0,-1)
var gravity = 100
var maxFallSpeed = 300
var walkSpeed = 200
var dashSpeed = 600
var dashCooldown = 2 
var canDash = false
var isDashing = false
var canJump = true
var isJumping = false
var jumpForce = -400
var jumpFallForce = 70
var canClimbing = false
var isClimbing = false
var moveVector = Vector2()
var dashCount = 0
# Inicialização de variáveis

func _physics_process(_delta):
	gravityProcess()
	jump()
	move()
	dash()
	on_ground()
	moveVector = move_and_slide(moveVector, up)
	
	
	
func gravityProcess():
	gravity = 10
	moveVector.y += gravity 
	if moveVector.y > maxFallSpeed:
		moveVector.y = maxFallSpeed
	
	
	
	 
func on_ground():
	if is_on_floor():
		canJump = true
		isJumping = false
	else:
		$justTimeinJump.start()

func dash():
	if canDash and Input.is_action_just_pressed("dash"):
		moveVector.x *= 10
		$CantDashTimer.start()
		
func move():
	if Input.is_action_pressed("ui_right"):
		moveVector.x = walkSpeed 
		canDash = true
		$playerSprite.play('walk')
		$playerSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		moveVector.x = -walkSpeed 
		canDash = true
		$playerSprite.play('walk')
		$playerSprite.flip_h = true
	else:
		moveVector.x = lerp(moveVector.x,0, 0.35)
		$playerSprite.play('idle')

func jump():
	if Input.is_action_just_pressed("ui_up") and ((is_on_floor() or canJump)):
		isJumping = true
		canJump = false
		moveVector.y = jumpForce
		$playerSprite.play('jump')
		$justTimeinJump.start()

	if Input.is_action_just_released('ui_up'):
		moveVector.y = jumpFallForce
		
func _on_CantDashTimer_timeout(): # sinal emitido pelo CantDashTimer
	canDash = false


func _on_justTimeinJump_timeout(): # sinal emitido pelo justTimeinJump
	canJump = false
