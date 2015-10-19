#!/usr/bin/python

import config.systemConfig as config
import lib.comment   as comment

def initialize():
    comment.echo_title("initialize")

def start():
    comment.echo_title("start")

def term():
    comment.echo_title("term")

def main():
    initialize()
    start()
    term()

main()


import target.sample_category.sample_item.test_1_1
