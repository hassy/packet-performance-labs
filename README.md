# packet-performance-labs

<p align="center">Create an on-demand baremetal performance lab in minutes with <a href="https://packet.net">Packet.net</a> 🔬 📈</p>

## About

This repo contains the scripts for setting up on-demand baremetal performance analysis & benchmarking labs on Packet.net.

- Scripted: One command to create and tear down a machine.
- On-demand: Less than 15 minutes to set up. Pay from just [$0.05/hour](https://www.packet.net/bare-metal/servers/type-0/).
- Baremetal: Blazing fast dedicated machines with no virtualization overhead or noisy neighbors.
- Performance analysis & benchmarking: A recent Linux kernel with `perf`. A Node.js environment with nvm and stackvis.
- Other useful tools: Emacs + [purcell/emacs.d](https://github.com/purcell/emacs.d)
- Powered by [Packet.net](https://packet.net)

This is something I quickly put together for myself for working on [Artillery.io](https://artillery.io). I hope you find it useful too.

## Usage

### Requirements

- Sign up for a Packet.net account and get an API key
- Create a Packet.net project (e.g. "Performance Labs") and grab its project ID

### Pull the Docker image


Grab the Docker image which contains all required dependencies installed (Ansible, Packet.net module etc):

```shell
docker pull hassy/packet-performance-labs
```

and start a shell session:

```shell
docker run --mount type=bind,source="$HOME/.ssh/id_rsa.pub",target=/ansible/key.pub,readonly -it --rm hassy/packet-performance-labs /bin/bash
```

Change the `source` path in the `--mount` directive to point to the SSH public key you want to use for your Packet.net instances.

#### Create a machine

To provision a perf lab machine:

```shell
API_TOKEN="your Packet API token" PROJECT_ID="your Packet project ID" make create-lab
```

Once finished, `ssh` in (the username is `root`) and you're good to go.

By default a [Type0](https://www.packet.net/bare-metal/servers/type-0/) server will be provisioned in Amsterdam. You can specify the facility and server type with `PACKET_FACILITY` and `PACKET_PLAN`:

- `PACKET_FACILITY=sjc1 API_TOKEN="token" PROJECT_ID="id" make create-lab` - create a server in San Jose.
- `PACKET_PLAN=baremetal_1e PACKET_FACILITY=ord1 API_TOKEN="token" PROJECT_ID="id" make create-lab` - create a Type1 server in Chicago.

Full list of facility & plan codes is available through the Packet API:

- [facilities](https://www.packet.net/developers/api/facilities/)
- [plans](https://www.packet.net/developers/api/plans/)

(**NOTE:** This command should be run from the Docker container.)

#### Delete the machine

When you're done with the machine, run:

```shell
API_TOKEN="your Packet API token" PROJECT_ID="your Packet project ID" make delete-lab
```

(**NOTE:** This command should be run from the Docker container.)


## License

MIT
