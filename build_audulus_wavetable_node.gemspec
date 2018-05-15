Gem::Specification.new do |s|
  s.name        = 'build_audulus_wavetable_node'
  s.version     = '0.1.0'
  s.date        = '2018-05-15'
  s.summary     = "Builds a wavetable patch for Audulus given a WAV file"
  s.description = ""
  s.authors     = ["Jimmy Thrasher"]
  s.email       = 'jimmy@jimmythrasher.com'
  s.files       = Dir.glob("lib/*")
  s.executables << "build_audulus_wavetable_node"
  s.homepage    =
    'https://github.com/jjthrash/audulus_wave_table'
  s.license       = 'MIT'

  s.add_runtime_dependency 'fftw3', '~> 0.3'
end
