class_name UI extends Control

var informationTexts = [
"Info\nSauna heater",		#0
"Info\nSauna ventilation",	#1
"Info\nClothes net",		#2
"Info\nShower door",		#3
"Info\nShower feet clamps",	#4
"Info\nShower start",		#5
"Info\nShower head",		#6
"Info\nShower stop",		#7
"Info\nSauna door",			#8
"Info\nSauna feet clamps",	#9
"Info\nKiulu",				#10
"Info\nSauna whisk",		#11
"Info\nBeer",				#12
"Info\nRadio",				#13
"Info\nSmart window",		#14
"Info\nSauna stove",		#15
"Info\nTemperature sensor"]	#16
			
var taskTexts = [
"Task 1|20\nTurn the sauna heater on",
"Task 2|20\nTurn the sauna ventilation on",
"Task 3|20\nTake off your clothes",
"Task 4|20\nOpen the shower door",
"Task 5|20\nSecure your feet to the shower",
"Task 6|20\nClose the shower door",
"Task 7|20\nStart the shower",
"Task 8|20\nClean yourself with the shower head",
"Task 9|20\nStop and ventilate the shower",
"Task 10|20\nDetach yourself",
"Task 11|20\nOpen the shower door",
"Task 12|20\nOpen the sauna door",
"Task 13|20\nGo inside sauna",
"Task 14|20\nClose the sauna door",
"Task 15|20\nAttach yourself to the floor",
"Task 16|20\nThrow löyly!",
"Task 17|20\nUse the sauna whisk",
"Task 18|20\nThrow löyty!",
"Task 19|20\nEnjoy a cold one",
"Task 20|20\nThrow löyty!"]

var currentInfo = 0
var currentTask = 0
var collisionTimer = 0

var taskManager: TaskManager
var player: PlayerPawn

func _init() -> void:
	pass

func _ready() -> void:
	var ray =  $"../PlayerPawn/Camera/ViewRay"
	ray.target_position.z = -0.4
	taskManager = get_parent().find_child("TaskManager")
	player = get_parent().find_child("PlayerPawn")
	HideInfo()
	var fade = $Fade
	fade.visible = false
	fade.color.a = 0

func _process(delta: float) -> void:
	var fade = $Fade
	if fade.visible:
		fade.color.a += delta * 0.33
		return
	
	var ray =  $"../PlayerPawn/Camera/ViewRay"
	var targetObject = ray.get_collider()
	if(ray.is_colliding()):
		if(targetObject.is_in_group("Interactable")):
			collisionTimer = 0
			var interaction_object_id = targetObject.get_name().to_int()
			ShowInfo(interaction_object_id)
			#if Input.is_key_pressed(KEY_ENTER):
			if Input.is_action_pressed("interact"):
				taskManager.interacted_with(interaction_object_id, targetObject)
	else:
		if(collisionTimer > 0.33):
			HideInfo()
		else:
			collisionTimer += delta
	
	var spacebar = $Spacabar
	spacebar.visible = player.is_jump_allowed()

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
		var mouse = $Mouse
		mouse.visible = true

func HideInfo():
	var infoBox = $InfoBox
	if(infoBox.visible):
		print("Hide info")
		infoBox.visible = false
		var mouse = $Mouse
		mouse.visible = false
	
func ShowTask(index):
	if(index < taskTexts.size() &&  index >= 0):
		currentTask = index
		var taskText = $TaskBox/Task
		taskText.text = taskTexts[currentTask]
	
func ShowNextTask():
	currentTask += 1
	ShowTask(currentTask)
	
func ShowSpacebar():
	var space = $Spacebar
	space.visible = true
	
func HideSpacebar():
	var space = $Spacebar
	space.visible = false
	
func FadeToEnd():
	var fade = $Fade
	fade.visible = true
