import theme

# Theme config.
config.load_autoconfig()
theme.setup(c, {
    'padding': {
        'left': 8,
        'right': 8,
        'top': 8,
        'bottom': 8,
    }
})

# Configure spanish language.
c.content.headers.accept_language = "es-ES,es;q=0.9,en;q=0.8"
c.qt.args = ["--lang=es-ES"]

# Dark mode if available.
c.colors.webpage.preferred_color_scheme = "dark"

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
    "https://easylist.to/easylist/fanboy-social.txt",
]

config.bind('<Ctrl-f>', 'hint links spawn mpv {hint-url}')

config.load_autoconfig()
