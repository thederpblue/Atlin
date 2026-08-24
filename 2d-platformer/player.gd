extends CharacterBody2D

var dashes = 1
var timeSinceDash = 0
var timeOnFloor = 0
var jumpTime = 0

var fallMaxSpeed = 160

var airTime = 0

var gravity = 900

var maxWalkVelocity = 90
var walkAcceleration = 1000
var decelerationAboveMax = 400

var jumpVelocity = 105
var maxJumpTime = 0.2

var dashVelocity = 240
var afterDashVelocity = 160
var dashTime = 0.15
var dashCooldown = 0.2
var dashDir = Vector2()


func _physics_process(delta):
	get_node("Label").text = str(velocity)
	updateTimes(delta)
	updateIcon()
	
		

	#FRICTION
	
	
	#GRAVITY
	if (timeSinceDash > 0.25 and jumpTime == 0 || jumpTime > maxJumpTime):
		if velocity.y + gravity * delta > fallMaxSpeed:
			velocity.y = fallMaxSpeed
		else:
			velocity.y += delta * gravity
	
	#UPDATE DASHES
	if is_on_floor():
		dashes = 1
	
	if timeSinceDash < dashTime and !timeSinceDash == 0:
		velocity = dashDir * dashVelocity
	if timeSinceDash > dashTime and timeSinceDash - delta < dashTime:
		velocity = dashDir * afterDashVelocity
	
	
	
	#DETECT MOVEMENT
	jumpTime += delta
	if Input.is_key_pressed(KEY_SPACE):
		jump(delta)
	elif is_on_floor():
		jumpTime = 0
	if Input.is_key_pressed(KEY_LEFT):
		walk_left(delta)
	if Input.is_key_pressed(KEY_RIGHT):
		walk_right(delta)
	if !Input.is_key_pressed(KEY_LEFT) and !Input.is_key_pressed(KEY_RIGHT):
		stop_walk()
	if Input.is_key_pressed(KEY_C) and dashes >  0 and timeSinceDash > dashCooldown:
		dash()
	
	
	
	# APPLY MOVEMENT
	move_and_slide()
	
func friction(delta):
	if abs(velocity.x) > maxWalkVelocity:
		velocity.x -= delta * decelerationAboveMax
	
	
func updateIcon():
	if timeSinceDash > 0.25:
		get_node("GPUParticles2D").emitting = false
		if dashes == 0:
			get_node("Sprite2D").texture = load("res://theoWalk.png")
		elif dashes == 1:
			get_node("Sprite2D").texture = load("res://theoWalk.png")
	else:
		get_node("GPUParticles2D").emitting = true
		get_node("Sprite2D").texture = load("res://theoWalk.png")

func updateTimes(delta):
	timeSinceDash += delta
	if is_on_floor():
		timeOnFloor += delta
		airTime = 0
	elif !is_on_floor():
		timeOnFloor = 0
		airTime += delta
	

func jump(delta):
	if self.is_on_floor() || (jumpTime > 0 and jumpTime <= maxJumpTime):
		velocity.y = -jumpVelocity 

func walk_left(delta):
	get_child(0).scale.x = -1
	if velocity.x - (walkAcceleration * delta) < -maxWalkVelocity:
		velocity.x = -maxWalkVelocity
	else:
		velocity.x -= walkAcceleration * delta

func walk_right(delta):
	get_child(0).scale.x = 1
	if velocity.x + (walkAcceleration * delta) > maxWalkVelocity:
		velocity.x = maxWalkVelocity
	else:
		velocity.x += walkAcceleration * delta
	
func stop_walk():
	velocity.x = 0

func dash():
	dashDir = get_dir().normalized()
	print(dashDir)
	dashes -= 1
	timeOnFloor = -0.25
	timeSinceDash = 0


func get_dir():
	var dir = Vector2(0,0)
	if Input.is_key_pressed(KEY_LEFT):
		dir.x = -1
	elif Input.is_key_pressed(KEY_RIGHT):
		dir.x = 1
	if Input.is_key_pressed(KEY_UP):
		dir.y = -1
	elif Input.is_key_pressed(KEY_DOWN):
		dir.y = 1
	if dir == Vector2(0,0):
		dir.x = get_child(0).scale.x
	
	return dir
	
