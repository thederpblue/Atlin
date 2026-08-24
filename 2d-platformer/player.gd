extends CharacterBody2D

var was_left = false
var was_right = false

var respawnPoint = Vector2(0,0)
var velocityQueue = []
var velocityBlock = 0


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
	applyfriction(delta)
	applyGravity(delta)
	updateDashes(delta)
	updateVelocityQueue(delta)
	
	
	
	
	#DETECT MOVEMENT
	var left = Input.is_key_pressed(KEY_LEFT)
	var right = Input.is_key_pressed(KEY_RIGHT)
	
	jumpTime += delta
	if Input.is_key_pressed(KEY_SPACE):
		jump(delta)
	elif is_on_floor():
		jumpTime = 0
	if left:
		walk_left(delta)
	if right:
		walk_right(delta)
	if (was_left || was_right) and !left and !right:
		stop_walk()
	if Input.is_key_pressed(KEY_C) and dashes >  0 and timeSinceDash > dashCooldown:
		dash(delta)
	
	was_left = left
	was_right = right
	
	# APPLY MOVEMENT
	move_and_slide()
	
func updateVelocityQueue(delta):
	for i in range(velocityQueue.size() - 1, -1, -1):
		
		if velocityQueue[i].constant:
			if velocityQueue[i].add:
				velocity += velocityQueue[i].velocity * delta
			else:
				velocity = velocityQueue[i].velocity
		elif velocityQueue[i].time - delta <= 0:
			if velocityQueue[i].add:
				velocity += velocityQueue[i].velocity
			else:
				velocity = velocityQueue[i].velocity
		velocityQueue[i].time -= delta
		if velocityQueue[i].time <= 0:
			velocityQueue.pop_at(i)

func addToVeloctiyQueue(velocity: Vector2, time: float, constant: bool, add: bool):
	velocityQueue.push_back(QueueVelocity.new(velocity, time, constant, add)) 
	
	
func updateDashes(delta):
	if is_on_floor() and velocityBlock <= 0 - 0.01:
		dashes = 1
	
	
func applyGravity(delta):
	if velocityBlock <= 0:
		velocity.y += gravity * delta

func applyfriction(delta):
	if velocityBlock <= 0 and is_on_floor():
		if velocity.x > 0:
			velocity.x -= delta * decelerationAboveMax
		elif velocity.x < 0:
			velocity.x += delta * decelerationAboveMax
	
func updateIcon():
	if velocity.x != 0:
		get_node("AnimatedSprite2D").play("Walking")
	else:
		get_node("AnimatedSprite2D").play("Idle")
	if timeSinceDash > 0.25:
		get_node("GPUParticles2D").emitting = false
	else:
		get_node("GPUParticles2D").emitting = true
	

func updateTimes(delta):
	velocityBlock -= delta
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
	if velocityBlock <= 0:
		if velocity.x > -maxWalkVelocity:
			if velocity.x - (walkAcceleration * delta) < -maxWalkVelocity:
				velocity.x = -maxWalkVelocity
			elif velocity.x > -maxWalkVelocity:
				velocity.x -= walkAcceleration * delta

func walk_right(delta):
	get_child(0).scale.x = 1
	if velocityBlock <= 0:
		if velocity.x < maxWalkVelocity:
			if velocity.x + (walkAcceleration * delta) > maxWalkVelocity:
				velocity.x = maxWalkVelocity
			else:
				velocity.x += walkAcceleration * delta
	
func stop_walk():
	velocity.x = 0

func dash(delta):
	dashDir = get_dir().normalized()
	print(dashDir)
	addToVeloctiyQueue(dashDir * dashVelocity, dashTime, true, false)
	addToVeloctiyQueue(dashDir * afterDashVelocity, dashTime + delta, false, false)
	velocityBlock = 0.25
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
	
	
