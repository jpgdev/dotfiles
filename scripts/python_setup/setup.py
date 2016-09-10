#!/bin/python
# import click
# import os
# import subprocess
from pacman_helper import PacmanHelper

# from subprocess import CalledProcessError, check_output, Popen

# @click.command()
# @click.option('--')

pacman = PacmanHelper()
pacman.load_and_install_packages('packages/base_pkgs.yml')

# for doc in base_pkgs:
# pkgs = doc['pkgs']
# print(doc.items())
#     for k, v in doc.items():
#         pkgs = v
#         # print(k, "->", v)
#     print("\n"),
#
# pkgs = ", ".join(pkgs)
# print(pkgs)
