#!/bin/bash

set -euo pipefail

TS_DIR=messages/

rm -rf $TS_DIR/*
mkdir -p $TS_DIR

echo 'generating new code files'

protoc -I schemas/ \
  --plugin=./node_modules/.bin/protoc-gen-ts_proto \
  --ts_proto_out=$TS_DIR \
  --ts_proto_opt=esModuleInterop=true \
  --ts_proto_opt=env=node \
  --ts_proto_opt=exportCommonSymbols=true \
  --ts_proto_opt=outputEncodeMethods=true \
  schemas/*.proto
