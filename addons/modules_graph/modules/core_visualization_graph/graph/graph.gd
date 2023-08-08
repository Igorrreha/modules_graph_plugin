class_name MgpGraph
extends GraphEdit


@export var _content_variants_pack: MgpTaggedResourcesPack
@export var _graph_position_extension_script: Script
@export var _default_new_node_position: Vector2i

var _content: Array


func update(items: Array) -> void:
	for item in items:
		if not _content.has(item):
			append_content(item)


func append_content(content: Entity) -> void:
	_content.append(content)
	
	var content_variant: = (_content_variants_pack
		.get_resource(content.tag) as MgpGraphContentVariant)
	
	if not content_variant or not content_variant.content_node_tscn:
		return
	
	var content_node_position = content.extensions.get(_graph_position_extension_script)
	if not content_node_position:
		content_node_position = MgpGraphPositionExtension.new(_default_new_node_position)
		content.extensions[_graph_position_extension_script] = content_node_position
	
	var new_node = content_variant.content_node_tscn.instantiate() as MgpGraphNode
	new_node.position_offset = content_node_position.position
	new_node.setup(content)
	add_child(new_node)
