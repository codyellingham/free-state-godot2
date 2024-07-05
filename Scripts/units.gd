extends CharacterBody2D

var selected = false
var target = Vector2.ZERO
var speed = 200
var target_max = 1

func _ready():
	target = position
	velocity = Vector2.ZERO

func _physics_process(delta):
	velocity = Vector2.ZERO
	if position.distance_to(target) > target_max:
		velocity = position.direction_to(target) * speed
	move_and_slide()

func move_to(tar):
	target = tar

func select():
	selected = true
	$Selected.visible = true
	$UnitSelected.visible = true
		
func deselect():
	selected = false
	$Selected.visible = false
	$UnitSelected.visible = false
			
