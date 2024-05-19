extends Node2D

#func _process(delta):
#	if Input.is_action_just_pressed("attack"):
#		var GrassEffect = load("res://Main/Grass_effect.tscn")
#		var grasseffect = GrassEffect.instance()
#		var world = get_tree().current_scene
#		world.add_child(grasseffect)
#		grasseffect.global_position = global_position
#		queue_free()

func create_grass_effect():
	var GrassEffect = load("res://Main/Grass_effect.tscn")
	var grasseffect = GrassEffect.instance()
	var world = get_tree().current_scene
	world.add_child(grasseffect)
	grasseffect.global_position = global_position

func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
