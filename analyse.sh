#!/bin/sh

TAIL_STR=1



if [ ! -d rrd ]; then
                mkdir rrd
fi

if [ ! -d png ]; then
                mkdir png
fi

for video in `cat video`; do

if [ ! -e rrd/${video}_360.rrd ]; then
faketime "2011-01-01 00:00:00" rrdtool create \
	-s 1800sec \
	rrd/${video}_360.rrd \
	DS:speed:GAUGE:3600:U:U \
	RRA:AVERAGE:0.5:1:1440 \
        RRA:AVERAGE:0.5:24:356 \
        RRA:AVERAGE:0.5:356:10 \
	RRA:MAX:0.5:1:1440 \
        RRA:MAX:0.5:24:356 \
        RRA:MAX:0.5:356:10 \
	RRA:LAST:0.5:1:1440 \
        RRA:LAST:0.5:24:356 \
        RRA:LAST:0.5:356:10
faketime "2011-01-01 00:00:00" rrdtool create \
        -s 1800sec \
        rrd/${video}_720.rrd \
        DS:speed:GAUGE:3600:U:U \
        RRA:AVERAGE:0.5:1:1440 \
        RRA:AVERAGE:0.5:24:356 \
        RRA:AVERAGE:0.5:356:10 \
        RRA:MAX:0.5:1:1440 \
        RRA:MAX:0.5:24:356 \
        RRA:MAX:0.5:356:10 \
        RRA:LAST:0.5:1:1440 \
        RRA:LAST:0.5:24:356 \
        RRA:LAST:0.5:356:10

fi

for value in `cat $video/speed_360.log | grep saved | tail -n $TAIL_STR | cut -d ")" -f 1 | sed "s/(//"|sed "s/,/\./"|awk '
{
	if ($4 == "MB/s") {
		speed = $3*1000;
		} else {
		speed = $3
		}
	print($1 "_" $2 ";" speed);
}'`; do
echo "${video}_360\t$value"
TIME=`echo $value|cut -d ";" -f 1|sed "s/_/ /"`
SPEED=`echo $value|cut -d ";" -f 2`
#echo "$TIME $SPEED"
faketime "$TIME" rrdtool update rrd/${video}_360.rrd N:$SPEED
done;

for value in `cat $video/speed_720.log | grep saved | tail -n $TAIL_STR | cut -d ")" -f 1 | sed "s/(//"|sed "s/,/\./"|awk '
{
        if ($4 == "MB/s") {
                speed = $3*1000;
                } else {
                speed = $3
                }
        print($1 "_" $2 ";" speed);
}'`; do
echo "${video}_720\t$value"
TIME=`echo $value|cut -d ";" -f 1|sed "s/_/ /"`
SPEED=`echo $value|cut -d ";" -f 2`
#echo "$TIME $SPEED"
faketime "$TIME" rrdtool update rrd/${video}_720.rrd N:$SPEED
done;

./graph.sh $video week
./graph.sh $video day

done;
