require_relative 'audulus'

module SplineHelper
  # samples: list of values 0..1, assumed to be evenly spaced
  # along the X axis
  def self.build_spline_node_from_samples(samples)
    coordinates = samples.each_with_index.map {|sample, i|
      [i.to_f/(samples.count-1).to_f, sample]
    }
    build_spline_node_from_coordinates(coordinates)
  end

  # coordinates: list of x,y pairs, where x in [0..1] and y in [0..1]
  def self.build_spline_node_from_coordinates(coordinates)
    spline_node = Audulus.build_simple_node("Spline")
    spline_node["controlPoints"] = coordinates.map { |x, sample|
      {
        "x" => x,
        "y" => sample.to_f,
      }
    }
    spline_node
  end
end
