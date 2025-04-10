extends CharacterBody2D

const speed = 80

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var dir
func _ready() -> void:
	dir = "down"

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		velocity.y = 0
		animated_sprite.flip_h=false
		animated_sprite.play("side walk")
		dir = "right"
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		velocity.y = 0
		animated_sprite.flip_h=true
		animated_sprite.play("side walk")
		dir = "left"
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = speed
		animated_sprite.play("front walk")
		dir = "down"
	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -speed
		animated_sprite.play("back walk")
		dir = "up"
	else:
		velocity.x = 0
		velocity.y = 0
		if dir == "right" or dir == "left":
			animated_sprite.play("side idle")
		elif dir == "up":
			animated_sprite.play("back idle")
		elif dir == "down":
			animated_sprite.play("front idle")
	
	move_and_slide()
	
	
	
