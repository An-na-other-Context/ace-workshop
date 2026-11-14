extends CanvasLayer
## AI-made (Claude, 11.11.2026). Part of ai-assisted/claude/learning/graybox, not part of the game.
## Calm 2D overlays around the 3D workshop: dialogue line, book, assist, settings,
## first-visit onboarding and the "?" tool. Built in code for the graybox — turning
## pieces of it into editor scenes is a good first Godot exercise.

# Loaded by path, because AI-made scripts have no class_name.
const Workshop = preload("res://ai-assisted/claude/learning/graybox/workshop.gd")
const SETTINGS_PATH := "user://ace_settings.cfg"
const CHAPTERS := [
	"1 · Intro: the concept", "2 · Breaking", "3 · Hardware + electronics",
	"4 · CPU, memory, devices", "5 · Firmware", "6 · Kernel", "7 · Services", "8 · Apps", "9 · Review",
]

var workshop: Workshop
var cfg := ConfigFile.new()
var explain_mode := false

var tag_label: Label
var line_label: Label
var back_button: Button
var next_button: Button
var progress_label: Label
var book_panel: PanelContainer
var assist_panel: PanelContainer
var settings_panel: PanelContainer
var help_menu: PanelContainer
var onboarding: ColorRect


func _ready() -> void:
	workshop = get_parent() as Workshop
	cfg.load(SETTINGS_PATH)  # no file yet on the first run; that's fine
	workshop.motion_on = cfg.get_value("settings", "motion", false)
	# Order matters: the top bar's buttons point at the panels, so those come first.
	_build_book()
	_build_assist()
	_build_dialogue()
	_build_settings()
	_build_help_menu()
	_build_top_bar()
	_build_onboarding()
	# The workshop is set up after this overlay (children get ready first),
	# so its first step_changed arrives here.
	workshop.step_changed.connect(_on_step_changed)
	workshop.view_changed.connect(_on_view_changed)
	workshop.object_clicked.connect(_on_object_clicked)
	if not cfg.get_value("onboarding", "seen", false):
		onboarding.show()


# ---------- small builders ----------

func _button(text: String, action: Callable) -> Button:
	var b := Button.new()
	b.text = text
	b.pressed.connect(_on_button.bind(text, action))
	return b


## Every button goes through here, so "explain one thing" can intercept it.
func _on_button(text: String, action: Callable) -> void:
	if explain_mode and text != "?":
		_explain(text)
		return
	action.call()


func _label(text: String, font_px := 16) -> Label:
	var l := Label.new()
	l.text = text
	l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	l.add_theme_font_size_override("font_size", font_px)
	return l


func _panel(min_size: Vector2) -> PanelContainer:
	var p := PanelContainer.new()
	p.custom_minimum_size = min_size
	add_child(p)
	return p


func _vbox(parent: Control, separation := 8) -> VBoxContainer:
	var margin := MarginContainer.new()
	for side in ["left", "right", "top", "bottom"]:
		margin.add_theme_constant_override("margin_" + side, 14)
	parent.add_child(margin)
	var v := VBoxContainer.new()
	v.add_theme_constant_override("separation", separation)
	margin.add_child(v)
	return v


# ---------- overlays ----------

func _build_top_bar() -> void:
	var left := HBoxContainer.new()
	add_child(left)
	left.position = Vector2(12, 12)
	left.add_child(_button("☰ Book", func() -> void: book_panel.visible = not book_panel.visible))

	var right := HBoxContainer.new()
	add_child(right)
	right.add_child(_button("?", func() -> void: help_menu.visible = not help_menu.visible))
	right.add_child(_button("Settings", settings_panel.show))
	right.add_child(_button("Assist", func() -> void: assist_panel.visible = not assist_panel.visible))
	right.add_child(_button("Reset view", workshop.reset_view))
	right.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_MINSIZE, 12)
	right.grow_horizontal = Control.GROW_DIRECTION_BEGIN


func _build_book() -> void:
	book_panel = _panel(Vector2(260, 0))
	book_panel.position = Vector2(12, 60)
	var v := _vbox(book_panel, 4)
	v.add_child(_label("THE BOOK", 12))
	for i in CHAPTERS.size():
		var l := _label(CHAPTERS[i], 15)
		if i > 0:
			l.modulate = Color(1, 1, 1, 0.55)
		v.add_child(l)
	v.add_child(HSeparator.new())
	v.add_child(_label("Depth gauge: at the top, before the dive", 13))
	book_panel.hide()


func _build_assist() -> void:
	assist_panel = _panel(Vector2(280, 0))
	var v := _vbox(assist_panel)
	v.add_child(_label("ASSIST · THIS STEP", 12))
	v.add_child(_label("In the scene", 15))
	for key in ["overview", "pc", "car", "plug", "goal"]:
		v.add_child(_button(Workshop.NAMES[key], workshop.look_at_view.bind(key, true)))
	for title in ["Mine", "Suggested reading", "Sources", "Related"]:
		v.add_child(HSeparator.new())
		v.add_child(_label(title + "  (placeholder)", 14))
	assist_panel.set_anchors_and_offsets_preset(Control.PRESET_CENTER_RIGHT, Control.PRESET_MODE_MINSIZE, 12)
	assist_panel.grow_horizontal = Control.GROW_DIRECTION_BEGIN


func _build_dialogue() -> void:
	var p := _panel(Vector2(760, 0))
	var v := _vbox(p, 6)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 14)
	v.add_child(row)
	var guide := PanelContainer.new()  # placeholder for the 2D guide character
	guide.custom_minimum_size = Vector2(72, 88)
	guide.add_child(_label("guide", 12))
	row.add_child(guide)
	var text := VBoxContainer.new()
	text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(text)
	tag_label = _label("", 13)
	tag_label.modulate = Color(1, 1, 1, 0.65)
	line_label = _label("", 22)
	text.add_child(tag_label)
	text.add_child(line_label)
	var buttons := HBoxContainer.new()
	buttons.alignment = BoxContainer.ALIGNMENT_END
	back_button = _button("Back", func() -> void: workshop.go_to_step(workshop.step - 1))
	next_button = _button("Next →", func() -> void: workshop.go_to_step(workshop.step + 1))
	buttons.add_child(back_button)
	buttons.add_child(next_button)
	text.add_child(buttons)
	progress_label = _label("", 13)
	progress_label.modulate = Color(1, 1, 1, 0.6)
	v.add_child(progress_label)
	p.set_anchors_and_offsets_preset(Control.PRESET_CENTER_BOTTOM, Control.PRESET_MODE_MINSIZE, 24)
	p.grow_horizontal = Control.GROW_DIRECTION_BOTH
	p.grow_vertical = Control.GROW_DIRECTION_BEGIN


func _build_settings() -> void:
	settings_panel = _panel(Vector2(420, 0))
	var v := _vbox(settings_panel)
	v.add_child(_label("Settings", 20))
	var motion := CheckButton.new()
	motion.text = "Motion: camera glides between views"
	motion.button_pressed = workshop.motion_on
	motion.toggled.connect(_on_motion_toggled)
	v.add_child(motion)
	v.add_child(_label("Off: the camera jumps instead. Theme, fonts and symbols come back later.", 14))
	v.add_child(_button("Close", settings_panel.hide))
	settings_panel.set_anchors_and_offsets_preset(Control.PRESET_CENTER, Control.PRESET_MODE_MINSIZE)
	settings_panel.hide()


func _build_help_menu() -> void:
	help_menu = _panel(Vector2(280, 0))
	var v := _vbox(help_menu)
	v.add_child(_button("Replay the whole onboarding", _replay_onboarding))
	v.add_child(_button("Explain one thing — then tap it", _start_explain))
	help_menu.set_anchors_and_offsets_preset(Control.PRESET_TOP_RIGHT, Control.PRESET_MODE_MINSIZE, 12)
	help_menu.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	help_menu.position.y += 50
	help_menu.hide()


func _build_onboarding() -> void:
	onboarding = ColorRect.new()
	onboarding.color = Color(0, 0, 0, 0.35)
	add_child(onboarding)
	onboarding.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var card := PanelContainer.new()
	card.custom_minimum_size = Vector2(520, 0)
	onboarding.add_child(card)
	var v := _vbox(card)
	v.add_child(_label("FIRST VISIT · ONBOARDING PLACEHOLDER", 12))
	v.add_child(_label("How every part gets explored", 22))
	v.add_child(_label("Six questions, asked of every part: who · what · when · where · why · how. The real tour will show each one on the scene and let you try it.", 16))
	var row := HBoxContainer.new()
	row.alignment = BoxContainer.ALIGNMENT_END
	row.add_child(_button("Skip", _close_onboarding))
	row.add_child(_button("Start the tour", _start_tour))
	v.add_child(row)
	v.add_child(_label("You can replay it any time with the ? button.", 13))
	card.set_anchors_and_offsets_preset(Control.PRESET_CENTER, Control.PRESET_MODE_MINSIZE)
	onboarding.hide()


# ---------- reactions ----------

func _on_step_changed(index: int, step: Dictionary) -> void:
	tag_label.text = "%s · looking at %s" % [step["tag"], Workshop.NAMES[step["view"]]]
	line_label.text = step["line"]
	back_button.disabled = index == 0
	var last := index == Workshop.STEPS.size() - 1
	next_button.disabled = last
	next_button.text = "Chapter continues later" if last else "Next →"
	progress_label.text = "Goal: get to know three working machines   ·   step %d of %d" % [index + 1, Workshop.STEPS.size()]


func _on_view_changed(view: String, by_choice: bool) -> void:
	if by_choice:
		tag_label.text = "%s · looking at %s (your choice)" % [Workshop.STEPS[workshop.step]["tag"], Workshop.NAMES[view]]


func _on_object_clicked(view: String) -> void:
	if explain_mode:
		_explain(Workshop.NAMES[view])
	else:
		workshop.look_at_view(view, true)


func _on_motion_toggled(on: bool) -> void:
	workshop.motion_on = on
	cfg.set_value("settings", "motion", on)
	cfg.save(SETTINGS_PATH)


func _replay_onboarding() -> void:
	help_menu.hide()
	onboarding.show()


func _close_onboarding() -> void:
	onboarding.hide()
	cfg.set_value("onboarding", "seen", true)
	cfg.save(SETTINGS_PATH)


func _start_tour() -> void:
	_close_onboarding()
	line_label.text = "(The real tour would start here and walk through who · what · when · where · why · how on the scene.)"


func _start_explain() -> void:
	help_menu.hide()
	explain_mode = true
	tag_label.text = "Explain mode: tap anything to see its onboarding. Esc to stop."


func _explain(thing: String) -> void:
	tag_label.text = "Onboarding for: %s (placeholder) — what it is, why it's here, how to use it." % thing


func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_cancel"):
		return
	if explain_mode:
		explain_mode = false
		_on_step_changed(workshop.step, Workshop.STEPS[workshop.step])
	elif help_menu.visible:
		help_menu.hide()
	elif settings_panel.visible:
		settings_panel.hide()
	elif onboarding.visible:
		_close_onboarding()
	else:
		return
	get_viewport().set_input_as_handled()
