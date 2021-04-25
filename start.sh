#!/usr/bin/env bash

cd "$(dirname "$(realpath $0)")"

./entrypoint.sh -d ./state/validator/ --validator
