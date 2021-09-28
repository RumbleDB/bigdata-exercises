#!/usr/bin/env bash

createdb -U postgres "discogs"
curl https://cloud.inf.ethz.ch/s/4bZWo4TjeXgCNz5/download/discogs.dump.xz | xz -d | \
    psql -U postgres --set ON_ERROR_STOP=on "discogs"
