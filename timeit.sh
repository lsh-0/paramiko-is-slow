#!/bin/bash
set -e

# hide Cryptography's new deprecation warnings
export PYTHONWARNINGS="ignore" 

remote_host=${1:-"127.0.0.1"}
port=${2:-"22"}

source venv3/bin/activate

echo "--- First, verify the length of the outputted data."
python3 ssh.py ssh "$remote_host" 'dd if=/dev/zero bs=10M count=1' "$port" | wc -c

echo ""
echo "--- Second, time it in Python 3."
time python3 ssh.py ssh "$remote_host" 'dd if=/dev/zero bs=10M count=1' "$port" | sha256sum -

deactivate; source venv2/bin/activate
echo ""
echo "--- Third, time it in Python 2."
time python2 ssh.py ssh "$remote_host" 'dd if=/dev/zero bs=10M count=1' "$port" | sha256sum -

deactivate; source venv3/bin/activate
echo ""
echo "--- Now, try 20MB instead (py3)"
time python3 ssh.py ssh "$remote_host" 'dd if=/dev/zero bs=20M count=1' "$port" > /dev/null

deactivate; source venv2/bin/activate
echo ""
echo "--- Now, try 20MB instead (py2)"
time python2 ssh.py ssh "$remote_host" 'dd if=/dev/zero bs=20M count=1' "$port" > /dev/null
