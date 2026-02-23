# Disable GUI support to prevent GTK3 dependency installation
final: prev: {
  gst_all_1 = prev.gst_all_1.overrideScope (qfinal: qprev: {
    gst-plugins-bad = qprev.gst-plugins-bad.override {
      guiSupport = false;
    };
  });
}
