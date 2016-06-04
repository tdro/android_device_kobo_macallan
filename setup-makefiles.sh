#tdro@github.com

OUTDIR=vendor/$VENDOR/$DEVICE
MAKEFILE=../../../$OUTDIR/$DEVICE-vendor-blobs.mk

(cat << EOF) > $MAKEFILE

PRODUCT_COPY_FILES += \\
EOF

LINEEND=" \\"
COUNT=`wc -l ../$DEVICE/proprietary-files.txt | awk {'print $1'}`
DISM=`egrep -c '(^#|^$)' ../$DEVICE/proprietary-files.txt`
COUNT=`expr $COUNT - $DISM`
for FILE in `egrep -v '(^#|^$)' ../$DEVICE/proprietary-files.txt`; do
  COUNT=`expr $COUNT - 1`
  if [ $COUNT = "0" ]; then
    LINEEND=""
  fi
   echo "    $OUTDIR/$FILE:$FILE$LINEEND" >> $MAKEFILE
done

(cat << EOF) > ../../../$OUTDIR/$DEVICE-vendor.mk


\$(call inherit-product, vendor/$VENDOR/$DEVICE/$DEVICE-vendor-blobs.mk)
EOF

(cat << EOF) > ../../../$OUTDIR/BoardConfigVendor.mk

EOF
