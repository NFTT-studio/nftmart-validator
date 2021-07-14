#!/usr/bin/env bash

export BOOT1=/dns/boot1.staging.nftmart.io/tcp/30333/p2p/12D3KooWEWdAjfxHM6re5yybcajpgMzgJEGTDWFw9ZrWTr1wicVQ
export BOOT2=/dns/boot2.staging.nftmart.io/tcp/30333/p2p/12D3KooWP1BNyrk7Q1uMvhcmjAUwZjNRHjVwXu5jWhShvdFeQmPv
export BOOT3=/dns/boot3.staging.nftmart.io/tcp/30333/p2p/12D3KooWJmqtRND4Q6rjFB6QaUnVBhQxfxkLm21Ax5Z1mppG6xPw


exec_nftmart(){
  exec nftmart \
    --telemetry-url="wss://telemetry.polkadot.io/submit/ 0" \
    --bootnodes ${BOOT1} ${BOOT2} ${BOOT3} \
    --execution=NativeElseWasm \
    --rpc-methods=Unsafe \
    --unsafe-ws-external \
    --chain=staging \
    "$@"
}

exec_nftmart "$@"
