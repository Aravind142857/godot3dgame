extends CharacterBody3D
# speed in mps
@export var speed = 14
# falling acceleration in mps
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO
func _physics_process(delta):
	var direction = Vector3.ZERO
	 
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
		
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
	
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	# move the character
	velocity = target_velocity
	move_and_slide()