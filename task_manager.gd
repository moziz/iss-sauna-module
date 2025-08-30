class_name TaskManager extends Node3D

var taskRequirement = [
	0, 1, 2
]

var finished_interaction_event = 0

var ui: UI

func _ready():
	ui = get_parent().find_child("UI");
	assert(ui)

func _process(delta: float) -> void:
	pass

func interacted_with(interactable_id: int, target_object: Node) -> void:
	var requirement = taskRequirement[ui.currentTask];
	if interactable_id == requirement:
		if target_object.has_method("Interact"):
			target_object.Interact()
		print("Task done")
		ui.ShowNextTask()
	else:
		print("Invalid interaction target. Required: ", requirement)
