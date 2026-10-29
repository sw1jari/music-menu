# music-menu

A dmenu music picker. Browse your music folder, play a single track or a whole album with mpv in the background, and pause, skip or stop from the same menu.

The current track is written to `$XDG_RUNTIME_DIR/music-now`, so a status bar can show it (see [dwm-status](https://github.com/sw1jari/dwm-status)).

## Requirements
bash, dmenu, mpv, socat

## Install
```sh
cp music-menu ~/.local/bin/
mkdir -p ~/.config/mpv/scripts-music
cp now-playing.lua ~/.config/mpv/scripts-music/
```

## Usage
Run `music-menu`, ideally from a keybinding. Folders end in `/`, and picking a folder shows its contents. "▶ Play whole album" plays everything below the current folder in order. While music is playing, the top menu also shows pause/resume, next, previous and stop. If [spotify-menu](https://github.com/sw1jari/spotify-menu) is installed, "🎧 Spotify" opens it.

Music is read from `/data/music` by default. Set `MUSIC_DIR` to use another folder:
```sh
MUSIC_DIR=~/Music music-menu
```

## Optional: media keys
`mediakey` makes your keyboard's play/pause, next and previous keys control music-menu's mpv. If music-menu isn't playing, it falls back to `playerctl`, so the keys still work with other players.

Extra requirements: socat (already needed by music-menu) and playerctl.

```sh
cp mediakey ~/.local/bin/
```

Bind it in your hotkey daemon, like in sxhkd:
```
XF86AudioPlay
    mediakey play-pause
XF86AudioNext
    mediakey next
XF86AudioPrev
    mediakey previous
```
