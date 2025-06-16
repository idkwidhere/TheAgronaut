extends CharacterBody2D
class_name Player

var speed = 160
var player_direction: Vector2


#interaction
var interactable: Array
var interactables: bool = false
var closest_interactable = 0
var closest_distance

# inventory
var is_player_menu_open = false
var player_inventory: InventoryData = preload("res://Entities/Player/player_inventory.tres")

#planting - will eventually be loaded from inventory
const CARROT = preload("res://Items/Crops/Carrot/carrot_seed.tres")

func _ready() -> void:
	SignalBus.connect("request_player_inventory", _send_player_inventory)

func _physics_process(delta: float) -> void:
	player_direction.x = Input.get_axis("move_left", "move_right")
	player_direction.y = Input.get_axis("move_up", "move_down")
	player_direction = player_direction.normalized()
	
	if player_direction.x > 0: 
		%PlayerSprite.flip_h = false
	elif player_direction.x < 0: 
		%PlayerSprite.flip_h = true
		
	if player_direction:
		velocity = player_direction * speed
		# do sprite animation here?
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		#more animation 
		
	move_and_slide()

func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and interactable:
		interactable[0].interact_handler()
	if Input.is_action_just_pressed("menu"):
		open_player_menu()

func open_player_menu():
	if !is_player_menu_open:
		SignalBus.emit_signal("player_inventory", player_inventory)
		%PlayerMenu.show()
		is_player_menu_open = true
	elif is_player_menu_open:
		%PlayerMenu.hide()
		is_player_menu_open = false

func find_closest_interactable(): # sort all interactables in range to get the closest one to interact with
	for item in interactable:
		pass

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.has_node("Interactable"):
		interactable.append(body)
		interactables = true
	if interactable:
		interactable[0].show_interaction()

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body in interactable:
		body.hide_interaction()
		interactable.erase(body)
	if !interactable:
		interactables = false

func subtract_player_inventory_item(item: SlotData) -> void:
	if item in player_inventory.contents:
		
		print("found it")

func _send_player_inventory() -> void:
	SignalBus.emit_signal("player_inventory", player_inventory)
