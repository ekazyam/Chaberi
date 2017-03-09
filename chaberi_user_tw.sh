#!/bin/bash
#
# hello :)
# this tool useing forwarding is following.
#
# this tool useing tw command.
# tw command is twitter client.
# please install in advance.
# $ gem install tw
# 

#####################
# Check Signin.
#####################
function isSignin()
{
	# Const def.
	EXIST=0
	NOT_EXIST=1
	USER=${1}
	TMP=${2}

	if [ `grep -E "<span class=\"member-name-lv[[:digit:]]\">${USER}[[:space:]]{0,}</span>" ${TMP} | wc -l` != 0 ]
	then
		return ${EXIST}
	else
		return ${NOT_EXIST}
	fi
}

#####################
# Tweet.
#####################
function doTweet()
{
	# const def.
	# for example.
	# MSG_HEADER: [INFO]
	# MSG_USER:   hogeuser
	# MSG_FOOTER: is here!!
	# The message will be as follows :-)
	# [INFO] hogeuser is here!!
	MSG_HEADER="[INFO]"
	MSG_USER=$1
	MSG_FOOTER=" is here."

	yes | tw -silent ${MSG_HEADER}${MSG_USER}${MSG_FOOTER}
}

#####################
# Main Function. 
#####################
# Const def.
EXIST=0

# Target user.
# Please difinistions for array.
Users=(
hoge
piyo
fuga
)

# get html.
# this html is using the user ditected scraping.
# scraping url is following.
URL="http://hiratara.dyndns.org/chaberi/"
TMP=`echo /tmp/$RANDOM`
curl -s ${URL} -o ${TMP}

# Check Start.
for (( Z = 0; Z < ${#Users[@]}; ++Z ))
do
	# Check user sign in in chaberi.
	isSignin ${Users[$Z]} ${TMP}
	if [ $? = ${EXIST} ]
	then
		doTweet ${Users[$Z]}
	fi
done

# tmpfile del.
rm -f ${TMP}

