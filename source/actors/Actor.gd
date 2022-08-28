extends KinematicBody2D
class_name Actor
#-------------------------------------------------------------------------------------------------#
#Variables
#Movement
var motion = Vector2()
var walk_speed = 3.5 * Globals.TILE_SIZE
var run_speed = 7 * Globals.TILE_SIZE
var max_speed = walk_speed
