class_name MgpGraphNodesGroupsStorage
extends Node


var groups: Dictionary#[String, Array[MgpGraphNode]]


func append_group(group_id: StringName, nodes: Array[MgpGraphNode]) -> void:
	groups[group_id] = nodes


func update_group(group_id: StringName, nodes: Array[MgpGraphNode]) -> void:
	append_group(group_id, nodes)


func remove_group(group_id: StringName) -> void:
	groups.erase(group_id)
