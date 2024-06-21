extends Node2D

func _ready():
	$TopicPanel/Topic.text += GameData.topic
	GameData.rpc("update_player_status", "drawing")
	
func _process(delta):
	var time_left = $Timer.time_left
	$TopicPanel/TimeLeft.text = "Time Left: " + "%02ds" % time_left

func _on_timer_timeout():
	GameData.drawing_timer_ended.emit()
	$TimeUpPanel.visible = true
