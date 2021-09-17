# Big Data @ ETH Zurich (Fall 2021)

This repository hosts the weekly exercise sheets of the [Big Data course](https://systems.ethz.ch/education/courses/2021-autumn/big-data.html) at ETH Zurich.

## Docker Compose

The exercises sheets heavily rely on [Docker Compose](https://docs.docker.com/compose/). In short, Docker Compose allows us to define software environments that you can bring up on your own computer (ideally) with a single command. In the following, we describe how to install it and how to solve problems if they occur.

### Installation

* Windows: Installing [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/) should install everything you need (Docker Engine and Docker compose).
* Mac: Installing [Docker Desktop for Mac](https://docs.docker.com/desktop/mac/install/) should install everything you need (Docker Engine and Docker compose). According to the documentation, this should also work for Apple silicon processors but we cannot test this ourselves.
* Linux: Install [Docker Engine](https://docs.docker.com/engine/install/) (see distro-specific guides) and [Docker Compose](https://docs.docker.com/compose/install/).

### Basic Usage

Check out this repository using git. In the folder of a particular exercise (that contains a `docker-compose.yml` file), run the following command in a terminal:

```bash
docker-compose up
```

This outputs the log of the various services that are started in different docker containers. Check this output in case something goes wrong. To stop the services, press Ctrl+C. You can also start the services in the background and stop them with an explicit command:

```bash
docker-compose up -d  # Run the services in 'daemon' mode
docker-compose stop   # Stops the services but leaves the containers
docker-compose down   # Stops the services if running and removes the containers
```

In most if not all weeks, one of the services is a Jupyter notebook server with which you can use the exercise notebooks interactively. You can access the server by accessing [http://localhost:8888](http://localhost:8888) in your favorite browser. The exercise folder is automatically mounted into the container of the Jupyter notebook server such that you can open the notebooks we provide right away. Changes you make in the server are reflected immediately on your disk, so even if you destroy the containers, they are still there.


### Permissions to Host Folder

Accessing the host folder that is mounted into the containers may not immediately work due to permissions. In that case, use the following procedure:

1. In the root folder of this repository run:
   ```bash
   ./init-docker-env.sh
   ```
   This creates an `.env` file in the same folder with the user and group IDs of your host user. You only need to do this once.
1. After that, in every new terminal you use, run the following command:
   ```bash
   ./activate-docker-env.sh
   ```
   This changes the command `docker-compose` to automatically use the `.env` file from the previous step, which the docker containers use in turn to run their processes as your user from the host.
1. When you are done, close your terminal or run:
   ```bash
   ./deactivate-docker-env.sh
   ```
