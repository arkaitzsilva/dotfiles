def setup(c, options={}):
    palette = {
        'frappe0': '#303446',  # base
        'frappe1': '#292C3C',  # mantle
        'frappe2': '#232634',  # crust
        'frappe3': '#414559',  # surface0
        'frappe4': '#51576D',  # surface1
        'frappe5': '#626880',  # surface2
        'frappe6': '#737994',  # overlay0
        'frappe7': '#838BA7',  # overlay1
        'frappe8': '#949CBB',  # overlay2
        'frappe9': '#C6D0F5',  # text
        'frappe10': '#A6D189', # green
        'frappe11': '#E78284', # red
        'frappe12': '#E5C890', # yellow
        'frappe13': '#CA9EE6', # mauve
        'frappe14': '#8CAAEE', # blue
        'frappe15': '#81C8BE'  # teal
    }

    spacing = options.get('spacing', {
        'vertical': 5,
        'horizontal': 5
    })

    padding = options.get('padding', {
        'top': spacing['vertical'],
        'right': spacing['horizontal'],
        'bottom': spacing['vertical'],
        'left': spacing['horizontal']
    })

    c.colors.completion.category.bg = palette['frappe0']
    c.colors.completion.category.border.bottom = palette['frappe0']
    c.colors.completion.category.border.top = palette['frappe0']
    c.colors.completion.category.fg = palette['frappe9']
    c.colors.completion.even.bg = palette['frappe0']
    c.colors.completion.odd.bg = palette['frappe0']
    c.colors.completion.fg = palette['frappe9']
    c.colors.completion.item.selected.bg = palette['frappe3']
    c.colors.completion.item.selected.border.bottom = palette['frappe3']
    c.colors.completion.item.selected.border.top = palette['frappe3']
    c.colors.completion.item.selected.fg = palette['frappe9']
    c.colors.completion.match.fg = palette['frappe12']
    c.colors.completion.scrollbar.bg = palette['frappe0']
    c.colors.completion.scrollbar.fg = palette['frappe9']

    c.colors.downloads.bar.bg = palette['frappe0']
    c.colors.downloads.error.bg = palette['frappe0']
    c.colors.downloads.error.fg = palette['frappe11']
    c.colors.downloads.stop.bg = palette['frappe0']
    c.colors.downloads.system.bg = 'none'

    c.colors.hints.bg = palette['frappe0']
    c.colors.hints.fg = palette['frappe14']
    c.hints.border = '1px solid ' + palette['frappe0']
    c.colors.hints.match.fg = palette['frappe9']

    c.colors.keyhint.bg = palette['frappe0']
    c.colors.keyhint.fg = palette['frappe14']
    c.colors.keyhint.suffix.fg = palette['frappe15']

    c.colors.messages.error.bg = palette['frappe0']
    c.colors.messages.error.border = palette['frappe0']
    c.colors.messages.error.fg = palette['frappe11']
    c.colors.messages.info.bg = palette['frappe0']
    c.colors.messages.info.border = palette['frappe0']
    c.colors.messages.info.fg = palette['frappe14']
    c.colors.messages.warning.bg = palette['frappe0']
    c.colors.messages.warning.border = palette['frappe0']
    c.colors.messages.warning.fg = palette['frappe11']

    c.colors.prompts.bg = palette['frappe0']
    c.colors.prompts.border = '1px solid ' + palette['frappe0']
    c.colors.prompts.fg = palette['frappe14']
    c.colors.prompts.selected.bg = palette['frappe3']

    c.colors.statusbar.caret.bg = palette['frappe0']
    c.colors.statusbar.caret.fg = palette['frappe12']
    c.colors.statusbar.caret.selection.bg = palette['frappe0']
    c.colors.statusbar.caret.selection.fg = palette['frappe12']
    c.colors.statusbar.command.bg = palette['frappe0']
    c.colors.statusbar.command.fg = palette['frappe13']
    c.colors.statusbar.command.private.bg = palette['frappe0']
    c.colors.statusbar.command.private.fg = palette['frappe8']
    c.colors.statusbar.insert.bg = palette['frappe1']
    c.colors.statusbar.insert.fg = palette['frappe9']
    c.colors.statusbar.normal.bg = palette['frappe0']
    c.colors.statusbar.normal.fg = palette['frappe9']
    c.colors.statusbar.passthrough.bg = palette['frappe0']
    c.colors.statusbar.passthrough.fg = palette['frappe12']
    c.colors.statusbar.private.bg = palette['frappe0']
    c.colors.statusbar.private.fg = palette['frappe8']
    c.colors.statusbar.progress.bg = palette['frappe0']
    c.colors.statusbar.url.error.fg = palette['frappe11']
    c.colors.statusbar.url.fg = palette['frappe9']
    c.colors.statusbar.url.hover.fg = palette['frappe14']
    c.colors.statusbar.url.success.http.fg = palette['frappe10']
    c.colors.statusbar.url.success.https.fg = palette['frappe10']
    c.colors.statusbar.url.warn.fg = palette['frappe12']

    c.statusbar.padding = padding

    c.colors.tabs.bar.bg = palette['frappe3']
    c.colors.tabs.even.bg = palette['frappe3']
    c.colors.tabs.even.fg = palette['frappe9']
    c.colors.tabs.indicator.error = palette['frappe11']
    c.colors.tabs.indicator.start = palette['frappe12']
    c.colors.tabs.indicator.stop = palette['frappe10']
    c.colors.tabs.indicator.system = 'none'
    c.colors.tabs.odd.bg = palette['frappe3']
    c.colors.tabs.odd.fg = palette['frappe9']
    c.colors.tabs.selected.even.bg = palette['frappe0']
    c.colors.tabs.selected.even.fg = palette['frappe9']
    c.colors.tabs.selected.odd.bg = palette['frappe0']
    c.colors.tabs.selected.odd.fg = palette['frappe9']

    c.tabs.padding = padding
    c.tabs.indicator.width = 1
    c.tabs.favicons.scale = 1
