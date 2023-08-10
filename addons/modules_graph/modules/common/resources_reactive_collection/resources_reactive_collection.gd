class_name ResourcesReactiveCollection
extends ReactiveResource


signal resource_appended(resource: Resource)


@export var item_script: Script
@export var resources: Array[Resource]


func try_append(resource: Resource, caller: Callable) -> bool:
	if _match_type(resource):
		resources.append(resource)
		set_value("resources", resources, caller)
		
		resource_appended.emit(resource)
		return true
	
	return false


func _match_type(resource: Resource) -> bool:
	return resource.get_script() == item_script
