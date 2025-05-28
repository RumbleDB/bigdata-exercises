# Big Data For Engineer @ ETH Zurich (Spring 2025)

This repository hosts the weekly exercise sheets of the [Big Data course](https://systems.ethz.ch/education/courses/2025-spring/big-data-for-engineers.html) at ETH Zurich.

## Docker Compose

The exercises sheets heavily rely on [Docker Compose](https://docs.docker.com/compose/). In short, Docker Compose allows us to define software environments that you can bring up on your own computer (ideally) with a single command. In the following, we describe how to install it and how to solve problems if they occur.

### Installation

* Windows: Installing [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/) should install everything you need (Docker Engine and Docker compose).
* Mac: Installing [Docker Desktop for Mac](https://docs.docker.com/desktop/mac/install/) should install everything you need (Docker Engine and Docker compose). According to the documentation, this should also work for Apple silicon processors but we cannot test this ourselves.
* Linux: Install [Docker Engine](https://docs.docker.com/engine/install/) (see distro-specific guides) and [Docker Compose](https://docs.docker.com/compose/install/).

### Basic Usage

Most exercises will use the Exam Magic Box Docker environment. You can find the
download link in Moodle. After unzipping, open a terminal and go to
the `exam-docker` directory containing the `docker-compose.yml` and run
```bash
docker-compose up
```
This outputs the log of the various services that are started in different docker containers. Check this output in case something goes wrong. To stop the services, press Ctrl+C. You can also start the services in the background and stop them with an explicit command:

```bash
docker-compose up -d  # Run the services in 'daemon' mode
docker-compose stop   # Stops the services but leaves the containers
docker-compose down   # Stops the services if running and removes the containers
```

In most if not all weeks, one of the services is a Jupyter notebook server with
which you can use the exercise notebooks interactively. You can access the
server by accessing [http://localhost:8888](http://localhost:8888) in your
favorite browser. The `notebooks` folder in the Magic Box is automatically mounted into the
container of the Jupyter notebook server.
To start with an exercise, copy the Jupyter `*.ipynb` files from the directory
here into the `notebooks/` folder and find it in Jupyter at [http://localhost:8888](http://localhost:8888).
Changes you make in the server are reflected immediately on
your disk, so even if you destroy the containers, they are still there.

### RumbleDB Troubleshooting

If you encounter issues while using RumbleDB, here are some common troubleshooting steps you can follow:

#### 1. ETHZ Proxy

Sometimes the ETHZ proxy, which is automatically set up when you connect to the network (either via VPN or Wi-Fi) can interfere with the Docker DNS service used to communicate with the RumbleDB container.

To bypass this, try adding the following code at the top of your notebook:

```python
import os

proxy_url = ''

os.environ['http_proxy'] = proxy_url
os.environ['https_proxy'] = proxy_url
os.environ['ftp_proxy'] = proxy_url
os.environ['HTTP_PROXY'] = proxy_url
os.environ['HTTPS_PROXY'] = proxy_url
os.environ['FTP_PROXY'] = proxy_url
```

**Note:** A typical error you might see when the RumbleDB connection fails due to this issue is:

```
JSONDecodeError: Expecting value: line 1 column 1 (char 0)
```

#### 2. Conflict with the Docker Engine

We’ve observed that certain versions of the Docker Engine (for example, **27.5.1**) combined with Docker Desktop (for example, **4.38**) can cause issues with the operating system’s cgroups on macOS or Linux, which in turn interferes with RumbleDB.

To fix this, update to the **latest version** of Docker Engine and Docker Desktop.

**Note:** A typical error message related to this issue is:

```
ConnectionError: ('Connection aborted.', RemoteDisconnected('Remote end closed connection without response'))
```
