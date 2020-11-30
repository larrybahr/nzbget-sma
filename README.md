SMA container based on linuxserver/nzbget
=========================================

Docker container for NZBGet that includes all FFMPEG and python requirements to run SMA with NZBGet.

[](https://github.com/StevenChorkley/nzbget-sma#version-tags)
-------------------------------------------------------------

Version Tags
------------

| Tag | Description |
| --- | --- |
| latest | Stable release from NZBGet with precompiled FFMPEG binaries |
| preview | Preview release from NZBGet with precompiled FFMPEG binaries |

[](https://github.com/StevenChorkley/nzbget-sma#usage)
------------------------------------------------------

Usage
-----

### [](https://github.com/StevenChorkley/nzbget-sma#recent-update)

### Recent update

As of 09/03/2020 the containers were overhauled and the location of the script was changed from `/usr/local/bin/sma/sickbeard_mp4_automator` to `/usr/local/sma`. The autoProcess mount point has been modified as well to be more docker friendly in a `/usr/local/sma/config` directory. Please review and update accordingly.

### [](https://github.com/StevenChorkley/nzbget-sma#docker-compose)

### docker-compose

```
yaml
  nzbget:
    image: stevepork/nzbget-sma
    container_name: nzbget
    volumes:
      - /opt/appdata/nzbget:/config
      - /opt/appdata/sma:/usr/local/sma/config
      - /mnt/storage/downloads:/downloads
    ports:
      - 6789:6789
    restart: always
    environment:
      - PUID=${PUID}
      - PGID=${PGID}

```

### [](https://github.com/StevenChorkley/nzbget-sma#autoprocessini)

### autoProcess.ini

-   Mount autoProcess.ini containing directory to `/usr/local/sma/config` using volumes
-   Consider making this writable as new options will be auto written to the config as they are added

### [](https://github.com/StevenChorkley/nzbget-sma#ffmpeg-binaries)

### FFMPEG Binaries

-   `/usr/local/bin/ffmpeg`
-   `/usr/local/bin/ffprobe`

[](https://github.com/StevenChorkley/nzbget-sma#configuring-nzbget)
-------------------------------------------------------------------

Configuring NZBGet
------------------

### [](https://github.com/StevenChorkley/nzbget-sma#configure-custom-script)

### Configure Custom Script

-   Settings > NZBGETPOSTPROCESS

| Parameter | Value |
| --- | --- |
| MP4_FOLDER | `/usr/local/sma/` |

-   Settings > Extension Scripts

| Parameter | Value |
| --- | --- |
| ShellOverride | `.py=/usr/bin/python3` |

[](https://github.com/StevenChorkley/nzbget-sma#logs)
-----------------------------------------------------

Logs
----

Located at `/usr/local/sma/config/sma.log` inside the container and your mounted config folder

[](https://github.com/StevenChorkley/nzbget-sma#environment-variables)
----------------------------------------------------------------------

Environment Variables
---------------------

| Variable | Description |
| --- | --- |
| PUID | User ID |
| PGID | Group ID |
| HOST | Local IP address for callback requests, default `127.0.0.1` |
| SMA_PATH | `/usr/local/sma` |
| SMA_UPDATE | Default `false`. Set `true` to pull git update of SMA on restart |
