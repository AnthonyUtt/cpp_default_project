"""Installer for default_cpp_project
This script takes the destination directory as an argument.
It will copy all of the necessary files to the destination
directory. Will work with existing local git repos.
"""

from os import system
from os.path import isdir, isfile
from shutil import copy, copytree
from sys import argv

files_to_copy = [
    'CMakeLists.txt',
    '.gitignore',
    '.clang-format',
    'test',
    'include',
    'cmake',
    'src'
]

def copy_files(dest):
    for f in files_to_copy:
        if isdir(f):
            copytree(f, dest + '/' + f)
        elif isfile(f):
            copy(f, dest)
        else:
            print('###ERROR###')

def main():
    if len(argv) != 2:
        print('Usage: install.py <destination>')
        exit(1)
    
    if isdir(argv[1]):
        copy_files(argv[1])
    else:
        print('Destination must be a valid directory!')
        exit(2)

main()  # Call to main() to begin script processing