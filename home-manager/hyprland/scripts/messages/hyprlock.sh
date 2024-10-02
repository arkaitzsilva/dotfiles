#!/bin/sh

export TEXTDOMAIN="messages"
export TEXTDOMAINDIR="../po"

get_login_input_hint() {
  echo "<i>"$(gettext "Logged in as")"</i>" $USER
}

get_login_input_hint
