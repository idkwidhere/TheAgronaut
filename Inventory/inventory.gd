extends PanelContainer

const INVENTORY_SLOT = preload("res://Inventory/InventorySlots/inventory_slot.tscn")
@onready var item_grid: GridContainer = $MarginContainer/ItemGrid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("player_inventory", set_inventory_data)


func set_inventory_data(inventory_data: InventoryData) -> void:
	populate_item_grid(inventory_data.contents)
	
func populate_item_grid(slot_datas: Array[SlotData]) -> void:
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in slot_datas:
		var slot = INVENTORY_SLOT.instantiate()
		item_grid.add_child(slot)
		
		if slot_data:
			slot.set_slot_data(slot_data)
