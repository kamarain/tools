# Usage:
#  $ source rsync_folders
#  $ source rsync_folders back


# Add each pair separater by a white space (SOURCE: no slashing end TARGET:Yes slashding end)
os=`uname`

if [ "$os" = "Darwin" ]; then # MacOS
    echo "MacOS system"
    SOURCEROOT=/Users/kamarain/
else
    echo "Linux system"
    SOURCEROOT=/home/kamarain/
fi;

SOURCES=(Documents
	 Pictures
	 Videos
	 Desktop)
    #	 Work/sdu_dk
    #	 Work/lut_fi)

TARGETROOT=linux-ssh.tuni.fi:laptop_backup/

DELETE_AT_TARGET=(0 0 0 0 0 0)

if [[ $1 == "back" ]]
then
    echo "RESTORING FILES"
    i=0;
    for src in ${SOURCES[@]}
    do
	echo "EXECUTING" rsync -avu --modify-window=10 ${TARGETROOT}${SOURCES[$i]} ${SOURCEROOT}
	rsync -avu --modify-window=10 ${TARGETROOT}${SOURCES[$i]} ${SOURCEROOT} 
	let "i=$i+1";
    done
else
    echo "STORING FILES TO REMOVE DIR";
    i=0;
    for src in ${SOURCES[@]}
    do
	if [ ${DELETE_AT_TARGET[$i]} -eq 1 ]
	then
	    echo "EXECUTING" rsync -avu --modify-window=10 --delete ${SOURCEROOT}${SOURCES[$i]} ${TARGETS[$i]}
	    rsync -avu --modify-window=10 --delete ${SOURCEROOT}${SOURCES[$i]} ${TARGETS[$i]}
	else
	    echo "EXECUTING" rsync -avu --modify-window=10 ${SOURCEROOT}${SOURCES[$i]} ${TARGETS[$i]}
	    rsync -avu --modify-window=10 ${SOURCEROOT}${SOURCES[$i]} ${TARGETS[$i]}
	fi;
	let "i=$i+1";
    done
fi;

