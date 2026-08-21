extends Area2D
class_name DialogueArea2D
@export var OwnDialogue: DialogueResource
#se MAX_INTERACTION_COUNT = 0, não há limite de interação
@export var MAX_INTERACTION_COUNT: int = 0
var CurrentInteractions: int = 0
@export var Placa: Area2D





func StartDialogue() -> void:
	if MAX_INTERACTION_COUNT != 0 and CurrentInteractions >= MAX_INTERACTION_COUNT:
		return
	
	DialogueManager.show_dialogue_balloon(OwnDialogue)
	
	CurrentInteractions += 1
	if CurrentInteractions == MAX_INTERACTION_COUNT and Placa:
		Placa.visible = false
	
	
