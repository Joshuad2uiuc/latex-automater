#!/bin/bash
# usage: bash make-script.sh "Name of essay"
# params : The actual plain English title of the essay (e.g. Leaves of Grass)
reldir="$( dirname -- "$0"; )";
author=$( grep 'author:' $reldir/config.yml | tail | cut -d '"' -f 2)
repo_location=$( grep 'repo_location:' $reldir/config.yml | tail | cut -d : -f 2)

lowercase_title=$(echo "$@" | tr '[:upper:]' '[:lower:]')

# convert title to hyphenate
hyphenated_title=$(echo "$lowercase_title" | tr " " "-")

title=$(echo "$@" | xargs)

# create directory
cp -R $repo_location/default-template $hyphenated_title

# Rename main to hyphenated title
mv ./$hyphenated_title/main.tex ./$hyphenated_title/$hyphenated_title.tex

# Insert title as latex file name
sed -i '' -e "s/\title{Title}/\title{$title}/g" ./$hyphenated_title/$hyphenated_title.tex 

# Insert author name in file
sed -i '' -e "s/\author{Author}/\author{$author}/g" ./$hyphenated_title/$hyphenated_title.tex 

# Grab date
date=$(date '+%B %Y')

# Put date into file 
sed -i '' -e "s/\date{Date}/\date{$date}/g" ./$hyphenated_title/$hyphenated_title.tex 
