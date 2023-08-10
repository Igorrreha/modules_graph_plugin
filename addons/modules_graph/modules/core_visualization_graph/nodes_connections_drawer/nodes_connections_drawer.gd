extends Node


@export var _graph: GraphEdit
@export var _connections_manager: MgpGraphNodesConnectionManager

@export_group("Line")
@export var _line_width: float
@export var _line_dash: float
@export var _line_color: Color

@export_group("Arrow")
@export_range(0, 360, 1) var _arrow_angle_degrees: float
@export var _arrow_length: float


func _ready() -> void:
	_graph.draw.connect(_on_graph_draw)


func _on_graph_draw() -> void:
	var connections = _connections_manager.connections
	
	var zoom = _graph.zoom
	var line_width = _line_width * zoom
	var line_dash = _line_dash * zoom
	
	for node_a in connections:
		for node_b in connections[node_a]:
			var point_a = node_a.position + node_a.size / 2 * zoom
			var point_b = node_b.position + node_b.size / 2 * zoom
			
			var delta = point_b - point_a
			var delta_angle = delta.angle()
			
			var offset = Vector2.ZERO
			
			point_a += _get_contact_with_offsetted_center_ray_position(node_a.get_rect(),
				delta_angle, offset)
			point_b -= _get_contact_with_offsetted_center_ray_position(node_b.get_rect(),
				delta_angle, -offset)
			_draw_connection(point_a, point_b, _line_color, line_width, line_dash)


func _get_contact_with_offsetted_center_ray_position(rect: Rect2, angle: float,
		center_offset: Vector2) -> Vector2:
	if center_offset.length() > 0:
		var angle_vector = Vector2.from_angle(angle)
		var center = rect.size / 2
		
		var direction_multiplyer = Vector2(1 if angle_vector.x > 0 else -1,
			1 if angle_vector.y > 0 else -1)
		
		var sub_rect = Rect2(Vector2.ZERO, rect.size - center_offset
			* direction_multiplyer * 2)
		var offset_delta = _get_contact_with_center_ray_position(sub_rect, angle)
		return center_offset + offset_delta
	else:
		return _get_contact_with_center_ray_position(rect, angle)
	
	return Vector2.ZERO


func _get_contact_with_center_ray_position(rect: Rect2, angle: float) -> Vector2:
	var angle_vector = Vector2.from_angle(angle)
	var center = rect.size / 2
	
	var angle_ratio = abs(sin(center.angle()))
	var delta_angle_ratio = abs(sin(angle))
	
	var angle_to_right = angle_vector.angle_to(Vector2.RIGHT)
	if delta_angle_ratio < angle_ratio:
		return (center.x / cos(angle_to_right) * angle_vector
			* (1 if angle_vector.x > 0 else -1))
	
	var angle_to_down = angle_vector.angle_to(Vector2.DOWN)
	if delta_angle_ratio > angle_ratio:
		return (center.y / cos(angle_to_down) * angle_vector
			* (1 if angle_vector.y > 0 else -1))
	
	return Vector2.ZERO


func _draw_connection(from: Vector2, to: Vector2,
	color: Color, line_width: float, line_dash: float) -> void:

	_graph.draw_line(from, to, color, line_width)
	
	var delta = to - from
	var delta_angle = delta.angle()
	_draw_arrow_head(to, delta_angle, _graph.zoom, true)


func _draw_arrow_head(target: Vector2, angle: float, zoom: float,
		closed: bool = false, filled: bool = false) -> void:
	var angle_vector = Vector2.from_angle(angle)
	var tail_delta = angle_vector * -_arrow_length * zoom
	
	var line_width = _line_width * zoom
	
	var point_a = target + tail_delta.rotated(deg_to_rad(_arrow_angle_degrees / 2))
	_graph.draw_line(target, point_a, _line_color, line_width)
	
	var point_b = target + tail_delta.rotated(deg_to_rad(-_arrow_angle_degrees / 2))
	_graph.draw_line(target, point_b, _line_color, line_width)
	
	if closed or filled:
		_graph.draw_line(point_a, point_b, _line_color, line_width)
	
	if filled:
		_graph.draw_colored_polygon([target, point_a, point_b], _line_color)
