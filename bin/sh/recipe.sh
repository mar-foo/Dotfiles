#!/bin/sh
# MIT/X Consortium License

# © 2021 Mario Forzanini <mario.forzanini@studenti.unimi.it>

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

cd /tmp
curl -LO https://based.cooking/index.html 2>/dev/null
recipe=$(sed '0,/id=artlist/d;/<\/ul>/,$d;s/^.*\">//;s/<\/a.*$//' /tmp/index.html | dmenu -i -l 20 -p "Recipe: ")
recipe_address=$(grep "$recipe" /tmp/index.html | cut -d\" -f2)
${BROWSER:-surf-open.sh} https://based.cooking/$recipe_address
rm /tmp/index.html
