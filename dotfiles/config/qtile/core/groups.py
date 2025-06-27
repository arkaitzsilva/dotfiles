from libqtile.config import Group, Key
from libqtile.lazy import lazy

from core.keys import keys, mod
from utils.match import wm_class


groups: list[Group] = []

for key, label, layout, matches in [
    ("1", "1", "max", wm_class("org.qutebrowser.qutebrowser")),
    ("2", "2", "monadtall", wm_class("foot")),
    ("3", "3", "max", wm_class()),
    ("4", "4", "monadtall", wm_class()),
    ("5", "5", "monadtall", wm_class()),
    ("6", "6", "monadtall", wm_class()),
    ("7", "7", "monadtall", wm_class()),
    ("8", "8", "monadtall", wm_class()),
    ("9", "9", "monadtall", wm_class()),
]:
  groups.append(Group(key, matches, label=label, layout=layout))

  keys.extend([
      # mod1 + letter of group = switch to group
      Key([mod], key, lazy.group[key].toscreen(toggle=True)),

      # mod1 + shift + letter of group = move focused window to group
      Key([mod, "shift"], key, lazy.window.togroup(key)),
  ])  # fmt: skip
