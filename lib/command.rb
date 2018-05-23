require 'optparse'

require_relative 'audulus'
require_relative 'sox'
require_relative 'wavetable_patch'
require_relative 'spline_patch'
require_relative 'midi_patch'
require_relative 'spline_helper'

module Command
  def self.build_patch_data(path, title, subtitle)
    # break the path into directory and path so we can build the audulus file's name
    parent, file = path.split("/")[-2..-1]

    # load the samples from the WAV file
    samples = Sox.load_samples(path)

    # build the audulus patch name from the WAV file name
    basename = File.basename(file, ".wav")
    puts "building #{basename}.audulus"
    audulus_patch_name = "#{basename}.audulus"

    results = { :output_path => audulus_patch_name,
                :samples     => samples,
                :title       => title,
                :subtitle    => subtitle, }

    results[:title]    ||= parent
    results[:subtitle] ||= basename

    results
  end

  def self.parse_arguments!(argv)
    results = {
      :spline_only => false
    }
    option_parser = OptionParser.new do |opts|
      opts.banner = "#{$0} [OPTIONS] INPUT_FILE"

      opts.on("-h", "--help", "Prints this help") do
        results[:help] = opts.help
      end

      opts.on("-s", "--spline", "generate a patch containing only a spline corresponding to the samples in the provided WAV file") do
        results[:spline_only] = true
      end

      opts.on("-tTITLE", "--title=TITLE", "provide a title for the patch (defaults to parent directory)") do |t|
        results[:title] = t
      end

      opts.on("-uSUBTITLE", "--subtitle=SUBTITLE", "provide a subtitle for the patch (defaults to file name, minus .wav)") do |u|
        results[:subtitle] = u
      end
    end

    option_parser.parse!(argv)
    if argv.count != 1
      results = {
        :help => option_parser.help
      }
    end

    results[:input_filename] = argv[0]

    results
  end

  def self.run(argv)
    options = parse_arguments!(argv)
    handle_base_options(options)

    if options[:spline_only]
      patch_data = build_patch_data(options[:input_filename], options[:title], options[:subtitle])
      SplinePatch.build_patch(patch_data)
    else
      patch_data = build_patch_data(options[:input_filename], options[:title], options[:subtitle])
      WavetablePatch.build_patch(patch_data)
    end
  end

  def self.parse_midi_arguments!(argv)
    results = {}

    option_parser = OptionParser.new do |opts|
      opts.banner = "#{$0} [OPTIONS] INPUT_FILE"

      opts.on("-h", "--help", "Prints this help") do
        results[:help] = opts.help
      end
    end

    option_parser.parse!(argv)
    if argv.count != 1
      results = {
        :help => option_parser.help
      }
    end

    results[:input_filename] = argv[0]

    results
  end

  def self.run_build_midi_node(argv)
    options = parse_midi_arguments!(argv)
    handle_base_options(options)
    MidiPatch.build_patch(options[:input_filename])
  end

  def self.handle_base_options(options)
    if options.has_key?(:help)
      puts options[:help]
      exit(0)
    end

    path = options[:input_filename]
    unless File.exist?(path)
      puts "Cannot find file at #{path}"
      exit(1)
    end

    options
  end
end
