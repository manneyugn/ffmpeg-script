#!/bin/bash
mkdir convert
for n in *.mp4
do
   echo $n
   ffmpeg -y -i ${n} -filter:v scale=-2:720 -c:a copy ./convert/${n}
done
