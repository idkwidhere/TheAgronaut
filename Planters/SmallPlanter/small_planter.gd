extends StaticBody2D
class_name SmallPlanter

#interaction and notification
var showing_interaction = false
#interact menu
var is_menu_open = false
var crop_to_plant: ItemData


#growing stuff
var is_growing = false
var is_empty = true
var current_crop: ItemData
var crop_stages: int
var current_crop_stage: int
var crop_stage_art: Array
var current_crop_stage_art: Texture2D

var selected_crop: ItemData
var player_inventory: InventoryData

#seed selection
const INVENTORY_SLOT = preload("res://Inventory/InventorySlots/inventory_slot_buttons.tscn")
@onready var seed_container: GridContainer = $PlanterMenu/PanelContainer/MarginContainer/SeedContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("player_inventory", set_inventory_data)


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
		SignalBus.emit_signal("request_player_inventory")
		
	elif is_growing and is_menu_open:
		%PlanterMenu.hide()
		is_menu_open = false
	else:
		print("Not ready!")


func start_crop(seed_resource):
	if !is_growing:
		is_growing = true
		is_empty = false
		current_crop_stage = 1
		current_crop = seed_resource
		crop_stage_art = seed_resource.crop_stage_art
		current_crop_stage_art = crop_stage_art[current_crop_stage - 1]
		%CurrentCrop.texture = current_crop_stage_art
		print(str(current_crop.item_name) + " planted") 
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


func set_inventory_data(inventory_data: InventoryData) -> void:
	populate_item_grid(inventory_data.contents)
	player_inventory = inventory_data
	
func populate_item_grid(slot_datas: Array[SlotData]) -> void:
	for child in seed_container.get_children():
		child.queue_free()
		
	for slot_data in slot_datas:
		var slot = INVENTORY_SLOT.instantiate()
		if slot_data and slot_data.item_data.item_type == 1:
			seed_container.add_child(slot)
			
			if slot_data:
				slot.set_slot_data(slot_data)


func _on_plant_button_pressed() -> void:
	var selections = seed_container.get_children()
	var to_subtract
	for selection in selections:
		if selection.selected:
			start_crop(selection.item_data)
			
		else:
			print("no crop selected!")
