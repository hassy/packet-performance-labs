# packet-performance-labs

<p align="center">Create an on-demand baremetal performance lab in minutes with <a href="https://packet.net">Packet.net</a> 🔬 📈</p>

## About

This repo contains the scripts for setting up on-demand baremetal performance analysis & benchmarking labs on Packet.net.

- Scripted: One command to create and tear down a machine.
- On-demand: Less than 15 minutes to set up. Pay from just [$0.05/hour](https://www.packet.net/bare-metal/servers/type-0/).
- Baremetal: Blazing fast dedicated machines with no virtualization overhead or noisy neighbors.
- Performance analysis & benchmarking: A recent Linux kernel with `perf`. A Node.js environment with nvm and stackvis.
- Powered by [Packet.net](https://packet.net)

This is something I wrote for myself for working on [Artillery.io](https://artillery.io). I hope you find it useful too.

## Usage

### Requirements

- Sign up for a Packet.net account and get an API key
- Create a Packet.net project (e.g. "Performance Labs") and grab its project ID

### Pull the Docker image

Grab and run the Docker image with all dependencies (Ansible, Packet.net modules etc) pre-installed:

```shell
docker run -it --rm hassy/packet-performance-labs /bin/bash
```

#### Create a machine

To provision a perf lab machine:

```shell
API_TOKEN="your Packet API token" PROJECT_ID="your Packet project ID" make create-lab
```

Once finished, `ssh` in (the username is `root`) and you're good to go.

**NOTE** This command should be run from the Docker container.

#### Delete the machine

When you're done with the machine, run:

```shell
API_TOKEN="your Packet API token" PROJECT_ID="your Packet project ID" make delete-lab
```

**NOTE** This command should be run from the Docker container.


## License

MIT
