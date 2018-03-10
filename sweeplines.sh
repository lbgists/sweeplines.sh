#!/usr/bin/env bash
# Sweeping Lines Terminal Screensaver
# Copyright (c) 2018 Yu-Jie Lin
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# window size
W=($(tput cols) $(tput lines))

# line position (\e[y;xH is 1-based)
P=(1 1)

# sweeping direction / increment (inc-x, inc-y)
D=(1 1)
# line symbols
# dir symbol inc-x   -y       idx = (ix * iy + 1) / 2
#  NE      \     1 * -1 = -1    0
#  SW      \    -1 *  1 = -1    0
#  NW      /    -1 * -1 =  1    1
#  SE      /     1 *  1 =  1    1
L='\/'


clear
while sleep 0.05; do
    ((i = (D[0] * D[1] + 1) / 2))
    echo -ne "\e[${P[1]};${P[0]}H${L:i:1}"
    for i in 0 1; do
        # sweeping by one step
        ((P[i] += D[i]))
        # if out of bound, flip the direction (by * -1), and use the new
        # direction value to compensate to get back into the boundary
        ((P[i] < 1 || P[i] > W[i])) && ((D[i] *= -1, P[i] += D[i]))
    done
done
