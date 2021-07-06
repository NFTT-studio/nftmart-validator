#!/usr/bin/env bash

export BOOT=/ip4/81.70.132.13/tcp/30343/p2p/12D3KooWP44EhEGK9pp33nr19p3xKqUbnRWawgapeJ8Bbq3y4QmX

exec_nftmart(){
  exec nftmart \
    --telemetry-url="wss://telemetry.polkadot.io/submit/ 0" \
    --bootnodes ${BOOT} \
    --execution=NativeElseWasm \
    --rpc-methods=Unsafe \
    --unsafe-ws-external \
    --chain=staging \
    "$@"
}

exec_nftmart "$@"
