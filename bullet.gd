extends CharacterBody2D

@export var speed: int = 1000
@export var direction: Vector2 = Vector2.RIGHT  # Direção inicial da bala

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

	# Destruir se sair da tela
	if not get_viewport_rect().has_point(global_position):
		queue_free()
