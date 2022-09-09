extends Actor
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
#Animation Nodes
onready var spritePlayer = $AnimationPlayers/SpritePlayer
onready var animTree = $AnimationPlayers/AnimationTree
onready var playBack = animTree.get("parameters/playback")
onready var currentState = playBack.get_current_node()
#-------------------------------------------------------------------------------------------------#
func apply_movement():
	motion = Vector2.ZERO
	if Input.is_action_pressed("ui_right"): motion.x += 1
	if Input.is_action_pressed("ui_left"): motion.x -= 1
	if Input.is_action_pressed("ui_down"): motion.y += 1
	if Input.is_action_pressed("ui_up"): motion.y -= 1
	motion = motion.normalized() * max_speed #Normalizes Diagonal Movement
	motion = move_and_slide(motion)
