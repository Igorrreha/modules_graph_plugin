@tool
extends EditorPlugin


var _menu_item_name: String = "Mark selected folders as modules"

var _entity_extension_inspector_plugin: EditorInspectorPlugin = preload("res://addons/modules_graph/modules/inspector_plugins/entity_extension/inspector_plugin.gd").new()


func _enter_tree() -> void:
	add_tool_menu_item(_menu_item_name, _mark_selected_folders_as_modules)
	add_inspector_plugin(_entity_extension_inspector_plugin)


func _exit_tree() -> void:
	remove_tool_menu_item(_menu_item_name)
	remove_inspector_plugin(_entity_extension_inspector_plugin)


func _mark_selected_folders_as_modules() -> void:
	var selected_paths = get_editor_interface().get_selected_paths()
	for path in selected_paths:
		if (DirAccess.dir_exists_absolute(path)):
			var config = MgpModule.new()
			config.resource_name = path.get_basename().split("/")[-2]
			ResourceSaver.save(config, path.path_join("module.tres"))
