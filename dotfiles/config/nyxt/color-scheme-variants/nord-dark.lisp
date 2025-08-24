(define-configuration browser
  ((theme
    (make-instance 'theme:theme
                   :background-color "#2E3440"       ; Nord polar night
                   :on-background-color "#D8DEE9"    ; Nord snow
                   :accent-color "#88C0D0"           ; Nord frost
                   :on-accent-color "#ECEFF4"        ; Nord snow light
                   :primary-color "#81A1C1"          ; Nord frost darker
                   :on-primary-color "#ECEFF4"
                   :secondary-color "#E5E9F0"
                   :on-secondary-color "#2E3440")))) ; contrast oscuro

(define-configuration nyxt/mode/style:dark-mode
  ((style
    (theme:themed-css (theme *browser*)
      `(* :background-color ,theme:background "!important"
          :background-image none "!important"
          :color "#D8DEE9" "!important")
      `(a :background-color ,theme:background "!important"
          :background-image none "!important"
          :color "#88C0D0" "!important")))))
