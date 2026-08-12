extends Button



func _on_pressed() -> void:
	SceneManager.change_scene(
	"res://CenaPrincipal/Cena_principal.tscn",
	{ "pattern": "squares", "pattern_leave": "squares" }
	)
