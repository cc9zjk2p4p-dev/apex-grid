extends Control

const RaceViewScript = preload("res://scripts/race_view.gd")
const SAVE_PATH := "user://apex_grid_career.cfg"

var credits := 2500
var engine_level := 1
var aero_level := 1
var handling_level := 1
var selected_tab := "garage"
var content: VBoxContainer
var credits_label: Label
var status_label: Label
var race_view: Control
var race_status: Label
var race_lap := 1

const BG := Color("#0b121a")
const PANEL := Color("#14212c")
const LINE := Color("#2b3d4b")
const TEXT := Color("#f2f5f7")
const MUTED := Color("#9aabb7")
const RED := Color("#ef514b")
const GREEN := Color("#69d5a1")

func _ready() -> void:
	_load_career()
	_build_shell()
	_show_garage()

func _build_shell() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.color = BG
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	var root := VBoxContainer.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_theme_constant_override("separation", 0)
	add_child(root)
	var header := HBoxContainer.new()
	header.custom_minimum_size.y = 76
	header.add_theme_constant_override("separation", 14)
	header.add_theme_constant_override("margin_left", 24)
	header.add_theme_constant_override("margin_right", 24)
	header.add_theme_constant_override("margin_top", 12)
	header.add_theme_constant_override("margin_bottom", 8)
	root.add_child(header)
	var brand := Label.new()
	brand.text = "APEX  GRID"
	brand.add_theme_font_size_override("font_size", 27)
	brand.add_theme_color_override("font_color", TEXT)
	header.add_child(brand)
	var subtitle := Label.new()
	subtitle.text = "  MOTORSPORT MANAGEMENT"
	subtitle.add_theme_font_size_override("font_size", 10)
	subtitle.add_theme_color_override("font_color", MUTED)
	subtitle.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	header.add_child(subtitle)
	var spacer := Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header.add_child(spacer)
	credits_label = Label.new()
	credits_label.add_theme_font_size_override("font_size", 16)
	credits_label.add_theme_color_override("font_color", Color("#f2bd59"))
	header.add_child(credits_label)
	_update_credits()
	var divider := ColorRect.new()
	divider.color = LINE
	divider.custom_minimum_size.y = 1
	root.add_child(divider)
	var nav := HBoxContainer.new()
	nav.custom_minimum_size.y = 54
	nav.add_theme_constant_override("separation", 8)
	nav.add_theme_constant_override("margin_left", 20)
	nav.add_theme_constant_override("margin_top", 8)
	nav.add_theme_constant_override("margin_bottom", 8)
	root.add_child(nav)
	_add_nav_button(nav, "GARAGE", _show_garage)
	_add_nav_button(nav, "RACE WEEKEND", _show_race)
	_add_nav_button(nav, "CHAMPIONSHIP", _show_championship)
	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	root.add_child(scroll)
	content = VBoxContainer.new()
	content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content.add_theme_constant_override("separation", 14)
	content.add_theme_constant_override("margin_left", 22)
	content.add_theme_constant_override("margin_right", 22)
	content.add_theme_constant_override("margin_top", 18)
	content.add_theme_constant_override("margin_bottom", 24)
	scroll.add_child(content)
	status_label = Label.new()
	status_label.custom_minimum_size.y = 34
	status_label.add_theme_color_override("font_color", GREEN)
	status_label.add_theme_font_size_override("font_size", 12)
	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	root.add_child(status_label)

func _add_nav_button(parent: HBoxContainer, title: String, action: Callable) -> void:
	var button := Button.new()
	button.text = title
	button.custom_minimum_size = Vector2(138, 38)
	button.add_theme_font_size_override("font_size", 12)
	button.pressed.connect(action)
	_style_button(button, false)
	parent.add_child(button)

func _clear_content() -> void:
	for child in content.get_children():
		child.queue_free()
	race_view = null

func _heading(kicker: String, title: String, description: String) -> void:
	var tag := Label.new()
	tag.text = kicker
	tag.add_theme_font_size_override("font_size", 11)
	tag.add_theme_color_override("font_color", RED)
	content.add_child(tag)
	var title_label := Label.new()
	title_label.text = title
	title_label.add_theme_font_size_override("font_size", 30)
	title_label.add_theme_color_override("font_color", TEXT)
	content.add_child(title_label)
	var detail := Label.new()
	detail.text = description
	detail.add_theme_font_size_override("font_size", 13)
	detail.add_theme_color_override("font_color", MUTED)
	detail.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	content.add_child(detail)

func _card(title: String, description: String) -> VBoxContainer:
	var panel := PanelContainer.new()
	var style := StyleBoxFlat.new()
	style.bg_color = PANEL
	style.border_color = LINE
	style.set_border_width_all(1)
	style.set_corner_radius_all(10)
	style.content_margin_left = 16
	style.content_margin_right = 16
	style.content_margin_top = 14
	style.content_margin_bottom = 14
	panel.add_theme_stylebox_override("panel", style)
	content.add_child(panel)
	var body := VBoxContainer.new()
	body.add_theme_constant_override("separation", 7)
	panel.add_child(body)
	var name := Label.new()
	name.text = title
	name.add_theme_font_size_override("font_size", 17)
	name.add_theme_color_override("font_color", TEXT)
	body.add_child(name)
	var detail := Label.new()
	detail.text = description
	detail.add_theme_font_size_override("font_size", 12)
	detail.add_theme_color_override("font_color", MUTED)
	detail.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	body.add_child(detail)
	return body

func _make_button(title: String, action: Callable, parent: Control, primary := false) -> Button:
	var button := Button.new()
	button.text = title
	button.custom_minimum_size = Vector2(160, 42)
	button.add_theme_font_size_override("font_size", 12)
	_style_button(button, primary)
	button.pressed.connect(action)
	parent.add_child(button)
	return button

func _style_button(button: Button, primary: bool) -> void:
	var normal := StyleBoxFlat.new()
	normal.bg_color = RED if primary else Color("#20313e")
	normal.set_corner_radius_all(7)
	normal.content_margin_left = 14
	normal.content_margin_right = 14
	normal.content_margin_top = 8
	normal.content_margin_bottom = 8
	button.add_theme_stylebox_override("normal", normal)
	var hover := normal.duplicate()
	hover.bg_color = Color("#ff6b61") if primary else Color("#2d4352")
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_color_override("font_color", Color.WHITE)

func _show_garage() -> void:
	selected_tab = "garage"
	_clear_content()
	_heading("TEAM OPERATIONS  /  SEASON 01", "Your garage", "Build a faster car, invest in your team, and prepare for the next race weekend.")
	var overview := _card("APEX GP  ·  CONSTRUCTOR PROFILE", "A new independent team with one goal: fight for the championship.")
	_add_stat_line(overview, "Car development", "Engine  Lv.%d     Aero  Lv.%d     Handling  Lv.%d" % [engine_level, aero_level, handling_level])
	_add_stat_line(overview, "Team resources", "%d credits available" % credits)
	_add_stat_line(overview, "Next event", "Apex Circuit  ·  8 laps  ·  Dry forecast")
	var car := _card("CAR DEVELOPMENT", "Upgrade a performance area to improve your race package.")
	_add_upgrade(car, "Power unit", engine_level, 450, "engine")
	_add_upgrade(car, "Aerodynamics", aero_level, 400, "aero")
	_add_upgrade(car, "Handling", handling_level, 350, "handling")
	var next := _card("NEXT STEP", "The Godot foundation is in place. Championship systems and career migration will arrive in later milestones.")
	_make_button("OPEN RACE WEEKEND", _show_race, next, true)
	status_label.text = "GARAGE READY  ·  CAREER SAVED LOCALLY"

func _add_stat_line(parent: VBoxContainer, label_text: String, value: String) -> void:
	var line := HBoxContainer.new()
	parent.add_child(line)
	var left := Label.new()
	left.text = label_text
	left.add_theme_color_override("font_color", MUTED)
	left.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	line.add_child(left)
	var right := Label.new()
	right.text = value
	right.add_theme_color_override("font_color", TEXT)
	line.add_child(right)

func _add_upgrade(parent: VBoxContainer, title: String, level: int, base_cost: int, key: String) -> void:
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)
	parent.add_child(row)
	var label := Label.new()
	label.text = "%s  ·  LEVEL %d" % [title, level]
	label.add_theme_color_override("font_color", TEXT)
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(label)
	var cost := base_cost * level
	var button := Button.new()
	button.text = "UPGRADE  ·  %d CR" % cost
	button.custom_minimum_size = Vector2(154, 38)
	_style_button(button, false)
	button.pressed.connect(_buy_upgrade.bind(key, cost))
	row.add_child(button)

func _buy_upgrade(key: String, cost: int) -> void:
	if credits < cost:
		status_label.text = "NOT ENOUGH CREDITS  ·  FINISH A RACE TO EARN MORE"
		return
	credits -= cost
	match key:
		"engine": engine_level += 1
		"aero": aero_level += 1
		"handling": handling_level += 1
	_save_career()
	_update_credits()
	_show_garage()
	status_label.text = "DEVELOPMENT COMPLETE  ·  %s UPGRADED" % key.to_upper()

func _show_race() -> void:
	selected_tab = "race"
	_clear_content()
	_heading("RACE CONTROL  /  ROUND 01 OF 08", "Apex Circuit", "Eight-lap test session. Watch the gaps, manage the pace, and bring the car home.")
	var info := _card("SESSION BRIEFING", "Track: Apex Circuit     Conditions: Dry     Tyre: Medium\nRace distance: 8 laps     Starting position: P5")
	race_status = Label.new()
	race_status.text = "SESSION READY  ·  WAITING FOR LIGHTS"
	race_status.add_theme_color_override("font_color", GREEN)
	race_status.add_theme_font_size_override("font_size", 12)
	info.add_child(race_status)
	race_view = RaceViewScript.new()
	race_view.custom_minimum_size = Vector2(0, 330)
	race_view.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	race_view.lap_completed.connect(_on_lap_completed)
	content.add_child(race_view)
	var controls := HBoxContainer.new()
	controls.add_theme_constant_override("separation", 10)
	content.add_child(controls)
	_make_button("START RACE", _start_race, controls, true)
	_make_button("PAUSE SESSION", _pause_race, controls)
	status_label.text = "RACE CONTROL READY  ·  LIVE TIMING PROTOTYPE"

func _start_race() -> void:
	if race_view:
		race_view.start_race()
		race_status.text = "GREEN FLAG  ·  LAP 1 / 8"

func _pause_race() -> void:
	if race_view:
		race_view.pause_race()
		race_status.text = "SESSION PAUSED"

func _on_lap_completed(completed_lap: int) -> void:
	if race_status:
		race_status.text = "GREEN FLAG  ·  LAP %d / 8" % mini(completed_lap + 1, 8)
		if completed_lap >= 8:
			credits += 300
			_update_credits()
			_save_career()
			race_status.text = "CHEQUERED FLAG  ·  +300 CREDITS"
			status_label.text = "SESSION COMPLETE  ·  CAREER REWARD SAVED"

func _show_championship() -> void:
	selected_tab = "championship"
	_clear_content()
	_heading("CHAMPIONSHIP  /  SEASON 01", "The road to the title", "The eight-round championship will be migrated into the native career layer in the next milestone.")
	var standings := _card("CONSTRUCTORS' STANDINGS", "01  Apex GP                         0 pts\n02  Northstar Motorsport      0 pts\n03  Vortex Racing                  0 pts\n04  Meridian Autosport         0 pts")
	_add_stat_line(standings, "Season progress", "Round 1 of 8")
	_add_stat_line(standings, "Career archive", "Migration planned")
	_make_button("BACK TO GARAGE", _show_garage, standings)

func _update_credits() -> void:
	if credits_label:
		credits_label.text = "%d CR" % credits

func _save_career() -> void:
	var config := ConfigFile.new()
	config.set_value("career", "credits", credits)
	config.set_value("car", "engine_level", engine_level)
	config.set_value("car", "aero_level", aero_level)
	config.set_value("car", "handling_level", handling_level)
	config.save(SAVE_PATH)

func _load_career() -> void:
	var config := ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		credits = int(config.get_value("career", "credits", credits))
		engine_level = int(config.get_value("car", "engine_level", engine_level))
		aero_level = int(config.get_value("car", "aero_level", aero_level))
		handling_level = int(config.get_value("car", "handling_level", handling_level))
