class_name ResourcesSaver
extends Node


@export var _collections: Array[ResourcesReactiveCollection]


func save() -> void:
	for collection in _collections:
		for resource in collection.resources:
			if resource.resource_path:
				ResourceSaver.save(resource)
