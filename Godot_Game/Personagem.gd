extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVIDADE = 20
const VELOCIDADE = 200
const JUMP = -500
var movimento = Vector2() 
#vector2 recebe coordenadas de x e y para movimentação 2D

# Delta = Frames por segundo > Determina a quantidade de frames do jogo
func _physics_process(_delta): 
	
	movimento.y += GRAVIDADE
	
	#Quando as teclas de movimentação são pressionadas
	if Input.is_action_pressed("ui_right"): 
		movimento.x = VELOCIDADE #Velocidade que o movimento acontece
		$Sprite.play("run")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"): 
		movimento.x = -VELOCIDADE
		$Sprite.play("run")
		$Sprite.flip_h = true #Faz a sprite "flipar" na horizontal
	else:
		movimento.x = 0
		$Sprite.play("idle")
	#Pulo (Necessita especificar aonde está o chão)
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			movimento.y = JUMP
	else:
		$Sprite.play("up")
	movimento = move_and_slide(movimento, UP)
