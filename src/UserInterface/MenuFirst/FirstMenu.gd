extends Control

var player_scene
onready var settings_scene = preload("res://src/UserInterface/Setting/Settings.tscn").instance()
onready var setting_layer = $SettingsLayer


func _ready() -> void:
	var data = GameDatabase.load_data()
	player_scene = data["player_init"]["scene"]
	
	var sound_music = data["game_setting"]["sound_music"]
	if sound_music.checked == false:
		$AudioFirstMenu.playing = false
	else:
		$AudioFirstMenu.play()
		$AudioFirstMenu.volume_db = sound_music.vol
		
		
func _on_PlayTouchscreen_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(player_scene)
	
	
func _get_configuration_warning() -> String:
	return "Property Empty" if player_scene == "" else ""


func _on_QuitTouchscreen_pressed() -> void:
	get_tree().quit()


func _on_SettingTouchscreen_pressed() -> void:
	get_tree().paused = true
	setting_layer.add_child(settings_scene)
