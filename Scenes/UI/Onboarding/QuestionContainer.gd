extends CenterContainer

@onready var questions = [$"Question 1", $"Question 2"]


var curr_index = 0

func _ready():
	questions[0].show()
	
func show_next_question():
	questions[curr_index].hide()
	curr_index += 1
	
	if curr_index < questions.size():
		questions[curr_index].show()
	else:
		PlayerData.is_onboarded = true
		PlayerData.save_player_data()
		%AnimationPlayer.play("fade_out")
