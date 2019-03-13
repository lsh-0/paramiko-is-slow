# Python3+Paramiko is slow

This proves it.

## Requirements

* Python2
* Virtualenv for Python2
* Python3

You'll also need to be able to ssh to 127.0.0.1 with your current username.

You may need to add your `id_rsa.pub` pubkey to your `./ssh/authorized_keys` file.

## Usage

    $ ./install.sh
    $ ./timeit.sh
    
## Further

* https://github.com/paramiko/paramiko/issues/1141
