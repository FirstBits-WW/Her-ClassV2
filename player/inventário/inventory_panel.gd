extends Panel

const HAND_CLOSED =  preload("res://Visuals/CursorVisuals/mouse fechado.png")
const HAND_OPEN   =  preload("res://Visuals/CursorVisuals/mouse aberto.png")

signal inventario_alterado



func _ready() -> void:
	Input.set_custom_mouse_cursor(HAND_OPEN, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(HAND_CLOSED, Input.CURSOR_FORBIDDEN)
	Input.set_custom_mouse_cursor(HAND_CLOSED, Input.CURSOR_CAN_DROP)
	Input.set_custom_mouse_cursor(HAND_CLOSED, Input.CURSOR_DRAG)


var data_bk

func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		data_bk = get_viewport().gui_get_drag_data()
	if what == Node.NOTIFICATION_DRAG_END:
		if not is_drag_successful():
			if data_bk:
				data_bk.icon.show()
				data_bk = null
		else:
			inventario_alterado.emit()
