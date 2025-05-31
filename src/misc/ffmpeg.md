# ffmpeg

> I know... There are a bunch of GUI wrapper FOSS's out there. But I want to look cool converting my anime OST UwU.

Head over to [installation.md](#installation) if you've not installed `ffmpeg`.

- `flac` to `alac`

```
ffmpeg -i /path/to/input.flac -vcodec copy -acodec alac /path/to/output.m4a
```

## Installation

- Mac: brew install ffmpeg
- Windows: Download the .exe binary from https://ffmpeg.org/download.html and add it to your PATH
- Linux:
  - Ubuntu/Debian: `sudo apt install ffmpeg` or `snap install ffmpeg`
  - Arch: `sudo pacman -S ffmpeg`

## Troubleshooting

### [Solved] Could not load some mysterious libraries

Sometimes `brew` messes up somehow. In my case, `ffmpeg` suddenly was not able to load `libtesseract` and traced the stack to `liblepto*`. I was able to fix the error by reinstalling both.

```sh
brew reinstall tesseract && brew reinstall leptonica
```

Bottom line is, if it misses some `lib$1`, just try to reinstall the `$1`. If the name is incomplete and `brew` cannot find the name, just Bing or Google it.

### [Unsolved] Transcoding rebooted my PC

Happens on Windows. This is on the weirder side, I did not find any logs from Windows Events. It might have to do with the hardware encoders like NVENC or RAM timing. I did some A/B testings which narrowed down to those 2 factors with 70-80% confidence `:)`.

This bug completely shuts down my PC. No BSOD, no nothing.
