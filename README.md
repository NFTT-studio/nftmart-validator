# nftmart-validator

```
$ docker-compose up
```

http://localhost:9944/#/rpc

invoke `author.rotateKeys()`

0x2c1987a4491f49bd17ce3fa93a2bcd79eb7262284fec1d0ff27f34e8e61e40c9d0251519daca19d54bed3da2d7ab82c6c7be34f23b0d91d2fc4539a025f6dd70b22ccf185d4d2c2b6c35927f815d3a8bab91316b33de42f211f68d69e4cc2730a85e70c492b51f90e91884a28a7b21b7f23ad1703fbc721420db403e56136559

http://localhost:9944/#/extrinsics

invoke staking.bond(controller, value, payee)

invoke session.setKeys(keys, proof)

invoke staking.validate(prefs)

http://localhost:9944/#/staking/waiting

your validator should be ready starting from the next era.

http://localhost:9944/#/staking
