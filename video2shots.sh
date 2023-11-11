# Uses ffmpeg shot detector to divide a long video (mp4) to shorter
# clips
input_file=$1
fname=`basename -s .mp4 $1`
output_dir="./"$fname"_clips"
if test -d $output_dir; then
    # Exists
else
    mkdir $output_dir
fi
ffmpeg -y -i $input_file -vf yadif \
       -c:v libx264 -profile:v high -preset:v fast \
       -x264opts min-keyint=15:keyint=1000:scenecut=20 -b:v 2000k \
       -c:a aac -b:a 128k \
       -f segment -segment_format mp4 -segment_time 0.01 -segment_format_options movflags=faststart \
       "$output_dir"/shot%05d.mp4
