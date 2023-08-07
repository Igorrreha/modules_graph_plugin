class_name MgpCell
extends PanelContainer


@export var _signals_channel: MgpCellSignalsChannel
var content: MgpEntity
var _content_node: Node


func is_empty() -> bool:
	return not content;


func set_content(content: MgpEntity) -> void:
	self.content = content
	if _content_node:
		_content_node.queue_free()
	
	_signals_channel.content_setted.emit(self)


func add_content_node(node: Node) -> void:
	add_child(node)
	_content_node = node
