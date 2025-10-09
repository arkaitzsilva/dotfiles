def setup(c, options={}):
    palette = {
        'bg': '#1a1b26',
        'bg_dark': '#24283b',
        'bg_highlight': '#292e42',
        'comment': '#565f89',
        'fg': '#c0caf5',
        'fg_dark': '#a9b1d6',
        'blue': '#7aa2f7',
        'cyan': '#7dcfff',
        'purple': '#9d7cd8',
        'magenta': '#bb9af7',
        'red': '#f7768e',
        'orange': '#ff9e64',
        'yellow': '#e0af68',
        'green': '#9ece6a',
    }

    spacing = options.get('spacing', {'vertical': 5, 'horizontal': 5})
    padding = options.get('padding', {
        'top': spacing['vertical'],
        'right': spacing['horizontal'],
        'bottom': spacing['vertical'],
        'left': spacing['horizontal']
    })

    # === Completion widget ===
    c.colors.completion.category.bg = palette['bg']
    c.colors.completion.category.border.bottom = palette['bg']
    c.colors.completion.category.border.top = palette['bg']
    c.colors.completion.category.fg = palette['fg_dark']

    c.colors.completion.even.bg = palette['bg']
    c.colors.completion.odd.bg = palette['bg']
    c.colors.completion.fg = palette['fg_dark']
    c.colors.completion.item.selected.bg = palette['comment']
    c.colors.completion.item.selected.border.bottom = palette['comment']
    c.colors.completion.item.selected.border.top = palette['comment']
    c.colors.completion.item.selected.fg = palette['fg_dark']
    c.colors.completion.match.fg = palette['orange']
    c.colors.completion.scrollbar.bg = palette['bg']
    c.colors.completion.scrollbar.fg = palette['fg_dark']

    # === Downloads ===
    c.colors.downloads.bar.bg = palette['bg']
    c.colors.downloads.error.bg = palette['bg']
    c.colors.downloads.error.fg = palette['red']
    c.colors.downloads.stop.bg = palette['bg']
    c.colors.downloads.system.bg = 'none'

    # === Hints ===
    c.colors.hints.bg = palette['bg']
    c.colors.hints.fg = palette['cyan']
    c.hints.border = '1px solid ' + palette['bg']
    c.colors.hints.match.fg = palette['fg']

    # === Keyhint ===
    c.colors.keyhint.bg = palette['bg']
    c.colors.keyhint.fg = palette['cyan']
    c.colors.keyhint.suffix.fg = palette['purple']

    # === Messages ===
    for t in ['error', 'info', 'warning']:
        c.colors.messages[t].bg = palette['bg']
        c.colors.messages[t].border = palette['bg']
    c.colors.messages.error.fg = palette['red']
    c.colors.messages.info.fg = palette['purple']
    c.colors.messages.warning.fg = palette['red']

    # === Prompts ===
    c.colors.prompts.bg = palette['bg']
    c.colors.prompts.border = '1px solid ' + palette['bg']
    c.colors.prompts.fg = palette['cyan']
    c.colors.prompts.selected.bg = palette['comment']

    # === Statusbar ===
    c.colors.statusbar.caret.bg = palette['bg']
    c.colors.statusbar.caret.fg = palette['orange']
    c.colors.statusbar.caret.selection.bg = palette['bg']
    c.colors.statusbar.caret.selection.fg = palette['orange']
    c.colors.statusbar.command.bg = palette['bg']
    c.colors.statusbar.command.fg = palette['magenta']
    c.colors.statusbar.command.private.bg = palette['bg']
    c.colors.statusbar.command.private.fg = palette['fg_dark']
    c.colors.statusbar.insert.bg = palette['bg_dark']
    c.colors.statusbar.insert.fg = palette['blue']
    c.colors.statusbar.normal.bg = palette['bg']
    c.colors.statusbar.normal.fg = palette['fg_dark']
    c.colors.statusbar.passthrough.bg = palette['bg']
    c.colors.statusbar.passthrough.fg = palette['orange']
    c.colors.statusbar.private.bg = palette['bg']
    c.colors.statusbar.private.fg = palette['fg']
    c.colors.statusbar.progress.bg = palette['bg']
    c.colors.statusbar.url.error.fg = palette['red']
    c.colors.statusbar.url.fg = palette['fg_dark']
    c.colors.statusbar.url.hover.fg = palette['cyan']
    c.colors.statusbar.url.success.http.fg = palette['green']
    c.colors.statusbar.url.success.https.fg = palette['green']
    c.colors.statusbar.url.warn.fg = palette['yellow']
    c.statusbar.padding = padding

    # === Tabs ===
    c.colors.tabs.bar.bg = palette['comment']
    c.colors.tabs.even.bg = palette['comment']
    c.colors.tabs.even.fg = palette['fg_dark']
    c.colors.tabs.indicator.error = palette['red']
    c.colors.tabs.indicator.start = palette['orange']
    c.colors.tabs.indicator.stop = palette['green']
    c.colors.tabs.indicator.system = 'none'
    c.colors.tabs.odd.bg = palette['comment']
    c.colors.tabs.odd.fg = palette['fg_dark']
    c.colors.tabs.selected.even.bg = palette['bg']
    c.colors.tabs.selected.even.fg = palette['fg_dark']
    c.colors.tabs.selected.odd.bg = palette['bg']
    c.colors.tabs.selected.odd.fg = palette['fg_dark']
    c.tabs.padding = padding
    c.tabs.indicator.width = 1
    c.tabs.favicons.scale = 1
