#!/bin/sh
gpg -d ~/.calcurse/apts.gpg > ~/.calcurse/apts && st -e calcurse ; rm ~/.calcurse/apts.gpg ; encr ~/.calcurse/apts
