extends Control


onready var slotItem = preload("res://src/UserInterface/Item/Item.tscn").instance()
onready var itemContainer = $HBoxContainer/ItemInventory/BackgrundEquip/ItemContainer
onready var labelEquipment = $HBoxContainer/DetailItem/BackgrundDetail/LabelEquipment

var data_game = GameDatabase.load_data()
var max_item = 6

var _indexes: int = 0
var item_player: Array



func _ready() -> void:
	load_equipment()
	
	for _indexes in range(max_item):
		var newSlot = slotItem.duplicate()
		
		if _indexes < item_player.size():
			if item_player[_indexes].amount > 0:
				itemContainer.add_child(newSlot)
				newSlot.setItemTexture(item_player[_indexes])
				newSlot.dataEquipment = item_player[_indexes]
		else:
			itemContainer.add_child(newSlot)
		

func load_equipment():
	item_player = data_game["item_inventory"]["item_material"].values()
	




