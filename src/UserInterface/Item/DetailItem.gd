extends VBoxContainer

onready var labelEquipment = $BackgrundDetail/LabelEquipment
onready var labelDetailEquip = $BackgrundDetail/LabelDetailEquip
onready var touchUseEquipment = $BackgrundDetail/BackgroundUse
onready var touchNotUseEquipment = $BackgrundDetail/BackgroundNotUse

func _ready() -> void:
# warning-ignore:return_value_discarded
	GameDatabase.connect("update_detail", self, "update_label")
	
	
func update_label():
	var data_item = GameDatabase.item_data_show
	if data_item.type_item == "equipment":
		get_player_using_equipment(data_item)
	labelEquipment.text = data_item.item_name
	labelDetailEquip.show()
	
	labelDetailEquip.text = data_item.description


func get_player_using_equipment(data_item_game):
	var data_load = GameDatabase.load_data()
	var detailItem = data_load["player_use_equip"]["equip_use_name"]
	if detailItem == null:
		touchUseEquipment.show()
	elif detailItem == data_item_game.item_name:
		touchUseEquipment.hide()
		touchNotUseEquipment.show()
	else : 
		touchUseEquipment.show()
		touchNotUseEquipment.hide()


func _on_TouchUse_pressed() -> void:
	update_player_equip(labelEquipment.get_text())
	touchUseEquipment.hide()
	touchNotUseEquipment.show()	


func _on_TouchNotUse_pressed() -> void:
	update_player_equip(null)
	touchUseEquipment.show()
	touchNotUseEquipment.hide()	



func update_player_equip(label):
	var data = GameDatabase.load_data()
	var save_equip_use = data
	var new_name_equip = label
	save_equip_use["player_use_equip"] = {
		equip_use_name = new_name_equip
	}
	GameDatabase.save_data(save_equip_use)
	if new_name_equip == null:
		GameDatabase.equip_texture = new_name_equip
	else:
		GameDatabase.equip_texture = save_equip_use["item_inventory"]["equipment"][new_name_equip].src
		
