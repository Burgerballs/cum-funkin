extends Character
func play_anim(anim:StringName,force:bool = false) -> void:
	super(anim,force)
	if sprite:
		if anim.begins_with("lyrics"):
			await RenderingServer.frame_post_draw
			sprite.scale = Vector2(1.5,1.5)
			dance_steps = []
		else:
			sprite.scale = Vector2.ONE
	await sprite.animation_finished
	dance_steps = ["idle"]
	pass
