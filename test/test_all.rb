require 'minitest/autorun'
require 'command'

class AllTest < Minitest::Test
  def test_argument_parsing
    options = Command.parse_arguments!([])
    assert(options.has_key?(:help))

    options = Command.parse_arguments!(["-s"])
    assert(options.has_key?(:help))

    options = Command.parse_arguments!(["-h"])
    assert(options.has_key?(:help))

    options = Command.parse_arguments!(["--help"])
    assert(options.has_key?(:help))

    options = Command.parse_arguments!(["filename"])
    assert_equal("filename", options[:input_filename])
    refute(options[:spline_only])

    options = Command.parse_arguments!(["-s", "filename"])
    assert_equal("filename", options[:input_filename])
    assert(options[:spline_only])

    options = Command.parse_arguments!(["-m", "filename"])
    assert_equal("filename", options[:input_filename])
    assert(options[:midi])
  end
end
