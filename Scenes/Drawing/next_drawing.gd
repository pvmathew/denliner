extends Control


func _ready():
	GameData.drawing = GameData.peek_drawing

func _process(delta):
	var time_left = $Timer.time_left
	$Panel/TimeLeft.text = "%02ds" % time_left

func _on_timer_timeout():
	GameData.end_peeking()
