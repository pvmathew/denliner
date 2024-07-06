extends TextureRect

func _ready():
	var shadow_material = self.material
	shadow_material.set_shader_parameter("background_texture", $"../TextureRect3".material)
