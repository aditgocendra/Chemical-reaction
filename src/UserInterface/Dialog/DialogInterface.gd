extends Control


var instance_db = GameDatabase.load_data()#ganti ketika export
var conversation: Array
var indexes: int = 0
var mission_player: String


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
	var mission_  = instance_db["player_mission"]["mission"]
	if GameDatabase.npc_name == "nurdin":
		if instance_db["mission_finish"]["mission1"].mission == false:
			if mission_ != null:
				return true
			else: return false
		else : return true
	elif GameDatabase.npc_name == "yadi":
		if instance_db["mission_finish"]["mission2"].mission == false:
			if mission_ != null:
				return true
			else: return false
		else : return true


func _on_TouchFinishDialog_pressed() -> void:
	$".".hide()
	indexes = 0
	if GameDatabase.npc_name != "Holdin":
		take_cancel.hide()
		next_touch.show()
	else:
		take_cancel.hide()
		next_touch.show()
		text_dialog.show()
		finish_touch.hide()
		craft_container.hide()
		quest_container.hide()
		
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
			name_label.text = "Prof Yadi"
		indexes = 0
		conversation = data.values()
		
	else:
		var mission1 = instance_db["mission_finish"]["mission1"].mission
		var mission2 = instance_db["mission_finish"]["mission2"].mission
		
		if GameDatabase.npc_name == "nurdin" and  mission1 == true:
			data = instance_db["talking"]["finish_dialog"]
			conversation = data.values()
		elif GameDatabase.npc_name == "yadi" and  mission2 == true:
			print(GameDatabase.npc_name, mission2)
			data = instance_db["talking"]["finish_dialog"]
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
	var data_mission = instance_db["mission_finish"]["mission1"]
	var data_question = instance_db["question"]["Pembakaran kayu"]
	mission_player = "mission1"
	checkMissionFinish(data_mission.mission, data_question)
	


func _on_TouchChoice2_pressed() -> void:
	var data_mission = instance_db["mission_finish"]["mission2"]
	var data_question = instance_db["question"]["Besi berkarat"]
	mission_player = "mission2"
	checkMissionFinish(data_mission.mission, data_question)
	


func _on_TouchChoice3_pressed() -> void:
	var data_mission = instance_db["mission_finish"]["mission3"]
	var data_question = instance_db["question"]["Proses fotosintesis"]
	mission_player = "mission3"
	checkMissionFinish(data_mission.mission, data_question)
	


func checkMissionFinish(_mission, data_question) -> void:
	var data_player_mission = instance_db["player_mission"]["mission"]
	craft_container.hide()
	if _mission == false and mission_player == data_player_mission:
		$BackgroundDialog/QuestionContainer/QuestLabel.text = "Pertanyaan : " + data_question.question
		$BackgroundDialog/QuestionContainer/AnswerLabel1.text = "A. " + data_question.choice_answer1
		$BackgroundDialog/QuestionContainer/AnswerLabel2.text = "B. " + data_question.choice_answer2
		quest_container.show()
	else:
		text_dialog.show()
		text_dialog.set_bbcode("Sepertinya kamu sedang tidak menjalankan misi ini atau sudah menyelesaikan misi ini.... kembali lagi lain hari.")
		text_dialog.set_visible_characters(0)
		take_cancel.hide()
		finish_touch.show()


func _on_TouchTrueAnswer_pressed() -> void:
	var data_finish_mission = instance_db
	quest_container.hide()
	take_cancel.hide()
	
	if checkItemMaterial() == true:
		$AnimationPlayer.play("play_craft")
		
		data_finish_mission["mission_finish"][mission_player] = {
			mission = true
		}	
		
		data_finish_mission["player_mission"] = {
			mission = null
		}
		
		if mission_player == "mission1":
			data_finish_mission["item_inventory"]["item_material"]["api"]["amount"] += 1
		else: data_finish_mission["item_inventory"]["item_material"]["besi_berkaarat"]["amount"] += 1
		
		GameDatabase.save_data(data_finish_mission)
		GameDatabase.craft_finish = true
		GameDatabase.json_data = data_finish_mission
		text_dialog.set_bbcode("Selamat kamu berhasil menjawab pertanyaanku, sekarang aku akan membuatkan apa yang kamu inginkan.")
	else:
		text_dialog.set_bbcode("Oh maaf sepertinya aku tidak bisa membuatkan apa yang kamu mau, dikarenakan kekurangan material")
	
	text_dialog.set_visible_characters(0) 
	text_dialog.show()
	
	finish_touch.show()
	

func _on_TouchFalseAnswer2_pressed() -> void:
	quest_container.hide()
	take_cancel.hide()
	text_dialog.show()
	text_dialog.set_bbcode("Maafkan aku seperti nya kamu telah gagal menjawab pertanyaan ku, silahkan coba lagi pada lain waktu.")
	text_dialog.set_visible_characters(0) 
	finish_touch.show()


func checkItemMaterial() -> bool:
	var data_need_item: Array = get_mission_player()
	var item_player_inv = get_item_inventory()
	var item_material = instance_db
	
# warning-ignore:unused_variable
	var index = 0
	var param:bool
	for index in range(2):
		if data_need_item[index].material_name == "Broken stone":
			if item_player_inv["broken_stone"]["amount"] < int(data_need_item[index].value):
				param = false
			else:
				var minus = item_player_inv["broken_stone"]["amount"] - int(data_need_item[index].value)
				item_material["item_inventory"]["item_material"]["broken_stone"]["amount"] = minus
				param = true
		elif data_need_item[index].material_name == "Small wood":
			if item_player_inv["small_wood"]["amount"] < int(data_need_item[index].value):
				param = false
			else: 
				var minus = item_player_inv["small_wood"]["amount"] - int(data_need_item[index].value)
				item_material["item_inventory"]["item_material"]["small_wood"]["amount"] = minus
				param = true
		elif data_need_item[index].material_name == "Big wood":
			if item_player_inv["big_wood"]["amount"] < int(data_need_item[index].value):
				param = false
			else: 
				var minus = item_player_inv["big_wood"]["amount"] - int(data_need_item[index].value)
				item_material["item_inventory"]["item_material"]["big_wood"]["amount"] = minus
				param = true
				
	if param == true:
		instance_db = item_material
		
	return param
		
	

func get_mission_player():
	var mission_active = instance_db["player_mission"]["mission"]
	var needItem = instance_db["mission"][mission_active]
	return needItem.values()


func get_item_inventory():
	var item_inv = instance_db["item_inventory"]["item_material"]
	return item_inv
