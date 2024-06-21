extends Control

var timer_ended = false

var point1 : Vector2 = Vector2(0, 0)
var width : int = 10
var color : Color = Color.GREEN

var _point2 : Vector2

var current_line = []

func _ready():
	GameData.drawing_timer_ended.connect(_on_drawing_timer_ended)

func _process(_delta):
	var mouse_position = get_viewport().get_mouse_position()
	if Input.is_mouse_button_pressed( 1 ) and !timer_ended:
		if current_line.is_empty():
			current_line.push_back(mouse_position)
		else:
			if mouse_position != current_line.back():
				current_line.push_back(mouse_position)
	else:
		if not current_line.is_empty():
			GameData.drawing.push_back(current_line)
			current_line = []
	queue_redraw()

func my_draw_polyline(line: Array):
	if line.is_empty():
		pass
	if len(line) > 1:
		draw_polyline(line, color, width)
	else:
		draw_circle(line.back(), width, color)

func _draw():
	for line in GameData.drawing:
		my_draw_polyline(line)
	if not current_line.is_empty():
		my_draw_polyline(current_line)
		
func _on_drawing_timer_ended():
	timer_ended = true
