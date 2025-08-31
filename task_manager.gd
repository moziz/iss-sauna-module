class_name TaskManager extends Node3D

var finished_interaction_event = 0

var ui: UI

func _ready():
	ui = get_parent().find_child("UI");
	assert(ui)

func _process(delta: float) -> void:
	pass

func interacted_with(interactable_id: int, target_object: Node) -> void:
	var requirement = ui.currentTask;
	if interactable_id == requirement:
		if target_object.has_method("Interact"):
			target_object.Interact(interactable_id)
		print("Task done")
		ui.ShowNextTask()
	else:
		print("Invalid interaction target. Required: ", requirement)


static func get_interaction_ids(name: String) -> Array:
	var ids = [];
	var splits = name.split(" ", false)
	for split in splits:
		ids.append(split.to_int())
	return ids

static func get_best_match_interaction_id(ids: Array, current_task_id: int):
	for id in ids:
		if id == current_task_id:
			return id
	return -1
