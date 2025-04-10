extends CharacterBody2D

var speed = 50
var player_chase = false
var player: CharacterBody2D = null
var last_direction = Vector2.DOWN

func _physics_process(delta: float) -> void:
	if player_chase:
		var direction = (player.global_position - global_position).normalized() 
		position += direction * speed * delta
		update_animation_direction(direction)
		last_direction = direction
	else:
		play_idle_animation()

func update_animation_direction(direction:Vector2):
	#prioritising y movement over x movement for smoother look
	if abs(direction.y) > abs(direction.x):
		if direction.y > 0:
			$AnimatedSprite2D.play("front walk")  # Down
		else:
			$AnimatedSprite2D.play("back walk")   # Up
	else:
		# Horizontal movement
		if direction.x != 0:
			$AnimatedSprite2D.flip_h = direction.x < 0
			$AnimatedSprite2D.play("side walk")

func play_idle_animation():
	if abs(last_direction.x) > abs(last_direction.y):
		# Horizontal Idle
		$AnimatedSprite2D.flip_h = last_direction.x < 0
		$AnimatedSprite2D.play("side idle")
	else:
		if last_direction.y > 0:
			$AnimatedSprite2D.play("front idle")
		else:
			$AnimatedSprite2D.play("back idle")


func _on_detection_area_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		player_chase = false
