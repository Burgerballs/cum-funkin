extends Node


var cam: Camera2D
var game: Game
var hud: BaseHud

var dad: Character
#var bf: Character

var event_index: int = 0
var events: Array[Event] = []
var cam_locked: bool = false
var addition: float = 0.0
var shake_strangth:float = 0
var shake_duration:float = 0
var og_rate:float = 1.0

func _ready() -> void:
	game = Game.instance
	hud = game.hud
	cam = game.stage.camera
	events = Game.instance.event_manager.events
	events.sort_custom(func(a, b):
		return a.time < b.time)
	dad = game.player_list[0].chars[0]


func _process(delta: float) -> void:
	var game_size:Vector2 = get_window().content_scale_size
	if shake_duration > 0 and shake_strangth > 0:
		game.stage.camera.offset = Vector2((randf_range(-1,1) * shake_strangth) * game_size.x,(randf_range(-1,1) * shake_strangth) * game_size.y)
		shake_duration -= delta
	else:
		game.stage.camera.offset = Vector2.ZERO
		shake_strangth = 0
	while event_index < events.size() - 1:
		var event := events[event_index]
		if Conductor.time < event.time:
			break
		
		_event(event)
		event_index += 1
	if Conductor.stepi == 3362:
		dad.play_anim("lyrics",true)
	if Conductor.stepi == 3440:
		game.stage.breakCore()
func _event(event: Event) -> void:
	if event is CameraFocusEvent:
		match event.target:
			1:
				if not cam_locked:
					game.stage.zoom = 0.5 + addition
			_:
				if not cam_locked:
					game.stage.zoom = 0.625 + addition
		return
	if not event is PsychEvent:
		return
	
	event = event as PsychEvent
	var donut: String = event.name
	var param1: String = str(event.one)
	var param2: String = str(event.two)
	match donut.to_lower():
		'icon switch':
			hud.cpu_icon.icon_set = int(param1) - 1
		'ill make':
			match param1:
				"pre":
					game.stage.zoom = 0.5
					cam_locked = true
					for i in [hud.bar,hud.score_text]:
						create_tween().tween_property(i,"modulate:a",0,1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
					for i in game.player_list:
						create_tween().tween_property(i.notefield,"modulate:a",0,1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
				"hud in":
					game.player_list[1].notefield.position.x = 417
					for i in game.player_list:
						create_tween().tween_property(i.notefield,"modulate:a",1,1.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
				"txt":
					hud.lyrics.text = param2
				"break mirror":
					game.stage.break_core.visible = true
					game.stage.break_core_progress = 1.0
					create_tween().tween_property(game.stage,"break_core_progress",0.0,game.stage.fade_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
					shake_strangth = 0.01
					shake_duration = 0.25
					game.stage.glass_break.play(0.0)
					print("MIRROR BREAK")
					
					
				"black":
					print("cock")
					create_tween().tween_property(game.stage.black,"color:a",1,1.125).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
					game.stage.zoom = 0.6
					create_tween().tween_property(game.stage,"zoom",1.125,0.75).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
				"vid":
					game.stage.cut.play()
					og_rate = Conductor.rate
					Conductor.rate = 1.0
					await game.stage.cut.finished
					create_tween().tween_property(game.stage.cut,"modulate:a",0,2)
					game.stage.blu.visible = true
					create_tween().tween_property(game.player_list[1].notefield,"position:x",752,2.0).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
					Conductor.rate = og_rate
					game.stage.black.color.a = 0
					cam_locked = false
				"die":
					game.stage.black.color.a = 1
					
					create_tween().tween_property(game.player_list[1].notefield,"modulate:a",0,4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
					
				_:
					print("NOT DONE EVEN %s"%param1)
					
					

		'zoomin':
			addition = float(param1)
		'add camera zoom':
			var normal_zoom: float = 0.015
			var hud_zoom: float = 0.03
			if (not param1.is_empty()) and param1.is_valid_float():
				normal_zoom = float(param1)
			if (not param2.is_empty()) and param2.is_valid_float():
				hud_zoom = float(param2)
			
			cam.zoom += Vector2(normal_zoom, normal_zoom)
			hud.scale += Vector2(hud_zoom, hud_zoom)
		'camera zoom':
			game.stage.zoom *= float(param1)
		'setzoom':
			var i_am_having_a_seizure_and_a_cheesecake := float(param2)
			cam.zoom = Vector2(i_am_having_a_seizure_and_a_cheesecake, i_am_having_a_seizure_and_a_cheesecake)
			game.stage.zoom = i_am_having_a_seizure_and_a_cheesecake
			cam_locked = true
		'removelock':
			cam_locked = false
		'hurt':
			pass
			#if game.health > 0.5:
			#game.health -= 0.05
		'change character':
			match param2:
				'transLookalike':
					dad.anim_suffix = '_small'
					var dad_spr := dad.sprite
					dad_spr.self_modulate = Color.TRANSPARENT
					var cummies: Node2D = dad_spr.get_node('big_to_small')
					cummies.visible = true
					cummies.play('ElUngrow')
					dad.camera_position = dad.get_node('camera2')
				'bf-lookalike':
					var dad_spr := dad.sprite
					dad_spr.self_modulate = Color.WHITE
					var cummies := dad_spr.get_node('big_to_small')
					cummies.queue_free()
				'transLookalike2':
					dad.anim_suffix = ''
					var dad_spr := dad.sprite
					dad_spr.self_modulate = Color.TRANSPARENT
					var cummies: Node2D = dad_spr.get_node('small_to_big')
					cummies.visible = true
					cummies.play('ElUnshrink')
					dad.camera_position = dad.get_node('camera')
				'evilLookaLike':
					var dad_spr := dad.sprite
					dad_spr.self_modulate = Color.WHITE
					if dad_spr.has_node('small_to_big'):
						var cummies := dad_spr.get_node('small_to_big')
						cummies.queue_free()
				_:
					pass
		_:
			pass
