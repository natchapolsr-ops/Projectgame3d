extends Node3D

@export var target: Node

@export var zoom_minimum := 16
@export var zoom_maximum := 4
@export var zoom_speed := 10

@export var rotation_speed := 120

var camera_rotation: Vector3
var zoom := 10

@onready var camera = $Camera

func _ready():
	camera_rotation = rotation_degrees
	if not target:
		target = get_tree().get_root().find_node("Player", true, false) # <-- ตัวนี้

func _physics_process(delta):
	if target:
		self.position = self.position.lerp(target.position, delta * 4)
	rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)
	camera.position = camera.position.lerp(Vector3(0, 0, zoom), 8 * delta)
	handle_input(delta)

func handle_input(delta):
	var input := Vector3.ZERO
	input.y = Input.get_axis("camera_left", "camera_right")
	input.x = Input.get_axis("camera_up", "camera_down")
	camera_rotation += input.limit_length(1.0) * rotation_speed * delta
	camera_rotation.x = clamp(camera_rotation.x, -80, -10)
	zoom += Input.get_axis("zoom_in", "zoom_out") * zoom_speed * delta
	zoom = clamp(zoom, zoom_maximum, zoom_minimum)
