extends TextureRect

@export var moveX: float 
@export var moveY: float 

var startX: float 
var startY: float 
var valueX: float
var valueY: float

func _ready() -> void:
	startX = position.x
	startY = position.y
	valueX = 0
	valueY = 0

func _process(delta: float) -> void:
	valueX += delta * 0.6
	valueY += delta * 0.77
	self.position.x = sin(valueX) * moveX + startX
	self.position.y = cos(valueY) * moveY + startY
