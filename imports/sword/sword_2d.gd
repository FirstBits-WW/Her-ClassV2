extends Node2D
class_name ItemScene

const DRAG_FACTOR := 15.0
const RUN_SPEED := 600.0
@onready var armaWrapper: Node2D = $ArmaWrapper
@onready var sprite: Sprite2D = $ArmaWrapper/Sprite2D
var atkTween: Tween





@onready var animation_player := %AnimationPlayer
var Player: PlayerCharacter
func _physics_process(_delta: float) -> void:
		sprite.rotation = lerp(sprite.rotation,-get_parent().rotation,0.2)

func _unhandled_key_input(event: InputEvent) -> void:
	if not event.is_pressed():
		return
		
	if event.keycode == KEY_Z and Player and Player.is_active:
		animation_player.play("slash")


		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slash":
		animation_player.play("RESET")
