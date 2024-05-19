extends Node2D

onready var anim_sprite = $AnimatedSprite

func _ready():
	anim_sprite.play("Animate")

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		anim_sprite.frame = 0
		anim_sprite.play("Animate")
