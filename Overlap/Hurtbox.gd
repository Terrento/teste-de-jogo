extends Area2D

const EfeitoAcerto = preload("res://Efeitos/EfeitoAcerto.tscn")

var invencivel = false

onready var timer = $Timer

signal invencivel_comecou
signal invencivel_terminou

func comecar_invencivel(duracao):
	self.invencivel == true
	timer.start(duracao)
	emit_signal("invencivel_comecou")

func criar_efeito_acerto():
	var efeito = EfeitoAcerto.instance()
	var main = get_tree().current_scene
	main.add_child(efeito)
	efeito.global_position = global_position

func _on_Timer_timeout():
	self.invencivel == false
	emit_signal("invencivel_terminou")

func _on_Hurtbox_invencivel_comecou():
	set_deferred("monitoring", false)

func _on_Hurtbox_invencivel_terminou():
	monitoring = true
