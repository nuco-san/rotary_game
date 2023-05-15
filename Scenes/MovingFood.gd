extends Area2D

signal food_clicked
var food_id : String
var movement_time : float = 2


func set_sprite_rotation(rotation : float):
	$Shadow.rotation_degrees = rotation
	$FoodSprite.rotation_degrees = rotation


func set_id(id):
	food_id = id
	$FoodSprite.texture = load("res://04_Sprite_EXPORT_ROTARY/Sprite_prodotti_senzaombra_EXPORT_ROTARY/" + id + "_sprite.png")
	$Shadow.texture = load("res://04_Sprite_EXPORT_ROTARY/Sprite_prodotti_ombra_EXPORT_ROTARY/" + id + "_ombra.png")


func move(finishing_point : Position2D):
	$Tween.interpolate_property(self, "position", self.position, finishing_point.position, movement_time)
	$Tween.start()


func destroy_tap():
	$Tween.stop_all()
	$AnimationPlayer.play("destroy")
	yield($AnimationPlayer, "animation_finished")
	emit_signal("food_clicked")
	queue_free()


func destroy_arrive():
	queue_free()


func _on_TouchScreenButton_pressed():
	destroy_tap()
