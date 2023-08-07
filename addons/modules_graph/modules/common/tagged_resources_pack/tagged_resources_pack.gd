class_name MgpTaggedResourcesPack
extends Resource


@export var _resources: Array[MgpTaggedResource]
var _resources_dictionary: Dictionary


var _resources_dictionary_filled: bool


func get_resource(tag: MgpEntityTag) -> Resource:
	if not _resources_dictionary_filled:
		for tagged_resource in _resources:
			_resources_dictionary[tagged_resource.tag] = tagged_resource.resource
		_resources_dictionary_filled = true
	
	return (_resources_dictionary[tag] if _resources_dictionary.has(tag)
		else null)
