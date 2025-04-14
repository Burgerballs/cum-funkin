extends CanvasLayer
@onready var bg: ColorRect = $bg
var game:Game
func _ready() -> void:
	game = Game.instance
	bg.modulate = 0
	create_tween().tween_property(bg,"modulate:a",0.6,0.4).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	game.set_process_input(false)
func _input(event: InputEvent) -> void:
	if event.is_echo():
		return
	if event.is_action_pressed("ui_accept"):
		game.process_mode = Node.PROCESS_MODE_INHERIT
		queue_free()
		game.set_process_input(true)
		game.paused = false
		
