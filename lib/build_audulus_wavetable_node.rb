"""
The following code builds an Audulus wavetable node given a single cycle waveform.

The way it works is by building a spline node corresponding to the waveform, then
building the support patch to drive a Phasor node at the desired frequency into the
spline node to generate the output.

The complexity in the patch comes from the fact that for any wavetable you will
quickly reach a point where you are generating harmonics that are beyond the Nyquist
limit. Without diving into details, the problem with this is that it will cause
aliasing, or frequencies that are not actually part of the underlying waveform.
These usually sound bad and one usually doesn't want them.

The solution is as follows (glossing over important details):
1. determine a set of frequency bands we care about. In my case, 0-55Hz, and up by
   octaves for 8 octaves
2. for each frequency band, run the waveform through a Fast Fourier Transform
3. attenuate frequencies higher than the Nyquist limit for that frequency band
4. run an inverse FFT to get a new waveform
5. generate a wavetable for each frequency band
6. generate support patch to make sure the right wavetable is chosen for a given
   frequency

Steps 2–4 behave like a very precise single-pole non-resonant low-pass-filter, and
I probably could have used that, but this approach was more direct.
"""

raise "Not suitable for library use yet"
