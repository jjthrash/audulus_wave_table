# Audulus Wavetable Builder

## Installing

From a terminal:

```
sudo gem install build_audulus_wavetable_node
```

You will be asked for a password. Use your own password. The `sudo` command
runs a program as the superuser, allowing it to install the library.

## Using

```
build_audulus_wavetable_node <path_to_wav_file.wav>
```

will output `<path_to_wav_file.audulus>`. Assumes the input WAV file is
a single cycle, monophonic, and probably would prefer CD quality or above
(16-bits per sample).

## What to do with the results

See the [excellent tutorial](https://www.youtube.com/watch?v=nWPuRtrBfvM)
about spline nodes by forum user RobertSyrett for ideas on what you can do
with the results of running this script.

Also, see the [original post](https://forum.audulus.com/t/know-your-nodes-pt-5-5-5-splines-streamlining-a-large-patch/506)
for context.

## TODO

- rearrange to make useful as a library so people can supply calculated
  samples rather than only WAV files
- allow users to specify title and subtitle for nodes rather than using
  parent directory and filename
