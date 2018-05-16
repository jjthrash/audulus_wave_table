module SampleGenerator
  # Make a set of random samples. Useful for generating a cyclic
  # noise wavetable. This method would be used in place of loading
  # the WAV file.
  def make_random_samples(count)
    count.times.map {
      rand*2-1
    }
  end

  # Make a set of samples conforming to a parabola. This method would
  # be used in place of loading the WAV file.
  def make_parabolic_samples(count)
    f = ->(x) { -4*x**2 + 4*x }
    count.times.map {|index|
      index.to_f / (count-1)
    }.map(&f).map {|sample|
      sample*2-1
    }
  end
end
