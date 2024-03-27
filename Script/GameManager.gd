extends Node

@onready var supermom: CharacterBody2D = $"../Supermom" as Mom
@onready var pipe_spawner: Node = $"../PipeSpawner" as PipeSpawner
@onready var ground: Node2D = $"../Ground" as Ground
@onready var fade: Node = $"../Fade" as Fade
@onready var ui: CanvasLayer = $"../UI" as UI

const SAVE_FILE_PATH = "user://savedata.save"

var score = 0
var highscore = 0

func _ready() -> void:
	supermom.game_started.connect(on_game_started)
	ground.mom_crashed.connect(end_game)
	pipe_spawner.mom_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored)
	load_highscore()


func on_game_started():
	ui.on_game_ready()
	ui.on_game_start()
	pipe_spawner.start_spawning_pipes()

func end_game():
	if fade  != null:
		fade.play()
	ground.stop()
	supermom.kill()
	pipe_spawner.stop()
	
	if score > highscore:
		highscore = score
		save_highscore()
	
	ui.on_game_over(score, highscore)

func on_point_scored():
	score += 1
	ui.update_points(score)

func set_score(new_score):
	score = new_score
	ui.on_game_over(score)

func save_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE_READ)
	save_data.store_32(highscore)

func load_highscore():
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_FILE_PATH):
		highscore = save_data.get_32()
