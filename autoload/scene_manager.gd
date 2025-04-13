extends Node

@onready var trans: TextureRect = $trans
func switch_scene(scene_path:String):
	get_tree().paused = true
	trans.position.y = 720
	var tw = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tw.tween_property(trans,"position:y",-360,0.33 + get_process_delta_time())
	await tw.finished
	var s = Time.get_ticks_usec()
	get_tree().change_scene_to_file(scene_path)
	var d = Time.get_ticks_usec() - s
	
	tw = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tw.tween_property(trans,"position:y",720,0.33 + d / (1000 * 1000.0))
	await tw.finished
	get_tree().paused = not get_window().has_focus()
