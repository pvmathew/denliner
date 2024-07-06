extends VBoxContainer

@onready var parent = get_parent()

@onready var anim = $AnimationPlayer
@onready var question = $Question

@onready var input_container = $MarginContainer
@onready var name_input = $MarginContainer/HBoxContainer/MarginContainer/HBoxContainer/NameInput


var counter = -20
var input_visible = false

func _process(delta):
	if self.visible:
		counter += delta * 10  # Adjust the multiplier to control the speed of counter increment
		if counter < 15:
			question.text = "[center][fade start=" + str(counter) + " length=1]" + "お名前を教えてください" + "[/fade][/center]"
		else:
			if !input_visible:
				input_visible = true
				anim.play("fade_in_input")


func _on_ok_pressed():
	PlayerData.nickname = name_input.text
	anim.play("fade_out_all")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out_all":
		parent.show_next_question()
