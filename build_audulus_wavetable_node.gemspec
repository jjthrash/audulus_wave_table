Gem::Specification.new do |s|
  s.name        = 'build_audulus_wavetable_node'
  s.version     = '0.4.0'
  s.date        = '2018-05-18'
  s.summary     = "Builds Audulus patches based on WAV or MIDI file inputs"
  s.description = ""
  s.authors     = ["Jimmy Thrasher"]
  s.email       = 'jimmy@jimmythrasher.com'
  s.files       = Dir.glob("lib/*")
  s.executables << "build_audulus_wavetable_node"
  s.homepage    =
    'https://github.com/jjthrash/audulus_wave_table'
  s.license       = 'MIT'

  s.add_runtime_dependency 'fftw3', '~> 0.3'
  s.add_runtime_dependency 'midilib', '~> 2.0'

  s.add_development_dependency 'minitest', '~> 5.11'
end
