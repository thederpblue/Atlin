class_name QueueVelocity

var velocity: Vector2
var time: float
var constant: bool
var add: bool

func _init(velocity: Vector2, time: float, constant: bool, set: bool):
	self.velocity = velocity
	self.time = time
	self.constant = constant
