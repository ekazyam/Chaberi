#!/usr/bin/python3
import subprocess
import random
import urllib.request
import re
import atexit
#
# hello :)
# this tool useing forwarding is following.
#
# this tool useing tw command.
# tw command is twitter client.
# please install in advance.
# $ gem install tw
#


def main():
    URL = "http://hiratara.dyndns.org/chaberi/"
    TMP, header = urllib.request.urlretrieve(URL)
    atexit.register(delTmp, TMP)

    Users = [
        "hoge",
        "piyo",
        'fuga'
    ]

    # read tmpfile and search.
    # target user is definitions in main function.
    filep = open(TMP)
    datas = filep.readlines()
    filep.close()

    for user in Users:
        pattern = '<span class="member-name-lv\d{0,}\">' + \
            user + ' {0,}</span>'
        for line in datas:
            result = re.search(pattern, line)
            if result is not None:
                doTweet(user)
                break


def doTweet(MSG_USER):
    # const def.
    # for example.
    # MSG_HEADER: [INFO]
    # MSG_USER:   hogeuser
    # MSG_FOOTER: is here!!
    # The message will be as follows :-)
    # [INFO] hogeuser is here!!
    MSG_HEADER = "[INFO]"
    MSG_FOOTER = " is here."
    subprocess.call(['tw', MSG_HEADER, MSG_USER, MSG_FOOTER])


def delTmp(tmp):
    # when called this fucntion ,delete tmp file.
    # tmp file using user serach.
    # tmp file using user serach.
    subprocess.call(['rm', tmp])

if __name__ == "__main__":
    main()
