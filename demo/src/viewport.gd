extends SubViewport

func _input(ev: InputEvent) -> void:
	if ev is InputEventKey:
		if ev.pressed and not ev.echo:
			match ev.keycode:
				KEY_W:
					debug_draw = Viewport.DEBUG_DRAW_WIREFRAME if debug_draw == DEBUG_DRAW_DISABLED else DEBUG_DRAW_DISABLED
