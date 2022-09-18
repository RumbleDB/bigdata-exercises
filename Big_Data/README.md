# Big Data @ ETH Zurich (Fall 2022)

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

### Working behind ETH's Proxy

If you are working within the ETH network (i.e., from within ETH's wifi, from one of the pool computers, or via VPN), you need to configure Docker in two places to work with that proxy. Below is a description how (adapted from [the official documentation](https://docs.docker.com/network/proxy/)).

#### Docker Client

Edit `~/.docker/config.json` and make sure the proxy is configured like this:

```JSON
{
 "proxies":
 {
   "default":
   {
     "httpProxy": "http://proxy.ethz.ch:3128",
     "httpsProxy": "http://proxy.ethz.ch:3128"
   }
 }
}
```

#### Docker Engine

Inside the Docker containers (which are started by Docker Compose), the environment variables `http(s)_proxy` both upper and lower case should be set to `http://proxy.ethz.ch:3128`. There are a number of ways to achieve this:

* Modify the `.env` file in each `exerciseXX` directory or the one in the root directory if this repository and add the following lines:
   ```bash
   HTTPS_PROXY=http://proxy.ethz.ch:3128
   HTTP_PROXY=http://proxy.ethz.ch:3128
   FTP_PROXY=http://proxy.ethz.ch:3128
   https_proxy=http://proxy.ethz.ch:3128
   http_proxy=http://proxy.ethz.ch:3128
   ftp_proxy=http://proxy.ethz.ch:3128
   ```
* If you know your system is using systemd (which is the default in Ubuntu), try out [this method](https://docs.docker.com/config/daemon/systemd/#httphttps-proxy) to configure these variables permanently.
* If you know your system is using SysV (e.g., some older Ubuntu/Debian versions), try out [this method](https://stackoverflow.com/a/38386911/651937)

### SSH Tunnel

You may want to run Docker Compose on some computer (maybe from the ETH pool) but use a browser on another one (maybe your laptop at home). This is possible with SSH tunneling.

With that approach, there are two to three computers involved: (1) your machine (with the browser), (2) a *jump host*, and (3) the target machine (where Docker Compose runs). It may be that (2) and (3) are the same computer. For this to work, you will need an SSH client on your machine (1), you need to be able to SSH from your machine (1) to the jump host (2), the jump host (2) needs to be able to reach the target machine (3) over the network, and Docker Compose needs to be installed as described above on the target machine (3).

Once everything is installed, do the following to establish the tunnel:

```bash
ssh -L $LOCAL_PORT:$TARGET_MACHINE_DNSNAME:$TARGET_PORT -p $SSH_PORT $SSH_USER@$JUMPHOST_DNSNAME
 ```

For the notebook server, `TARGET_PORT=8888`. You typically set `LOCAL_PORT` to the same value or to `80`, in which case you can omit the port from the URL in your local browser. `SSH_PORT` is 22 by default; `SSH_USER` is probably your NETHZ ID if the target machine (3) is managed by ETH. If the target machine (3) is the same machine as the jump host (2), then `TARGET_MACHINE_DNSNAME=localhost`.

If a `docker-compose.yml` exposes more than one service with a web server, you can repeat the `-L $LOCAL_PORT:$TARGET_MACHINE_DNSNAME:$TARGET_PORT` with different values of `LOCAL_PORT` and `TARGET_PORT`.
