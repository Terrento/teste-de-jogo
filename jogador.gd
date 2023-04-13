extends KinematicBody2D

export var movimento = 70

func _physics_process(delta):
	var velocidade = Vector2.ZERO
	
	#Se tal conjunto de teclas é apertado, x ou y adiciona valor
	#Nestes cados, o mapeamento está para as setas do teclado
	if Input.is_action_pressed("ui_right"):
		velocidade.x += 1
	if Input.is_action_pressed("ui_left"):
		velocidade.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocidade.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocidade.y += 1
		
	velocidade = velocidade.normalized() #Impedir que o personagem se mova mais rapidamente na diagonal
	
	if velocidade == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Parado") #Parado
	else:
		$AnimationTree.get("parameters/playback").travel("Andando") #Mover para animação de andar
		$AnimationTree.set("parameters/Parado/blend_position", velocidade) #Congelar a direção de movimento
		$AnimationTree.set("parameters/Andando/blend_position", velocidade) #Anima~ção de andar para outros lados
	
	move_and_slide(movimento * velocidade)
