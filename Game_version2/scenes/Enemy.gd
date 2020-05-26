extends KinematicBody2D

var up = Vector2(0, -1)
var moveState  
var velocidade = 50
func _ready():
	moveState = Vector2()

func _physics_process(delta):
	move_and_slide(moveState, up)


func _on_left_timeout():
	$right.start()
	moveState.x = velocidade
	$AnimatedSprite.play('idle')
	$AnimatedSprite.flip_h = true
	print('terminou left')

func _on_right_timeout():
	$left.start()
	moveState.x = -velocidade
	$AnimatedSprite.play('idle')
	$AnimatedSprite.flip_h = false
	print('terminou right')
