extends CharacterBody2D

const SPEED = 400
var clientes = 1
var nome_jogador = "Anônimo"
@onready var label = $Label

@export var bullet_scene: PackedScene  # Referência para a cena da bala

func _unhandled_input(event):
	# Verifica se o evento de pressionamento de botão de tiro ocorreu
	if event.is_action_pressed("shoot"):
		spawn_bullet()

@rpc("any_peer")  # Todos os jogadores recebem a RPC
func spawn_bullet():
	# Somente quem pressionou o botão irá criar a bala
	if is_multiplayer_authority():  # Verifica se é o jogador que apertou o botão
		if bullet_scene:
			var bullet = bullet_scene.instantiate()
			bullet.global_position = global_position  # A bala nasce na posição do jogador
			# Definindo a direção da bala, baseada na orientação do player
			bullet.direction = (Vector2.RIGHT if $Sprite2D.flip_h == false else Vector2.LEFT)
			get_parent().add_child(bullet)  # Adiciona a bala à cena
			rpc_id(1, "spawn_bullet", global_position, bullet.direction)  # Envia a RPC para os outros jogadores


func _enter_tree() -> void:
	set_multiplayer_authority(self.name.to_int())
	$Label.text = nome_jogador

func _physics_process(delta: float) -> void:
	
	if (is_multiplayer_authority()):
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
