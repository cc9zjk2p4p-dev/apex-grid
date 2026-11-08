extends Control
class_name ApexRaceView

signal lap_completed(lap_number: int)

var running := false
var elapsed := 0.0
var lap_number := 1
var race_laps := 8
var player_progress := 0.0
var rival_progress := [0.10, 0.34, 0.57, 0.78]
var player_speed := 0.115

const TRACK := Color("#536574")
const PLAYER := Color("#ef514b")
const RIVALS := [Color("#55c6e8"), Color("#f2bd59"), Color("#9b83e8"), Color("#65c994")]

func start_race() -> void:
	running = true
	elapsed = 0.0
	lap_number = 1
	player_progress = 0.0
	rival_progress = [0.10, 0.34, 0.57, 0.78]
	queue_redraw()

func pause_race() -> void:
	running = false
	queue_redraw()

func _process(delta: float) -> void:
	if not running:
		return
	elapsed += delta
	player_progress = fposmod(player_progress + delta * player_speed, 1.0)
	for i in range(rival_progress.size()):
		rival_progress[i] = fposmod(rival_progress[i] + delta * (player_speed * (0.91 + float(i) * 0.035)), 1.0)
	if elapsed >= 7.5:
		elapsed = 0.0
		lap_number += 1
		lap_completed.emit(lap_number - 1)
		if lap_number > race_laps:
			running = false
	queue_redraw()

func _draw() -> void:
	var size := get_size()
	var center := size * 0.5
	var rx := maxf(90.0, size.x * 0.34)
	var ry := maxf(65.0, size.y * 0.29)
	var outer := PackedVector2Array()
	var inner := PackedVector2Array()
	for i in range(97):
		var a := TAU * float(i) / 96.0
		outer.append(center + Vector2(cos(a) * (rx + 28.0), sin(a) * (ry + 28.0)))
		inner.append(center + Vector2(cos(a) * (rx - 28.0), sin(a) * (ry - 28.0)))
	draw_colored_polygon(outer, Color("#253541"))
	draw_colored_polygon(inner, Color("#15232c"))
	draw_polyline(outer, Color("#a6b5bd"), 2.0, true)
	draw_polyline(inner, Color("#a6b5bd"), 2.0, true)
	for i in range(24):
		var a := TAU * float(i) / 24.0
		var p := center + Vector2(cos(a) * rx, sin(a) * ry)
		draw_circle(p, 2.0, Color("#71828d"))
	# Start/finish marker.
	var finish := center + Vector2(0, -ry)
	draw_line(finish + Vector2(-26, 0), finish + Vector2(26, 0), Color.WHITE, 4.0)
	# Rivals.
	for i in range(rival_progress.size()):
		_draw_car(center, rx, ry, rival_progress[i], RIVALS[i], 10.0)
	_draw_car(center, rx, ry, player_progress, PLAYER, 14.0)
	draw_string(ThemeDB.fallback_font, Vector2(18, 28), "APEX CIRCUIT  /  LIVE SESSION", HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("#b7c7d1"))
	var state_text := "GREEN FLAG" if running else "SESSION READY"
	draw_string(ThemeDB.fallback_font, Vector2(18, 50), state_text, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color("#70d8a7"))

func _draw_car(center: Vector2, rx: float, ry: float, progress: float, paint: Color, car_width: float) -> void:
	var angle := progress * TAU - PI * 0.5
	var position := center + Vector2(cos(angle) * rx, sin(angle) * ry)
	draw_set_transform(position, angle + PI * 0.5)
	draw_rect(Rect2(Vector2(-car_width, -5.0), Vector2(car_width * 2.0, 10.0)), paint)
	draw_rect(Rect2(Vector2(-4.0, -3.0), Vector2(8.0, 6.0)), Color("#dce5e9"))
	draw_rect(Rect2(Vector2(-car_width * 0.65, -7.0), Vector2(5.0, 14.0)), Color("#111820"))
	draw_rect(Rect2(Vector2(car_width * 0.35, -7.0), Vector2(5.0, 14.0)), Color("#111820"))
	draw_set_transform(Vector2.ZERO, 0.0)
