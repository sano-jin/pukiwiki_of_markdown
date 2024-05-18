#!/bin/bash
set -eux

dune build
cd js
dune build js.bc.js
cd ..
sudo cp _build/default/js/js.bc.js docs/



