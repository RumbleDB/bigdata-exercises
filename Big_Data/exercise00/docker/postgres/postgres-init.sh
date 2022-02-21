#!/usr/bin/env bash

createdb -U postgres "beer.stackexchange.com"
curl -sS https://cloud.inf.ethz.ch/s/ik3FjCA67p33gZD/download/beer.stackexchange.com.dump.xz | xz -d | \
    psql -U postgres --set ON_ERROR_STOP=on "beer.stackexchange.com"
