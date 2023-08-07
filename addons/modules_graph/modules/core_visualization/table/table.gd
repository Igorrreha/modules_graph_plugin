class_name MgpTable
extends GridContainer


@export var _cell_tscn: PackedScene

var _rows: = 0
var _items: Array


func update(items: Array) -> void:
	for item in items:
		if not _items.has(item):
			add_item(item)


func add_item(item: Variant) -> void:
	var empty_cell = _try_get_empty_cell()
	if empty_cell:
		empty_cell.set_content(item)
		return
	
	set_content(item, Vector2i(0, _rows + 1))


func set_content(content: Variant, position: Vector2i) -> void:
	if columns < position.x or _rows < position.y:
		_update_size(Vector2i(max(columns, position.x), max(_rows, position.y)))
	
	var child_idx = position.x - 1 + ((position.y - 1) * columns)
	var cell = get_child(child_idx) as MgpCell
	cell.set_content(content)


func _try_get_empty_cell() -> MgpCell:
	for child_idx in range(get_child_count()):
		var child = get_child(child_idx)
		if child.is_empty():
			return child
	
	return null


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
