extends RichTextLabel

var counter = 0

func _process(delta):
	counter += delta * 10  # Adjust the multiplier to control the speed of counter increment
	if counter < 30:
		self.text = "[center][fade start=" + str(counter) + " length=1]" + "犬派ですか？それとも猫派ですか？" + "[/fade][/center]"
