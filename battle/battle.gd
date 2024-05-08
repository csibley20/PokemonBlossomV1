extends Node2D

const POKEMON_INST = preload("res://pokemon/poke_inst.tscn")

var type_dict = {
	"Normal":0, "Fire":1, "Water":2, "Grass":3, "Electric":4, "Ice":5, 
	"Fighting":6, "Poison":7, "Ground":8, "Flying":9, "Psychic":10, "Bug":11,
	"Rock":12, "Ghost":13, "Dragon":14, "Dark":15, "Steel":16, "Fairy":17
}

var type_chart = [ # index matches to a type
	#NOR  FIR  WAT  GRA  ELE  ICE  FIG  POI  GRO  FLY  PSY  BuG  ROC  GHO  DRA  DAR  STE  FAI
	[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 0.0, 1.0, 1.0, 0.5, 1.0], # 0  = Normal
	[1.0, 0.5, 0.5, 2.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 0.5, 1.0, 2.0, 1.0], # 1  = Fire
	[1.0, 2.0, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 1.0, 1.0], # 2  = Water
	[1.0, 0.5, 2.0, 0.5, 1.0, 1.0, 1.0, 0.5, 2.0, 0.5, 1.0, 0.5, 2.0, 1.0, 0.5, 1.0, 0.5, 1.0], # 3  = Grass
	[1.0, 1.0, 2.0, 0.5, 0.5, 1.0, 1.0, 1.0, 0.0, 2.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0], # 4  = Electric
	[1.0, 0.5, 0.5, 2.0, 1.0, 0.5, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0], # 5  = Ice
	[2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 0.5, 0.5, 0.5, 2.0, 0.0, 1.0, 2.0, 2.0, 0.5], # 6  = Fighting
	[1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 0.5, 0.5, 1.0, 1.0, 1.0, 0.5, 0.5, 1.0, 1.0, 0.0, 2.0], # 7  = Poison
	[1.0, 2.0, 1.0, 0.5, 2.0, 1.0, 1.0, 2.0, 1.0, 0.0, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 2.0, 1.0], # 8  = Ground
	[1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 0.5, 1.0], # 9  = Flying
	[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 0.0, 0.5, 1.0], # 10 = Psychic
	[1.0, 0.5, 1.0, 2.0, 1.0, 1.0, 0.5, 0.5, 1.0, 0.5, 2.0, 1.0, 1.0, 0.5, 1.0, 2.0, 0.5, 0.5], # 11 = Bug
	[1.0, 2.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 0.5, 2.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0], # 12 = Rock
	[0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 1.0], # 13 = Ghost
	[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 0.5, 0.0], # 14 = Dragon
	[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 2.0, 1.0, 0.5, 1.0, 0.5], # 15 = Dark
	[1.0, 0.5, 0.5, 1.0, 0.5, 2.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 0.5, 2.0], # 16 = Steel
	[1.0, 0.5, 1.0, 1.0, 1.0, 1.0, 2.0, 0.5, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 0.5, 1.0]  # 17 = Fairy
	]

var crit_table = [24, 8, 2, 1]

var poke1 = POKEMON_INST.instantiate()
var poke2 = POKEMON_INST.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	poke1.create_poke(load("res://pokemon/resources/popplio.tres"), 10, "Hardy")
	poke2.create_poke(load("res://pokemon/resources/pikipek.tres"), 10, "Docile")
	
	var move1 = load("res://battle/moves/resources/peck.tres")
	
	print(execute_attack(poke1, poke2, move1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func execute_attack(user, target, move):
	
	print(user.pokemon_species.species_name + " uses " + move.move_name + " on " + target.pokemon_species.species_name)
	
	var power = move.power
	var level = user.level
	var attack
	var defense
	
	if move.category == "Physical":
		attack = user.atk
		defense = target.def
	elif move.category == "Special":
		attack = user.spatk
		defense = target.spdef
	else:
		return
	
	var crit = 1
	var roll = randi_range(85, 100)/100.0
	var stab = 1
	var effective = calc_effectiveness(move.type, target.types)
	
	# checks for crit
	if randi_range(1, crit_table[user.crit_stage]) == 1:
		# TBD: queue critical hit message
		crit = 1.5
	
	#checks for stab
	for i in user.types:
		if move.type == i:
			stab = 1.5
	
	if effective == 0:
		# TBD: queue no effect message
		pass
	elif effective > 1:
		# TBD: queue super effective message
		pass
	elif effective < 1:
		# TBD: queue not very effective message
		pass
	
	var damage_raw = ((((2 * level)/5 + 2) * power * (attack/defense))/50 + 2) * crit * roll * stab * effective
	var damage = snapped(damage_raw, 0)
	
	return damage

#checks the type effectiveness multiplier
func calc_effectiveness(attack_type, target_types):
	var multiplier = 1
	var offense_index = type_dict[attack_type]
	for i in target_types:
		var defense_index = type_dict[i]
		multiplier = multiplier * type_chart[offense_index][defense_index]
	return multiplier
