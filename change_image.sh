#!/bin/bash
#This script checks the meta data inside a tif image and does some manipulation, then saves as a new tif. More specifically it changes the xy position coordinates of the image.
#Not done yet, need to incoorporate the coordinates by selecting well, through IF-statement. And rather use XSLT instead of sed.
if [ $# -eq 0 ];
then
echo "Syntax: $(basename $0) image x-coordinate y-coordinate"
exit 1
fi
image=$1
xCoord=$2
yCoord=$3
s=$(<settings.cfg)
set -- $s
tiffinfo $image | cat > $1
tiffinfo $image | \
sed -e 's/  ImageDescription: //' -e '1,/  Planar Configuration:/d' -e "s/PositionX=\".*\" PositionY=\".*\" /PositionX=\"$xCoord\" PositionY=\"$yCoord\" /" | \
cat > $2
convert -depth 16 -comment "@/home/martin/Skrivbord/chcoord/after.txt" $image $image".new"
