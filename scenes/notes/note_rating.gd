class_name NoteRating extends Resource
# judge diff
enum {
	JUDGE_1,
	JUDGE_2,
	JUDGE_3,
	JUDGE_4,
	JUDGE_5,
	JUDGE_6,
	JUDGE_7
}
var hit_diff:float
var rating:String = "invalid"
var score:float = -10.0
const judgeScales:Dictionary = {
	"J1" : 1.50,
	"J2" : 1.33,
	"J3" : 1.16,
	"J4" : 1.0,
	"J5" : 0.84,
	"J6" : 0.66,
	"J7" : 0.5,
	"J8" : 0.33,
	"JUSTICE" : 0.2
}

static var timeing_dict:Dictionary = {
	22.5 : "marvelous",
	45.0 : "sick",
	90.0 : "good",
	135.0 : "bad",
	180.0: "shit"
}
const scores:Array[float] = [350,300,150,50,0,-10]
const ratings:Array[String] = ["marvelous","sick","good","bad","shit","invalid"]
static func get_timeings(judge_diff:int):
	var defaults = [22.5,45.0,90.0,135.0,180.0]
	return defaults

static func rate_note(note:Note,autoplay:bool = false,judge_diff:int = JUDGE_4):
	var times = timeing_dict
	var _rate := NoteRating.new()
	_rate.hit_diff = abs(note.time - Conductor.time)*1000.0
	if autoplay:
		_rate.hit_diff = 0
	for i in times.keys():
		if i > _rate.hit_diff:
			_rate.rating = times.get(i)
			break
	_rate.score = scores[ratings.find(_rate.rating)]
	return _rate
	pass
