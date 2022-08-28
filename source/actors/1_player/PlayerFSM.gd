extends StateMachine
#-------------------------------------------------------------------------------------------------#
#Variables
#OnReady Variables
onready var stateLabel: Label = parent.get_node("StateOutput")
#-------------------------------------------------------------------------------------------------#
#Ready
func _ready() -> void:
	stateAdd("idleNorth")
	stateAdd("idleSouth")
	stateAdd("idleEast")
	stateAdd("idleWest")
	stateAdd("walkNorth")
	stateAdd("walkSouth")
	stateAdd("walkEast")
	stateAdd("walkWest")
	call_deferred("stateSet", states.idleSouth)
#-------------------------------------------------------------------------------------------------#
#Input Handler
func _input(_event: InputEvent) -> void:
	pass
#-------------------------------------------------------------------------------------------------#
#State Label
func _process(_delta: float) -> void:
	stateLabel.text = str(states.keys()[state])
#-------------------------------------------------------------------------------------------------#
#State Logistics
# warning-ignore:unused_argument
func stateLogic(delta):
	parent.apply_movement()
#State Transitions
# warning-ignore:unused_argument
func transitions(delta):
	match(state):
		states.idleNorth: return dirMove()
		states.idleSouth: return dirMove()
		states.idleEast: return dirMove()
		states.idleWest: return dirMove()
		states.walkNorth:
			if parent.motion.y == 0:
				return states.idleNorth
			return dirMove()
		states.walkSouth:
			if parent.motion.y == 0:
				return states.idleSouth
			return dirMove()
		states.walkEast:
			if parent.motion.x == 0:
				return states.idleEast
			return dirMove()
		states.walkWest:
			if parent.motion.x == 0:
				return states.idleWest
			return dirMove()
	return null
#Enter State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateEnter(newState, oldState):
	match(newState):
		states.idleSouth: parent.playBack.travel("idleSouth")
		states.walkSouth: parent.playBack.travel("walkSouth")
#Exit State
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func stateExit(oldState, newState):
	pass
#Set State
func stateSet(newState):
	prevState = state
	state = newState
	if prevState != null:
		stateExit(prevState, newState)
	if newState != null:
		stateEnter(newState, prevState)
#Add State
func stateAdd(stateName):
	states[stateName] = states.size()
#-------------------------------------------------------------------------------------------------#
#Directional Movement Transition
func dirMove():
	if parent.motion.x == parent.max_speed: return states.walkEast
	if parent.motion.x == -parent.max_speed: return states.walkWest
	if parent.motion.y == parent.max_speed: return states.walkSouth
	if parent.motion.y == -parent.max_speed: return states.walkNorth
