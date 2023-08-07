class_name MgpResourcesFromFsLoader
extends Node


signal resource_loaded(resource: Resource)


@export_dir var _root_dir_path: String


func _ready() -> void:
	_load_resources(_root_dir_path)


func _load_resources(root_dir_path: String) -> void:
	for file_name in DirAccess.get_files_at(root_dir_path):
		var file_path = root_dir_path.path_join(file_name)
		
		if not file_path.ends_with(".tres"):
			continue
		
		var resource = ResourceLoader.load(file_path)
		resource_loaded.emit(resource)
	
	for dir_name in DirAccess.get_directories_at(root_dir_path):
		var dir_path = root_dir_path.path_join(dir_name)
		_load_resources(dir_path)
