extends Node3D

@onready var window_title = get_window().title


func _process(_delta):
	get_window().title = window_title + " | FPS: " + str(Engine.get_frames_per_second())

func _input(ev: InputEvent) -> void:
	if ev is InputEventKey:
		if ev.pressed and not ev.echo:
			match ev.keycode:
				KEY_1:
					get_tree().change_scene_to_file("res://scenes/main.tscn")
				KEY_2:
					get_tree().change_scene_to_file("res://scenes/main_skinned.tscn")
