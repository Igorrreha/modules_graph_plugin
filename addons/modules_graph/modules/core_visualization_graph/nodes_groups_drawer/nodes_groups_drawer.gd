extends Node


@export var _graph: GraphEdit
@export var _groups_nodes_storage: MgpModulesGroupsNodesStorage

@export var _default_drawing_settings: MgpModulesGroupDrawingSettings


func _ready() -> void:
	_graph.draw.connect(_on_graph_draw)


func _on_graph_draw() -> void:
	var zoom = _graph.zoom
	
	for group in _groups_nodes_storage.groups:
		var drawing_settings = _get_drawing_settings(group)
		var line_width = drawing_settings.line_width * zoom
		
		var top_left_point = Vector2.INF
		var bottom_right_point = -Vector2.INF
		for node in _groups_nodes_storage.groups[group]:
			if top_left_point.x > node.position.x:
				top_left_point.x = node.position.x
			if bottom_right_point.x < node.position.x + node.size.x * zoom:
				bottom_right_point.x = node.position.x + node.size.x * zoom
			
			if top_left_point.y > node.position.y:
				top_left_point.y = node.position.y
			if bottom_right_point.y < node.position.y + node.size.y * zoom:
				bottom_right_point.y = node.position.y + node.size.y * zoom
		
		var group_rect = Rect2(top_left_point, bottom_right_point - top_left_point)
		_graph.draw_rect(group_rect, drawing_settings.line_color, false, line_width)
		_graph.draw_string(drawing_settings.header_font,
			group_rect.position - drawing_settings.header_font_size * zoom * Vector2(0, 1),
			group.resource_name, 0, -1, drawing_settings.header_font_size * zoom)


func _get_drawing_settings(group: MgpModulesGroup) -> MgpModulesGroupDrawingSettings:
	if not group.extensions.has(_default_drawing_settings.get_script()):
		var new_drawing_settings = _default_drawing_settings.duplicate()
		group.extensions[_default_drawing_settings.get_script()] = new_drawing_settings
	
	return group.extensions[_default_drawing_settings.get_script()]
