# Audulus Node Builder Tools

This gem includes three tools:
- `build_audulus_wavetable_node`—builds an anti-aliased wavetable node from a WAV
  file assumed to provide a single cycle waveform
- `build_audulus_spline_node`—builds a spline node based on WAV file or CSV input
- `build_audulus_midi_nodes`—builds a patch containing two spline nodes, corresponding
  to the pitch and velocity of the note events in the MIDI file

## Installing

From a terminal:

```
sudo gem install build_audulus_nodes
```

You will be asked for a password. Use your own password. The `sudo` command
runs a program as the superuser, allowing it to install the library.

## Building a wavetable

```
build_audulus_wavetable_node <path_to_wav_file.wav>
```

will output `<path_to_wav_file.audulus>`. Assumes the input WAV file is
a single cycle, monophonic, and probably would prefer CD quality or above
(16-bits per sample).

## Building a spline

```
build_audulus_spline_node <path_to_file.wav>
```
or
```
build_audulus_spline_node --csv <path_to_file.csv>
```

will output `<path_to_file.audulus>`.

## Building MIDI nodes

```
build_audulus_midi_nodes <path_to_file.mid>
```

will output `<path_to_file.audulus>`

## What to do with the results

See the [excellent tutorial](https://www.youtube.com/watch?v=nWPuRtrBfvM)
about spline nodes by forum user RobertSyrett for ideas on what you can do
with the results of running this script.

Also, see the [original post](https://forum.audulus.com/t/know-your-nodes-pt-5-5-5-splines-streamlining-a-large-patch/506)
for context.

## TODO

- rearrange to make useful as a library so people can supply calculated
  samples rather than only WAV files
