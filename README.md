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

5. Save the script (e.g. devdocs.sh)
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
6. Make it executable
```sh
chmod +x devdocs.sh
``` 
8. Execute the script with any of the docs you want
```sh
./devdocs.sh html
```

# Linux

Ensure Python 3 is installed, and continue from step 3 of the MacOS steps.

# Using `pipx`

As an alternative to using a virtual environment, the pipx tool can be used to make `html-to-markdown` available globally.
Follow your system's [installation steps](https://github.com/pypa/pipx?tab=readme-ov-file#install-pipx) then run:

```sh
pipx install html-to-markdown
```

Now the script can be run without a venv. 

All credits for the script go to @danferns
