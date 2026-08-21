extends DialogueMachine2D
class_name DialogueTeleporter2D

@export var spawn_position: Node2D
@export var player_scene: PackedScene



func Machinefunc() -> void:
	var newplayer: PlayerCharacter = player_scene.instantiate()
	newplayer.position = spawn_position.position
	newplayer.set_active(false)
	spawn_position.queue_free()
	add_child(newplayer)
	game_manager.players.append(newplayer)
	$CollisionShape2D.set_deferred("disabled",true)
