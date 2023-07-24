#!/bin/bash
for n in *.mp4
do
    filename=$(basename ${n} .mp4)
    mkdir ${filename}
    ffmpeg -y -i ${n} -g 48 -keyint_min 48 -sc_threshold 0 -stats  \
    -map 0:v -c:v:0 libx264 -filter:v:0 scale=-2:480 -b:v:0 3100k -r:v:0 30  \
    -map 0:v -c:v:2 libx264 -filter:v:2 scale=-2:720 -b:v:2 2400k -r:v:1 60  \
    -map 0:v -c:v:3 libx264 -filter:v:3 scale=-2:360 -b:v:3 1200k -r:v:2 30  \
    -map 0:a -c:a:0 aac -b:a:0 128k -ac 2 \
    -f hls -var_stream_map "v:0,agroup:1 v:1,agroup:1 v:2,agroup:1 a:0,agroup:1" \
    -hls_list_size 0 -hls_time 6  -master_pl_name master.m3u8 -y ./${filename}/TOS%v.m3u8
done
