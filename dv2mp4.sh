# Converts a camcorder DV file <fname>.dv to <fname>.mp4 (saves space a lot)
fname=`basename -s .dv $1`
ffmpeg -i "$fname.dv" -vf yadif "$fname.mp4"

