extends Node2D

func _ready():
	GameData.drawing = GameData.peek_drawing
	$ANSWER.text += GameData.topic
	$Panel2.visible = true

func _process(delta):
	$Panel/TimeLeft.text = "%02ds" % $PeekTimer.time_left
	

func _on_guess_inpug_text_changed(new_guess):
	var topic = GameData.topic
	print("guess input changed to: ", new_guess)
	if new_guess == GameData.topic:
		$"YOU WIN!".visible = true
		
