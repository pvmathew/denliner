extends Control

var width : int = 10
var color : Color = Color.GREEN

func _ready():
	GameData.peek_timer_ended.connect(_on_peek_timer_ended)

func _process(_delta):
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
		
func _on_peek_timer_ended():
	self.visible = false
