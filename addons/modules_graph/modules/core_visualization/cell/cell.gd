class_name MgpCell
extends PanelContainer


@export var _signals_channel: MgpCellSignalsChannel
var content: MgpEntity


func is_empty() -> bool:
	return not content;


func set_content(content: MgpEntity) -> void:
	self.content = content
	_signals_channel.content_setted.emit(self)
