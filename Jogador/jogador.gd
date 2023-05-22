extends KinematicBody2D

export var movimento = 80
var direcao = Vector2.ZERO

enum { #enumera variáveis
	MOV,
	ROL,
	ATQ
}
var estado = MOV
onready var espadaHitbox = $HitboxPivo/EspadaHitbox
onready var stats = $JogadorEstatisticas
onready var hurtbox = $Hurtbox

func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	match estado: #É como se fosse um switch basicamente. Faz com que apena um bloco de código rode por vez. Facilita debug
		MOV:
			estado_mov(delta)
		
		ROL:
			pass
		
		ATQ:
			estado_atq(delta)
	
func estado_mov(delta):
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
		direcao = velocidade
		espadaHitbox.repulsao = direcao
		$AnimationTree.get("parameters/playback").travel("Andando") #Mover para animação de andar
		$AnimationTree.set("parameters/Parado/blend_position", velocidade) #Congelar a direção de movimento
		$AnimationTree.set("parameters/Andando/blend_position", velocidade) #Animação de andar para outros lados
		$AnimationTree.set("parameters/Ataque/blend_position", velocidade) #Não mudar direção de ataque. Forçar animação de ataque mesma direção e movimento
	move_and_slide(movimento * velocidade)
	
	if Input.is_action_just_pressed("ataque"):
		estado = ATQ

func estado_atq(delta):
	
	$AnimationTree.get("parameters/playback").travel("Ataque")

func ataque_terminado():
	estado = MOV

func _on_Hurtbox_area_entered(area):
	stats.vida -= 1
	hurtbox.comecar_invencivel(0.5)
	hurtbox.criar_efeito_acerto()

func _on_JogadorEstatisticas_vida_zero():
	queue_free()
