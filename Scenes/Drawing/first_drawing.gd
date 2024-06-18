extends Node2D

func _ready():
	$TopicPanel/Topic.text += GameData.topic
