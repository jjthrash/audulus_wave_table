require 'minitest/autorun'
require 'spline_helper'

class SplineHelperTest < Minitest::Test
  def test_building_from_samples
    samples = [0, 0.5, 1]
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

  def test_building_from_coordinates
    coordinates = [[0,   1],
                   [0.3, 0.5],
                   [0.6, 0.0],
                   [1.0, 0.25],]
    result = SplineHelper.build_spline_node_from_coordinates(coordinates)
    point0 = result['controlPoints'][0]
    assert_equal(0.0, point0['x'])
    assert_equal(1.0, point0['y'])
    point1 = result['controlPoints'][1]
    assert_equal(0.3, point1['x'])
    assert_equal(0.5, point1['y'])
    point2 = result['controlPoints'][2]
    assert_equal(0.6, point2['x'])
    assert_equal(0.0, point2['y'])
    point3 = result['controlPoints'][3]
    assert_equal(1.0, point3['x'])
    assert_equal(0.25, point3['y'])
  end
end
