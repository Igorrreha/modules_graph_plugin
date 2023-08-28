class_name MgpModulesGroupsStorage
extends Node


signal group_appended(group: MgpModulesGroup, modules: Array[MgpModule])
signal group_updated(group: MgpModulesGroup, modules: Array[MgpModule])
signal group_removed(group: MgpModulesGroup)


@export var _graph_nodes_provider: MgpGraphNodesProvider
@export var _modules_collection: ResourcesReactiveCollection
@export var _groups_collection: ResourcesReactiveCollection


var groups: Dictionary#[MgpNodesGroup, Array[MgpModule]]


func _ready() -> void:
	_modules_collection.resource_appended.connect(_on_module_appended)
	_modules_collection.resource_removed.connect(_on_module_removed)
	_groups_collection.resource_appended.connect(_on_group_appended)
	_groups_collection.resource_removed.connect(_on_group_removed)


func _on_module_appended(module: MgpModule) -> void:
	for group in _groups_collection.resources:
		var group_dir = group.resource_path.get_base_dir()
		if not module.resource_path.begins_with(group_dir):
			continue
		
		groups[group].append(module)
		group_updated.emit(group, groups[group])


func _on_module_removed(module: MgpModule) -> void:
	for group in groups:
		if groups[group].has(module):
			groups[group].erase(module)
			group_updated.emit(group, groups[group])


func _on_group_appended(group: MgpModulesGroup) -> void:
	groups[group] = _get_modules_in_group(group)
	group_appended.emit(group, groups[group])


func _on_group_removed(group: MgpModulesGroup) -> void:
	groups.erase(group)
	group_removed.emit(group)


func _get_modules_in_group(group: MgpModulesGroup) -> Array[MgpModule]:
	var modules_in_group: Array[MgpModule]
	var group_dir = group.resource_path.get_base_dir()
	
	for module in _modules_collection.resources:
		if module.resource_path.begins_with(group_dir):
			modules_in_group.append(module as MgpModule)
	
	return modules_in_group
