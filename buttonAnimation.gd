extends Node

var startPos
@export var targetPos: Vector3 
var startRot
@export var targetRot: Quaternion 
@export var speed: float 
@export var curve: Curve

var isAnimating 
var value

func _ready() -> void:
	startPos = self.position
	startRot = self.quaternion

func Play():
	if(!isAnimating):
		isAnimating = true
		value = 0
	
func _process(delta: float) -> void:
	if(isAnimating):
		value += speed * delta
		var sample = curve.sample(value)
		self.position = startPos.lerp(targetPos, sample)
		self.quaternion = startRot.slerp(targetRot, sample)
		print ("animation")
		if(value >= 1):
			isAnimating = false
