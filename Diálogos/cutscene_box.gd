extends Area2D
class_name CutsceneArea2D
@export var OwnDialogue: DialogueResource






func StartDialogue() -> void:
	DialogueManager.show_dialogue_balloon(OwnDialogue)
	
	pass
	

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter:
		StartDialogue()
