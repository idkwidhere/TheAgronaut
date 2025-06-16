extends Resource
class_name InventoryData

@export var contents: Array[SlotData]

func subtract_inventory_item(item: SlotData) -> void:
	var to_subtract = contents.find(item)
	print(to_subtract)
