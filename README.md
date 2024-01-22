Benthos Studio Self-Hosted
==========================

This repository contains example deployment scripts for [Benthos Studio Self-Hosted][benthos-studio] users. For more information about Benthos Studio Self-Hosted check out [the about page][self-hosted-about].

## Docker

You can quickly run a Benthos Studio Self-Hosted instance via docker without any configuration with:

```sh
docker run --rm -p 3001:3001 ghcr.io/benthosdev/benthos-studio-shost
```

This will instanciate a self-hosted instance, which you can access at `http://localhost:3001`. You will be prompted to set an admin password and then validate the license of the instance via the web interface.

The self-hosted application comes with a few general options and subcommands which you can view with:

```sh
docker run --rm ghcr.io/benthosdev/benthos-studio-shost --help
```

And the `server` subcommand (which runs the self-hosted server) options can be viewed with:

```sh
docker run --rm ghcr.io/benthosdev/benthos-studio-shost server --help
```

This is fun for playing with, but by default the instance database will vanish once the instance is stopped, check out the following examples for ways to persist and back up the database.

## Docker Compose

Navigate to [the `./compose-example` directory][compose-example] for an example `docker-compose` configuration. This shows a basic deployment with metrics, dashboards, backups, etc.

[benthos-studio]: https://studio.benthos.dev/
[self-hosted-about]: https://studio.benthos.dev/app/selfhosted
[compose-example]: ./compose-example
