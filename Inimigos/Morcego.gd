extends KinematicBody2D

var repulsao = Vector2.ZERO
var atrito = 200
var forca_repulsao = 130
onready var stats = $Estatisticas

func _physics_process(delta):
	repulsao = repulsao.move_toward(Vector2.ZERO, atrito * delta)
	repulsao = move_and_slide(repulsao)

func _on_Hurtbox_area_entered(area):
	stats.vida -= area.dano #Call down. Morcego 'fala' pra estatisticas fazer algo
	repulsao = area.repulsao * forca_repulsao

func _on_Estatisticas_vida_zero():
	queue_free() #signal up nesse caso. estatisticas fala pra pai fazer algo
