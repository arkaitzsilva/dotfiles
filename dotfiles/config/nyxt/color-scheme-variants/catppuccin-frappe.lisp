(define-configuration browser
  ((theme
    (make-instance 'theme:theme
                   :background-color "#303446"       ; Catppuccin Frappe base
                   :on-background-color "#C6D0F5"    ; Text / foreground
                   :accent-color "#8CAAEE"           ; Accent blue
                   :on-accent-color "#303446"        ; Text on accent
                   :primary-color "#8CAAEE"          ; Primary blue
                   :on-primary-color "#303446"       ; Text on primary
                   :secondary-color "#A6D189"        ; Secondary green
                   :on-secondary-color "#303446")))) ; Dark contrast

(define-configuration nyxt/mode/style:dark-mode
  ((style
    (theme:themed-css (theme *browser*)
      `(* :background-color ,theme:background "!important"
          :background-image none "!important"
          :color "#C6D0F5" "!important")
      `(a :background-color ,theme:background "!important"
          :background-image none "!important"
          :color "#8CAAEE" "!important")))))
