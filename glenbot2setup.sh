#!/bin/bash

# 20221206T072650Z: I got tired of creating new linux boxes for various things
# and having to set up each one to my preferences.  This script will automate
# that process.

# This script should be run everywhere, and self smart enough to be run more
# than once and not consume more resources whenever doing so.

# colors as learned from https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
#echo "${red}red text ${green}green text${reset}"

# to see if GlenBot2 is installed, check for a line about ~/.glenbot2_aliases
if grep -Pq "if \[ -f ~/.aliases_glenbot2 \]; then" ~/.bashrc
then
  tput setaf 2 # set output to green
  /usr/bin/printf "\xE2\x9C\x94" # print a checkmark
  tput sgr0  # reset output
  /usr/bin/printf " GlenBot2 is installed.\n"
else
  echo -n "20221206T090649Z: GlenBot2 is installing itsef here... "
  echo " " >> $HOME/.bashrc
  echo "# GlenBot2" >> $HOME/.bashrc
  echo "if [ -f ~/.aliases_glenbot2 ]; then" >> $HOME/.bashrc
  echo "    . ~/.aliases_glenbot2" >> $HOME/.bashrc
  echo "fi" >> $HOME/.bashrc
  bash <(curl -Ls https://raw.githubusercontent.com/GlenCooper/glenbot2_public/main/glenbot2setup.sh)
  echo "Done"
fi

glenbot2filename="$HOME/.aliases_glenbot2"
if [ -f $glenbot2filename ]; then
  echo "20221206T113729Z: Filename \"$glenbot2filename\" already exists."
else
  echo -n "Creating \"$glenbot2filename\"... "
  echo "alias c='clear'" > $glenbot2filename
  echo "Done."
fi
  
