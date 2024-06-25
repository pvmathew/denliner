extends Control


func _ready():
	GameData.drawing = GameData.peek_drawing

func _process(delta):
	
	if $PeekTimer.is_stopped():
		$Panel/TimeLeft.text = "%02ds" % $DrawingTimer.time_left
	else:
		$Panel/TimeLeft.text = "%02ds" % $PeekTimer.time_left

func _on_drawing_timer_timeout():
	GameData.drawing_timer_ended.emit()

func _on_peek_timer_timeout():
	GameData.peek_timer_ended.emit()
	$DrawingTimer.start()
