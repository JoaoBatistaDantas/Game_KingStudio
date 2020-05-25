extends KinematicBody2D

# Declaração de variáveis
const up = Vector2(0,-1)
var gravity = 100
var maxFallSpeed = 300
var walkSpeed = 200
var dashSpeed = 600
var dashCooldown = 2 
var canDash = true
var isDashing = false
var canJump = true
var isJumping = false
var jumpForce = -350
var jumpFallForce = 70
var canClimbing = false
var isClimbing = false
var moveVector = Vector2()
var justTimeInJump = true
# Inicialização de variáveis
func _ready():
	pass
	
func _physics_process(delta):
	gravityProcess()
	moveProcess()
	on_ground()
	moveVector = move_and_slide(moveVector, up)
	
	
func gravityProcess():
	gravity = 10
	moveVector.y += gravity 
	if moveVector.y > maxFallSpeed:
		moveVector.y = maxFallSpeed
	
func moveProcess():
	if Input.is_action_pressed("ui_right"):
		moveVector.x = walkSpeed 
		$playerSprite.play('walk')
		$playerSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		moveVector.x = -walkSpeed 
		$playerSprite.play('walk')
		$playerSprite.flip_h = true
	else:
		moveVector.x = lerp(moveVector.x,0, 0.35)
		$playerSprite.play('idle')
	if Input.is_action_just_pressed("ui_up") and (is_on_floor() or justTimeInJump):
		$Timer.start()
		isJumping = true
		justTimeInJump = false
		moveVector.y = jumpForce
	if Input.is_action_just_released('ui_up'):
		moveVector.y = jumpFallForce 
func on_ground():
	if is_on_floor():
		canJump = true
		isJumping = false
		justTimeInJump = true
	else: 
		$Timer2.start()
	#imp gravidade
	#imp movimentação e flip de sprite
	#imp animações
	#imp dash
	#imp climb
	#imp stamina
	#imp stamina ui


func _on_Timer_timeout():
	canJump = false


func _on_Timer2_timeout():
	canJump = false
