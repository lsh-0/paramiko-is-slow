import os, sys, getpass

import aaargh
from paramiko import SSHClient, AutoAddPolicy

cli = aaargh.App()

@cli.cmd
@cli.cmd_arg('hostname')
@cli.cmd_arg('command')
@cli.cmd_arg('port')
def ssh(hostname, command, port=22):
    with SSHClient() as ssh_client:
        ssh_client.set_missing_host_key_policy(AutoAddPolicy())
        ssh_client.connect(hostname=hostname,
                           port=port,
                           username=getpass.getuser(),
                           allow_agent=False,
                           look_for_keys=False,
                           key_filename=os.path.expanduser('~/.ssh/id_rsa'))
        stdin, stdout, stderr = ssh_client.exec_command(command)
        return stdout.read()

if __name__ == '__main__':
    output = cli.run()
    try:
        sys.stdout.buffer.write(output)
    except Exception:
        # For python 2
        sys.stdout.write(output)
