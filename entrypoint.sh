#!/usr/bin/env bash

#export BOOT1=/dns/82.157.37.77/tcp/30333/p2p/12D3KooWP44EhEGK9pp33nr19p3xKqUbnRWawgapeJ8Bbq3y4QmX
#export BOOT2=/dns/82.157.37.77/tcp/30334/p2p/12D3KooWM5QknCEcvJGJDKAE7uuBgbAcCXdFpiZHH9KLcw5oSUN5
export BOOT1=/dns/43.129.73.167/tcp/30333/p2p/12D3KooWP44EhEGK9pp33nr19p3xKqUbnRWawgapeJ8Bbq3y4QmX
export BOOT2=/dns/43.129.73.167/tcp/30334/p2p/12D3KooWM5QknCEcvJGJDKAE7uuBgbAcCXdFpiZHH9KLcw5oSUN5

exec_nftmart(){
  exec nftmart \
    --telemetry-url="wss://telemetry.polkadot.io/submit/ 0" \
    --bootnodes=${BOOT1} \
    --bootnodes=${BOOT2} \
    --execution=NativeElseWasm \
    --rpc-methods=Unsafe \
    --unsafe-ws-external \
    --chain=staging_spec_raw.json \
    --wasm-execution=Interpreted \
    --ws-port=9944 \
    --port=30333 \
    "$@"
}

exec_nftmart "$@"
