#/bin/bash
set -e 
set -o nounset
ME=$(basename "$0")

if [ "$#" -ne 1 ]; then
	echo "Usage $ME <path to export to (must not exist)>"
	exit 3
fi

VERSION=$(grep -o "VERSION =.*" editor.html | sed 's/.*"\(.*\)";/\1/')
echo "$VERSION"

if [ -z "$VERSION" ]; then
	echo "Version is blank, which means we can't continue"
	exit 6
fi

LOCATION="$1"
LOCATION="$LOCATION/$VERSION"
if [ -e "$LOCATION" ]; then
	echo "You must export to a location that doesn't already exist"
	exit 4
fi


if [[ -n $(git status --porcelain) ]]; then
	echo "Failing due to dirty repo";
	exit 5;
fi



echo "VERSION is $VERSION"
echo git checkout-index -a --prefix=\""$LOCATION"\/\"
echo git submodule foreach \'git checkout-index -a --prefix=\""$LOCATION"\/\$path/\"\'
echo "Now you can run these if it all looks right"
