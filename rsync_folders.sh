# Add each pair separater by a white space (SOURCE: no slashing end TARGET:Yes slashding end)
os=`uname`

if [ "$os" = "Darwin" ]; then
    print $os
    SOURCES=(/Users/kamarain/Documents
	     /Users/kamarain/Pictures
	     /Users/kamarain/Videos
	     /Users/kamarain/Desktop)
    #	 /home/kamarain/Work/sdu_dk
    #	 /home/kamarain/Work/lut_fi)
else
    SOURCES=(/home/kamarain/Documents
	     /home/kamarain/Pictures
	     /home/kamarain/Videos
	     /home/kamarain/Desktop)
    #	 /home/kamarain/Work/sdu_dk
    #	 /home/kamarain/Work/lut_fi)
fi;

TARGETS=(linux-ssh.tuni.fi:laptop_backup/
	 linux-ssh.tuni.fi:laptop_backup/
	 linux-ssh.tuni.fi:laptop_backup/
	 linux-ssh.tuni.fi:laptop_backup/)
##TARGETS=(staff-linux.cc.tut.fi:laptop_backup/
##	 staff-linux.cc.tut.fi:laptop_backup/
##	 staff-linux.cc.tut.fi:laptop_backup/
##	 staff-linux.cc.tut.fi:laptop_backup/)
#	 staff-linux.cc.tut.fi:laptop_backup/Work/
#	 staff-linux.cc.tut.fi:laptop_backup/Work/)
DELETE_AT_TARGET=(1 1 1 1 0 0)

i=0;
for src in ${SOURCES[@]}
do
    echo "---"
    echo "BACKUPING FILES";
    echo "---"
    echo ITEM: $i
    echo SOURCE: ${SOURCES[$i]}
    echo TARGET: ${TARGETS[$i]}
    echo DELETE OLD:${DELETE_AT_TARGET[$i]}
    if [ ${DELETE_AT_TARGET[$i]} -eq 1 ]
    then
	echo rsync -avu --modify-window=10 --delete ${SOURCES[$i]} ${TARGETS[$i]}
	rsync -avu --modify-window=10 --delete ${SOURCES[$i]} ${TARGETS[$i]}
    else
	echo rsync -avu --modify-window=10 ${SOURCES[$i]} ${TARGETS[$i]}
	rsync -avu --modify-window=10 ${SOURCES[$i]} ${TARGETS[$i]}
   fi;
    let "i=$i+1";
done
