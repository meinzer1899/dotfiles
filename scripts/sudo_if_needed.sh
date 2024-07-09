#!/bin/bash
# ask for sudo permssions only if needed
if ! sudo --validate --on-interactive &>/dev/null; then
    echo -e "\nGet sudo permissions"
    sudo -v --prompt="  $(cyan)◆$(clr) %p password: "
fi
