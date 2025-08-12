def setup(c, options={}):
    palette = {
        'nord0': '#2e3440',
        'nord1': '#3b4252',
        'nord2': '#434c5e',
        'nord3': '#4c566a',
        'nord4': '#d8dee9',
        'nord5': '#e5e9f0',
        'nord6': '#eceff4',
        'nord7': '#8fbcbb',
        'nord8': '#88c0d0',
        'nord9': '#81a1c1',
        'nord10': '#5e81ac',
        'nord11': '#bf616a',
        'nord12': '#d08770',
        'nord13': '#ebcb8b',
        'nord14': '#a3be8c',
        'nord15': '#b48ead'
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

    # Background color of the completion widget category headers.
    c.colors.completion.category.bg = palette['nord0']

    # Bottom border color of the completion widget category headers.
    c.colors.completion.category.border.bottom = palette['nord0']

    # Top border color of the completion widget category headers.
    c.colors.completion.category.border.top = palette['nord0']

    # Foreground color of completion widget category headers.
    c.colors.completion.category.fg = palette['nord4']

    # Background color of the completion widget for even rows.
    c.colors.completion.even.bg = palette['nord0']

    # Background color of the completion widget for odd rows.
    c.colors.completion.odd.bg = palette['nord0']

    # Text color of the completion widget.
    c.colors.completion.fg = palette['nord4']

    # Background color of the selected completion item.
    c.colors.completion.item.selected.bg = palette['nord3']

    # Bottom border color of the selected completion item.
    c.colors.completion.item.selected.border.bottom = palette['nord3']

    # Top border color of the completion widget category headers.
    c.colors.completion.item.selected.border.top = palette['nord3']

    # Foreground color of the selected completion item.
    c.colors.completion.item.selected.fg = palette['nord4']

    # Foreground color of the matched text in the completion.
    c.colors.completion.match.fg = palette['nord12']

    # Color of the scrollbar in completion view
    c.colors.completion.scrollbar.bg = palette['nord0']

    # Color of the scrollbar handle in completion view.
    c.colors.completion.scrollbar.fg = palette['nord4']

    # Background color for the download bar.
    c.colors.downloads.bar.bg = palette['nord0']

    # Background color for downloads with errors.
    c.colors.downloads.error.bg = palette['nord0']

    # Foreground color for downloads with errors.
    c.colors.downloads.error.fg = palette['nord11']

    # Color gradient stop for download backgrounds.
    c.colors.downloads.stop.bg = palette['nord0']

    # Color gradient interpolation system for download backgrounds.
    c.colors.downloads.system.bg = 'none'

    # Background color for hints.
    c.colors.hints.bg = palette['nord0']

    # Font color for hints.
    c.colors.hints.fg = palette['nord9']

    # Hints
    c.hints.border = '1px solid ' + palette['nord0']

    # Font color for the matched part of hints.
    c.colors.hints.match.fg = palette['nord5']

    # Background color of the keyhint widget.
    c.colors.keyhint.bg = palette['nord0']

    # Text color for the keyhint widget.
    c.colors.keyhint.fg = palette['nord9']

    # Highlight color for keys to complete the current keychain.
    c.colors.keyhint.suffix.fg = palette['nord10']

    # Background color of an error message.
    c.colors.messages.error.bg = palette['nord0']

    # Border color of an error message.
    c.colors.messages.error.border = palette['nord0']

    # Foreground color of an error message.
    c.colors.messages.error.fg = palette['nord11']

    # Background color of an info message.
    c.colors.messages.info.bg = palette['nord0']

    # Border color of an info message.
    c.colors.messages.info.border = palette['nord0']

    # Foreground color an info message.
    c.colors.messages.info.fg = palette['nord10']

    # Background color of a warning message.
    c.colors.messages.warning.bg = palette['nord0']

    # Border color of a warning message.
    c.colors.messages.warning.border = palette['nord0']

    # Foreground color a warning message.
    c.colors.messages.warning.fg = palette['nord11']

    # Background color for prompts.
    c.colors.prompts.bg = palette['nord0']

    # Border used around UI elements in prompts.
    c.colors.prompts.border = '1px solid ' + palette['nord0']

    # Foreground color for prompts.
    c.colors.prompts.fg = palette['nord8']

    # Background color for the selected item in filename prompts.
    c.colors.prompts.selected.bg = palette['nord3']

    # Background color of the statusbar in caret mode.
    c.colors.statusbar.caret.bg = palette['nord0']

    # Foreground color of the statusbar in caret mode.
    c.colors.statusbar.caret.fg = palette['nord12']

    # Background color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.bg = palette['nord0']

    # Foreground color of the statusbar in caret mode with a selection.
    c.colors.statusbar.caret.selection.fg = palette['nord12']

    # Background color of the statusbar in command mode.
    c.colors.statusbar.command.bg = palette['nord0']

    # Foreground color of the statusbar in command mode.
    c.colors.statusbar.command.fg = palette['nord15']

    # Background color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.bg = palette['nord0']

    # Foreground color of the statusbar in private browsing + command mode.
    c.colors.statusbar.command.private.fg = palette['nord5']

    # Background color of the statusbar in insert mode.
    c.colors.statusbar.insert.bg = palette['nord1']

    # Foreground color of the statusbar in insert mode.
    c.colors.statusbar.insert.fg = palette['nord6']

    # Background color of the statusbar.
    c.colors.statusbar.normal.bg = palette['nord0']

    # Foreground color of the statusbar.
    c.colors.statusbar.normal.fg = palette['nord4']

    # Background color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.bg = palette['nord0']

    # Foreground color of the statusbar in passthrough mode.
    c.colors.statusbar.passthrough.fg = palette['nord12']

    # Background color of the statusbar in private browsing mode.
    c.colors.statusbar.private.bg = palette['nord0']

    # Foreground color of the statusbar in private browsing mode.
    c.colors.statusbar.private.fg = palette['nord5']

    # Background color of the progress bar.
    c.colors.statusbar.progress.bg = palette['nord0']

    # Foreground color of the URL in the statusbar on error.
    c.colors.statusbar.url.error.fg = palette['nord11']

    # Default foreground color of the URL in the statusbar.
    c.colors.statusbar.url.fg = palette['nord4']

    # Foreground color of the URL in the statusbar for hovered links.
    c.colors.statusbar.url.hover.fg = palette['nord8']

    # Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.http.fg = palette['nord14']

    # Foreground color of the URL in the statusbar on successful load
    c.colors.statusbar.url.success.https.fg = palette['nord14']

    # Foreground color of the URL in the statusbar when there's a warning.
    c.colors.statusbar.url.warn.fg = palette['nord13']

    # Status bar padding
    c.statusbar.padding = padding

    # Background color of the tab bar.
    c.colors.tabs.bar.bg = palette['nord3']

    # Background color of unselected even tabs.
    c.colors.tabs.even.bg = palette['nord3']

    # Foreground color of unselected even tabs.
    c.colors.tabs.even.fg = palette['nord4']

    # Color for the tab indicator on errors.
    c.colors.tabs.indicator.error = palette['nord11']

    # Color gradient start for the tab indicator.
    c.colors.tabs.indicator.start = palette['nord12']

    # Color gradient end for the tab indicator.
    c.colors.tabs.indicator.stop = palette['nord14']

    # Color gradient interpolation system for the tab indicator.
    c.colors.tabs.indicator.system = 'none'

    # Background color of unselected odd tabs.
    c.colors.tabs.odd.bg = palette['nord3']

    # Foreground color of unselected odd tabs.
    c.colors.tabs.odd.fg = palette['nord4']

    # Background color of selected even tabs.
    c.colors.tabs.selected.even.bg = palette['nord0']

    # Foreground color of selected even tabs.
    c.colors.tabs.selected.even.fg = palette['nord4']

    # Background color of selected odd tabs.
    c.colors.tabs.selected.odd.bg = palette['nord0']

    # Foreground color of selected odd tabs.
    c.colors.tabs.selected.odd.fg = palette['nord4']

    # Tab padding
    c.tabs.padding = padding
    c.tabs.indicator.width = 1
    c.tabs.favicons.scale = 1
