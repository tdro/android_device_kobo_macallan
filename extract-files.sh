#!/bin/bash

find system/ -type f > proprietary-files.txt

export DEVICE=macallan
export VENDOR=kobo

SRC=$1

BASE=../../../vendor/$VENDOR/$DEVICE
rm -rf $BASE/*

for FILE in `egrep -v '(^#|^$)' proprietary-files.txt`; do
	echo "Extracting $FILE ..."
	OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
	FILE=`echo ${PARSING_ARRAY[0]} | sed -e "s/^-//g"`
	DEST=${PARSING_ARRAY[1]}
	if [ -z $DEST ]
	then
		DEST=$FILE
	fi
	DIR=`dirname $FILE`
	if [ ! -d $BASE/$DIR ]; then
		mkdir -p $BASE/$DIR
	fi
	cp $FILE $BASE/$DEST
	# if file dot not exist try destination
	if [ "$?" != "0" ]
	then
		cp $SRC/system/$DEST $BASE/$DEST
	fi
done

./setup-makefiles.sh
