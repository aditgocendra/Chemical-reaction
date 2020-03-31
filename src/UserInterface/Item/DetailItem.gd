extends VBoxContainer

onready var labelEquipment = $BackgrundDetail/LabelEquipment
onready var labelDetailEquip = $BackgrundDetail/LabelDetailEquip
onready var touchUseEquipment = $BackgrundDetail/BackgroundUse
onready var touchNotUseEquipment = $BackgrundDetail/BackgroundNotUse

func _ready() -> void:
	GameDatabase.connect("update_detail", self, "update_label")
	
	
	
func update_label():
	var data_equipment = GameDatabase.item_data_show
	labelEquipment.text = data_equipment.equipment_name
	labelDetailEquip.show()
	get_player_using_equipment(data_equipment)
	labelDetailEquip.text = data_equipment.description


func get_player_using_equipment(data_equipment):
	var data_load = GameDatabase.load_data()
	var playerEquip = data_load["player_use_equip"]["equip_use_name"]
	if playerEquip == null:
		touchUseEquipment.show()
	elif playerEquip == data_equipment.equipment_name:
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
		GameDatabase.equip_texture = save_equip_use["equipment"][new_name_equip].src
		
