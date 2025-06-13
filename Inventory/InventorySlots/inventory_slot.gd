extends PanelContainer

@onready var item_texture: TextureRect = $MarginContainer/ItemTexture
@onready var quantity_label: Label = $QuantityLabel

func set_slot_data(slot_data: SlotData) -> void:
	var item_data = slot_data.item_data
	item_texture.texture = item_data.item_art
	tooltip_text = "%s\n%s" % [item_data.item_name, item_data.description]
	
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()
