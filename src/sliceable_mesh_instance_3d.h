#ifndef SLICEABLE_MESH_INSTANCE_3D_H
#define SLICEABLE_MESH_INSTANCE_3D_H

#include <godot_cpp/classes/mesh_instance3d.hpp>
#include <godot_cpp/classes/array_mesh.hpp>
#include <godot_cpp/classes/mesh_data_tool.hpp>
#include <godot_cpp/classes/surface_tool.hpp>

namespace godot {

class SliceableMeshInstance3D : public MeshInstance3D {
	GDCLASS(SliceableMeshInstance3D, MeshInstance3D)

private:
	Ref<Material> m_inner_material;
	
	// data structure holding info about the starting vertex of a lid
	struct LidData
	{
		Vector3 position;
		PackedInt32Array bones;
		PackedFloat32Array weights;
	};

protected:
	static void _bind_methods();

public:
	SliceableMeshInstance3D();
	~SliceableMeshInstance3D();

	void set_inner_material(const Ref<Material> p_inner_material);
	Ref<Material> get_inner_material() const;

	void slice_along_plane(const Plane p_plane);
	// additionally shrinks the vertex array by creating an index array (triangle list), but takes significantly more time
	void slice_along_plane_indexed(const Plane p_plane);

private:
	void slice_along_plane_p(const Plane p_plane, const bool indexed);
	Ref<ArrayMesh> slice_mesh_along_plane(
		const Ref<ArrayMesh> p_array_mesh, const Plane p_plane, const bool indexed
	) const;
	void slice_surface_along_plane(
		const Ref<MeshDataTool> p_mdt, const Ref<SurfaceTool> p_st_sliced, const Ref<SurfaceTool> p_st_lid,
		LidData &p_lid_data, bool &p_pos_on_lid_defined, const Plane p_plane_os
	) const;
};

}

#endif
