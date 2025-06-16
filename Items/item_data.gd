extends Resource
class_name ItemData

enum item_types {CROP, SEED, ITEM, TOOL}

@export var item_name: String
@export var item_type: item_types
@export var stackable: bool = true
@export var item_art: Texture2D
@export_multiline var description: String
