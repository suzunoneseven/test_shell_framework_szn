#!/usr/bin/python
# config: utf-8
# logget.py

import subprocess
import threading

psArray=[]

class tail(threading.Thread):
    """ """

    def __init__(self, host, user, passwd, file):
        super(tail, self).__init__()
        self.host = host
        self.user = user
        self.passwd = passwd
        self.file = file

    def run(self):
        cmd = "./logget.sh -h " + self.host + " -u " + self.user + " -p " + self.passwd + " -f " + self.file
        p = subprocess.Popen(cmd.split(' '), shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        psArray.append(p)

def tail_start(host, user, passwd, file):
    th = tail(host, user, passwd, file)
    th.start()

def tail_stop():
    for p in psArray:
        print p.communicate()
