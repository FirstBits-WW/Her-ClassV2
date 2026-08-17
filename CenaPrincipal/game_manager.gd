extends Node
class_name GameManager

@export var camera: Node2D
@export var players: Array[PlayerCharacter] # Arraste os 3 personagens para este array no Inspetor
static var is_dialogue_running: bool = false
const player_scene: PackedScene = preload("res://player/player.tscn")
var current_player_index: int = 0

func _ready() -> void:
	# Validação de segurança inicial
	if players.is_empty() or camera == null:
		push_error("GameManager: Configure os jogadores e a câmera no Inspetor!")
		return
		
	# Inicializa o estado dos personagens
	for i in range(players.size()):
		players[i].set_active(i == current_player_index)
		
	# Define o alvo inicial da câmera
	camera.set_target(players[current_player_index])
	# Teletransporta a câmera para o primeiro jogador logo de cara (sem transição inicial)
	camera.global_position = players[current_player_index].global_position
	
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(_recursoDialogo: DialogueResource) -> void:
	is_dialogue_running = false
func _on_dialogue_started(_recursoDialogo: DialogueResource) -> void:
	is_dialogue_running = true
func _unhandled_key_input(event: InputEvent) -> void:
	if not event.is_pressed():
		return
		
	if event.keycode == KEY_1:
		switch_character(0)
	elif event.keycode == KEY_2:
		switch_character(1)
	elif event.keycode == KEY_3:
		switch_character(2)
		
	# Troca ciclicamente usando o TAB
	elif event.is_action_pressed("mudar_personagem"):
		var next_index = (current_player_index + 1) % players.size()
		switch_character(next_index)

func switch_character(new_index: int) -> void:
	# Evita trocar para o mesmo personagem que já está ativo ou índice inválido
	if new_index == current_player_index or new_index >= players.size():
		return
	if is_dialogue_running:
		return
		
	# Desativa o personagem atual
	players[current_player_index].set_active(false)
	
	# Atualiza o índice para o novo personagem
	current_player_index = new_index
	
	# Ativa o novo personagem
	players[current_player_index].set_active(true)
	
	# Avisa a câmera para seguir o novo alvo
	camera.set_target(players[current_player_index])
	


func _on_button_pressed() -> void:
	var newplayer: PlayerCharacter = player_scene.instantiate()
	newplayer.position = Vector2(200,100)
	newplayer.set_active(false)
	add_child(newplayer)
	players.append(newplayer)
	
	
