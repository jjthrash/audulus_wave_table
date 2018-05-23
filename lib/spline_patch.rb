module SplinePatch
  # Build just a spline from the given samples. Intended for automation rather than
  # for wavetables.
  def self.build_patch(patch_data)
    doc = Audulus.build_init_doc
    patch = doc['patch']
    spline_node =
      if patch_data[:samples]
        scaled_samples = patch_data[:samples].map {|sample| (sample.to_f + 1.0)/2.0}
        SplineHelper.build_spline_node_from_samples(scaled_samples)
      elsif patch_data[:coordinates]
        SplineHelper.build_spline_node_from_coordinates(patch_data[:coordinates])
      end
    Audulus.add_node(patch, spline_node)

    File.write(patch_data[:output_path], JSON.generate(doc))
  end
end
