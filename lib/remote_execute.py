#!/usr/bin/python
# config: utf-8
# remote_execute.py

import subprocess

class ssh:
    """   """

    def __init__(self, host, user, passwd):
        self.host = host
        self.user = user
        self.passwd = passwd

    def expect(self, command):
        subprocess.call(["./remote_execute.sh", "-h", self.host, "-u", self.user, "-p", self.passwd, "-c", command])
