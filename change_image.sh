#!/bin/bash
#This script checks the meta data inside a tif image and does some manipulation, then injects the meta data inside an existing ome.tif image. More specifically it changes the xy position coordinates of the image using arguments.
#Not done yet, need to incoorporate the coordinates by selecting well, through IF-statement. And rather use XSLT instead of sed.
if [ $# -eq 0 ];
then
echo "Syntax: $(basename $0) image x-coordinate y-coordinate"
exit 1
fi
. "/home/martin/change-image/settings.cfg"
image=$1
xCoord=$2
yCoord=$3
sh /home/martin/Skrivbord/bftools/tiffcomment $image | cat > $BEFORE
sh /home/martin/Skrivbord/bftools/tiffcomment $image | \
sed -e "s/PositionX=\".*\" PositionY=\".*\" /PositionX=\"$xCoord\" PositionY=\"$yCoord\" /" | \
cat > $AFTER
sh /home/martin/Skrivbord/bftools/tiffcomment -set "$AFTER" $image
