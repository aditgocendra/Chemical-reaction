extends Node

var DB_dialog_path =  "res://databases/database_game.json"

var default_data = {
  "game_setting": {
	"sound_fx": {
	  "checked": true,
	  "vol": 0
	},
	"sound_music": {
	  "checked": true,
	  "vol": 0
	}
  },
  "item_inventory": {
	"equipment": {
	  "Axe": {
		"amount": null,
		"description": "You can use this to cut and cut wood",
		"item_name": "Axe",
		"src": "res://assets/object/item/kapak.png",
		"type_item": "equipment"
	  },
	  "Hammer": {
		"amount": null,
		"description": "You can use this to crush anything other than wood",
		"item_name": "Hammer",
		"src": "res://assets/object/item/palu.png",
		"type_item": "equipment"
	  }
	},
	"item_material": {
	  "big_wood": {
		"amount": 0,
		"description": "Diambil dari dunia yang indah kamu dapat menggunakan nya",
		"item_name": "Big wood",
		"src": "res://assets/object/item/kayuBesar.png",
		"type_item": "item_material"
	  },
	  "broken_stone": {
		"amount": 0,
		"description": "Kamu bisa menggunakan ini untuk membuat sesuatu",
		"item_name": "Broken stone",
		"src": "res://assets/object/item/pecahanBatu.png",
		"type_item": "item_material"
	  },
	  "small_wood": {
		"amount": 0,
		"description": "Diambil dari pepohonan yang kecil bisa dijadikan sesuatu",
		"item_name": "Small wood",
		"src": "res://assets/object/item/kayuKecil.png",
		"type_item": "item_material"
	  },
	"api": {
		"amount": 0,
		"description": "Api",
		"item_name": "Fire",
		"src": "res://assets/object/item/api.png",
		"type_item": "equipment"
	  },
	  "besi_berkarat": {
		"amount": 0,
		"description": "Besi berkarat",
		"item_name": "Besi berkarat",
		"src": "res://assets/object/item/besi_berkarat.png",
		"type_item": "equipment"
	  }
	}
  },
  "mission": {
	"mission1": {
	  "001": {
		"material_name": "Broken stone",
		"value": "5"
	  },
	  "002": {
		"material_name": "Small wood",
		"value": "8"
	  }
	},
	"mission2": {
	  "001": {
		"material_name": "Big wood",
		"value": "5"
	  },
	  "002": {
		"material_name": "Crystal",
		"value": "8"
	  }
	},
	"mission3": {
	  "001": {
		"material_name": "Small wood",
		"value": "5"
	  },
	  "002": {
		"material_name": "Crystal",
		"value": "8"
	  }
	}
  },
  "mission_finish": {
	"mission1": {
	  "mission": false
	},
	"mission2": {
	  "mission": false
	},
	"mission3": {
	  "mission": false
	}
  },
  "player_init": {
	"scene": "res://src/Laboratory/Laboratory1.tscn"
  },
  "player_mission": {
	"mission": null
  },
  "player_use_equip": {
	"equip_use_name": null
  },
  "question": {
	"Besi berkarat": {
	  "choice_answer1": "Indoterm",
	  "choice_answer2": "Endoterm",
	  "question": "Reaksi kimia yang menyerap panas di sekitarnya dinamakan reaksi...?"
	},
	"Pembakaran kayu": {
	  "choice_answer1": "pembakaran bensin pada kendaraan bermotor",
	  "choice_answer2": "garam yg larut di air",
	  "question": "Manakah yg merupakan contoh reaksi eksoterm...?"
	},
	"Proses fotosintesis": {
	  "choice_answer1": "Uap",
	  "choice_answer2": "Gas",
	  "question": "Ketika kamu melarutkan tablet vitamin berkalsium tinggi ke dalam segelas air, kamu akan melihat gelembung-gelembung gas muncul dari dalam larutan. Hal ini membuktikan bahwa dalam peristiwa reaksi kimia dapat menimbulkan..?"
	}
  },
  "talking": {
	"dialog_crafter": {
	  "001": {
		"dialog": "Hello .... I'm a material maker here",
		"npc_name": "Holdin"
	  },
	  "002": {
		"dialog": "Reaksi kimia akan selalu disertai dengan energi. baik energi yang berupa panas, listrik atau pun cahaya.",
		"npc_name": "Holdin"
	  },
	  "003": {
		"dialog": "Reaksi kimia yang menghasilkan energi biasanya disebut dengan eksoterm sementara reaksi yang menyerap energi biasa disebut dengan reaksi endoterm.",
		"npc_name": "Holdin"
	  },
	  "004": {
		"dialog": "Do you want to make something?",
		"npc_name": "Holdin"
	  },
	  "005": {
		"dialog": "Sebelum kamu meminta ku membuatkan mu sesuatu kamu harus menjawab pertanyaan ku lebih dulu, apakah kamu bersedia?",
		"npc_name": "Holdin"
	  }
	},
	"dialog_prof_nurdin": {
	  "001": {
		"dialog": "Hi....... I am a professor in this laboratory",
		"npc_name": "nurdin"
	  },
	  "002": {
		"dialog": "Finally you come too, I have been waiting for your arrival",
		"npc_name": "nurdin"
	  },
	  "003": {
		"dialog": "I need your help to get the chemicals out there",
		"npc_name": "nurdin"
	  },
	  "004": {
		"dialog": "I'm doing research on a reaction and need some chemicals out there",
		"npc_name": "nurdin"
	  },
	  "005": {
		"dialog": "if you are willing?",
		"npc_name": "nurdin"
	  }
	},
	"dialog_prof_yadi": {
	  "001": {
		"dialog": "Hello .... introduce my name prof Yadi Subarjo I am a professor in this laboratory",
		"npc_name": "yadi"
	  },
	  "002": {
		"dialog": "Are you willing to accept assignments from me..?",
		"npc_name": "yadi"
	  },
	  "003": {
		"dialog": "Alright though this task is fairly difficult but I'm sure you can complete it quickly",
		"npc_name": "yadi"
	  },
	  "004": {
		"dialog": "I need an ingredient out there that I can't do alone",
		"npc_name": "yadi"
	  },
	  "005": {
		"dialog": "Are you ready ?",
		"npc_name": "yadi"
	  }
	},
	"end_dialog": {
	  "001": {
		"dialog": "Why are you still here, and not doing your job? I need it immediately"
	  }
	},
	"finish_dialog": {
	  "001": {
		"dialog": "Aku belum membutuhkan apapun saat ini... kuharap kamu tidak kecewa untuk datang di lain hari"
	  }
	}
  }
}


signal updated_mission
signal update_detail
signal update_texture_equip
signal update_npc
signal update_crafting


var json_data setget update_data
var npc_name setget update_npc_name

var new_item_data setget update_name_item
var item_data_show

var equip_texture setget update_texture
var path_texture
var craft_finish = false setget update_craft


var _file 

func _ready() -> void:
	load_data()


func load_data():
	_file = File.new()
		
	if not _file.file_exists(DB_dialog_path):
		save_data(default_data)
	else:
		_file.open(DB_dialog_path, File.READ)
		
		json_data = parse_json(_file.get_as_text())
		
		if json_data.size() > 0:
			return json_data
		
		
func save_data(new_data):
	_file = File.new()
	
	_file.open(DB_dialog_path, File.WRITE)
	_file.store_line(to_json(new_data))
	_file.close()
	
	
func update_data(new_json_data):
	json_data = new_json_data
	emit_signal("updated_mission")
	
	

func update_name_item(item_data):
	item_data_show =  item_data
	emit_signal("update_detail")


func update_texture(equip_txtr):
	path_texture = equip_txtr
	emit_signal("update_texture_equip")


func update_npc_name(nameNPC):
	npc_name = nameNPC
	emit_signal("update_npc")


func update_craft(craftFinish):
	craft_finish = craftFinish
	emit_signal("update_crafting")
