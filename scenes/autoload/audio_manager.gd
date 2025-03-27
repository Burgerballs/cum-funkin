extends Node
enum{
	MENU_SCROLL,
	MENU_CONFIRM
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sfx(s:int):
	match s:
		MENU_SCROLL:
			get_node("sfx/menu_scroll").play()
		MENU_CONFIRM:
			get_node("sfx/menu_confirm").play()

	pass
	
