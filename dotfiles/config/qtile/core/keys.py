from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from utils.config import cfg

ctl = "control"
if cfg.is_xephyr:
  mod = "mod1"
  restart = lazy.restart()
else:
  mod = "mod4"
  restart = lazy.reload_config()

if not cfg.term:
  cfg.term = guess_terminal()

keys = [Key(*key) for key in [  # type: ignore
    # switch window focus
    ([mod], "left", lazy.layout.left()),
    ([mod], "down", lazy.layout.down()),
    ([mod], "up", lazy.layout.up()),
    ([mod], "right", lazy.layout.right()),

    # move windows between columns
    ([mod, "shift"], "left", lazy.layout.shuffle_left()),
    ([mod, "shift"], "down", lazy.layout.shuffle_down()),
    ([mod, "shift"], "up", lazy.layout.shuffle_up()),
    ([mod, "shift"], "right", lazy.layout.shuffle_right()),

    # switch groups
    ([mod], "Page_Down", lazy.screen.next_group()),
    ([mod], "Page_Up", lazy.screen.prev_group()),

    # window management
    ([mod], "q", lazy.window.kill()),

    # qtile management
    ([mod, ctl], "b", lazy.hide_show_bar()),
    ([mod, ctl], "s", lazy.shutdown()),
    ([mod, ctl], "r", restart),

    # terminal
    ([mod], "Return", lazy.spawn(cfg.term)),

    # apps/tools
    # ([mod], "r", lazy.spawn(cfg.launcher["mod"])),

    # backlight
    ([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
    ([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),

    # volume
    ([], "XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")),
    ([], "XF86AudioLowerVolume", lazy.spawn(
        "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")),
    ([], "XF86AudioRaiseVolume", lazy.spawn(
        "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+")),

    # player control
    ([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    ([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    ([], "XF86AudioNext", lazy.spawn("playerctl next")),
]]  # fmt: skip
