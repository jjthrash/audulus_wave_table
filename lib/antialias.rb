require 'fftw3'

class Antialias
  # sample_rate, Hz, e.g. 44100
  # fundamental, Hz, e.g. 440
  # samples: -1..1
  def self.antialias_for_fundamental(sample_rate, fundamental, samples)
    fft = FFTW3.fft(NArray[samples]).to_a.flatten
    dampened = dampen_higher_partials(sample_rate, fundamental, fft)
    (FFTW3.ifft(NArray[dampened]) / samples.count).real.to_a.flatten
  end

  # kill everything higher than a scaled nyquist limit
  # ease in/out everything else to minimize partials near nyquist
  def self.dampen_higher_partials(sample_rate, fundamental, fft)
    nyquist = sample_rate.to_f / 2
    sample_fundamental = sample_rate.to_f / fft.count
    scaled_nyquist = nyquist / fundamental * sample_fundamental
    sample_duration = fft.count.to_f / sample_rate
    sub_nyquist_sample_count = scaled_nyquist * sample_duration
    fft.each_with_index.map {|power, i|
      hz = i.to_f / fft.count * sample_rate.to_f
      if hz < scaled_nyquist
        scale_partial(i, sub_nyquist_sample_count, power)
      else
        0+0i
      end
    }
  end

  # dampen partials higher than a certain frequency using a smooth
  # "ease-in-out" shape
  def self.scale_partial(partial_index, partial_count, partial_value)
    partial_value * (Math.cos(partial_index.to_f*Math::PI/2/partial_count)**2)
  end
end

