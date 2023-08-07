class_name MgpTable
extends GridContainer


@export var _cell_tscn: PackedScene
@export var _table_position_extension_script: Script

var _rows: = 0
var _items: Array


func update(items: Array) -> void:
	for item in items:
		if not _items.has(item):
			add_item(item)


func add_item(item: Entity) -> void:
	_items.append(item)
	
	var table_position = item.extensions.get(_table_position_extension_script)
	if table_position:
		set_content(item, table_position.position)
		return
	
	var empty_cell_position = _try_get_empty_cell_position()
	if empty_cell_position != Vector2i.ZERO:
		set_content(item, empty_cell_position)
		return
	
	var content_position = (Vector2i(columns + 1, 1) if columns <= _rows
		else Vector2i(1, _rows + 1))
	set_content(item, content_position)


func set_content(content: Entity, position: Vector2i) -> void:
	if columns < position.x or _rows < position.y:
		_update_size(Vector2i(max(columns, position.x), max(_rows, position.y)))
	
	var child_idx = position.x - 1 + ((position.y - 1) * columns)
	var cell = get_child(child_idx) as MgpCell
	cell.set_content(content)
	
	var extension = MgpTablePositionExtension.new(position)
	content.extensions[_table_position_extension_script] = extension


func _try_get_empty_cell_position() -> Vector2i:
	for row_idx in range(_rows):
		for column_idx in range(columns):
			var child = get_child(row_idx * columns + column_idx)
			if child.is_empty():
				return Vector2i(column_idx + 1, row_idx + 1)
	
	return Vector2i.ZERO


func _update_size(new_size: Vector2i) -> void:
	var size_delta = new_size - Vector2i(columns, _rows)
	
	if size_delta.x > 0:
		for row_number in range(_rows, 0, -1):
			var cell_add_idx = row_number * columns
			
			for i in range(size_delta.x):
				var new_cell = _cell_tscn.instantiate()
				add_child(new_cell)
				move_child(new_cell, cell_add_idx)
	columns = new_size.x
	
	if size_delta.y > 0:
		for i in range(columns * size_delta.y):
			add_child(_cell_tscn.instantiate())
	_rows = new_size.y
