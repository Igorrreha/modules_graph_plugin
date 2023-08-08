extends MgpGraphNode


func setup(content: Entity) -> void:
	$Label.text = content.resource_name
