#!/usr/bin/env bash

. .env
chown ${PUID}:${PGID} -R ./config/*
