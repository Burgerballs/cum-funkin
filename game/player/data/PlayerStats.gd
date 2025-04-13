class_name PlayerStats extends Resource
var health:float = 1.0:
	set(v):
		health = min(v,2.0)
		
var score:int = 0
var combo:int = 0:
	set(v):
		combo = v
		max_combo = maxi(combo,max_combo)
var max_combo:int = 0
var combo_breaks:int = 0
var notes_hit:int = 0
var accuracy_points:float = 0.0
var accuracy:float = 0.0
var ratings:Dictionary = {
	"marvelous": 0,
	"sick": 0,
	"good": 0,
	"bad": 0,
	"shit": 0
}
