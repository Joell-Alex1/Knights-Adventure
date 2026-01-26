extends Node

signal player_respawned
var paused = true
var current_checkpoint: Checkpoint


var pause_menu
var level_selection = preload("res://level_selection.tscn")

var playerAlive : bool
var playerDamageZone : Area2D
var player: Player

var BatdamageZone : Area2D
var BatdamageAmt : int
var DamageDealt : bool
var bat : BatEnemy


func _ready():
	player = get_tree().root.get_node("Main/Player_1")
	
func start_game():
	transistion_to_scene(level_selection.resource_path)
	
func transistion_to_scene(scene_path):
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(scene_path)
func exit_game():
	get_tree().quit()
	
func respawn_player():
	if current_checkpoint != null:
		#player.position = current_checkpoint.global_position
		#player.velocity = Vector2.ZERO  # Reset the player's velocity
		#player.health = player.max_health
		#player.update_health()
		#player.dead = false
		#player.can_take_damage = true
		#playerAlive=true
		#player.animation.play("Idle")
		##func respawn_player():
	#if current_checkpoint:
		player.respawn()
		#emit_signal("player_respawned")
		
		

func pause_play():
	paused = !paused
	#pause_menu.visible = paused

func resume():
	pause_play()

func restart():
	player.update_health()
	current_checkpoint = null
	get_tree().reload_current_scene()
func quit():
	get_tree().quit()
