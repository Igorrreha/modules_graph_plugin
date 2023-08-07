class_name MgpCellContentVisualizer
extends Node


@export var _signals_channel: MgpCellSignalsChannel
@export var _visualization_settings_pack: MgpTaggedResourcesPack


func _ready() -> void:
	_signals_channel.content_setted.connect(_on_cell_content_setted)


func _on_cell_content_setted(cell: MgpCell) -> void:
	var settings: = (_visualization_settings_pack
		.get_resource(cell.content.tag) as MgpCellVisualizationSettings)
	
	if not settings.content_tscn:
		return
	
	var content_node = settings.content_tscn.instantiate()
	content_node.setup(cell.content)
	cell.add_content_node(content_node)
