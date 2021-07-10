#!/bin/sh
cd /tmp
curl -LO https://based.cooking/index.html 2>/dev/null
recipe=$(sed '0,/id=artlist/d;/<\/ul>/,$d;s/^.*\">//;s/<\/a.*$//' /tmp/index.html | dmenu -i -l 20 -p "Recipe: ")
recipe_address=$(grep "$recipe" /tmp/index.html | cut -d\" -f2)
links https://based.cooking/$recipe_address
rm /tmp/index.html
