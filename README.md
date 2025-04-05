# HPS Container

This package contains the **HPS container build environment**, including the Dockerfile and `docker-compose.yml` needed to launch the **Host Provisioning Service (HPS)** for PXE boot and automated host configuration.

Deploy your sovereign private data space with hps-container plus hps-system.


## Design principles - Base layer

- Everything does just one thing (Unix: Do one thing an do it well)
  - Applies to scripts, hardware, network etc
- Designed for business continuity
  - Any hardware failure does not affect operation
- Designed for (unanticipated and catastrophic) failure
  - Assume things will fail in ways that were not considered, make it easy to recover
- Provide flexible and secure back-up options
  - DR can be anywhere, make sure it can only be accessed as intended
- Ensure recovery from disaster is simple, robust and testable
  - Because we are not our best selves when it all falls to pieces 
- Optimise both security and convenience
  - Strike the best of a difficult balance
- Make it simple, make it understandable
  - All written in Bash so that any sysadmin can understand what is going on
  - Easier to maintain and improve
  - Improve security - no external libraries to worry about
- Rebuild without Internet access
  - Assume the disaster means that all you have is the DR host and no Internet
- Segregate networks
  - Know what should be on each
- Make no hardware assumptions
  - The solution should work equally on Raspberry Pi's, JBOC (Just a Bunch Of Computers) or enterprise-grade servers
- Easy to test
  - Deploy just with VM's
- Installation is repeatable
  - Add future nodes without having to remember what you did last time
- Scalable performance and capacity
  - Increase network bandwidth, Compute Nodes, disk size and speed to grow the cluster
- Application agnostic
  - Put on it what you want
- Cluserable clusters
  - Add new clusters to create additional application planes
- Minimal documentation required
  - Maximal documentation available
- Welcomes hackers
  - You can add and update components, extend contribute
- Resists crackers
  - Others can't update components
- Freely available to all
  - Download, play, discover, test
- Professional services
  - If your time is more valuable than your money, experts are available at commercial rates
- Aim for perfection
  - Accept functional
- Any hardware can be replaced without affecting functionality
  - Hardware upgrades or repairs are not a reason to interrupt services
- No operational external dependencies
  - External paries can't interfere with services
- Optimise performance
  - Squeeze maximum performance out of resources
- Reduce waste
  - Reuse old hardware, even disks, make the most of hardware
- When your data becomes ransomed, make it easy to recover
  - Assume the bad actors get in, reduce the damage

## Contents

- `Dockerfile` — Defines the container environment (Debian-based), installs necessary services (nginx, fcgiwrap, dnsmasq, tftpd-hpa), and sets up entrypoint.
- `docker-compose.yml` — Mounts `/srv` from the host, exposes ports for HTTP, DHCP, and TFTP.
- `srv/` — Empty placeholder directory where `hps-system` should be placed and extracted.

## Requirements

This container **requires the `hps-system` package** to be mounted at:

```
/srv/hps
```

### How to Set Up

1. Extract `hps-system.tar.gz` into the included `srv/` directory:

```bash
tar -xzf hps-system.tar.gz -C ./srv
```

This will create the necessary `/srv/hps` layout used by the container.

2. Build and launch the container:

```bash
docker compose build
docker compose up -d
```

The container will fail to start if `/srv/hps/http/boot.ipxe` is missing.

## Documentation

After extracting `hps-system`, refer to `/srv/hps/README.md` inside the container (if provided) for full instructions.
