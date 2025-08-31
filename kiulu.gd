extends Node

@export var animationNode: Node 
@export var water: Node 
@export var waterTarget: Node 
var waterAnimation = false
var waterAnimationValue = 0

func _ready() -> void:
	water.visible = false

func Interact(id: int):
	print("kiulu")
	animationNode.Play()
	$AudioStreamPlayer3D.play()
	await get_tree().create_timer(0.33).timeout
	waterAnimation = true
	waterAnimationValue = 0
	water.visible = true

func _process(delta: float) -> void:
	if waterAnimation:
		water.global_position = self.global_position.lerp(waterTarget.global_position, waterAnimationValue)
		waterAnimationValue += 2 * delta
		if(waterAnimationValue > 1):
			waterAnimation = false
			water.visible = false
			var smoke = $"../../Smoke"
			smoke.restart()
			smoke.emitting = true
			$AudioStreamPlayer3D2.play()
	
