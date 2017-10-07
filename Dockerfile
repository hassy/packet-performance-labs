FROM bitnami/minideb:stretch

RUN apt-get update && apt-get install -y jq python python-pip
RUN pip install ansible packet-python

WORKDIR /ansible

COPY ansible.cfg .
COPY create_packet_host.yml .
COPY delete_packet_host.yml .
COPY packet_net.ini .
COPY packet_net.py .
COPY run_ansible.sh .
COPY Makefile .

CMD ["/bin/bash"]
