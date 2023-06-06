@tool
extends Node2D

func _draw():
	correct_all()

func correct_all():
	var custom_rect = Rect2(Vector2.ZERO, Vector2(3000,3000))
	for polygon in self.get_children():
		print("check: " + polygon.name)
		RenderingServer.canvas_item_set_custom_rect(polygon.get_canvas_item(), true, custom_rect)
