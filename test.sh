#!/bin/sh

cd ~/youtube
LC_MESSAGES=C

for video in `cat video`; do
	if [ ! -d $video ]; then
		mkdir $video
		touch $video/speed_720.log
		touch $video/speed_360.log
	fi
	# get 360p
	q360_url="`./youtube-dl.py --get-url -f 34 "http://www.youtube.com/watch?v=$video"`"
	/usr/bin/wget --progress=dot:mega -o $video/wget.log -O /dev/null "$q360_url"
	grep saved $video/wget.log >> $video/speed_360.log
	HOST360=`cat $video/wget.log | grep "|" | cut -d "|" -f 2`
	echo $HOST360
	DT=`date +%Y-%m-%d_%H-%M`
	/usr/bin/mtr -wrc100 $HOST360 > $video/${DT}_360.mtr &

	# get 720p
	q720_url="`./youtube-dl.py --get-url -f 22 "http://www.youtube.com/watch?v=$video"`"
	/usr/bin/wget --progress=dot:mega -o $video/wget.log -O /dev/null "$q720_url"
	grep saved $video/wget.log >> $video/speed_720.log
	HOST720=`cat $video/wget.log | grep "|" | cut -d "|" -f 2`
	echo $HOST720
	DT=`date +%Y-%m-%d_%H-%M`
	/usr/bin/mtr -wrc100 $HOST720 > $video/${DT}_720.mtr &
done;

./analyse.sh
