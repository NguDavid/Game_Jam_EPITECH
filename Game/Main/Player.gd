extends KinematicBody2D

const acceleration = 500
const speed = 80
const friction = 500

enum {
	MOVE,
	ROLL,
	ATT
}

var state = MOVE
var move = Vector2.ZERO

onready var animation = $P_anim
onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

func _ready():
	anim_tree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			
		ROLL:
			pass
			
		ATT:
			attack_state(delta)


func move_state(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input)
		anim_tree.set("parameters/Run/blend_position", input)
		anim_tree.set("parameters/Attack/blend_position", input)
		anim_state.travel("Run")
		move = move.move_toward(input * speed, acceleration * delta)
	else:
		anim_state.travel("Idle")
		move = move.move_toward(Vector2.ZERO, friction * delta)
		
	move = move_and_slide(move)
	
	if Input.is_action_just_pressed("attack"):
		state = ATT

func attack_state(delta):
	move = Vector2.ZERO
	anim_state.travel("Attack")

func attack_animation_finish():
	state = MOVE
