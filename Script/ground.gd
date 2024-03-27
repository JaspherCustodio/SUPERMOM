extends Node2D

class_name  Ground

signal mom_crashed

@export var speed: int = -150

@onready var sprite1: Sprite2D = $Area2D/Sprite2D
@onready var sprite2: Sprite2D = $Area2D2/Sprite2D

func  _ready() -> void:
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()

func  _process(delta: float) -> void:
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta
	
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()

func _on_body_entered(body: Node2D) -> void:
	mom_crashed.emit()
	stop()
	(body as Mom).stop()

func stop():
	speed = 0
