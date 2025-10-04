extends Node3D

var levels = [
	"res://scenes/main.tscn",
	"res://scenes/level_2.tscn",
	"res://scenes/level_3.tscn"
]
var current_level_index: int = 0
var end_scene = "res://scenes/end_screen.tscn"

func _ready():
	var scene_path = get_tree().current_scene.scene_file_path
	current_level_index = levels.find(scene_path)
	$Area3D.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	print("body entered:", body)
	if body.name == "Player":
		var next_level_index = current_level_index + 1
		if next_level_index < levels.size():
			print("Going to:", levels[next_level_index])
			get_tree().change_scene_to_file(levels[next_level_index])
		else:
			get_tree().change_scene_to_file(end_scene)
