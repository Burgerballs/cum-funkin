class_name HealthIcon extends Sprite2D

@export var health:float = 1.0
@export var texture_frame_map:Dictionary = {0.4: 1}
func _process(delta: float) -> void:

	for i in texture_frame_map.keys():
		if i == 0.0:
			frame = texture_frame_map.get(i,0)
		if i >= health:
			frame = texture_frame_map.get(i,0)
