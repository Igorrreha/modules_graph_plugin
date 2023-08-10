extends Node


@export var _graph_nodes_provider: MgpGraphNodesProvider
@export var _nodes_connections_manager: MgpGraphNodesConnectionManager


func append(connection: MgpModulesConnection) -> void:
	var node_from = _graph_nodes_provider.provide(connection.module_from)
	var node_to = _graph_nodes_provider.provide(connection.module_to)
	_nodes_connections_manager.add_connection(node_from, node_to)
