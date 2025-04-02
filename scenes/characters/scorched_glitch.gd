extends Character
@onready var chars = [$sprite, $sprite2]
@onready var player = [$anim_player, $anim_player2]
var cur_char:int = 0:
	set(v):
		cur_char = v
		sprite.visible = false
		sprite = chars[cur_char%2]
		anim_player = player[cur_char%2]
		sprite.visible = true
		play_anim(_cur_anim)
func play_anim(anim:StringName,force:bool = false):
	super.play_anim(anim,force)
	
func _physics_process(delta: float) -> void:
	if Engine.get_physics_frames() %2 == 0:
		cur_char = randi()%2
