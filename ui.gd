class_name UI extends Control

var informationTexts = [
"Info\nHello space traveler! I am your friendly sauna gnome assistant, ready to help!\nBefore entering the sauna, cleanse your spirit with a refreshing shower.\nMeanwhile, ISS waste heat will be heating the sauna.\nReady to get your sweat on?",
"Info\nThis Sweat Collector gathers the sweat bubbles excreted during a sauna session and gathers it for water recycling. Did you know? You are drinking the sweat of your colleagues!",
"Info\nA net for your clothes. Buck naked in the sauna, as they say!",
"Info\nShower door",
"Info\nWhoa! Dont float away, space cowboy! These feet clamps include temperature and shower controls usable by twisting your feet.",
"Info\nShower door",
"Info\nShower start",
"Info\nThe shower works much like a normal shower – except it’s more contained, and the water stays floating inside of the shower!",
"Info\nTurns off the shower and sucks the water out with the suction head by pressing this button.",
"Info\nDetach feet",
"Info\nShower door",
"Info\nSauna door",
"Info\nSauna feet clamps - time to get sweatin!",
"Info\nSauna door",
"Info\nPerfect for watering rocks. They’re thirsty!",
"Info\nSauna whisk. Made of plastic (what a disgrace).\nReal birch branches would create too much debris.",
"Info\nMore löyly!",
"Info\nBeer",
"Info\nEven more löyly!!!",
"Info\nRadio",
"Info\nSmart window",
"Info\nSauna stove",
"Info\nTemperature sensor"]

var taskTexts = [
"Task 1|20\nTurn on the sauna heater",
"Task 2|20\nTurn on the sauna ventilation ",
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
"Task 13|20\nAttach yourself to the floor",
"Task 14|20\nClose the sauna door",
"Task 15|20\nThrow löyly!",
"Task 16|20\nUse the sauna whisk",
"Task 17|20\nThrow löyty!",
"Task 18|20\nEnjoy a cold one",
"Task 19|20\nThrow löyty!",
"All tasks done. Enjoy life."]

var currentInfo = 0
var currentTask = 0
var collisionTimer = 0

var taskManager: TaskManager
var player: PlayerPawn

func _init() -> void:
	pass

func _ready() -> void:
	var ray =  $"../PlayerPawn/Camera/ViewRay"
	ray.target_position.z = -1.6
	taskManager = get_parent().find_child("TaskManager")
	player = get_parent().find_child("PlayerPawn")
	HideInfo()
	var fade = $Fade
	fade.visible = false
	fade.color.a = 0
	ShowTask(0)

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
			var interaction_object_ids = TaskManager.get_interaction_ids(targetObject.get_name())
			var best_match_interaction_id = TaskManager.get_best_match_interaction_id(interaction_object_ids, currentTask)
			ShowInfo(best_match_interaction_id if best_match_interaction_id > 0 else interaction_object_ids[0])
			#if Input.is_key_pressed(KEY_ENTER):
			if Input.is_action_pressed("interact"):
				taskManager.interacted_with(best_match_interaction_id, targetObject)
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
	if(index == 19):
		FadeToEnd()
	
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
