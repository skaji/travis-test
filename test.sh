#!/bin/bash

for c in /usr/local/opt/curl/bin/curl /usr/bin/curl /usr/local/bin/curl; do
  if which $c >/dev/null 2>&1; then
    echo "------ $c -------"
    $c --version
    $c -sSL -v -o /dev/null https://metacpan.org
    echo
  fi
done
