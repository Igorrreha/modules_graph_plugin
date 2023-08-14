extends Node


@export var _nodes_groups_storage: MgpGraphNodesGroupsStorage
@export var _graph_nodes_provider: MgpGraphNodesProvider
@export var _groups_content_storage: MgpModulesGroupsContentStorage


func _ready() -> void:
	_groups_content_storage.group_appended.connect(_on_group_appended)
	_groups_content_storage.group_updated.connect(_on_group_updated)
	_groups_content_storage.group_removed.connect(_on_group_removed)


func _on_group_appended(group: MgpModulesGroup, modules: Array[MgpModule]) -> void:
	_nodes_groups_storage.append_group(_get_group_id(group),
		_get_modules_nodes(modules))


func _on_group_updated(group: MgpModulesGroup, modules: Array[MgpModule]) -> void:
	_nodes_groups_storage.update_group(_get_group_id(group),
		_get_modules_nodes(modules))


func _on_group_removed(group: MgpModulesGroup) -> void:
	_nodes_groups_storage.remove_group(_get_group_id(group))


func _get_group_id(group: MgpModulesGroup) -> String:
	return str(group.resource_name)


func _get_modules_nodes(modules: Array[MgpModule]) -> Array[MgpGraphNode]:
	var modules_entities: Array[Entity]
	modules_entities.assign(modules)
	return _graph_nodes_provider.provide_many(modules_entities)
