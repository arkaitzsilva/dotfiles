c.tabs.padding = {
  "left": 8,
  "right": 8,
  "top": 8,
  "bottom": 8,
}

c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    # EasyList global
    "https://easylist-downloads.adblockplus.org/easylist.txt",
    # EasyList para España
    "https://easylist-downloads.adblockplus.org/easylistspanish.txt",
    # Anti-tracking
    "https://easylist-downloads.adblockplus.org/easyprivacy.txt",
    # Anti-annoyances (opcional)
    "https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt",
]

config.bind('<Ctrl-Shift-m>', 'spawn mpv {url}')
config.bind('<Ctrl-m>', 'hint links spawn mpv {hint-url}')          

config.load_autoconfig()
