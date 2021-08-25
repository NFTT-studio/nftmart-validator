#!/usr/bin/env bash


exec_nftmart(){
  exec nftmart-node \
    --execution=NativeElseWasm \
    --rpc-methods=Unsafe \
    --unsafe-ws-external \
    "$@"
}

exec_nftmart "$@"
