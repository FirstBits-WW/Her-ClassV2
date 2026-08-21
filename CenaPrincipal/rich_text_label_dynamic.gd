extends RichTextLabel
@export var game_manager: GameManager


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = "Utilize  [color=yellow]" + game_manager.pegar_nome_do_botao("move_up") +  game_manager.pegar_nome_do_botao("move_down") +  game_manager.pegar_nome_do_botao("move_left") +  game_manager.pegar_nome_do_botao("move_right") + "[/color] para se mover!"
