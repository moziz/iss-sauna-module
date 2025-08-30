extends Control

var informationTexts = [
"Info\nI am info",
"Info\nI am info too",
"Info\nI am info three"]
			
var taskTexts = [
"Task\nFirst task",
"Task\nSecond task",
"Task\nThird task"]

var currentInfo = 0
var currentTask = 0
var collisionTimer = 0

func _init() -> void:
	pass
	
func _ready() -> void:
	var ray =  $"../PlayerPawn/Camera/ViewRay"
	ray.target_position.z = -0.4
	HideInfo()
	
func _process(delta: float) -> void:
	var ray =  $"../PlayerPawn/Camera/ViewRay"
	var targetObject = ray.get_collider()
	if(ray.is_colliding()):
		if(targetObject.is_in_group("Interactable")):
			collisionTimer = 0
			ShowInfo(targetObject.get_name().to_int())
			if Input.is_key_pressed(KEY_ENTER): 
				print("Interact!")
				targetObject.Interact()
	else:
		if(collisionTimer > 0.33):
			HideInfo()
		else:
			collisionTimer += delta

func _input(event):
	if Input.is_key_pressed(KEY_1): 
		ShowInfo(0)
		
	if Input.is_key_pressed(KEY_2): 
		ShowInfo(1)
		
	if Input.is_key_pressed(KEY_3): 
		ShowInfo(2)
		
	if Input.is_key_pressed(KEY_0): 
		HideInfo()
		
	if Input.is_key_pressed(KEY_N): 
		ShowNextTask()

func ShowInfo(index):
	var infoBox = $InfoBox
	if(!infoBox.visible || index != currentInfo):
		print("Show info")
		print(index)
		var infoText = $InfoBox/Info
		infoText.text = informationTexts[index]
		infoBox.visible = true
		currentInfo = index

func HideInfo():
	var infoBox = $InfoBox
	if(infoBox.visible):
		print("Hide info")
		infoBox.visible = false
	
func ShowTask(index):
	if(index < taskTexts.size() &&  index >= 0):
		currentTask = index
		var taskText = $TaskBox/Task
		taskText.text = taskTexts[currentTask]
	
func ShowNextTask():
	currentTask += 1
	ShowTask(currentTask)
