extends Control

@export var move_info : Node
var temp = "bug"

func _ready():
	var border = $Border
	#$TextureRect.texture = load("res://assets/types/"+str(move_info.type)+".png")
	var style = StyleBoxFlat.new()
	match temp:
		"bug":
			style.bg_color = Color("#a0c888")
		"dark":
			pass
		"dragon":
			pass
		"electric":
			pass
		"fairy":
			pass
		"fighting":
			pass
		"fire":
			pass
		"flying":
			pass
		"ghost":
			pass
		"grass":
			pass
		"ground":
			pass
		"ice":
			pass
		"normal":
			pass
		"poison":
			pass
		"psychic":
			pass
		"rock":
			pass
		"steel":
			pass
		"water":
			pass
		_:
			style.bg_color = Color("#68a090")
	border.add_theme_stylebox_override("panel", style)
