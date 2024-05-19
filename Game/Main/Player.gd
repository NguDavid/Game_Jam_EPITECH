extends KinematicBody2D

const acceleration = 500
const speed = 80
const friction = 500

var move = Vector2.ZERO

onready var animation = $P_anim
onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input)
		anim_tree.set("parameters/Run/blend_position", input)
		anim_state.travel("Run")
		move = move.move_toward(input * speed, acceleration * delta)
	else:
		anim_state.travel("Idle")
		move = move.move_toward(Vector2.ZERO, friction * delta)
		
	move = move_and_slide(move)
