module SplinePatch
  # Build just a spline from the given samples. Intended for automation rather than
  # for wavetables.
  def self.build_patch(patch_data)
    doc = Audulus.build_init_doc
    patch = doc['patch']
    spline_node = SplineHelper.build_spline_node_from_samples(patch_data[:samples])
    Audulus.add_node(patch, spline_node)

    File.write(patch_data[:output_path], JSON.generate(doc))
  end
end
