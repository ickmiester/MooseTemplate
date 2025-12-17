extends Node

var MasterVolume:float = .50
var MusicVolume:float = .50
var SoundVolume:float = .50
var SfxPool:int = 10
var GlobalMute:bool = false
var MuteMultiple:float = 1
var MusicPlayer:AudioStreamPlayer
var SFXPlayers:Array[AudioStreamPlayer]

func _ready() -> void:
	MusicPlayer = AudioStreamPlayer.new()
	add_child(MusicPlayer)
	SFXPlayers = []
	for i in SfxPool:
		var tempPlayer = AudioStreamPlayer.new()
		SFXPlayers.append(tempPlayer)
		add_child(tempPlayer)
	
func Mute(value:bool) -> void:
	print("Setting Mute to: " + str(value))
	GlobalMute = value
	MuteMultiple = 1
	if(value):
		MuteMultiple = 0
	MusicPlayer.volume_linear = MasterVolume * MusicVolume * MuteMultiple
	for player in SFXPlayers:
		player.volume_linear = MasterVolume * SoundVolume * MuteMultiple
		

func PlaySound(sound:AudioStream, pitchBend:bool = true) -> void:
	for player in SFXPlayers:
		if(!player.playing):
			player.pitch_scale = 1
			if(pitchBend):
				player.pitch_scale = 0.9 + (Global.Random.randf()*.2)
			player.stream = sound
			player.volume_linear = MasterVolume * SoundVolume * MuteMultiple
			player.play()
			return
			
func PlayMusic(sound:AudioStream) -> void:
	MusicPlayer.stream = sound
	MusicPlayer.volume_linear = MasterVolume * MusicVolume * MuteMultiple
	MusicPlayer.play()
