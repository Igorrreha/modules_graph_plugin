class_name ResourcesSaver
extends Node


@export var _collection: ResourcesReactiveCollection


func save() -> void:
	for resource in _collection.resources:
		if resource.resource_path:
			print(resource.resource_name)
			ResourceSaver.save(resource)
