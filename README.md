A dockerized Variant of Promet-ERP
----------------------------------
 
Persist Data
 docker run --publish 10088:8085 --volume /my-docker-data-dir/promet:/srv/promet promet-server 
 
 
- [Introduction](#introduction)
    - [Changelog](Changelog.md)
- [Issues](#issues)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Available Configuration Parameters](#available-configuration-parameters)
    - [Data Store](#data-store)
    - [Database](#database)
        - [PostgreSQL (Recommended)](#postgresql)
            - [External PostgreSQL Server](#external-postgresql-server)
            - [Linking to PostgreSQL Container](#linking-to-postgresql-container)

# Introduction

Dockerfile to run Promet-ERP [promet-ERP](http://www.free-erp.de) GUI Client from an container image.

# Installation

Automated builds of the image are available on [Dockerhub](https://hub.docker.com/cutec/promet-server) and is the recommended method of installation.

```bash
docker pull cutec/promet-server:latest
```

Alternatively you can build the image locally.

```bash
docker build -t cutec/promet-server github.com/cutec-chris/promet-server-docker
```

# Quick Start

Step 1. Launch the promet container

```bash
docker run --publish 10088:8085 cutec/promet-server
```

Point your browser to `http://localhost:10088` and go through the Mandant Wizard to create and Database and prefill it with an Profile.

You should now have the Promet-ERP application up and ready for testing. If you want to use this image in production then please read on.

# Configuration

## Data Store

promet-ERP is an (Article,Contact,Project,Document) Management Software and as such you don't want to lose your Data when the docker container is stopped/deleted. To avoid losing any data, you should mount a volume at,

* `/srv/promet`

SELinux users are also required to change the security context of the mount point so that it plays nicely with selinux.

```bash
mkdir -p /srv/docker/promet
sudo chcon -Rt svirt_sandbox_file_t /srv/docker/promet
```

Volumes can be mounted in docker by specifying the `-v` option in the docker run command.

```bash
docker run --name promet-erp -d \
    --publish 10088:8080 \
    --volume /srv/docker/promet:/srv/promet \
    cutec/promet-server:latest
```

## Database

Promet-ERP uses a database backend to store its data. You can configure this image to use either SQLite, MySQL, Firebird, MsSQL or PostgreSQL.

### PostgreSQL

#### External PostgreSQL Server

The image also supports using an external PostgreSQL Server.

```sql
CREATE ROLE promet with LOGIN CREATEDB PASSWORD 'password';
CREATE DATABASE promet_production;
GRANT ALL PRIVILEGES ON DATABASE promet_production to promet;
```
The Webinterface will point you through the rest of the process.

## Upgrading

- **Step 1**: Update the docker image.

```bash
docker pull cutec/promet-server:latest
```

- **Step 2**: Stop and remove the currently running image

```bash
docker stop promet-erp
docker rm promet-erp
```

- **Step 4**: Start the image

```bash
docker run --name promet-erp -d [OPTIONS] cutec/promet-server:latest
```

## Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using docker version `1.3.0` or higher you can access a running containers shell using `docker exec` command.

```bash
docker exec -it promet-erp bash
```

# References

* https://github.com/cutec-chris/promet-erp
* http://www.free-erp.de
