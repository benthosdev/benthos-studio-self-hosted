Compose O11y Example
====================

This [docker-compose][docker-compose] example shows how metrics can be extracted from Benthos Studio Self-Hosted by [Prometheus][prometheus] in order to create dashboards in [Grafana][grafana].

To run it:

```sh
docker-compose up -d
```

You should now be able to access the Benthos Studio instance from `http://localhost:3001`. Once it's up get it licensed and create some configs. When you've created some activity you should be able to open [Grafana][grafana] at `http://localhost:3000` (`admin` is set up with the password `admin` by default), take a look at the dashboards and there should be one already prepared (`http://localhost:3000/d/VvVYFhN7z/benthos-studio` if you can't find it).

## Next Steps

### Update Benthos Schema

By default Benthos Studio only reflects a small subset of the full Benthos schema. You can sync session schemas up to your own fleet of Benthos instances similar to the official Benthos Studio. However, one chore that's worth doing is updating the default schema known by Studio to match the latest version of Benthos, this allows you to use the full suite of official Benthos plugins without perfoming a sync for each individual session.

In order to do this we first need to pull the latest version of Benthos, in this example we'll continue using docker:

```sh
docker pull jeffail/benthos:latest
```

Next, we can export a full schema definition for Benthos with the command `benthos list`, and the Benthos Studio Self-Hosted server has a subcommand `update-official-schema` which can be used to consume a schema from `stdin` and uses it to update the database. A handy script `cmd_studio.sh` can be found in this directory that executes a container with the same volume as a our compose config so that we're updating the same database as we have deployed. Putting these things together gives us:

```sh
docker run --rm jeffail/benthos:latest list --format json-full-scrubbed | ./cmd_studio.sh update-official-schema
```

### Litestream Backups

A [Litestream][litestream] service is included in this example that accesses a volume shared by the Benthos Studio Self-Hosted in order to create streamed back ups of the data. Right now it's configured to write those backups to the filesystem at its own volume `backup_data`. However, it'd be wise to change this to write data to an S3 bucket or some other remote destination if needed.

### Logs in Dashboards

Another addition that might be handy is forwarding Studio logs directly to [Loki][loki], which allows you to add logs to your [Grafana][grafana] dashboards. Once there is a running Loki instance to connect to you can enable this by adding the `--loki-url=<loki url>` flag to the Studio command, e.g.:

```yaml
    command:
      - '--db=/var/data/db'
      - '--loki-url=http://loki:3100'
      - 'server'
```

[docker-compose]: https://docs.docker.com/compose/
[grafana]: https://grafana.com/
[prometheus]: https://prometheus.io/docs/introduction/overview/
[litestream]: https://litestream.io/
[loki]: https://grafana.com/docs/loki/latest/
