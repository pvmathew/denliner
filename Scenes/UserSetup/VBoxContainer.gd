extends VBoxContainer

@onready var anim = $"../../../AnimationPlayer"
@onready var question = $DogOrCat
@onready var cat = $MarginContainer/HBoxContainer/Cat
@onready var dog = $MarginContainer/HBoxContainer/Dog

var counter = -20
var question_appeared = false

func _process(delta):
	counter += delta * 10  # Adjust the multiplier to control the speed of counter increment
	if counter < 30:
		question.text = "[center][fade start=" + str(counter) + " length=1]" + "犬派ですか？それとも猫派ですか？" + "[/fade][/center]"
	else:
		if !question_appeared:
			question_appeared = true
			anim.play("appear_pets")



func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "appear_pets"):
		print("Pets are now visible, enable clicking and focus here")


func _on_cat_mouse_entered():
	if cat.material == null:
		# Create a new material and assign it to the node
		var new_material = ShaderMaterial.new()  # Or whatever type of material you need
		cat.material = new_material  # Assign the new material to the node
		
	var shader = load("res://Scenes/UserSetup/wavy_pets.gdshader")
	cat.material.shader = shader


func _on_cat_mouse_exited():
	cat.material = null




func _on_dog_mouse_entered():
	if dog.material == null:
		# Create a new material and assign it to the node
		var new_material = ShaderMaterial.new()  # Or whatever type of material you need
		dog.material = new_material  # Assign the new material to the node
		
	var shader = load("res://Scenes/UserSetup/wavy_pets.gdshader")
	dog.material.shader = shader

func _on_dog_mouse_exited():
	dog.material = null
