class_name EventHandler extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
var events:Array[Event] = []
var cur_event:int = 0

signal event_fired(ev:Event)

func _process(delta: float) -> void:
	while cur_event < events.size() and\
	Conductor.time >= events[cur_event].time:
		var ev = events[cur_event]
		cur_event += 1
		event_fired.emit(ev)
		ev.fire()
func fire_event(ev:Event):
	ev.fire()
func queue_event(ev:Event):
	Game.meta.events.append(ev)
	Game.meta.events.sort_custom(func(a,b): a.time < b.time)
