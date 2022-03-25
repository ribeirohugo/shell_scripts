# Git Backups

Clones all repositories listed in a text file, and compresses all the content into a zip file.

## Requirements

It is required a file with the list of repositories URLs, each per line.

Package ``zip`` is mandatory to compress all backups.

## How to use

``sudo ./main.sh <repos_file>``

``<repos_file>`` - path to repository list file. It assumes ``repos.txt`` value by default.
