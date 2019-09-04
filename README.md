# Docker container for GAP development version (stable-4.11 branch)

This container provides the core GAP system build from the `stable-4.11` branch
of the [GAP repository](https://github.com/gap-system) and GAP packages
prepared for the next release of GAP made from that branch.

If you have installed [Docker](https://www.docker.com/), to use this
container first you need to download it using

    docker pull gapsystem/gap-docker-stable-4.11

After that, you can start the GAP container using

    docker run --rm -i -t gapsystem/gap-docker-stable-4.11

Note that you may have to run `docker` with `sudo`, particularly if you are on Ubuntu.

The location of GAP in the container is `/home/gap/inst/gap-stable-4.11`
