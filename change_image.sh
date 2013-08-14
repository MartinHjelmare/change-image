#!/bin/bash
#Change the path to "settings.cfg" if you execute the script from outside the script directory, before running script!
. "./settings.cfg"
#This script checks the meta data inside a tif image and does some manipulation, then injects the meta data inside an existing ome.tif image. More specifically it changes the xy position coordinates of the image using arguments.
#Not done yet, need to incoorporate the coordinates by selecting well, through IF-statement. And rather use XSLT instead of sed.
if [ $# -eq 0 ];
then
echo "Syntax: $(basename $0) image x-coordinate y-coordinate"
exit 1
fi
image=$1
xCoord=$2
yCoord=$3
#Remember that plates are reversed.
#xRow=$(expr $2 / 8 + 1)
#yRow=$(expr $2 % 8)
#xCoord=$(echo "scale= 3; ( 4 + $xRow * 9 ) / 1000" | bc)
#yCoord=$(echo "scale= 3; ( 4 + $yRow * 9 ) / 1000" | bc)
sh $BFTOOLS"tiffcomment" $image | cat > $BEFORE
sh $BFTOOLS"tiffcomment" $image | \
sed -e "s/PositionX=\".*\" PositionY=\".*\" /PositionX=\"$xCoord\" PositionY=\"$yCoord\" /" | \
cat > $AFTER
sh $BFTOOLS"tiffcomment" -set "$AFTER" $image
