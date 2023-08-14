extends EditorInspectorPlugin


var _entity_extension_script: Script = preload("res://addons/modules_graph/modules/common/entity/entity_extension.gd")
var _custom_controls_tscns: ScenesCollection = preload("res://addons/modules_graph/modules/inspector_plugins/entity_extension/custom_controls_tscns.tres")
var _custom_controls: Array[Node]


func _can_handle(object: Object) -> bool:
	return (object is Script
	and object.get_base_script() == _entity_extension_script)


func _parse_begin(object: Object) -> void:
	for scene in _custom_controls_tscns.scenes:
		var custom_control = scene.instantiate() as InspectorCustomControl
		custom_control.setup(object)
		add_custom_control(custom_control)
