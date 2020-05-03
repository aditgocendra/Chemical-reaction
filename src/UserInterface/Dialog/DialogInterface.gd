extends Control


var instance_db = GameDatabase.load_data()#ganti ketika export
var conversation: Array
var indexes: int = 0

var mission_interface = preload("res://src/UserInterface/Mission/MissionInterface.gd").new()
onready var text_dialog = $BackgroundDialog/TextDialog
onready var next_touch = $BackgroundDialog/TouchNextDialog
onready var finish_touch = $BackgroundDialog/TouchFinishDialog
onready var name_label = $BackgroundDialog/BackgroundName/NameLabel
onready var quest_container = $BackgroundDialog/QuestionContainer
onready var craft_container = $BackgroundDialog/CraftingContainerChoice

onready var take_cancel = $BackgroundDialog/TakeOrCancelDialog
onready var take_touch = $BackgroundDialog/TakeOrCancelDialog/TouchTakeButton
onready var scene_tree: SceneTree = get_tree()

func _ready() -> void:
# warning-ignore:return_value_discarded
	GameDatabase.connect("updated_mission", self, "updated_dialog")
# warning-ignore:return_value_discarded
	GameDatabase.connect("update_npc", self, "updated_npc")
	


func _update():
	var text = conversation[indexes].dialog
	
	text_dialog.set_bbcode(text)
	text_dialog.set_visible_characters(0) 
	if check_mission() == false or GameDatabase.npc_name == "Holdin":
		print(text)
		if indexes == conversation.size() - 1:
			if conversation[indexes].npc_name != "Holdin":
				next_touch.hide()
				take_cancel.show()
			else:
				if indexes == conversation.size() - 1:
					craft_container.show()
					text_dialog.hide()
					next_touch.hide()
					take_cancel.show()
					take_touch.hide()
	else:
		next_touch.hide()
		take_cancel.hide()
		finish_touch.show()
	
		

func _on_Timer_timeout() -> void:
	text_dialog.set_visible_characters(text_dialog.get_visible_characters() + 1) 


func _on_TouchNextDialog_pressed() -> void:
	indexes += 1
	if indexes < conversation.size():
		_update()
	elif indexes == conversation.size() - 1 and conversation[indexes].npc_name == "Holdin":
		_update()

func _on_TouchCancelButton_pressed() -> void:
	$".".hide()
	indexes = 0
	if GameDatabase.npc_name != "Holdin":
		take_cancel.hide()
		next_touch.show()
	else:
		take_cancel.hide()
		next_touch.show()
		text_dialog.show()
		craft_container.hide()
		quest_container.hide()
		
	scene_tree.paused = false


func _on_TouchTakeButton_pressed() -> void:
	$".".hide()
	indexes = 0
	take_cancel.hide()
	next_touch.show()
	_update()
	scene_tree.paused = false
	set_mission()
	
	
func set_mission():
	var save_mission = instance_db
	if conversation[indexes].npc_name == "nurdin":
		save_mission["player_mission"] = {
			mission = "mission1"
		}
	else:
		save_mission["player_mission"] = {
			mission = "mission2"
		}
	GameDatabase.save_data(save_mission)
	GameDatabase.json_data = save_mission
	

func check_mission():
	var mission_player  = instance_db["player_mission"]["mission"]
	
	if mission_player != null:
		return true
	else: return false


func _on_TouchFinishDialog_pressed() -> void:
	$".".hide()
	take_cancel.hide()
	next_touch.show()
	_update()
	scene_tree.paused = false


func get_dialog():
	var data
	if	check_mission() == false or GameDatabase.npc_name == "Holdin":
		if GameDatabase.npc_name == "nurdin":
			data = instance_db["talking"]["dialog_prof_nurdin"]
			name_label.text = "Prof Nurdin"
		elif GameDatabase.npc_name == "Holdin":
			data = instance_db["talking"]["dialog_crafter"]
			name_label.text = "Holdin"
		else:
			data = instance_db["talking"]["dialog_prof_yadi"]
			name_label.text = "Yadi"
		indexes = 0
		conversation = data.values()
		
	else:
		data = instance_db["talking"]["end_dialog"]
		conversation = data.values()
		
	_update()



func updated_dialog():
	instance_db = GameDatabase.json_data
	next_touch.show()
	finish_touch.hide()
	get_dialog()
	

func updated_npc():
	#load data dialog
	get_dialog()
	


func _on_TouchChoice1_pressed() -> void:
	var data_question = instance_db["question"]["Pembakaran kayu"]
	craft_container.hide()
	$BackgroundDialog/QuestionContainer/QuestLabel.text = "Pertanyaan : " + data_question.question
	$BackgroundDialog/QuestionContainer/AnswerLabel1.text = "A. " + data_question.choice_answer1
	$BackgroundDialog/QuestionContainer/AnswerLabel2.text = "B. " + data_question.choice_answer2
	quest_container.show()
	


func _on_TouchChoice2_pressed() -> void:
	var data_question = instance_db["question"]["Besi berkarat"]
	craft_container.hide()
	$BackgroundDialog/QuestionContainer/QuestLabel.text = "Pertanyaan : " + data_question.question
	$BackgroundDialog/QuestionContainer/AnswerLabel1.text = "A. " + data_question.choice_answer1
	$BackgroundDialog/QuestionContainer/AnswerLabel2.text = "B. " + data_question.choice_answer2
	quest_container.show()


func _on_TouchChoice3_pressed() -> void:
	var data_question = instance_db["question"]["Proses fotosintesis"]
	craft_container.hide()
	$BackgroundDialog/QuestionContainer/QuestLabel.text = "Pertanyaan : " + data_question.question
	$BackgroundDialog/QuestionContainer/AnswerLabel1.text = "A. " + data_question.choice_answer1
	$BackgroundDialog/QuestionContainer/AnswerLabel2.text = "B. " + data_question.choice_answer2
	quest_container.show()


func _on_TouchTrueAnswer_pressed() -> void:
	quest_container.hide()
	take_cancel.hide()
	text_dialog.show()
	text_dialog.set_bbcode("Selamat kamu berhasil menjawab pertanyaanku, sekarang aku akan membuatkan apa yang kamu inginkan.")
	text_dialog.set_visible_characters(0) 
	finish_touch.show()
