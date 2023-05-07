extends Node2D

func criar_grama():
	var GramaEfeito = load("res://Efeitos/GramaEfeito.tscn") #instanciando cena em uma varíavel
	var gramaEfeito = GramaEfeito.instance()
	var mundo = get_tree().current_scene
	mundo.add_child(gramaEfeito)
	gramaEfeito.global_position = global_position

func _on_Hurtbox_area_entered(area):
	criar_grama()
	queue_free()
