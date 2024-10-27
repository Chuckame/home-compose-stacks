# Stack
- Torrent downloader: transmission
    - url: `torrent.$DOMAIN_NAME`
- Gather indexers (like yggtorrent): jackett + jackett-flaresolverr (Resolves indexers behind cloudflare)
    - url: `jackett.$DOMAIN_NAME`
- search for movies using jackett indexers: radarr
    - url: `movies.$DOMAIN_NAME`
- search for series using jackett indexers: sonarr
    - url: `series.$DOMAIN_NAME`
- Media library/player: plex
    - url: `plex.$DOMAIN_NAME`
- File browser: hurlenko/filebrowser
    - url: `files.$DOMAIN_NAME`

> WARNING
> If you are not using a reverse proxy like caddy, you can open the port for each app using the port indicated in the `caddy.reverse_proxy` label, and remove all the caddy labels and `caddy` network

If manual torrent downloads: You **must not** download the movies/series inside `/downloads/library` as it is managed by sonarr & radarr which makes hard links automatically.

So you must well store your downloads:
- `/downloads/completed/sonarr` is for series downloads
- `/downloads/completed/radarr` is for movies downloads


# Installation
> You must install caddy stack to use this stack, or you need to export all corresponding ports
1. Fill the `.env` file
2. Exec `./fix-chown-before.sh` (Fixes user/group ids on config files, note that will make useless git changes)
3. Exec `docker-compose up -d`
4. Exec `./fix-chown-after.sh` (Fixes user/group ids on volumes)
5. Configure file browser:
    - Go to `files.$DOMAIN_NAME`, login as admin/admin
    - Go to settings > User Management
    - Edit admin user with your custom username and password, and Save
6. Configure jackett with Sonarr & Radarr:
    - Go to `jackett.$DOMAIN_NAME`
    - Go at the bottom, fill `FlareSolverr API URL` with `http://jackett-flaresolverr:8191`
    - Click on apply server settings
7. Configure Sonarr & Radarr with Transmission
    - Go to `Settings > Download clients > Add > Transmission`
    - Fill Name with `Transmission`
    - host: torrent
    - port: 9091
    - Save
8. Map the download folder to radarr & sonarr
    - Go to `Settings > Download clients`
    - Scroll to the bottom
    - Click on the `+` to add a remote path
      * host: torrent
      * Remote Path: /downloads/completed/radarr/
      * Local Path: /downloads/completed/radarr/
9. Prepare directory structure in Sonarr & Radarr:
    - Go to `Settings > Media Management`, Scroll down to Root Folders
    - Click add root folder
    - Select `/downloads/library/series` for Sonarr, `/downloads/library/movies` for Radarr
10. Prepare directory structure in Plex:
    - On the welcome screen, or do find `Add library`
    - For Movies library, choose `/downloads/library/movies`
    - For Series library, choose `/downloads/library/series`

## Setup an indexer
- Add your indexer by clicking on `+ Add indexer` on the top
- Configure Sonarr & Radarr indexers. For each indexer configured into jackett, go to sonarr & radarr:
    - Go to `Settings > Indexers > Add > Torznab > Custom`
    - Fill name with your indexer name
    - On Jackett dasboard, click on `Copy Torznab field` related to the indexer, and paste it into the url field. Replace `https://jackett.$DOMAIN_NAME/therestofurl` with `http://jackett:9117/therestofurl`
    - For the API key use jackett's api key, available on the top right corner of Jackett
    - Configure the correct category IDs via the Categories options. See the Jackett indexer configuration for a list of supported categories.
