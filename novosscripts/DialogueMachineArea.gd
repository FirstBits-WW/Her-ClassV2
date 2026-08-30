class_name DialogueMachine2D
extends DialogueArea2D


func StartDialogue() -> void:
	if MAX_INTERACTION_COUNT != 0 and CurrentInteractions >= MAX_INTERACTION_COUNT:
		return
	
	
	Machinefunc()
	DialogueManager.show_dialogue_balloon(OwnDialogue," ", [game_manager])
	await  DialogueManager.dialogue_ended
	AfterDialogueFunc()
	
	CurrentInteractions += 1
	if MAX_INTERACTION_COUNT != 0 and CurrentInteractions == MAX_INTERACTION_COUNT and Placa:
		Placa.visible = false
func Machinefunc() -> void:
	pass
func AfterDialogueFunc() -> void:
	pass
