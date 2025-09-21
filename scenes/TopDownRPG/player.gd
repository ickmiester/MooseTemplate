extends CharacterBody2D

class_name Player

signal hit
@export var speed = 400 # How fast the player will move (pixels/sec).
#@export var exclamation :Sprite2D
@export var currentTarget:Node2D
@export var Keys :Array[String]
var rng = RandomNumberGenerator.new()
@export var camera:Camera2D
@export var SpawnLocation:Node2D
var queuedForRez:Array = []
var currentRezs = 0
@export_file("*.tscn") var gameOverScene: String
var frozen = false
@export var PlayerSounds:AudioStreamPlayer
@export var ApproachTarget:Node2D
@export var KeyLabel:Label
var inCircle:bool




# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "idle"
	#exclamation.hide()
	global_position = SpawnLocation.global_position

func _process(delta):
	camera.position_smoothing_enabled = true;
	if(frozen):
		return
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "idle"
		PlayerSounds.stop()
	#position += velocity * delta
	if velocity.x != 0:
		if(!PlayerSounds.playing):
			PlayerSounds.pitch_scale = 0.9 + (rng.randf()*.2)
			#TODO set step sound
			PlayerSounds.play()
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "walk"
		if(!PlayerSounds.playing):
			#TODO set step sound
			PlayerSounds.pitch_scale = 0.9 + (rng.randf()*.2)
			PlayerSounds.play()
		#$AnimatedSprite2D.flip_v = velocity.y > 0
	if Input.is_action_just_pressed("interact"):
		if(currentTarget != null):
			if(currentTarget.is_in_group("npcs")):
				print("talking to NPC")
				currentTarget.DisplayText(self)
				currentTarget.exclamation.hide()
			if(currentTarget.is_in_group("houses")):
				if(currentTarget.lock == null || currentTarget.lock == "" || Keys.has(currentTarget.lock)):
					if(currentTarget.lock!=null && currentTarget.lock != ""):
						ShowKey("Used: " + currentTarget.lock)
					if(currentTarget.interiorScene != null):
						currentTarget.OpenSound.play()
						position = currentTarget.interiorScene.global_position
						camera.position_smoothing_enabled = false;
				else:
					ShowKey("Need: " + currentTarget.lock)
					#TODO set locked sound
					PlayerSounds.play()
			if(currentTarget.is_in_group("items")):
				if(currentTarget.key != null):
					Keys.append(currentTarget.key)
					ShowKey("Gained: " + currentTarget.key)
				#TODO set item sound
				PlayerSounds.play()
				currentTarget.queue_free()
	move_and_slide()

func ShowKey(key:String) -> void:
	KeyLabel.show()
	KeyLabel.text = key
	await get_tree().create_timer(1).timeout
	KeyLabel.hide()

func _on_area_entered(area: Area2D) -> void:
	print("area entered")
	if area.is_in_group("bodies"):
		print("showing !")
		if(currentTarget != null):
			currentTarget.exclamation.hide()
		currentTarget = area
		currentTarget.exclamation.show()
	if area.is_in_group("npcs"):
		if !area.visible:
			return
		print("showing !")
		if(currentTarget != null):
			currentTarget.exclamation.hide()
		currentTarget = area
		currentTarget.exclamation.show()
	if area.get_parent().is_in_group("houses"):
		if(currentTarget != null):
			currentTarget.exclamation.hide()
		currentTarget = area.get_parent()
		currentTarget.exclamation.show()
	if area.get_parent().is_in_group("items"):
		if(currentTarget != null):
			currentTarget.exclamation.hide()
		currentTarget = area.get_parent()
		currentTarget.exclamation.show()


func _on_area_exited(area: Area2D) -> void:
	print("area left")
	if area == currentTarget:
		currentTarget.exclamation.hide()
		currentTarget = null
	if(currentTarget == area.get_parent()):
		currentTarget.exclamation.hide()
		currentTarget = null

func die() -> void:
	frozen = true
	#TODO set death sound
	PlayerSounds.play()
	$AnimatedSprite2D.animation = "die"
	await get_tree().create_timer(2).timeout
	$AnimatedSprite2D.play_backwards("die")
	#TODO set rez sound
	PlayerSounds.play()
	position = SpawnLocation.global_position
	camera.position_smoothing_enabled = false;
	for NPC in queuedForRez:
		NPC.show()
		currentRezs+=1
	queuedForRez.clear()
	print("I died!")
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.animation = "idle"
	frozen = false
		
	pass
