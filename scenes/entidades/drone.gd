extends Sprite2D

@onready var itemSway: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	itemSway_init()

func itemSway_init() -> void:
	itemSway = create_tween()
	itemSway.set_loops(200)
	itemSway.set_ease(Tween.EASE_IN_OUT)
	itemSway.set_trans(Tween.TRANS_CUBIC)
	itemSway.tween_property(self,"position:y",5,2)
	itemSway.tween_property(self,"position:y",-5,2)
	
# Called when the node enters the scene tree for the first time.
