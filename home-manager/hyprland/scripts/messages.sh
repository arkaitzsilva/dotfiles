#!/bin/sh

export TEXTDOMAIN="messages"
export TEXTDOMAINDIR="./po"

get_login_input_hint() {
  echo $(gettext "Logged in as ") $USER
}

get_login_input_hint
