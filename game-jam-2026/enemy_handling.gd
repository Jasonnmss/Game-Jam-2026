extends Node2D
class_name EnemyHandling

var enemyBCell = preload("res://enemyBCell.tscn")
var enemyTCell = preload("res://enemyTCell.tscn")


@export var level = 0
@export var wave = 0
var ongoing_wave = 0
var enemys_allive = 0
@export var won = 0
var bCell_speed = 20
var level1_waves = [[2,0,[Vector2(896, 146),Vector2(1061, 300)]],
					[2,0,[Vector2(896, 146),Vector2(1080, 405)]],
					[3,0,[Vector2(1050, 146),Vector2(900, 405),Vector2(890,200)]],
					[2,1,[Vector2(910, 200),Vector2(1050, 330)],[Vector2(1200,280)]],
					[2,2,[Vector2(900, 340),Vector2(1100,240)],[Vector2(1000, 405),Vector2(1050,150)]]]

var level2_waves = [[3,0,[Vector2(900, 350),Vector2(1050, 150),Vector2(1200,250)],[]],
					[3,1,[Vector2(900, 400),Vector2(1000, 150),Vector2(1200,250)],[Vector2(1050,350)]],
					[3,2,[Vector2(900, 250),Vector2(1100, 350),Vector2(1200,170)],[Vector2(1000,300),Vector2(1250,150)]],
					[3,3,[Vector2(900, 200),Vector2(1200, 300),Vector2(1300,400)],[Vector2(1020, 400),Vector2(1120, 220),Vector2(1260,150)]],
					[4,3,[Vector2(900, 200),Vector2(1050, 200),Vector2(1200,150),Vector2(1330,250)],[Vector2(950, 300),Vector2(1280, 350),Vector2(1400,150)]]]
			
var level3_waves = [[2,3,[Vector2(950,250),Vector2(1200,300)],[Vector2(900, 150),Vector2(1050, 350),Vector2(1100,200)]],
					[1,4,[Vector2(1150,250)],[Vector2(900, 200),Vector2(1000, 350),Vector2(1100,400),Vector2(1200,150)]],
					[6,2,[Vector2(900, 150),Vector2(1000, 400),Vector2(1100,300),Vector2(1200, 200),Vector2(1300, 400),Vector2(1400,200)],
					[Vector2(1150, 350),Vector2(1250, 250)]],
					[6,6,[Vector2(1050, 150),Vector2(1150, 200),Vector2(1250,300),Vector2(1350, 200),Vector2(1550, 200),Vector2(1700,300)],
					[Vector2(900, 200),Vector2(950, 300),Vector2(1100,350),Vector2(1400, 300),Vector2(1450, 350),Vector2(1600,150)]],
					[0,0,[],[]]]
var levels = [level1_waves, level2_waves, level3_waves]

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if (ongoing_wave == 1):
		if enemys_allive > 0: pass
		else: 
			ongoing_wave = 0
			if wave < 5: wave += 1
			else:
				wave += 1
				if level < 3: level += 1
				else: won = 1
	
	else:
		initiate_wave()
		ongoing_wave = 1

func initiate_wave():
	var enemies_per_wave = levels[level]
	var enemy_Nbrs = enemies_per_wave[wave]
	var BCells = enemy_Nbrs[0]
	var TCells = enemy_Nbrs[1]
	var positionsB = Vector2(0,0)
	var positionsT = Vector2(0,0)
	if BCells != 0: positionsB = enemy_Nbrs[2]
	if TCells != 0: positionsT = enemy_Nbrs[3]
	var i = 0
	var j = 0
	enemys_allive = BCells + TCells
	if BCells != 0:
		while i < BCells:
			var bCell = enemyBCell.instantiate()
			bCell.died.connect(_on_b_cell_died)
			bCell.position = positionsB[i]
			get_parent().call_deferred("add_child", bCell)
			i += 1
	if TCells != 0:
		while j < TCells:
			var tCell = enemyTCell.instantiate() 
			tCell.died.connect(_on_enemy_t_cell_died)
			tCell.position = positionsT[j]
			get_parent().call_deferred("add_child", tCell)
			j += 1

func _on_enemy_t_cell_died():
	enemys_allive -= 1
	print("death,",enemys_allive)


func _on_b_cell_died():
	enemys_allive -= 1
	print("death,",enemys_allive)
