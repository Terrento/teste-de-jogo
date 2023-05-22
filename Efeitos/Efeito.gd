extends AnimatedSprite


func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	play("Animacao")

func _on_animation_finished():
	queue_free()
