class_name BaseHud extends Control
var stats:PlayerStats = null
var skin:UISkin = null
func on_note_miss(player:Player,note:Note):
	pass
func on_note_hit(player:Player,note:Note):
	pass
func on_beat_hit(beat:int):
	pass
func on_step_hit(step:int):
	pass
func on_note_rate(player:Player,_rating:NoteRating):
	pass
func on_song_start():
	pass
