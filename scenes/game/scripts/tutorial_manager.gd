extends Node
## A script to add into a level or game scene to display tutorial windows.

## A list of tutorial scenes to open, one after the other.
@export var tutorial_scenes : Array[PackedScene]
## If true, open the tutorials when the scene becomes ready.
@export var auto_open : bool = false
## Delay before opening the tutorials when the scene becomes ready.
@export var auto_open_delay : float = 0.25

func open_tutorials() -> void:
	if tutorial_scenes.is_empty():
		return
		
	# 1. PAUSA O JOGO (Tutoriais usam pause_mode = PROCESS para funcionar)
	get_tree().paused = true
	
	var _initial_focus_control : Control = get_viewport().gui_get_focus_owner()
	
	var total_scenes = tutorial_scenes.size()
	
	# Loop usando range para identificar índice 0 e último índice
	for i in range(total_scenes):
		var tutorial_scene = tutorial_scenes[i]
		var tutorial_menu : Control = tutorial_scene.instantiate()
		if tutorial_menu == null:
			push_warning("tutorial failed to open %s" % tutorial_scene)
			continue
			
		# Adicionamos direto na árvore (sem call_deferred) para animar imediatamente
		add_child(tutorial_menu)
		
		# --- ANIMAÇÃO DE ENTRADA DINÂMICA (Apenas no primeiro índice) ---
		if i == 0:
			# Define transparência inicial invisível
			tutorial_menu.modulate.a = 0.0
			# Cria tween paralelo e GARANTE que ele rode com o jogo pausado
			var tween_in = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_parallel(true)
			tween_in.tween_property(tutorial_menu, "modulate:a", 1.0, 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
		
		# Aguarda o sinal de fechar do template
		if tutorial_menu.has_signal(&"closed"):
			await tutorial_menu.closed
		else:
			await tutorial_menu.tree_exited
			
		# Verifica se o nó ainda existe antes de tentar animar a saída
		if is_instance_valid(tutorial_menu):
			# --- ANIMAÇÃO DE SAÍDA DINÂMICA (Apenas no último índice) ---
			if i == total_scenes - 1:
				# Garanitmos que ele permaneça visível caso o script Maaack tenha escondido
				tutorial_menu.visible = true
				tutorial_menu.modulate.a = 1.0
				
				# Cria tween paralelo e GARANTE que ele rode com o jogo pausado
				var tween_out = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_parallel(true)
				tween_out.tween_property(tutorial_menu, "modulate:a", 0.0, 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
				
				# ESPERA a animação de saída terminar visualmente
				await tween_out.finished
				
			# Libera o nó da memória
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
