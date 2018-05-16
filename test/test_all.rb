require 'minitest/autorun'
require 'build_audulus_wavetable_node'

class AllTest < Minitest::Test
  def test_argument_parsing
    options = parse_arguments!([])
    assert(options.has_key?(:help))

    options = parse_arguments!(["-s"])
    assert(options.has_key?(:help))

    options = parse_arguments!(["-h"])
    assert(options.has_key?(:help))

    options = parse_arguments!(["--help"])
    assert(options.has_key?(:help))

    options = parse_arguments!(["filename"])
    assert_equal("filename", options[:input_filename])
    refute(options[:spline_only])

    options = parse_arguments!(["-s", "filename"])
    assert_equal("filename", options[:input_filename])
    assert(options[:spline_only])
  end
end
