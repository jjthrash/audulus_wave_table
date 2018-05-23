Gem::Specification.new do |s|
  s.name        = 'build_audulus_nodes'
  s.version     = '0.5.0'
  s.date        = '2018-05-23'
  s.summary     = "Builds Audulus patches based on WAV, CSV, or MIDI file inputs"
  s.description = ""
  s.authors     = ["Jimmy Thrasher"]
  s.email       = 'jimmy@jimmythrasher.com'
  s.files       = Dir.glob("lib/*")
  s.executables << "build_audulus_wavetable_node"
  s.executables << "build_audulus_spline_node"
  s.executables << "build_audulus_midi_nodes"
  s.homepage    =
    'https://github.com/jjthrash/audulus_wave_table'
  s.license       = 'MIT'

  s.add_runtime_dependency 'fftw3', '~> 0.3'
  s.add_runtime_dependency 'midilib', '~> 2.0'

  s.add_development_dependency 'minitest', '~> 5.11'
end
