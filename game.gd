extends Node2D


const ADDRESS = "127.0.0.1"
const PORT = 3333
@export var player_scene: PackedScene



func _on_join_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ADDRESS, PORT)
	multiplayer.multiplayer_peer = peer
	$MultiplayerHUD.visible = false
	

func _on_host_pressed() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	$MultiplayerHUD.visible = false
	multiplayer.multiplayer_peer.peer_connected.connect(adicionar_jogador)
	adicionar_jogador(1)
	
func adicionar_jogador(id_jogador):
	var jogador = player_scene.instantiate()
	jogador.name = str(id_jogador)
	add_child(jogador)
	
