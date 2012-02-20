#!/bin/sh

rm index.html

echo "<html>                                                                                                                                             
<head>                                                                                                                                             
<title>YouTube</title>
<meta http-equiv="refresh" content="1800">
</head>                                                                                                                                            
<body>                                                                                                                                             
<center>"> index.html

for video in `cat video`; do
echo "<a href=http://www.youtube.com/watch?v=${video}>$video</a></br>"  >> index.html
echo "<img src=png/${video}_360_week.png /><img src=png/${video}_360_day.png /> </br>
<img src=png/${video}_720_week.png /><img src=png/${video}_720_day.png /> </br>" >> index.html
done;

echo "</center>                                                                                                                                          
</body>                                                                                                                                            
</html>" >> index.html

