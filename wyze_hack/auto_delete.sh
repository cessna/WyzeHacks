#!/bin/sh
if [ -z "$DELETE_OLDER_THAN" ];
then
    # Auto delete not enabled
    exit 0
fi

while true
do
    for DAY in `ls -d /media/mmcblk0p1/record/???????? 2>/dev/null| sort | head -n -$DELETE_OLDER_THAN 2>/dev/null| grep -oE "[0-9]{8}$"`;
    do
        SRC_DIR=/media/mmcblk0p1/record/$DAY

        if [ ! -d $SRC_DIR ];
        then
            continue
        fi

        for SRC_FILE in `find "$SRC_DIR" -name *.mp4 2>/dev/null| grep -oE "[0-9]{2}/[0-9]{2}\.mp4$"`;
        do
            # delete file here
            rm -f $SRC_DIR/$SRC_FILE
            # mv -n $SRC_DIR/$SRC_FILE $DST_DIR/$DST_FILE
        done
        rmdir $SRC_DIR/* $SRC_DIR
    done

    for DAY in `ls -d /media/mmcblk0p1/alarm/???????? 2>/dev/null| sort | head -n -$DELETE_OLDER_THAN 2>/dev/null| grep -oE "[0-9]{8}$"`;
    do
        SRC_DIR=/media/mmcblk0p1/alarm/$DAY
        DST_DIR=/media/mmcblk0p1/archive/alarm/$DAY
        
        # delete here
        # mv -n $SRC_DIR $DST_DIR
    done

    sleep 1d
done
