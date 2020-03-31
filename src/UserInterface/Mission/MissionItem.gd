extends Panel


onready var labelMaterial = $HBoxContainer/LabelMaterialName
onready var labelValue = $HBoxContainer/LabelValue
onready var hbox_container = $HBoxContainer


func setLabelMaterial(material_name : String, material_value : String):
	labelMaterial.text = material_name
	labelValue.text = material_value

