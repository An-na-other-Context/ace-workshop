extends Node3D
## AI-made (Claude, 11.11.2026). Part of ai-assisted/claude/learning/graybox, not part of the game.
## No class_name, by the rule for AI-made scripts: overlays.gd loads this script by its path.
## The gray workshop: one fixed camera view per dialogue step, plus optional turning
## of the object in focus. Graybox only — shapes, placement and flow, no real content.

signal step_changed(index: int, step: Dictionary)
signal view_changed(view: String, by_choice: bool)
signal object_clicked(view: String)

## Where the camera stands and what it looks at, per view.
const VIEWS := {
	"overview": {"pos": Vector3(0, 1.95, 2.7), "target": Vector3(0, 0.85, 0)},
	"pc": {"pos": Vector3(-1.1, 1.2, 1.05), "target": Vector3(-1.1, 1.0, 0)},
	"car": {"pos": Vector3(-0.35, 1.0, 0.75), "target": Vector3(-0.35, 0.87, 0)},
	"plug": {"pos": Vector3(0.25, 0.95, 0.55), "target": Vector3(0.25, 0.83, 0)},
	"goal": {"pos": Vector3(1.05, 1.55, 1.05), "target": Vector3(1.05, 0.98, 0)},
}

const NAMES := {
	"overview": "the whole desk",
	"pc": "self-built PC",
	"car": "car unit",
	"plug": "smart plug",
	"goal": "goal lab · your mini ACE OS",
}

## Placeholder story: one look per step.
const STEPS := [
	{"view": "overview", "tag": "1a · step 1", "line": "This is your workshop. Three machines sit on the desk."},
	{"view": "pc", "tag": "1a · step 2", "line": "A computer someone built from parts. (placeholder line)"},
	{"view": "car", "tag": "1a · step 3", "line": "The unit from an older car's dashboard. (placeholder line)"},
	{"view": "plug", "tag": "1a · step 4", "line": "A smart plug, small enough to hold. (placeholder line)"},
	{"view": "goal", "tag": "1a · step 5", "line": "And here, your own mini ACE OS — six empty layers, waiting."},
	{"view": "overview", "tag": "1a · step 6", "line": "Everything you'll need is on this desk. (placeholder line)"},
]

## Camera glide time in seconds when motion is on. With motion off the camera jumps.
@export var glide_seconds := 0.6
## Set by the settings overlay; off by default.
var motion_on := false

var step := 0
var current_view := "overview"

@onready var camera: Camera3D = $Camera
@onready var pointer: Label3D = $Pointer
@onready var objects := {"pc": $PC, "car": $CarUnit, "plug": $Plug, "goal": $GoalLab}

var _cam_target := Vector3.ZERO
var _from_pos := Vector3.ZERO
var _from_target := Vector3.ZERO
var _to_pos := Vector3.ZERO
var _to_target := Vector3.ZERO
var _tween: Tween
var _press_pos := Vector2.ZERO
var _dragging := false


func _ready() -> void:
	var start: Dictionary = VIEWS["overview"]
	_place_camera(start["pos"], start["target"])
	go_to_step(0)


## Moves the story to a step; the camera follows that step's view.
func go_to_step(index: int) -> void:
	step = clampi(index, 0, STEPS.size() - 1)
	var s: Dictionary = STEPS[step]
	look_at_view(s["view"], false)
	step_changed.emit(step, s)


## Looks at one view. by_choice = true when the learner picked it, not the story.
func look_at_view(view: String, by_choice := true) -> void:
	current_view = view
	var v: Dictionary = VIEWS[view]
	_update_pointer()
	if motion_on:
		_glide(v["pos"], v["target"])
	else:
		_place_camera(v["pos"], v["target"])
	view_changed.emit(view, by_choice)


## Puts every object back to its normal angle and the camera back to the current view.
func reset_view() -> void:
	for obj in objects.values():
		(obj as Node3D).rotation = Vector3.ZERO
	var v: Dictionary = VIEWS[current_view]
	_place_camera(v["pos"], v["target"])


## The object the camera is looking at right now, or null in the overview.
func focus_object() -> Node3D:
	return objects.get(current_view) as Node3D


func _place_camera(pos: Vector3, target: Vector3) -> void:
	if _tween and _tween.is_valid():
		_tween.kill()
	camera.position = pos
	_cam_target = target
	camera.look_at(target, Vector3.UP)


func _glide(pos: Vector3, target: Vector3) -> void:
	if _tween and _tween.is_valid():
		_tween.kill()
	_from_pos = camera.position
	_from_target = _cam_target
	_to_pos = pos
	_to_target = target
	_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	_tween.tween_method(_glide_step, 0.0, 1.0, glide_seconds)


func _glide_step(t: float) -> void:
	camera.position = _from_pos.lerp(_to_pos, t)
	_cam_target = _from_target.lerp(_to_target, t)
	camera.look_at(_cam_target, Vector3.UP)


## The pointer (a camera-facing "▼") sits above the object in focus.
func _update_pointer() -> void:
	var obj := focus_object()
	pointer.visible = obj != null and current_view != "goal"
	if pointer.visible:
		var label := obj.get_node("Label") as Node3D
		pointer.global_position = label.global_position + Vector3(0, 0.07, 0)


## Click = look at an object. Drag (or arrow keys) = turn the object in focus.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_press_pos = event.position
			_dragging = false
		elif not _dragging:
			_pick(event.position)
	elif event is InputEventMouseMotion and (event.button_mask & MOUSE_BUTTON_MASK_LEFT) != 0:
		if event.position.distance_to(_press_pos) > 4.0:
			_dragging = true
		if _dragging:
			_turn(event.relative.x * 0.01, event.relative.y * 0.01)
	elif event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_LEFT:
				_turn(-0.15, 0.0)
			KEY_RIGHT:
				_turn(0.15, 0.0)
			KEY_UP:
				_turn(0.0, -0.1)
			KEY_DOWN:
				_turn(0.0, 0.1)


func _turn(dx: float, dy: float) -> void:
	var obj := focus_object()
	if obj == null:
		return
	obj.rotation.y += dx
	obj.rotation.x = clampf(obj.rotation.x + dy, -0.6, 0.6)
	get_viewport().set_input_as_handled()


## Finds the object nearest the click on screen (no physics needed).
func _pick(screen_pos: Vector2) -> void:
	var best := ""
	var best_dist := 90.0
	for key in objects:
		var obj := objects[key] as Node3D
		var points := [obj.global_position, (obj.get_node("Label") as Node3D).global_position]
		for p in points:
			if camera.is_position_behind(p):
				continue
			var d := camera.unproject_position(p).distance_to(screen_pos)
			if d < best_dist:
				best_dist = d
				best = key
	if best != "":
		object_clicked.emit(best)
