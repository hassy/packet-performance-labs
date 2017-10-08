.PHONY: build-ansible-image docker-shell run-ansible

SHELL := /bin/bash

PACKET_FACILITY ?= "ams1"
PACKET_PLAN ?= "baremetal_0"

build-ansible-image: dynamic-inventory
	docker build -t hassy/packet-performance-labs .

docker-shell:
	docker run -it --rm hassy/packet-performance-labs /bin/bash

create-lab: dynamic-inventory
	@ PACKET_PROJECT_ID=$$PROJECT_ID PACKET_API_TOKEN=$$API_TOKEN bash run_ansible.sh create $(PACKET_FACILITY) $(PACKET_PLAN)

delete-lab: dynamic-inventory
	@ PACKET_PROJECT_ID=$$PROJECT_ID PACKET_API_TOKEN=$$API_TOKEN bash run_ansible.sh delete

packet-list-inventory: dynamic-inventory
	@ PACKET_API_TOKEN=$$API_TOKEN ./packet_net.py --list | jq .

push-image:
	docker push hassy/packet-performance-labs

#
# Dynamic inventory scripts:
#
dynamic-inventory: packet_net.py packet_net.ini
packet_net.py:
	wget https://github.com/ansible/ansible/raw/devel/contrib/inventory/packet_net.py
	chmod +x packet_net.py
packet_net.ini:
	wget https://github.com/ansible/ansible/raw/devel/contrib/inventory/packet_net.ini

clean:
	rm packet_net.py
	rm packet_net.ini
