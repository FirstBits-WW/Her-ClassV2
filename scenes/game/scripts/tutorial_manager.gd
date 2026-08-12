extends Node
## A script to add into a level or game scene to display tutorial windows.

## A list of tutorial scenes to open, one after the other.
@export var tutorial_scenes : Array[PackedScene]
## If true, open the tutorials when the scene becomes ready.
@export var auto_open : bool = false
## Delay before opening the tutorials when the scene becomes ready.
@export var auto_open_delay : float = 0.25

func open_tutorials() -> void:
	# Verifica se há tutoriais para exibir. Se não, encerra a função.
	if tutorial_scenes.is_empty():
		return
		
	# 1. PAUSA O JOGO
	get_tree().paused = true
	
	var _initial_focus_control : Control = get_viewport().gui_get_focus_owner()
	for tutorial_scene in tutorial_scenes:
		var tutorial_menu : Control = tutorial_scene.instantiate()
		if tutorial_menu == null:
			push_warning("tutorial failed to open %s" % tutorial_scene)
			continue # Alterado de 'return' para 'continue' para não travar o pause
			
		call_deferred("add_child", tutorial_menu)
		
		if tutorial_menu.has_signal(&"closed"):
			await tutorial_menu.closed
		else:
			await tutorial_menu.tree_exited
			
		if is_instance_valid(tutorial_menu):
			tutorial_menu.queue_free()
			
	if is_inside_tree() and _initial_focus_control:
		_initial_focus_control.grab_focus()
		
	# 2. DESPAUSA O JOGO (quando todos os tutoriais fecharem)
	get_tree().paused = false

func _ready() -> void:
	if auto_open:
		if auto_open_delay > 0.0:
			await get_tree().create_timer(auto_open_delay, false).timeout
		open_tutorials.call_deferred()
