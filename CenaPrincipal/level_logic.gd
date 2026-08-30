extends Node
class_name LevelLogic

@export var objetivo_label: Label
@export var game_manager: GameManager
@export var level1_dialogue1: DialogueResource
@export var level1_dialogue2: DialogueResource

var contador_tp: int = 0



func tp_incremental():
	if contador_tp == 1:
		objetivo_label.text = "Instancie seus colegas! (1/2)"
	if contador_tp == 2:
		objetivo_label.text = "Instancie seus colegas! (2/2)"
		DialogueManager.show_dialogue_balloon(level1_dialogue1," ", [game_manager,self])
		objetivo_label.text = "Crie uma lista com 3 astronautas"

func no_forcefield():
	DialogueManager.show_dialogue_balloon(level1_dialogue2," ", [game_manager,self])
