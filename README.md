# Localhost your devdocs

View docs in your Obsidian / any other .md viewer!


# Get Started - MACOS
1. install homebrew
2. Install python
```sh
brew install python
```
3. start venv
```sh
python3 -m venv venv
source venv/bin/activate
```
4. install html-to-markdown
```sh
pip3 install html-to-markdown
```
5. Execute the script
```sh
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
```


All credits for the script go to @danferns
