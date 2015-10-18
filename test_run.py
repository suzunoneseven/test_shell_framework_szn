#!/usr/bin/python

import config.config as config
import lib.comment as comment

def initialize():
    comment.echo_title("initialize")

def start():
    comment.echo_title("test start")

def term():
    comment.echo_title("term")

def main():
    initialize()
    start()
    term()

main()
