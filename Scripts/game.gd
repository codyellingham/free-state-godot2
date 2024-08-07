extends Node2D

var dragging = false
var selected = [] 
var drag_start = Vector2.ZERO
var select_rectangle = RectangleShape2D.new()
 
@onready var select_draw = $SelectDraw

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			for unit in selected:
				unit.collider.deselect()	
			selected = []
			dragging = true
			drag_start = event.position
		elif dragging:
			dragging = false
			select_draw.update_status(drag_start, event.position, dragging)
			var drag_end = event.position
			select_rectangle.extents = (drag_end - drag_start) / 2
			var space = get_world_2d().direct_space_state
			var query = PhysicsShapeQueryParameters2D.new() 
			## this might be wrong, tutorial says physics2dshapequeryparametrs
			query.set_shape(select_rectangle)
			query.transform = Transform2D(0, (drag_end + drag_start)/2)
			selected = space.intersect_shape(query)
			for unit in selected:
				unit.collider.select()
	if dragging:
		if event is InputEventMouseMotion:
			select_draw.update_status(drag_start, event.position, dragging)

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			for unit in selected:
				unit.collider.move_to(event.position)
