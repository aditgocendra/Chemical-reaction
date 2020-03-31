extends Control

onready var texture_item = $Panel/TextureItem
onready var panel_item = $Panel


var dataEquipment 
#var path = "res://assets/object/item/palu.png"


func setItemTexture(path) -> void:
	texture_item.texture = load(path.src)

func _on_TouchItem_pressed() -> void:
	if dataEquipment != null:
		GameDatabase.new_item_data = dataEquipment
		


func styleBox():
	var new_style = StyleBoxFlat.new()
	new_style.set_bg_color(Color("2f2b23"))
	new_style.set_border_color(Color("1d8f8f"))
	new_style.set_border_blend(true)
	panel_item.set('custom_styles/panel', new_style)
