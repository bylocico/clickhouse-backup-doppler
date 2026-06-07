# clickhouse-backup-doppler

Docker image packaging [clickhouse-backup](https://github.com/Altinity/clickhouse-backup) with [Doppler CLI](https://docs.doppler.com/docs/cli) for secrets injection.

## Versioning

The Docker image version tracks the upstream `altinity/clickhouse-backup` image version.

For example, `ghcr.io/bylocico/clickhouse-backup-doppler:2.7.1` contains `altinity/clickhouse-backup:2.7.1` with the Doppler CLI installed.

A scheduled workflow checks Docker Hub daily for new releases, builds and tests each one, and opens an auto-merge PR.

## Usage

```bash
docker pull ghcr.io/bylocico/clickhouse-backup-doppler:2.7.1
```

### With Doppler

```bash
docker run \
  -e DOPPLER_TOKEN=dp.st.xxx \
  ghcr.io/bylocico/clickhouse-backup-doppler:2.7.1 \
  list
```

### Docker Compose

```yaml
services:
  clickhouse-backup:
    image: ghcr.io/bylocico/clickhouse-backup-doppler:2.7.1
    environment:
      - DOPPLER_TOKEN=${DOPPLER_TOKEN}
```

## How it works

The entrypoint runs `doppler run -- doppler-launch.sh`, which:

1. Doppler injects secrets as environment variables
2. The launch script locates the `clickhouse-backup` binary
3. Execs to `clickhouse-backup` with all arguments passed through

## Configuration

| Environment Variable | Description |
|---------------------|-------------|
| `DOPPLER_TOKEN` | Doppler service token for secrets injection |
| `DOPPLER_PROJECT` | Doppler project name (alternative to token) |
| `DOPPLER_CONFIG` | Doppler config name (alternative to token) |

All upstream `clickhouse-backup` environment variables and CLI flags are supported.

## Development

Build locally:

```bash
docker build -t clickhouse-backup-doppler .
```

Build a specific upstream version:

```bash
docker build --build-arg CLICKHOUSE_BACKUP_VERSION=2.6.44 -t clickhouse-backup-doppler:2.6.44 .
```

Check for newer upstream versions:

```bash
node scripts/update-version.mjs --list-newer
```

Retarget to a specific version:

```bash
node scripts/update-version.mjs --version 2.7.1
```

## Publishing

Publishing is handled by `.github/workflows/publish.yml`. It runs on published GitHub Releases and on manual workflow dispatch.

The workflow builds multi-arch images (`linux/amd64`, `linux/arm64`) and pushes to GHCR.

## License

MIT
