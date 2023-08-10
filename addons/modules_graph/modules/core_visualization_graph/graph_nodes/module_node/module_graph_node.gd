extends MgpGraphNode


@export var _graph_node_position_extension: Script
var _content: Entity


func setup(content: Entity) -> void:
	super.setup(content)
	_content = content
	title = _content.resource_name


func _ready() -> void:
	position_offset_changed.connect(_on_position_offset_changed)


func _on_position_offset_changed() -> void:
	(_content.extensions.get(_graph_node_position_extension)
		.position) = position_offset
