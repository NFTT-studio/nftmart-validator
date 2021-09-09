# 成为 NFTMart 测试网验证人

[English version](https://github.com/NFTT-studio/nftmart-validator/blob/staging/README.md)


# 准备工作

在开始成为验证人前，你需要准备以下条件

1. 一个具有一定数量 NMT 资金的账号

    （成为验证人需要质押一定量的资金）

2. 一台满足配置要求的 Linux 服务器（ 2 核 4 GB 内存  100GB 硬盘）

    （成为验证人需要维护自己的节点）

4. 支持 [Polkadot{.js} extension](https://polkadot.js.org/extension/) 插件的浏览器，比如 Chrome，Firefox



## 安装 docker 和 docker-compose

为了支持在不同的环境下部署，NFTMart 测试网的验证人节点通过 docker 镜像打包并分发

这要求在服务器上安装 docker 和 docker-compose

Ubuntu / Debian:

```shell=
sudo apt update
sudo apt install docker.io docker-compose
```

Cent OS:
```shell=
sudo yum update
sudo yum install docker docker-compose
```

## 确保 docker 正确配置运行


输入以下命令

```shell=
systemctl status docker
```

![](https://i.imgur.com/B3Z16jy.png)

如果状态是 active (running)，说明 docker 服务已经成功启动。某些发行版不会自动启动服务，因此需要手动启动 docker 服务:

```shell=
sudo systemctl start docker
sudo systemctl enable docker
```

如果你是以非 root 用户执行 docker，那么推荐将当前用户加入 docker 分组:
```shell=
sudo usermod -aG docker $USER
newgrp docker
```

最后执行:
```shell=
docker version
```

应该显示 Client 和 Server 两者的信息：
![](https://i.imgur.com/K3Q0Q48.png)

如果只有 Client 信息，那么可能是 Server 没有运行，或者当前用户没有 docker 分组权限


# 部署节点

完成 docker 相关的配置后，我们就可以着手部署节点了

## 获取测试网验证人节点部署脚本

我们将通过 nftmart-validator 仓库 staging 分支提供的 `docker-compose.yml` 来启动 nftmart/node:staging-v2 镜像

我们将仓库的这个分支克隆到本地，并切换到 `nftmrat-validator` 目录下，后续操作均在此目录下进行
```shell=
git clone -b staging https://github.com/NFTT-studio/nftmart-validator
cd nftmart-validator
```

## 设置节点名称

每个验证人节点启动后会将自身基本信息同步到 [Polkadot Telemetry](https://telemetry.polkadot.io/#list/0xd8439c3493c41fd5780a23536ca46052fed731a7536b82ec6cc51e80c4855052) 服务

![](https://i.imgur.com/MYb2hBP.png)

我们可以通过这个页面获取当前网络区块高度，平均出块时间，每个节点各自的名称，地理位置，版本号等信息

为了方便与其他节点区分，我们需要参考当前目录下的 `example.env` 示例文件，创建 `.env` 文件

```shell=
cp example.env .env
```

并修改 `.env` 文件的内容，为我们的节点设置独一无二的名称

例如，如果你想将节点名称改为 `victor-hugo-1482`，应将 `.env` 文件中 `NAME=` 开头的一行修改为：

```shell=
NAME=victor-hugo-1482
```
然后就可以启动节点准备同步区块了

## 运行验证人节点

配置好你的节点名称后，输入以下命令前台启动节点（如果你想让它在后台运行，请参考下一节内容）
```shell=
docker-compose up nftmart
```


节点在启动后会同步区块，此时应耐心等待区块同步完成，同步速度主要取决于当前网络区块高度和服务器配置

### 切换到后台运行并查看日志

如果想将启动的节点切换到后台运行，可以在前台运行的终端输入 `Ctrl-C` 停止节点，然后将启动节点的命令改为：
```shell=
docker-compose up -d nftmart
```

随后，节点将以后台方式启动。节点短暂的重启不会导致质押的资金账户受到惩罚

如果想要查看节点日志，可以使用如下命令：
```shell=
docker-compose logs -f
```

### 等待节点同步完成

我们可以在 [Polkadot Telemetry](https://telemetry.polkadot.io/#list/0xd8439c3493c41fd5780a23536ca46052fed731a7536b82ec6cc51e80c4855052) 页面观察区块同步进度：

![](https://i.imgur.com/aFD0I8D.png)


当节点本地区块高度开始与网络中其他节点区块高度增长保持一致时，说明同步已经完成了，此时可以开始配置节点验证人


## 获取 Session Key

验证人加入网络时需要向网络广播自己的 [Session Key](https://wiki.polkadot.network/docs/learn-keys/#session-keys)，Session Key 并不用于控制资金，验证人可以定期更换自己的 Session Key

我们在另一个终端执行如下命令将输出一长串十六进制编码的信息
```shell=
docker-compose exec nftmart rotate-key
```

![](https://i.imgur.com/gNXkFgK.png)


将它完整地保存下来，作为下面配置验证人需要提供的 Session Key


## 创建 Stash 和 Controller 账号

进入 https://polkadot.js.org/apps/?rpc=wss://staging-ws.nftmart.io#/accounts 创建两个账号，并向其中转入一定数量的 NMT Token

其中 Stash 账号用于存放资金，而 Controller 账号则用于控制 Stash 账号

你也可以用同一个账号同时作为 Stash 和 Controller 账号

进入 https://polkadot.js.org/apps/?rpc=wss://staging-ws.nftmart.io#/staking/actions 

![](https://i.imgur.com/DLncJWI.png)

点击 "⊕ Validator" 按钮

![](https://i.imgur.com/3UvpJZ4.png)

分别选中你之前创建的 Stash 和 Controller 账号

![](https://i.imgur.com/fKZgnul.png)

再填入之前的 Session Key

![](https://i.imgur.com/YWyRx31.png)

确认交易

![](https://i.imgur.com/NQfKAA4.png)

等候片刻可以在 Waiting 队列看到你的验证人账户

![](https://i.imgur.com/RCWzy9d.png)

在本轮 era 结束时，验证人将重新选举，如果你的验证人账号左边出现 ![](https://i.imgur.com/FxxOG9w.png) 图标，说明你的节点将在下一个 era 成为验证人

![](https://i.imgur.com/PP7jg47.png)

如图所示，我们新加入的验证人节点 `victor-hugo-1482` 已经成功生产了 2 个区块

# 后续维护

## 更新节点程序

后续节点程序的更新依然会以 docker 镜像的方式发布，你只需要通过如下命令获取 nftmart-validator 仓库 staging 分支最新的部署代码：
```shell=
git pull
```

然后拉取最新的 docker 镜像：
```shell=
docker-compose pull
```
并重启节点：
```shell=
docker-compose down nftmart
docker-compose up -d nftmart
```

即可完成节点程序更新

## 迁移节点

如果想要将验证人节点迁移到另一台机器上运行，应该在新的机器上依次重复部署节点中的前几个步骤：获取部署脚本、设置节点名称、同步区块、获取 Session Key

然后在账户设置页面将 Session Key 替换为新的 Session Key 并提交

成功后即可将旧节点停止:

```shell=
docker-compose down nftmart
```


# 附录与常见问题

### Stash / Controller / Session Keys 的区别

参考文档：

- https://wiki.polkadot.network/docs/learn-keys/#controller-and-stash-keys
- https://wiki.polkadot.network/docs/learn-keys/#session-keys

### 我的节点为什么掉线了
这通常是由于服务器网络状况不佳导致连不上 peer 节点，无法同步区块
也有可能是服务器配置过低，内存资源不足或磁盘已满等原因导致的

由于众所周知的原因，推荐使用国外云厂商如 Digital Ocean, Vultr, Scaleway, AWS, Google Cloud 的节点，或者国内云厂商的海外节点

### 节点掉线了怎么办？
重启节点，并生成新的 Session Key，按照流程重新申请验证人
如果节点经常掉线，可能会被惩罚 (Slash)，导致资金损失


### 可以用家用台式机/笔记本运行验证人节点吗
理论上可行, 如果你能保证它 7x24 小时运行，而且有公网 IP
保持节点在这样的环境稳定运行需要较高水平的运维技能
事实上，你还可以在树莓派上运行 NFTMart 节点，不过你需要自行编译二进制文件


### 如何升级节点
