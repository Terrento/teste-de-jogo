extends Control

export var JogoCena : PackedScene
func _ready():
	pass # Replace with function body.


func _on_Comecar_pressed():
	get_tree().change_scene(JogoCena.resource_path)


func _on_Sair_pressed():
	get_tree().quit()


func _on_Creditos_pressed():
	get_tree().change_scene("res://Menu/Creditos.tscn")
