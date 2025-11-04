extends Node2D
@export_file("*.tscn") var refsScene: String
@export_file("*.tscn") var mainMenuScene: String
@export_file("*.tscn") var gameScene: String
@export_file("*.tscn") var infoScene: String
@export_file("*.tscn") var gameOverScene: String

func _ready() -> void:
	print("Refs got Readied!")

func GetScene(sceneName:Enums.Scenes) -> String:
	if(sceneName == Enums.Scenes.Refs):
		return refsScene;
	if(sceneName == Enums.Scenes.Info):
		return infoScene;
	if(sceneName == Enums.Scenes.Game):
		return gameScene;
	if(sceneName == Enums.Scenes.GameOver):
		return gameOverScene;
	if(sceneName == Enums.Scenes.MainMenu):
		return mainMenuScene;
	return mainMenuScene;
