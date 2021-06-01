# Convert bash 

## View supported bash
cat /etc/shells

## Check out  now being used
echo $0
echo $SHELL
env | grep SHELL

## Modify the default shell to /bin/bash 
chsh -s /bin/bash

Note:
After modifying the default shell of the system, it will not take effect immediately, \
and then the shell that is logged in to the system for modification will take effect.

