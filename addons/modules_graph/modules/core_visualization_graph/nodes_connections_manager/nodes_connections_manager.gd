class_name MgpGraphNodesConnectionManager
extends Node


var connections: Dictionary#[GraphNode, Array[GraphNode]]


func add_connection(node_from: GraphNode, node_to: GraphNode) -> void:
	if not connections.has(node_from):
		var connections_array: Array[GraphNode]
		connections[node_from] = connections_array
	
	if not connections[node_from].has(node_to):
		connections[node_from].append(node_to)


func remove_connection(node_from: GraphNode, node_to: GraphNode) -> void:
	if not connections.has(node_from):
		return
	
	connections[node_from].erase(node_to)
