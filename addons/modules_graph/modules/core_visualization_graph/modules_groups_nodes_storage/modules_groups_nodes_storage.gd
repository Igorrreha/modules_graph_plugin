class_name MgpModulesGroupsNodesStorage
extends Node


@export var _graph_nodes_provider: MgpGraphNodesProvider
@export var _groups_storage: MgpModulesGroupsStorage


var groups: Dictionary#[MgpModulesGroup, Array[MgpGraphNode]]


func _ready() -> void:
	_groups_storage.group_appended.connect(_on_group_updated)
	_groups_storage.group_updated.connect(_on_group_updated)
	_groups_storage.group_removed.connect(_on_group_removed)


func _on_group_updated(group: MgpModulesGroup, modules: Array[MgpModule]) -> void:
	groups[group] = _get_modules_nodes(modules)


func _on_group_removed(group: MgpModulesGroup) -> void:
	groups.erase(group)


func _get_modules_nodes(modules: Array[MgpModule]) -> Array[MgpGraphNode]:
	var modules_entities: Array[Entity]
	modules_entities.assign(modules)
	return _graph_nodes_provider.provide_many(modules_entities)
