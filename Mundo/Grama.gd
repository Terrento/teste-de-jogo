extends Node2D

const GramaEfeito = preload("res://Efeitos/GramaEfeito.tscn")#instanciando cena em uma varíavel
#Preload e compartilhar // não precisa carregar varias vezes
func criar_grama_efeito():
	var gramaEfeito = GramaEfeito.instance()
	get_parent().add_child(gramaEfeito)
	gramaEfeito.global_position = global_position

func _on_Hurtbox_area_entered(area):
	criar_grama_efeito()
	queue_free()
