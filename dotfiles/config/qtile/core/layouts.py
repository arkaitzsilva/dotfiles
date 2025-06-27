from libqtile import layout


config = {
    "border_width": 0,
    "margin": 4,
    "single_border_width": 0,
    "single_margin": 4,
}

layouts = [
    layout.MonadTall(
        **config,
        change_ratio=0.02,
        min_ratio=0.30,
        max_ratio=0.70,
    ),
    layout.Max(**config),
]
