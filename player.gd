extends CharacterBody2D

const SPEED = 400

func _ready() -> void:
	$Label.text = self.name
	
func _physics_process(delta: float) -> void:
	
	#Movimentação horizontal
	var direction_horizontal := Input.get_axis("ui_left", "ui_right")
	if direction_horizontal:
		velocity.x = direction_horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#Movimentação vertical
	var direction_vertical := Input.get_axis("ui_up", "ui_down")
	if direction_vertical:
		velocity.y = direction_vertical * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	
	#Versão alternativa com menos linhas ambas direções
	
	#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") 
	#velocity = direction * SPEED
	
	
	

	move_and_slide()
