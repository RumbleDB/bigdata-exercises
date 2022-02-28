#!/usr/bin/env bash

createdb -U postgres "discogs"
curl https://cloud.inf.ethz.ch/s/X6g4ScWRX2wBC4t/download/discogsexam.dump.xz | xz -d | \
    psql -U postgres --set ON_ERROR_STOP=on "discogs"


