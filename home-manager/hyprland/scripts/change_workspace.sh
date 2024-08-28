#!/bin/sh

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 [+|-] <maximum number of workspaces>"
  exit 1
fi

sign="$1"
max_ws="$2"

current_ws=$(hyprctl activeworkspace -j | jq '.id')

if ! [[ "$max_ws" =~ ^[0-9]+$ ]]; then
  echo "The second argument must be a valid number."
  exit 1
fi

if [ "$sign" = "+" ]; then
  if [ "$current_ws" -lt "$max_ws" ]; then
    next_ws=$((current_ws + 1))
    hyprctl dispatch workspace "$next_ws"
  fi
elif [ "$sign" = "-" ]; then
  if [ "$current_ws" -gt 1 ]; then
    prev_ws=$((current_ws - 1))
    hyprctl dispatch workspace "$prev_ws"
  fi
else
  echo "The first argument must be '+' or '-'."
  exit 1
fi
