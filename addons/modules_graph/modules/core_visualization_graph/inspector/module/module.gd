extends VBoxContainer


@export var _graph: MgpGraph

var _module: MgpModule

@onready var _name_field: LineEdit = $Name


func _ready() -> void:
	_graph.node_selected.connect(_on_graph_node_selected)
	_name_field.text_changed.connect(_on_module_name_changed)


func _on_graph_node_selected(node: Node) -> void:
	if (not node is MgpGraphNode
	or not node.content is MgpModule
	or node.content == _module):
		return
	
	if _module:
		_module.remove_callback("resource_name", _on_module_name_updated)
	
	_module = node.content
	_module.bind("resource_name", _on_module_name_updated, _on_module_name_changed)
	
	_on_module_name_updated()


func _on_module_name_updated() -> void:
	if _module:
		_name_field.text = _module.resource_name


func _on_module_name_changed(new_value: String) -> void:
	_module.set_value("resource_name", new_value, _on_module_name_changed)
