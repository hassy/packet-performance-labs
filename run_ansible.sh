#!/usr/bin/env bash

set -eu -o pipefail

if [[ $1 == "create" ]]; then
    packet_facility=${2:-ams1}
    packet_plan=${3:-baremetal_0}

    ansible-playbook -i packet_net.py --extra-vars "packet_project_id=$PACKET_PROJECT_ID packet_facility=$packet_facility packet_plan=$packet_plan" create_packet_host.yml
elif [[ $1 == "delete" ]]; then
    ansible-playbook -i packet_net.py --extra-vars "packet_project_id=$PACKET_PROJECT_ID" delete_packet_host.yml
else
    echo "Either \"create\" or \"delete\" needs to be specified"
fi
