#!/usr/bin/python
import os, sys
sys.path.append(os.getcwd())
import target.framework.baseTest as baseTest

class test_1_1(baseTest.baseTest):
    def __init__(self):
        print "test_1_1"

hoge = test_1_1()
