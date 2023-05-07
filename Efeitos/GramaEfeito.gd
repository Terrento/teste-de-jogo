extends Node2D


func _ready():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play("Animacao")

func _on_AnimatedSprite_animation_finished():
	queue_free()
