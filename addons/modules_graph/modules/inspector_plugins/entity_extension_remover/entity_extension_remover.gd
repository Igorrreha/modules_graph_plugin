@tool
extends InspectorCustomControl


@export var _label: Label
@export var _remove_from_all_entities_button: Button
@export var _resources_loader: ResourcesFromFsLoader

var _inspected_object: Script
var _dependent_entities: Array[Entity]


func setup(object: Script) -> void:
	_inspected_object = object
	$Label.text = _get_class_name()


func _get_class_name() -> String:
	for script_line in _inspected_object.source_code.split("\n"):
		if script_line.begins_with("class_name"):
			return script_line.split(" ")[-1]
	
	return ""


func _ready() -> void:
	_remove_from_all_entities_button.pressed.connect(_remove_from_all_entities_pressed)
	_resources_loader.resource_loaded.connect(_on_resource_from_fs_loaded)


func _remove_from_all_entities_pressed() -> void:
	_resources_loader.load_resources()
	
	print(_dependent_entities)
	
	for entity in _dependent_entities:
		entity.extensions.erase(_inspected_object)
		ResourceSaver.save(entity)
	
	_dependent_entities.clear()


func _on_resource_from_fs_loaded(resource: Resource) -> void:
	var entity = resource as Entity
	if not entity:
		return
	
	if entity.extensions.has(_inspected_object):
		_dependent_entities.append(entity)
