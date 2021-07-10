#!/bin/sh
groff -e -ms $1 -Tpdf > $(basename $1 .ms).pdf
