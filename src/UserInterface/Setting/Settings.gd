extends Control

onready var sound_fx = $MainSettings/SoundSettings/VBoxContainer/ContainerSoundFX/HSlider
onready var sound_music = $MainSettings/SoundSettings/VBoxContainer/ContainerSoundMusic/HSlider
onready var sound_fx_check = $MainSettings/SoundSettings/VBoxContainer/ContainerSoundFX/CheckBox
onready var sound_music_check = $MainSettings/SoundSettings/VBoxContainer/ContainerSoundMusic/CheckBox

var data = GameDatabase.load_data()

func _ready() -> void:
	setSound()


func _on_TouchExit_pressed() -> void:
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()


func _on_TouchApply_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().paused = false
	update_sound()
	get_tree().reload_current_scene()
	

func setSound()-> void:
	var sound_data = data["game_setting"]
	sound_fx.value = sound_data["sound_fx"]["vol"]
	sound_music.value = sound_data["sound_music"]["vol"]
	sound_fx_check.pressed = sound_data["sound_fx"]["checked"]
	sound_music_check.pressed = sound_data["sound_music"]["checked"]


func update_sound() -> void:
	var data_game = data
	var new_sound_fx = data_game["game_setting"]["sound_fx"]
	var new_sound_music = data_game["game_setting"]["sound_music"]
	
	new_sound_fx = {
		vol = sound_fx.value,
		checked = sound_fx_check.pressed
	}
	
	new_sound_music = {
		vol = sound_music.value,
		checked = sound_music_check.pressed
	}
	
	data_game["game_setting"] = {
		sound_fx = new_sound_fx,
		sound_music = new_sound_music
	}
	
	GameDatabase.save_data(data_game)
	sound_fx_check.pressed = new_sound_fx.checked
	sound_music_check.pressed = new_sound_music.checked
