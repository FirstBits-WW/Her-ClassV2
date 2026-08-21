extends Node

@export var OwnDialogue: DialogueResource


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StartDialogue()








func StartDialogue() -> void:
	DialogueManager.show_dialogue_balloon(OwnDialogue)
	
	pass
	
