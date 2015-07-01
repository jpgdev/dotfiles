# Change the end of line character for the current directory and its children
find . -type f -exec dos2unix {} {} \;

