#!/bin/bash
set -e
rm -rf venv2 venv3

python3 -m venv venv3
virtualenv2 venv2

source venv2/bin/activate
pip install aaargh paramiko
deactivate

source venv3/bin/activate
pip install aaargh paramiko
deactivate
