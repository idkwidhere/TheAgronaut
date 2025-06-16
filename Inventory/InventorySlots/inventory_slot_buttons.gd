extends Button

@onready var item_texture: TextureRect = $MarginContainer/ItemTexture
@onready var quantity_label: Label = $QuantityLabel

var item_data: ItemData
var selected

func set_slot_data(slot_data: SlotData) -> void:
	item_data = slot_data.item_data
	item_texture.texture = item_data.item_art
	tooltip_text = "%s\n%s" % [item_data.item_name, item_data.description]
	
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		selected = item_data
	else:
		selected = null
