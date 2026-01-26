extends Control

@export var _move_to: PackedScene

@export var _initial_delay: float = 1

var _splash_screens: Array[SplashScreen] = []

# Assuming SplashScreenManager is the parent node
@onready var _splash_screen_manager: Control = self

func _ready() -> void:
	assert(_move_to)

	set_process_input(false)

	# Collect all splash screens added as children of SplashScreenManager
	for splash_screen in _splash_screen_manager.get_children():
		if splash_screen is SplashScreen:
			splash_screen.hide()
			_splash_screens.push_back(splash_screen)

	await get_tree().create_timer(_initial_delay).timeout

	_start_splash_screen()

	set_process_input(true)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_skip"):
		_skip()


func _start_splash_screen() -> void:
	if _splash_screens.size() == 0:
		get_tree().change_scene_to_packed(_move_to)
	else:
		var splash_screen: SplashScreen = _splash_screens.pop_front()
		splash_screen.start()
		splash_screen.connect("finished", _start_splash_screen)


func _skip() -> void:
	if _splash_screens.size() > 0:
		_splash_screens.pop_front().queue_free()
	_start_splash_screen()
