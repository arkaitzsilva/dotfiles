(define-configuration browser
  ((theme
    (make-instance 'theme:theme
                   :background-color "#1A1B26"       ; Tokyo Night Storm background
                   :on-background-color "#C0CAF5"    ; Default foreground
                   :accent-color "#7DCFFF"           ; Accent cyan
                   :on-accent-color "#C0CAF5"        ; Text on accent
                   :primary-color "#7AA2F7"          ; Primary blue
                   :on-primary-color "#C0CAF5"       ; Text on primary
                   :secondary-color "#9ECE6A"        ; Secondary green
                   :on-secondary-color "#1A1B26")))) ; Dark contrast

(define-configuration nyxt/mode/style:dark-mode
  ((style
    (theme:themed-css (theme *browser*)
      `(* :background-color ,theme:background "!important"
          :background-image none "!important"
          :color "#C0CAF5" "!important")
      `(a :background-color ,theme:background "!important"
          :background-image none "!important"
          :color "#7DCFFF" "!important")))))
