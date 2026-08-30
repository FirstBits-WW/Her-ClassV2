extends Area2D


@export var texto_contador: Label 
@export var portao: StaticBody2D
@export var level_logic: LevelLogic

var quantidade_na_area: int = 0
var portao_aberto: bool = false

func _ready():

	if texto_contador:
		texto_contador.text = str(quantidade_na_area) + " / 3"




func _on_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter and not portao_aberto:
		quantidade_na_area += 1
		texto_contador.text = str(quantidade_na_area) + " / 3"
	if quantidade_na_area >= 3 and portao:
		level_logic.game_manager.set_camera_man_position($"../Portao/CollisionShape2D".position)
		portao_aberto = true
		portao.queue_free()
		level_logic.no_forcefield()
		



func _on_body_exited(body: Node2D) -> void:
	if body is PlayerCharacter and not portao_aberto:
		quantidade_na_area -= 1
		texto_contador.text = str(quantidade_na_area) + " / 3"
