extends BaseHud

@onready var time_txt: Label = $text

@onready var timebar: ProgressBar = $timebar
@onready var healthbar: ProgressBar = $healthbar
@onready var icon_p1: Sprite2D = $iconp1
@onready var icon_p2: Sprite2D = $iconp2

func _ready() -> void:
	print("psych hud")
	timebar.max_value = Conductor.audio.stream.get_length()
	timebar.value = 0
	timebar.modulate.a = 0
	time_txt.modulate.a = 0
	
	if SaveMan.save.downscroll:
		time_txt.position.y = 720 - 44
		healthbar.position.y = 720*0.11
		icon_p1.position.y = healthbar.position.y
		icon_p2.position.y = healthbar.position.y
	
		
	timebar.position.y = time_txt.position.y + time_txt.size.y/4
	Conductor.beat_hit.connect(_on_beat_hit)
func format_time(total_seconds: float) -> String:
	#total_seconds = 12345
	var seconds:float = fmod(total_seconds , 60.0)
	var minutes:int   =  int(total_seconds / 60.0) % 60
	var hours:  int   =  int(total_seconds / 3600.0)
	var hhmmss_string:String = "%2d:%02d" % [minutes, seconds]
	return hhmmss_string
func on_song_start():
	create_tween().tween_property(timebar,"modulate:a",1,0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	create_tween().tween_property(time_txt,"modulate:a",1,0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
var bar_center:float = 0
func _process(delta: float) -> void:
	healthbar.value = 2.0 - Game.instance.player_list[1].stats.health
	timebar.value = Conductor.time
	time_txt.text = format_time(Conductor.time)
	# icon shit
	bar_center = healthbar.position.x + (healthbar.value / healthbar.max_value)*healthbar.size.x
	const icon_offset = 26
	
	icon_p1.position.x = bar_center + (150 * icon_p1.scale.x - 150) / 2 - icon_offset + 75
	icon_p2.position.x = bar_center - (150 * icon_p1.scale.x) / 2 - icon_offset * 2 + 75
	
	var mult:float = lerp(1.0,icon_p1.scale.x,exp(-delta*9))
	icon_p1.scale = Vector2(mult,mult)
	icon_p2.scale = Vector2(mult,mult)
	
func _on_beat_hit(b):
	icon_p1.scale = Vector2(1.2,1.2)
	icon_p2.scale = Vector2(1.2,1.2)
