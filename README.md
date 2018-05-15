# Audulus Wavetable Builder

## Installing

```
sudo gem install build_audulus_wavetable_node
```

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
