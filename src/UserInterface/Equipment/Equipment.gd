extends Control


onready var slotItem = preload("res://src/UserInterface/Item/Item.tscn").instance()
onready var itemContainer = $HBoxContainer/ItemEquipment/BackgrundEquip/ItemContainer
onready var labelEquipment = $HBoxContainer/DetailItem/BackgrundDetail/LabelEquipment

var data_game = GameDatabase.load_data()
var max_item = 10

var _indexes: int = 0
var equipment_player: Array



func _ready() -> void:
	load_equipment()
	
	for _indexes in range(max_item):
		var newSlot = slotItem.duplicate()
		
		if _indexes < equipment_player.size():
			itemContainer.add_child(newSlot)
			newSlot.setItemTexture(equipment_player[_indexes])
			newSlot.dataEquipment = equipment_player[_indexes]
		else:
			itemContainer.add_child(newSlot)
		

func load_equipment():
	equipment_player = data_game["equipment"].values()





