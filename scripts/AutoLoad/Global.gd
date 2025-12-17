extends Node

var Random = RandomNumberGenerator.new()

func LoadScene(scene:Enums.Scenes):
	get_tree().change_scene_to_file(Refs.GetScene(scene))
