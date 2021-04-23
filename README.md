# nftmart-validator 

自动添加验证人流程

0. 安装最新的 docker-compose https://github.com/docker/compose/releases
```
# Linux amd64
$ curl -sL https://github.com/docker/compose/releases/download/1.29.1/docker-compose-Linux-x86_64 > docker-compose
$ chmod +x docker-compose

# macOS amd64
$ curl -sL https://github.com/docker/compose/releases/download/1.29.1/docker-compose-Darwin-x86_64 > docker-compose
$ chmod +x docker-compose
```

1. 克隆本仓库，并切换到 auto-validator 分支
```
$ git clone -b auto-validator https://github.com/NFTT-studio/nftmart-validator && cd nftmart-validator
```

2. 启动验证人节点，同步区块
```
$ docker-compose up
```

3. 区块同步完成后，编辑 config (YAML 格式) 文件，将 `STASH_ACCOUNT_MNEMONIC` 和`CONTROLLER_ACCOUNT_MNEMONIC` 改成自己特有的值，只要不与其他现有节点冲突即可，例如

```
STASH_ACCOUNT_MNEMONIC: //my-nftmart-validator-stash-account
CONTROLLER_ACCOUNT_MNEMONIC: //my-nftmart-validator-controller-account
```

```
STASH_ACCOUNT_MNEMONIC: //Alice
CONTROLLER_ACCOUNT_MNEMONIC: //Bob
```

```
STASH_ACCOUNT_MNEMONIC: //Charlos/stash
CONTROLLER_ACCOUNT_MNEMONIC: //Carlos/controller
```

```
STASH_ACCOUNT_MNEMONIC: //elon-musk-1
CONTROLLER_ACCOUNT_MNEMONIC: //666
```

都是可以的

4. 在另一个终端执行
```
$ docker-compose up add-validator
```

成功执行后，在 https://polkadot.js.org/apps/?rpc=wss://staging-ws.nftmart.io#/staking/waiting (或者 http://localhost:9944/#/staking/waiting) 可以看到名为 `//MY-VALIDATOR-STASH-ACCOUNT` 的账号已经进入验证人等待队列了

## 相关资源
- `add-validator` 命令的源码: https://github.com/NFTT-studio/nftmart/blob/nftmart-cli/nodejs-demo/add-validator.mjs

## 已知问题
- `setIdentity` 方法这里的交易有一定概率抛出错误，需要处理错误 (https://github.com/NFTT-studio/nftmart/blob/nftmart-cli/nodejs-demo/add-validator.mjs#L54-L70)
