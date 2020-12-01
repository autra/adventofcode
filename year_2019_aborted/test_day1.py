#!/usr/bin/env python
# -*- coding: utf-8 -*-
print('__file__={0:<35} | __name__={1:<20} | __package__={2:<20}'.format(__file__,__name__,str(__package__)))
from .day_1 import get_fuel, get_total, get_real_fuel


def test_getfuel():
    assert get_fuel(2) == 0
    assert get_fuel(3) == 0
    assert get_fuel(6) == 0
    assert get_fuel(9) == 1
    assert get_fuel(12) == 2
    assert get_fuel(14) == 2
    assert get_fuel(15) == 3
    assert get_fuel(1969) == 654
    assert get_fuel(100756) == 33583
    print('coucou')


def test_get_real_fuel():
    assert get_real_fuel(12) == 2
    assert get_real_fuel(14) == 2
    assert get_real_fuel(15) == 3
    assert get_real_fuel(33) == 10


def test_get_total():
    assert get_total(['12', '14', '15', '16']) == 10
    assert get_total(['33', '14']) == 12
