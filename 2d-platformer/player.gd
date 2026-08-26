extends CharacterBody2D

var was_left = false
var was_right = false

var respawnPoint = Vector2(0,0)
var velocityQueue = []
var velocityBlock = 0


var maxDashes = 1
var dashes = maxDashes


var timeSinceDash = 0
var timeOnFloor = 0
var jumpTime = 0

var fallMaxSpeed = 160

var airTime = 0

var gravity = 900

var isClimbing = false
var isClimbJumping = false

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

var lookingAtPhone = false

@onready var col_shape_node := $CollisionShape2D

func _ready():
	respawnPoint = position 
	velocity = ScreenHolder.carry_velocity

func _physics_process(delta):
	get_node("Label").text = str(velocity)
	updateTimes(delta)
	updateIcon()
	applyfriction(delta)
	applyGravity(delta)
	updateDashes(delta)
	updateVelocityQueue(delta) 
	updateClimbing(delta)
	
	
	
	
	#DETECT MOVEMENT
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	
	jumpTime += delta
	if Input.is_action_pressed("jump"):
		jump(delta)
	if Input.is_action_just_pressed("jump"):
		intitialJump(delta)
	elif is_on_floor():
		jumpTime = 0
	if left:
		walk_left(delta)
	if right:
		walk_right(delta)
	if (was_left || was_right) and !left and !right:
		stop_walk()
	if Input.is_action_just_pressed("dash") and dashes >  0 and timeSinceDash > dashCooldown:
		dash(delta)
	if Input.is_action_pressed("grab"):
		climb(delta)
	if Input.is_action_just_released("grab"):
		isClimbing = false
	
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
		if dashes < maxDashes:
			dashes = maxDashes
func updateClimbing(delta):
	if !is_on_wall():
		isClimbing = false
	
func applyGravity(delta):
	if velocityBlock <= 0 && !isClimbing:
		velocity.y += gravity * delta

func applyfriction(delta):
	if velocityBlock <= 0 and is_on_floor():
		if velocity.x > 0:
			velocity.x -= delta * decelerationAboveMax
		elif velocity.x < 0:
			velocity.x += delta * decelerationAboveMax
	
func updateIcon():
	if lookingAtPhone:
		get_node("AnimatedSprite2D").play("Phone_msg")
	elif velocity.y > 0:
		get_node("AnimatedSprite2D").play("Falling")
	elif velocity != Vector2.ZERO:
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
	if (jumpTime > 0 and jumpTime <= maxJumpTime) and !is_on_floor():
			velocity.y = -jumpVelocity 
func intitialJump(delta):
	if self.is_on_floor():
		velocity.y -=jumpVelocity
	if isClimbing:
		velocity.y -=2*jumpVelocity
		isClimbing = false
		isClimbJumping = true
		await get_tree().create_timer(0.1).timeout
		isClimbJumping = false


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
	addToVeloctiyQueue(dashDir * dashVelocity, dashTime, true, false)
	addToVeloctiyQueue(dashDir * afterDashVelocity, dashTime + delta, false, false)
	velocityBlock = 0.25
	dashes -= 1
	timeOnFloor = -0.25
	timeSinceDash = 0

func climb(delt):
	if is_on_wall() && !isClimbJumping:
		velocity.y = 0
		isClimbing = true
		
func get_dir():
	var dir = Vector2(0,0)
	if Input.is_action_pressed("left"):
		dir.x = -1
	elif Input.is_action_pressed("right"):
		dir.x = 1
	if Input.is_action_pressed("up"):
		dir.y = -1
	elif Input.is_action_pressed("down"):
		dir.y = 1
	if dir == Vector2(0,0):
		dir.x = get_child(0).scale.x
	
	return dir
	
	
