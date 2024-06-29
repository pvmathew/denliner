extends Control

var counter

func _ready():
	counter += 1
	if counter < 161:
		$RichTextLabel.set_bbcode("[fade start=" + str(counter) + " length=10]" + $RichTextLabel.text + "[/fade]")
