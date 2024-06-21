extends Control


func _ready():
	GameData.drawing = GameData.peek_drawing


func _on_timer_timeout():
	GameData.drawing = []
