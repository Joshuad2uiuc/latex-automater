#!/bin/bash
# usage: bash make-script.sh "Name of essay"
# params : The actual plain English title of the essay (e.g. Leaves of Grass)

author="FILL ME OUT"

lowercase_title=$(echo "$@" | tr '[:upper:]' '[:lower:]')

# convert title to hyphenate
hyphenated_title=$(echo "$lowercase_title" | tr " " "-")

# create directory
cp -R ~/writing/default-template $hyphenated_title

# Rename main to hyphenated title
mv ~/writing/$hyphenated_title/main.tex ~/writing/$hyphenated_title/$hyphenated_title.tex 

# Insert title as latex file name
sed -i '' -e "s/\title{Title}/\title{$@}/g" ~/writing/$hyphenated_title/$hyphenated_title.tex 

# Insert author name in file
sed -i '' -e "s/\title{Title}/\title{$author}/g" ~/writing/$hyphenated_title/$hyphenated_title.tex 

# Grab date
date=$(date '+%B %Y')

# Put date into file 
sed -i '' -e "s/\date{Date}/\date{$date}/g" ~/writing/$hyphenated_title/$hyphenated_title.tex 
