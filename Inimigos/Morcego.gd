extends KinematicBody2D

const EfeitoInimigoMorte = preload("res://Efeitos/EfeitoInimigoMorte.tscn")
export var movimento = 50
export var aceleracao = 300

enum {
	PRD,
	MOV,
	PSG
}
var estado = PRD

var repulsao = Vector2.ZERO
export var atrito = 200
var forca_repulsao = 130

onready var sprite = $AnimatedSprite
onready var stats = $Estatisticas
onready var zonaDetecta = $ZonaDetecta
onready var hurtbox = $Hurtbox

var velocidade = Vector2.ZERO

func _physics_process(delta):
	repulsao = repulsao.move_toward(Vector2.ZERO, atrito * delta)
	repulsao = move_and_slide(repulsao)
	
	match estado:
		PRD:
			estado_prd(delta)
		MOV:
			pass
		PSG:
			estado_psg(delta)
	
	velocidade = move_and_slide(velocidade)

func estado_prd(delta):
	velocidade = velocidade.move_toward(Vector2.ZERO, atrito * delta)
	procura_jogador()

func estado_psg(delta):
	var jogador = zonaDetecta.jogador
	if jogador != null:
		var direcao = global_position.direction_to(jogador.global_position + Vector2(0, 5))
		velocidade = velocidade.move_toward(direcao * movimento, delta * aceleracao)
	else:
		estado = PRD
	sprite.flip_h = velocidade.x < 0

func procura_jogador():
	if zonaDetecta.pode_ver_jogador():
		estado = PSG

func _on_Hurtbox_area_entered(area):
	stats.vida -= area.dano #Call down. Morcego 'fala' pra estatisticas fazer algo
	repulsao = area.repulsao * forca_repulsao
	hurtbox.criar_efeito_acerto()

func criar_morte_efeito():
	var efeitoInimigoMorto = EfeitoInimigoMorte.instance()
	get_parent().add_child(efeitoInimigoMorto)
	efeitoInimigoMorto.global_position = global_position

func _on_Estatisticas_vida_zero():
	criar_morte_efeito()
	queue_free() #signal up nesse caso. estatisticas fala pra pai fazer algo

