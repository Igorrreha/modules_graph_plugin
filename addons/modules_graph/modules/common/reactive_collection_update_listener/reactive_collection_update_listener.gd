extends Node


signal collection_updated(value: Array[Resource])
signal resource_appended(resource: Resource)


@export var _collection: ResourcesReactiveCollection


func _ready() -> void:
	var handler = _collection.get_handler("resources")
	handler.bind(_on_collection_updated)
	_collection.resource_appended.connect(_on_resource_appended)


func _on_collection_updated() -> void:
	collection_updated.emit(_collection.resources)


func _on_resource_appended(resource: Resource) -> void:
	resource_appended.emit(resource)
