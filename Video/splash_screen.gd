extends Node

func  _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func go_title_screen():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_video_stream_player_finished() -> void:
	go_title_screen()
