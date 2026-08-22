extends Node2D

@export var MusicSlider:HSlider;
@export var VolumeSlider:HSlider;
@export var SFXSlider:HSlider;
@export var TimeSlider:HSlider;
@export var TimeText:RichTextLabel;
@export var MuteButton:Button;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicSlider.value = MooseAudio.MusicVolume
	VolumeSlider.value = MooseAudio.MasterVolume
	SFXSlider.value = MooseAudio.SoundVolume
	MuteButton.button_pressed = MooseAudio.GlobalMute
	TimeSlider.value = Global.LevelTime;
	_on_time_slider_value_changed(TimeSlider.value)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_button_pressed() -> void:
	Global.LoadScene(Enums.Scenes.MainMenu)

func _on_music_slider_value_changed(value: float) -> void:
	MooseAudio.MusicVolume = MusicSlider.value
	MooseAudio.UpdateVolume() 
	pass # Replace with function body.

func _on_sfx_slider_value_changed(value: float) -> void:
	MooseAudio.SoundVolume = SFXSlider.value
	MooseAudio.UpdateVolume() 
	pass # Replace with function body.

func _on_volume_slider_value_changed(value: float) -> void:
	MooseAudio.MasterVolume = VolumeSlider.value
	MooseAudio.UpdateVolume() 
	pass # Replace with function body.

func _on_mute_button_pressed() -> void:
	MooseAudio.Mute(!MooseAudio.GlobalMute)
	MuteButton.button_pressed = MooseAudio.GlobalMute
	pass # Replace with function body.


func _on_time_slider_value_changed(value: float) -> void:
	Global.LevelTime = int(TimeSlider.value)
	TimeText.text = str(int(TimeSlider.value)) + " seconds"
	pass # Replace with function body.
