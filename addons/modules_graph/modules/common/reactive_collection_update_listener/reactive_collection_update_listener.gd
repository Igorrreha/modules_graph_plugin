extends Node


signal collection_updated(value: Array[Resource])


@export var _collection: ResourcesReactiveCollection


func _ready() -> void:
	var handler = _collection.get_handler("resources")
	handler.bind(_on_collection_updated)


func _on_collection_updated() -> void:
	collection_updated.emit(_collection.resources)
