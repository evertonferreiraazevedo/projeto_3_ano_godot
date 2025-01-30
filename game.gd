extends Node2D
const ADDRESS = "127.0.0.1"
const PORT = 3333

#var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene



func _on_join_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer
	$MultiplayerHUD.visible = false
	
var  clientes = 0
func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	$MultiplayerHUD.visible = false
	multiplayer.multiplayer_peer.peer_connected.connect(adicionar_jogador)
	clientes =+ 1
	print(clientes)
	adicionar_jogador(clientes)
	
func adicionar_jogador(id_jogador):
	var jogador = player_scene.instantiate()
	print(clientes)
	jogador.name = str(id_jogador)
	add_child(jogador)
	clientes +=1

#var clientes = 1
#func adicionar_jogador(id_jogador):
	#var jogador = player_scene.instantiate()
	#jogador.name = str(id_jogador)
	#if (jogador.name == "1"):
		#add_child(jogador)
	#else:
		#clientes +=1
		#jogador.name = str(clientes)
		#add_child(jogador)
