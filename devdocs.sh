#!/bin/bash
# Args: <language/framework>
set -euxo pipefail
wget https://downloads.devdocs.io/$1.tar.gz
mkdir $1
tar -xf $1.tar.gz --directory=$1
rm $1.tar.gz
cd $1
# these HTML files don't have <head>, we need to ensure UTF-8 is used
find . -name "*.html" -type f -exec sed -i '' '1i\
<head><meta charset="UTF-8"></head>' {} \;
# convert to html using parallel processing for speed
find . -name "*.html" -print0 | xargs -P 48 -0 -I {} sh -c 'html-to-markdown "$1" > "${1%.html}.md" && rm "$1"' sh {}
