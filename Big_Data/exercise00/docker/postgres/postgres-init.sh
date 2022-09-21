#!/usr/bin/env bash

createdb -U postgres "discogs"
curl https://cloud.inf.ethz.ch/s/DtjCHTLRHT39BRN/download/discogs.dump.xz | xz -d | \
    psql -U postgres --set ON_ERROR_STOP=on "discogs"
