#!/bin/sh

RRD=$1
TITLE=$1
PERIOD=$2

case "$PERIOD" in
	"now" )
		FILE=""
		START=5400 
	;; 
	"day" )
		FILE="_day"
		START=86400
		WIDTH=200
	;; 
	"week")
		FILE="_week"
		START=604800
		WIDTH=600
	;; 
	"month" )
		FILE="_month"
		START=2592000
	;; 
	"year")
		FILE="_year"
		START=31536000 
	;; 
esac

/usr/bin/rrdtool graph png/${RRD}_360$FILE.png \
--imgformat=PNG \
--start=-$START \
--end=-30 \
--title="${TITLE}_360" \
--rigid \
--base=1000 \
--height=150 \
--width=$WIDTH \
--lower-limit=0 \
--vertical-label="bits per second" \
--slope-mode \
--font TITLE:10: \
--font AXIS:8:/usr/local/lib/X11/fonts/TTF/Verdana.ttf \
--font LEGEND:8:/usr/local/lib/X11/fonts/TTF/Verdana.ttf \
--font UNIT:8:/usr/local/lib/X11/fonts/TTF/Verdana.ttf \
DEF:a="rrd/${RRD}_360.rrd":speed:AVERAGE \
CDEF:cdefa=a,8000,* \
AREA:cdefa#00CF00FF:" in" \
GPRINT:cdefa:LAST:"cur\:%3.2lf%s"  \
GPRINT:cdefa:AVERAGE:"avg\:%3.2lf%s"  \
GPRINT:cdefa:MAX:"max\:%3.2lf%s\n"


/usr/bin/rrdtool graph png/${RRD}_720$FILE.png \
--imgformat=PNG \
--start=-$START \
--end=-30 \
--title="${TITLE}_720" \
--rigid \
--base=1000 \
--height=150 \
--width=$WIDTH \
--lower-limit=0 \
--vertical-label="bits per second" \
--slope-mode \
--font TITLE:10: \
--font AXIS:8:/usr/local/lib/X11/fonts/TTF/Verdana.ttf \
--font LEGEND:8:/usr/local/lib/X11/fonts/TTF/Verdana.ttf \
--font UNIT:8:/usr/local/lib/X11/fonts/TTF/Verdana.ttf \
DEF:a="rrd/${RRD}_720.rrd":speed:AVERAGE \
CDEF:cdefa=a,8000,* \
AREA:cdefa#00CF00FF:" in" \
GPRINT:cdefa:LAST:"cur\:%3.2lf%s"  \
GPRINT:cdefa:AVERAGE:"avg\:%3.2lf%s"  \
GPRINT:cdefa:MAX:"max\:%3.2lf%s\n"

