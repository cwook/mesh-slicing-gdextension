extends SliceableMeshInstance3D

@export var plane_node : Node3D
@export var update_rate := 0.0

@onready var original_mesh : Mesh = self.mesh

func _ready() -> void:
	slice()

func _process(_delta):
	# do this after every other _process to avoid z-fighting when rotating the plane
	if update_rate <= 0.0:
		call_deferred("slice")

func slice():
	self.mesh = original_mesh
	
#	var time_start = Time.get_ticks_usec()
	self.slice_along_plane(Plane(-plane_node.global_transform.basis.z, plane_node.global_position))
	# remove the script from skinned meshes after 1st slice to prevent slowdown (for now)
	#if skeleton:
		#self.set_script(null)
#	print("Slicing ", self.get_parent().name, " took ", str(Time.get_ticks_usec() - time_start), "us")
	if update_rate > 0.0:
		var tw := create_tween()
		tw.tween_interval(update_rate)
		tw.tween_callback(self.call_deferred.bind("slice"))
