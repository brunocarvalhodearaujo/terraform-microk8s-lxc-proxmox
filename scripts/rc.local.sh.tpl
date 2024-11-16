#!/usr/bin/env bash

cat > /etc/rc.local <<EOF
#!/bin/bash

# If this symlink is missing, likely microk8s isn't running
if [ ! -L /dev/kmsg ]; then
  ln -s /dev/console /dev/kmsg
  apparmor_parser -r /var/lib/snapd/apparmor/profiles/*
fi

if [ -x /snap/bin/microk8s ]; then
  /snap/bin/microk8s.stop
  /snap/bin/microk8s.start
fi
EOF

chmod +x /etc/rc.local
