#!/bin/zsh
# convert-md-to-pdf - Use a simple script to convert all Markdown files in a folder into PDFs.

# Convert ALL md files in the CURRENT directory

# example input => output
# MyFile.md => MyFile.md.pdf



# for file in *.md; do pandoc -t latex --latex-engine=xelatex $file -o pdfs/$file.pdf; done

for file in *.md; do
    echo 'Exporting "'$file'" to "'$file'.pdf" ...'
    pandoc -t latex --latex-engine=xelatex -o $file.pdf $file
done
