class_name MgpGraphNodesProvider
extends Node


@export var _graph: MgpGraph


var _nodes_by_content: Dictionary#[Entity, MgpGraphNode]


func provide(content: Entity) -> MgpGraphNode:
	return _nodes_by_content.get(content)


func _ready() -> void:
	_graph.child_entered_tree.connect(_on_graph_child_entered_tree)
	_graph.child_exiting_tree.connect(_on_graph_child_exiting_tree)


func _on_graph_child_entered_tree(child: Node) -> void:
	if not child is MgpGraphNode:
		return
	
	_nodes_by_content[child.content] = child


func _on_graph_child_exiting_tree(child: Node) -> void:
	if not child is MgpGraphNode:
		return
	
	_nodes_by_content.erase(child.content)
