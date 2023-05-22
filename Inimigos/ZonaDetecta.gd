extends Area2D

var jogador = null

func pode_ver_jogador():
	return jogador != null

func _on_ZonaDetecta_body_entered(body):
	jogador = body

func _on_ZonaDetecta_body_exited(body):
	jogador = null
