extends VBoxContainer


@export var _graph: MgpGraph
@export var _groups_storage: MgpModulesGroupsStorage

@onready var _groups_nodes_container: ReactiveCollectionContainer = $GroupsContainer


var _state: MgpModulesGroupsInspectorState


func _ready() -> void:
	_graph.node_selected.connect(_on_graph_node_selected)
	_state = MgpModulesGroupsInspectorState.new()
	_groups_nodes_container.setup(_state.get_handler("groups"))


func _on_graph_node_selected(node: Node) -> void:
	if not node is MgpGraphNode or not node.content is MgpModule:
		return
	
	var groups: Array[MgpModulesGroup]
	for group in _groups_storage.groups:
		if _groups_storage.groups[group].has(node.content):
			groups.append(group)
	
	_state.set_value("groups", groups)
