extends CanvasLayer

class_name UI

@onready var points_label: Label = $MarginContainer/PointsLabel
@onready var game_over_box: VBoxContainer = $GameOverBox
@onready var game_ready: VBoxContainer = $GameReady
@onready var high_score_label: Label = $GameOverBox/HighScoreLabel
@onready var score_label: Label = $GameOverBox/ScoreLabel

func _ready() -> void:
	points_label.text ="%d" % 0

func on_game_ready():
	game_ready.visible = false

func on_game_start():
	points_label.visible = true

func update_points(points: int):
	points_label.text = "%d" % points

func on_game_over(score, highscore):
	score_label.text = "SCORE: %d" % score
	high_score_label.text = "BEST: %d" % highscore
	game_over_box.visible = true
	$GameOverBox/Panel/Restart.grab_focus()

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()
