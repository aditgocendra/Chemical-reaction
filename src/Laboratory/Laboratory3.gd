extends Node2D


func _ready() -> void:
	var data = GameDatabase.load_data()
	var sound_music = data["game_setting"]["sound_music"]
	
	if sound_music.checked == false:
		$SoundtrackLab3.playing = false
	else:
		$SoundtrackLab3.volume_db = sound_music.vol
		$SoundtrackLab3.play()
