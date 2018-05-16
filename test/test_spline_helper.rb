require 'minitest/autorun'
require 'spline_helper'

class SplineHelperTest < Minitest::Test
  def test_building_from_samples
    samples = [-1, 0, 1]
    result = SplineHelper.build_spline_node_from_samples(samples)
    point0 = result['controlPoints'][0]
    assert_equal(0.0, point0['x'])
    assert_equal(0.0, point0['y'])
    point1 = result['controlPoints'][1]
    assert_equal(0.5, point1['x'])
    assert_equal(0.5, point1['y'])
    point2 = result['controlPoints'][2]
    assert_equal(1.0, point2['x'])
    assert_equal(1.0, point2['y'])
  end
end
