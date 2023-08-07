extends MarginContainer


@export var _name_label: Label


func setup(module: MgpModule) -> void:
	_name_label.text = module.resource_name
