require_relative 'audulus'

module SplineHelper
  def self.build_spline_node_from_samples(samples)
    spline_node = Audulus.build_simple_node("Spline")
    spline_node["controlPoints"] = samples.each_with_index.map {|sample, i|
      {
        "x" => i.to_f/(samples.count-1).to_f,
        "y" => (sample+1)/2,
      }
    }
    spline_node
  end
end
