extends Node


@export var _graph: GraphEdit
@export var _groups_storage: MgpGraphNodesGroupsStorage

@export_group("Line")
@export var _line_width: float
@export var _line_color: Color

@export_group("Header")
@export var _header_font: Font
@export var _header_font_size: int = 16


func _ready() -> void:
	_graph.draw.connect(_on_graph_draw)


func _on_graph_draw() -> void:
	var groups = _groups_storage.groups
	
	var zoom = _graph.zoom
	var line_width = _line_width * zoom
	
	for group_id in groups:
		var top_left_point = Vector2.INF
		var bottom_right_point = -Vector2.INF
		for node in groups[group_id]:
			if top_left_point.x > node.position.x:
				top_left_point.x = node.position.x
			if bottom_right_point.x < node.position.x + node.size.x * zoom:
				bottom_right_point.x = node.position.x + node.size.x * zoom
			
			if top_left_point.y > node.position.y:
				top_left_point.y = node.position.y
			if bottom_right_point.y < node.position.y + node.size.y * zoom:
				bottom_right_point.y = node.position.y + node.size.y * zoom
		
		var group_rect = Rect2(top_left_point, bottom_right_point - top_left_point)
		_graph.draw_rect(group_rect, _line_color, false, line_width)
		_graph.draw_string(_header_font,
			group_rect.position - _header_font_size * zoom * Vector2(0, 1),
			group_id, 0, -1, _header_font_size * zoom)
