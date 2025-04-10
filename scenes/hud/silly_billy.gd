extends BaseHud
@onready var cpu_icon: HealthIcon = $bar/cpu_icon
@onready var player_icon: HealthIcon = $bar/player_icon
@onready var score_text: Label = $"score text"
@onready var lyrics: Label = $Root/Bars/lyrics
@onready var bar: TextureRect = $bar

const icon_offset:float = 26.0
const countdown_streams = [preload("res://assets/countdown/intro3.ogg"), preload("res://assets/countdown/intro2.ogg"), preload("res://assets/countdown/intro1.ogg"), preload("res://assets/countdown/introGo.ogg")]
const countdown_textures = [preload("res://assets/countdown/ready.png"),preload("res://assets/countdown/set.png"),preload("res://assets/countdown/go.png")]
func reload_icon_textures():
	cpu_icon.texture = Game.instance.player_list[0].chars[0].icon
	player_icon.texture = Game.instance.player_list[1].chars[0].icon
	pass
func _ready() -> void:
	pivot_offset = Vector2(640,360)
	reload_icon_textures()
	if not SaveMan.get_data("downscroll"):
		bar.global_position.y = 720 - bar.global_position.y
		score_text.global_position.y = 720 - 70
	update_score_text()
	
func on_note_miss(player:Player,note:Note):
	if player.does_input:
		update_score_text()	
func on_note_hit(player:Player,note:Note):
	
	if player.does_input:
		update_score_text()
	else:
		if Game.instance.player_list[1].stats.health > 0.1:
			Game.instance.player_list[1].stats.health -= 0.023*0.5

		
	pass
func _process(delta: float) -> void:
	scale = lerp(scale,Vector2.ONE,delta*5.0)
	var bps = (Conductor.bpm/60.0)*4.0
	player_icon.position.x = 400 + 75
	cpu_icon.position.x = 405 - cpu_icon.get_rect().size.x/2 + 25
	
	player_icon.health = stats.health
	cpu_icon.health = 2.0 - player_icon.health
	bar.value = stats.health
	
	pass
func update_score_text():
	score_text.text = "Score: %s; Combo Breaks: %s; Accuracy: %0.3f%%; Combo: %s (%s Max);"%[stats.score,stats.combo_breaks,stats.accuracy*100.0,stats.combo,stats.max_combo]
	pass
func on_beat_hit(beat:int):
	if beat %4 == 0:
		scale += Vector2(0.05,0.05)
	pass
	
func on_step_hit(step:int):
	pass
