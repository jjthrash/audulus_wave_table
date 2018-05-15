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

## TODO

- rearrange to make useful as a library so people can supply calculated
  samples rather than only WAV files
- allow users to specify title and subtitle for nodes rather than using
  parent directory and filename
