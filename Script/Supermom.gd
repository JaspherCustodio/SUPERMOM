extends CharacterBody2D

class_name Mom

signal game_started

@export var gravity: float = 900.0
@export var jump_force: int = 300
@export var rotation_speed: int = 2

@onready var animation_player = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var max_speed: int = 400
var is_started: bool = false
var should_process_input: bool = true

func _ready() -> void:
	velocity = Vector2.ZERO
	animation_player.play("idle")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started:
			game_started.emit()
			animation_player.play("fly")
			is_started = true
		jump()
	
	if !is_started:
		return
	velocity.y += gravity * delta
	
	velocity.y = min(velocity.y, max_speed)
	
	move_and_collide(velocity * delta)
	
	rotate_mom()

func jump():
	velocity.y = -jump_force
	rotation = deg_to_rad(-30)
	audio_stream_player_2d.play()

func rotate_mom():
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)

func kill():
	$Yeet.visible = true
	animation_player.play("knocked_out")
	should_process_input = false

func stop():
	gravity = 0
	velocity = Vector2.ZERO
