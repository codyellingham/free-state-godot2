extends CharacterBody2D

var selected = false
var target = Vector2.ZERO
var speed = 200
var target_max = 1
var direction_degrees = 0.0 #angle of direction
var current_direction = 1  # Initialize with default direction (North)

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	target = position
	velocity = Vector2.ZERO

func _physics_process(_delta):
	velocity = Vector2.ZERO
	
	if position.distance_to(target) > target_max:
		velocity = position.direction_to(target) * speed
		direction_degrees = wrapf(round(velocity.angle() * 180.0 / PI), 0, 360)
		print(direction_degrees)

	# Calculate direction and set animation
	current_direction = convert_direction_to_integer(direction_degrees)
	# print(current_direction)
	match current_direction:
		1:
			animated_sprite_2d.play("1_idle")
		2:
			animated_sprite_2d.play("2_idle")
		3:
			animated_sprite_2d.play("3_idle")
		4:
			animated_sprite_2d.play("4_idle")
		5:
			animated_sprite_2d.play("5_idle")
		6:
			animated_sprite_2d.play("6_idle")
		7:
			animated_sprite_2d.play("7_idle")
		8:
			animated_sprite_2d.play("8_idle")
	
	move_and_slide()
	
func convert_direction_to_integer(degrees: float) -> int:
	var direction
	if degrees >= 337.5 || degrees < 22.5:
		direction = 3  # North
	elif degrees >= 22.5 && degrees < 67.5:
		direction = 4  # Northeast
	elif degrees >= 67.5 && degrees < 112.5:
		direction = 5  # East
	elif degrees >= 112.5 && degrees < 157.5:
		direction = 6  # Southeast
	elif degrees >= 157.5 && degrees < 202.5:
		direction = 7  # South
	elif degrees >= 202.5 && degrees < 247.5:
		direction = 8  # Southwest
	elif degrees >= 247.5 && degrees < 292.5:
		direction = 1  # West
	elif degrees >= 292.5 && degrees < 337.5:
		direction = 2  # Northwest
	
	return direction

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
