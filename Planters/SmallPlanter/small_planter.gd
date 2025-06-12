extends StaticBody2D
class_name SmallPlanter

#interaction and notification
var showing_interaction = false
#interact menu
var is_menu_open = false
var crop_to_plant: Crop


#growing stuff
var is_growing = false
var is_empty = true
var current_crop: Crop
var crop_stages: int
var current_crop_stage: int
var crop_stage_art: Array
var current_crop_stage_art: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func test():
	print("interacted with " + str(self))

func show_interaction():
	showing_interaction = true
	%Interactable.show()
	
func hide_interaction():
	showing_interaction = false
	%Interactable.hide()

func interact_handler(crop):
	
	if !is_growing and !is_empty:
		collect_crop()
	elif !is_growing and is_empty:
		%PlanterMenu.show()
		is_menu_open = true
		start_crop(preload("res://Crops/Carrot/carrotstats.tres"))
		
	elif is_growing and is_menu_open:
		%PlanterMenu.hide()
		is_menu_open = false
	else:
		print("Not ready!")
	
		
func start_crop(crop_resource):
	if !is_growing:
		is_growing = true
		is_empty = false
		current_crop_stage = 1
		current_crop = crop_resource
		crop_stage_art = crop_resource.crop_stage_art
		current_crop_stage_art = crop_stage_art[current_crop_stage - 1]
		%CurrentCrop.texture = current_crop_stage_art
		print(str(current_crop.crop_name) + " planted") 
		%GrowTimer.wait_time = current_crop.crop_stage_time
		%GrowTimer.start()
		


func collect_crop():
	%CurrentCrop.texture = null
	is_empty = true


func _on_grow_timer_timeout() -> void:
	current_crop_stage += 1
	current_crop_stage_art = crop_stage_art[current_crop_stage - 1]
	%CurrentCrop.texture = current_crop_stage_art
	if current_crop_stage < current_crop.crop_stages + 1:
		%GrowTimer.start()
	else:
		is_growing = false
		current_crop = null


func _on_plant_button_pressed() -> void:
	pass
