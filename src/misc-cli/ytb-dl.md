# ytb-dl

> I recommend `ytp-dl` instead, which is a wrapper that provides better download performance.

Note: You will need to install missing codecs or ffmpeg to perform certain operations, for example, Audio Only mode.

- Download with the highest quality possible for both video and audio

```sh
yt-dlp $uri -f bestvideo*+bestaudio/best
```

- Download with only audio (requires `ffmpeg` on PATH)

```sh
yt-dlp -x $uri
```
