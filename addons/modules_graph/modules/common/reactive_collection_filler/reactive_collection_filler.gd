class_name ReactiveCollectionFiller
extends Node


@export var _collection: ResourcesReactiveCollection


func add_item(item: Resource) -> void:
	_collection.try_append(item, add_item)
