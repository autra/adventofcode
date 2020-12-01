#!/usr/bin/env python
# -*- coding: utf-8 -*-
import math
import os


def get_fuel(mass):
    return math.floor(mass / 3) - 2


def get_total(lines):
    agg = 0
    for line in lines:
        agg = agg + get_fuel(float(line))
    return agg


if __name__ == '__main__':
    lines = tuple(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), './day1_input'), 'r'))
    print(get_total(lines))
