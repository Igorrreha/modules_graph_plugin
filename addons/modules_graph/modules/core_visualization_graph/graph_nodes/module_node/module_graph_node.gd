extends MgpGraphNode


@export var _graph_node_position_extension: Script
var _content: Entity


func setup(content: Entity) -> void:
	super.setup(content)
	
	if _content:
		_content.remove_callback("resource_name", _on_content_name_updated)
	
	_content = content
	_content.bind("resource_name", _on_content_name_updated)
	
	_on_content_name_updated()


func _on_content_name_updated() -> void:
	if _content:
		title = _content.resource_name


func _ready() -> void:
	position_offset_changed.connect(_on_position_offset_changed)


func _on_position_offset_changed() -> void:
	(_content.extensions.get(_graph_node_position_extension)
		.position) = position_offset
