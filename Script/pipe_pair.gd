extends Node2D

class_name PipePair

signal mom_entered
signal  mom_scored

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed: int = 0

func set_speed(new_speed):
	speed = new_speed

func _process(delta: float) -> void:
	position.x += speed * delta

func _on_body_entered(_body):
	mom_entered.emit()

func _on_mom_scored(_body):
	audio_stream_player_2d.play()
	mom_scored.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
