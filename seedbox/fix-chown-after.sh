#!/usr/bin/env bash

. .env
chown ${PUID}:${PGID} -R /var/lib/docker/volumes/seedbox_downloads/_data
