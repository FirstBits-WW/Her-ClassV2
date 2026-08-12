extends Area2D


@export var texto_contador: Label 
@export var portao: StaticBody2D

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
		portao_aberto = true
		portao.queue_free()
		



func _on_body_exited(body: Node2D) -> void:
	if body is PlayerCharacter and not portao_aberto:
		quantidade_na_area -= 1
		texto_contador.text = str(quantidade_na_area) + " / 3"
