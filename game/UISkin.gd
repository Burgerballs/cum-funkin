class_name UISkin extends Resource
@export_category("ratings")
@export var shit_texture:Texture2D
@export var bad_texture:Texture2D
@export var good_texture:Texture2D
@export var sick_texture:Texture2D
@export var marvelous_texture:Texture2D
@export_category("combo")
@export var combo_texture:Texture2D = preload("uid://cucean7yot0pw")
@export_category("note skin")
@export var noteskin_scale:float = 1.0
@export var noteskin_frames:SpriteFrames = SpriteFrames.new()
@export var noteskin_hold_textures:Array[Texture] = []
@export var noteskin_tail_textures:Array[Texture] = []
