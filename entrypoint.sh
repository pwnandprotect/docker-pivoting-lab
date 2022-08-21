#!/bin/sh
echo "#!/bin/bash \n /home/maikroservice/tools/metasploit/msfconsole" > /bin/msfconsole
chmod +x /usr/bin/metasploit
ssh-keygen -A
exec /usr/sbin/sshd -D -e "$@"
