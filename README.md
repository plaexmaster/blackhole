# Scripts

## Installation

### Prerequisites
- Python 3.x installed.
- Pip package manager.

### Steps
1. Clone the repository (preferably into the home directory):

   ```bash
   git clone https://github.com/westsurname/scripts.git
   ```

2. Navigate to the project directory:

    ```bash
    cd scripts
    ```

3. Install the required packages:

    ```bash 
    pip install -r requirements.txt 
    ```
4. Copy `.env.template` to `.env` and populate the (applicable) variables:

   - **Sonarr** - Blackhole, Repair, Move Media to Directory, Reclaim Space, Add Next Episode:
     - `SONARR_HOST`: The host address of your Sonarr instance.
     - `SONARR_API_KEY`: The API key for accessing Sonarr.
     - `SONARR_ROOT_FOLDER`: The root folder path for Sonarr media files. (Required for repair compose service only)

   - **Radarr** - Blackhole, Repair, Move Media to Directory, Reclaim Space:
     - `RADARR_HOST`: The host address of your Radarr instance.
     - `RADARR_API_KEY`: The API key for accessing Radarr.
     - `RADARR_ROOT_FOLDER`: The root folder path for Radarr media files. (Required for repair compose service only)

   - **RealDebrid** - Blackhole, Repair:
     - `REALDEBRID_ENABLED`: Set to `true` to enable RealDebrid services.
     - `REALDEBRID_HOST`: The host address for the RealDebrid API.
     - `REALDEBRID_API_KEY`: The API key for accessing RealDebrid services.
     - `REALDEBRID_MOUNT_TORRENTS_PATH`: The path to the RealDebrid mount torrents folder.

   - **Blackhole** - Blackhole:
     - `BLACKHOLE_BASE_WATCH_PATH`: The base path for watched folders by the blackhole mechanism. Can be relative or absolute.
     - `BLACKHOLE_RADARR_PATH`: The path where torrent files will be dropped into by Radarr, relative to the base path.
     - `BLACKHOLE_SONARR_PATH`: The path where torrent files will be dropped into by Sonarr, relative to the base path.
     - `BLACKHOLE_FAIL_IF_NOT_CACHED`: Whether to fail operations if content is not cached.
     - `BLACKHOLE_RD_MOUNT_REFRESH_SECONDS`: How long to wait for the RealDebrid mount to refresh in seconds.
     - `BLACKHOLE_WAIT_FOR_TORRENT_TIMEOUT`: The timeout in seconds to wait for a torrent to be successful before failing.
     - `BLACKHOLE_HISTORY_PAGE_SIZE`: The number of history items to pull at once when attempting to mark a download as failed.

   - **General Configuration**:
    - `PYTHONUNBUFFERED`: Set to `TRUE` to ensure Python output is displayed in the logs in real-time.
    - `PUID`: Set this to the user ID that the service should run as.
    - `PGID`: Set this to the group ID that the service should run as.
    - `UMASK`: Set this to control the default file creation permissions.
    - `DOCKER_NETWORK`: Set this to the name of the Docker network to be used by the services.
    - `DOCKER_NETWORK_EXTERNAL`: Set this to `true` if specifying an external Docker network above, otherwise set to `false`.
    
## Blackhole

### Setup

1. Within the arrs, navigate to `Settings > Download Clients` and add a `Torrent Blackhole` client.

2. Configure the torrent blackhole download client as follows:
   - **Name**: `blackhole`
   - **Enable**: Yes
   - **Torrent Folder**: Set to `[BLACKHOLE_BASE_WATCH_PATH]/[BLACKHOLE_RADARR_PATH]` for Radarr or `[BLACKHOLE_BASE_WATCH_PATH]/[BLACKHOLE_SONARR_PATH]` for Sonarr
   - **Watch Folder**: Set to `[Torrent Folder]/completed`
   - **Save Magnet Files**: Yes, with the extension `.magnet`
   - **Read Only**: No
   - **Client Priority**: Prioritize as you please
   - **Tags**: Tag as you please
   - **Completed Download Handling**: Remove Completed

3. Run the `python_watcher.py` script to start monitoring the blackhole:

    ```bash
    python3 python_watcher.py
    ```