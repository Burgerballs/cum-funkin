extends Stage
@onready var cut: VideoStreamPlayer = $CanvasLayer/cut
@onready var break_core: Sprite2D = $CumInMyFunkin/SillyMirror/BreakCore
const fade_time = 1.75
@onready var blu: CanvasLayer = $blu
@export var field: Node2D
@onready var black: ColorRect = $CanvasLayer2/black
@onready var glass_break: AudioStreamPlayer = $"CumInMyFunkin/SillyMirror/glass break"

var break_core_progress:float = 0.0:
	set(v):
		break_core_progress = clamp(v,0.0,1.0)
		break_core.material.set_shader_parameter("progress",break_core_progress)
		
func breakCore():
	break_core.visible = true
	break_core_progress = 1.0
	create_tween().tween_property(self,"break_core_progress",0.0,fade_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
@onready var dad_notefield = Game.instance.player_list[0].notefield
const field_x = 1000.0
const field_y = 1320.0
var start:float = 0
func _ready() -> void:
	dad_notefield.reparent(field,false)
	dad_notefield.position = Vector2.ZERO
	if not SaveMan.save.downscroll:
		dad_notefield.position.y -= 450
