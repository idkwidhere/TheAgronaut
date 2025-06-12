extends Resource
class_name Crop

@export_category("Crop Info")
@export var crop_name: String
@export var crop_stages: int
@export var crop_stage_time: float

@export_category("Crop Art")
@export var crop_seed_art: Texture2D
@export var crop_stage_art: Array[Texture2D]
