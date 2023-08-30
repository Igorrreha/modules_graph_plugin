extends HBoxContainer


signal removing_requested


@export var _group_drawing_settings_ex: Script

var state: MgpModulesGroup
var _drawing_settings_state: MgpModulesGroupDrawingSettings

@onready var _name_field: LineEdit = $Name
@onready var _color_field: ColorPickerButton = $Color


func setup(state: MgpModulesGroup) -> void:
	if self.state:
		self.state.remove_callback("resource_name", _on_group_name_updated)
	
	if _drawing_settings_state:
		_drawing_settings_state.remove_callback("line_color", _on_line_color_updated)
	
	self.state = state
	self.state.bind("resource_name", _on_group_name_updated, _on_name_text_changed)
	
	if self.state.extensions.has(_group_drawing_settings_ex):
		_drawing_settings_state = (self.state.extensions[_group_drawing_settings_ex]
			as MgpModulesGroupDrawingSettings)
		_drawing_settings_state.bind("line_color", _on_line_color_updated, _on_line_color_changed)
	
	_on_group_name_updated()
	_on_line_color_updated()


func _ready() -> void:
	_name_field.text_changed.connect(_on_name_text_changed)
	_color_field.color_changed.connect(_on_line_color_changed)


func _exit_tree() -> void:
	state.remove_callback("resource_name", _on_group_name_updated)
	_drawing_settings_state.remove_callback("line_color", _on_line_color_updated)


func _on_group_name_updated() -> void:
	_name_field.text = state.resource_name


func _on_name_text_changed(new_value: String) -> void:
	if state:
		state.set_value("resource_name", new_value, _on_name_text_changed)


func _on_line_color_updated() -> void:
	_color_field.color = _drawing_settings_state.line_color


func _on_line_color_changed(new_value: Color) -> void:
	if _drawing_settings_state:
		_drawing_settings_state.set_value("line_color", new_value, _on_line_color_changed)
