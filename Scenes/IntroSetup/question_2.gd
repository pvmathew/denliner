extends VBoxContainer

@onready var parent = get_parent()

@onready var anim = $AnimationPlayer
@onready var question = $Question

@onready var cat = $MarginContainer/HBoxContainer/Cat
@onready var dog = $MarginContainer/HBoxContainer/Dog

var counter = -20
var question_appeared = false

var shader = load("res://Scenes/IntroSetup/wavy_pets.gdshader")


func _process(delta):
	if self.visible:
		counter += delta * 10  # Adjust the multiplier to control the speed of counter increment
		if counter < 30:
			question.text = "[center][fade start=" + str(counter) + " length=1]" + "犬派ですか？それとも猫派ですか？" + "[/fade][/center]"
		else:
			#$MarginContainer/HBoxContainer/MarginContainer.visisble = true
			if !question_appeared:
				question_appeared = true
				anim.play("appear_pets")

# Question 2 signals

func _on_cat_mouse_entered():
	if cat.material == null:
		# Create a new material and assign it to the node
		var new_material = ShaderMaterial.new()  # Or whatever type of material you need
		cat.material = new_material  # Assign the new material to the node
		
	cat.material.shader = shader


func _on_cat_mouse_exited():
	cat.material = null


func _on_dog_mouse_entered():
	if dog.material == null:
		# Create a new material and assign it to the node
		var new_material = ShaderMaterial.new()  # Or whatever type of material you need
		dog.material = new_material  # Assign the new material to the node
		
	dog.material.shader = shader

func _on_dog_mouse_exited():
	dog.material = null


func _on_cat_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		anim.play("fade_out_all")


func _on_dog_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		anim.play("fade_out_all")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out_all":
		parent.show_next_question()
		
