extends CharacterBody2D

var max_speed = 200
var max_force = 300

var slow_radius = 100.0
var panic_radius = 300.0

var wander_radius = 80.0
var wander_distance = 120.0
var wander_angle = 0.0

var weight_arrival = 1.0
var weight_avoid = 4.0

var target: Node2D
var current_behavior = "arrival"

func _ready():
	target = get_parent().get_node_or_null("Target")

func _input(event):
	if event.is_action_pressed("ui_1"):
		current_behavior = "seek"
	if event.is_action_pressed("ui_2"):
		current_behavior = "arrival"
	if event.is_action_pressed("ui_3"):
		current_behavior = "flee"
	if event.is_action_pressed("ui_4"):
		current_behavior = "wander"
	if event.is_action_pressed("ui_5"):
		current_behavior = "departure"

	print("Behavior atual:", current_behavior)

func _physics_process(delta):
	if target == null:
		return

	var steering = Vector2.ZERO

	match current_behavior:
		"seek":
			steering += seek(target.global_position)
		"arrival":
			steering += arrival(target.global_position)
		"flee":
			steering += flee(target.global_position)
		"departure":
			steering += departure(target.global_position)
		"wander":
			steering += wander()

	# 👇 Só usa avoidance quando faz sentido
	if current_behavior != "wander":
		steering += avoid_obstacles() * weight_avoid

	steering = steering.limit_length(max_force)

	velocity += steering * delta
	velocity = velocity.limit_length(max_speed)

	move_and_slide()

	# Rotaciona o personagem (visual)
	if velocity.length() > 0:
		rotation = velocity.angle()

func seek(target_position: Vector2) -> Vector2:
	var desired = (target_position - global_position).normalized() * max_speed
	return (desired - velocity).limit_length(max_force)

func arrival(target_position: Vector2) -> Vector2:
	var to_target = target_position - global_position
	var distance = to_target.length()

	if distance == 0:
		return Vector2.ZERO

	var desired_speed = max_speed

	if distance < slow_radius:
		desired_speed = max_speed * (distance / slow_radius)

	var desired = to_target.normalized() * desired_speed
	return (desired - velocity).limit_length(max_force)

func flee(target_position: Vector2) -> Vector2:
	var distance = global_position.distance_to(target_position)

	if distance > panic_radius:
		return Vector2.ZERO

	var desired = (global_position - target_position).normalized() * max_speed
	return (desired - velocity).limit_length(max_force)
	print("FLEE ATIVO")

func departure(target_position: Vector2) -> Vector2:
	var to_target = global_position - target_position
	var distance = to_target.length()

	if distance == 0:
		return Vector2.ZERO

	if distance > slow_radius:
		return Vector2.ZERO

	var desired_speed = max_speed * (1 - (distance / slow_radius))
	var desired = to_target.normalized() * desired_speed

	return (desired - velocity).limit_length(max_force)

func wander() -> Vector2:
	wander_angle += randf_range(-1.0, 1.0) # mais variação!

	var circle_center = velocity.normalized() * wander_distance

	if velocity.length() == 0:
		circle_center = Vector2.RIGHT * wander_distance

	var displacement = Vector2(cos(wander_angle), sin(wander_angle)) * wander_radius

	var wander_force = circle_center + displacement

	return wander_force.limit_length(max_force)

func avoid_obstacles() -> Vector2:
	var avoidance_force = Vector2.ZERO
	var look_ahead = 100.0

	if velocity.length() == 0:
		return Vector2.ZERO

	var forward = velocity.normalized()

	for obstacle in get_tree().get_nodes_in_group("obstacles"):
		var to_obstacle = obstacle.global_position - global_position
		var distance = to_obstacle.length()

		var dot = forward.dot(to_obstacle.normalized())

		if dot > 0.8 and distance < look_ahead:
			var perpendicular = Vector2(-forward.y, forward.x)
			avoidance_force += perpendicular * max_force

	return avoidance_force.limit_length(max_force)

func pursuit(target: Node2D) -> Vector2:
	var to_target = target.global_position - global_position
	var distance = to_target.length()

	var future_time = distance / max_speed
	var future_position = target.global_position

	if target is CharacterBody2D:
		future_position += target.velocity * future_time

	return seek(future_position)
	
func evasion(target: Node2D) -> Vector2:
	var to_target = target.global_position - global_position
	var distance = to_target.length()

	var future_time = distance / max_speed
	var future_position = target.global_position

	if target is CharacterBody2D:
		future_position += target.velocity * future_time

	return flee(future_position)
