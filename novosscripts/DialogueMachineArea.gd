class_name DialogueMachine2D
extends DialogueArea2D

@export var game_manager: GameManager

func StartDialogue() -> void:
	if MAX_INTERACTION_COUNT != 0 and CurrentInteractions >= MAX_INTERACTION_COUNT:
		return
	
	
	Machinefunc()
	DialogueManager.show_dialogue_balloon(OwnDialogue," ", [game_manager])
	
	CurrentInteractions += 1
	if MAX_INTERACTION_COUNT != 0 and CurrentInteractions == MAX_INTERACTION_COUNT and Placa:
		Placa.visible = false
func Machinefunc() -> void:
	pass
