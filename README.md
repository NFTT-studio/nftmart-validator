# Become a validator of NFTMart testnet  

[中文版](https://github.com/NFTT-studio/nftmart-validator/blob/staging/README_zh.md)

# Prepare working

Preconditions

1. Have a account that has some NMT token
（You need some NMT to apply validator on-chain）
2. One Linux server with 2 core 4 GB memory and 100GB hard disk
3. A browser with [Polkadot{.js} extension](https://polkadot.js.org/extension/), such as  Chrome，Firefox



## Install docker and docker-compose

For the different environment, we prepare the docker image for our validators. The NFTMart node update and distribute by docker image.

So we need to install docker and docker-compose first.

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

## Make sure docker configed and work well


With this CMD

```shell=
systemctl status docker
```

![](https://i.imgur.com/B3Z16jy.png)

If docker status is active (running)，its means that docker server is runing。Some docker edition will not run docker server automaticly, so we need to do it in manual:

```shell=
sudo systemctl start docker
sudo systemctl enable docker
```

Add current use into docker group , when your user is not root user:
```shell=
sudo usermod -aG docker $USER
newgrp docker
```

Then run CMD:
```shell=
docker version
```

Should show Client and Server infomations：
![](https://i.imgur.com/K3Q0Q48.png)

If you only got client infomation , maybe you need to check the cmd above.


# Deploy nodes

If we have successful runing docker, we can deploy our nodes

## Get testnet validator and depoly scripts

We provide nftmart-validator repo with staging branch ,use  `docker-compose.yml` to start nftmart/node:staging image.

You need to clone the repo into your sever，and change the branch with `nftmrat-validator` 
```shell=
git clone -b staging https://github.com/NFTT-studio/nftmart-validator
cd nftmart-validator
```

## Set node name

Every validator will sync his infomation to [Polkadot Telemetry](https://telemetry.polkadot.io/#list/Nftmart%20Staging) server

![](https://i.imgur.com/MYb2hBP.png)

We can get more infomations of current network, such as blockheight, average block time, version and other's node name.


We need use  `example.env` file as a template to create `.env` file

```shell=
cp example.env .env
```

Change `.env` content，set our node name.

If you want name your node as `victor-hugo-1482`，Please change `NAME=` value in  `.env` file.

```shell=
NAME="victor-hugo-1482"
```

Then we can run the node and sync the blocks.

## Running node

Use cmd to start your node:（If you want your node runing in background, please see the content below ）
```shell=
docker-compose up nftmart
```

The sync progress depend on the network blockheight and your bandwith, please be patient and waiting.

### Runing in background and check log
If you want your node runing in background, you can stop the node with  `Ctrl-C`  first, and use the cmd below:
```shell=
docker-compose up -d nftmart
```

Then ，your node will running in background, and you can use cmd to check the node's log：
```shell=
docker-compose logs -f
```

### Sync blocks

We can see the progress in [Polkadot Telemetry](https://telemetry.polkadot.io/#list/Nftmart%20Staging) page：

![](https://i.imgur.com/aFD0I8D.png)

When the sync process done ,you can see your node block height as same as other nodes. then you can config node validator .



## Get Session Key

Validator need broadcast his [Session Key](https://wiki.polkadot.network/docs/learn-keys/#session-keys) when he want to join the network.
Session key not control asset, and validator can change his session when he need.

Open another terminal to run generate the key:
```shell=
docker-compose exec nftmart rotate-key
```

![](https://i.imgur.com/gNXkFgK.png)

Save that session Key and we will use it in next step.


## Create Stash and Controller account

Open https://polkadot.js.org/apps/?rpc=wss://staging-ws.nftmart.io#/accounts to create two account，and send some NMT Token to them.

Stash account use to keep token， Controller account to manage stash account.

You can also use same account as Stash and Controller account.


Open https://polkadot.js.org/apps/?rpc=wss://staging-ws.nftmart.io#/staking/actions 

![](https://i.imgur.com/DLncJWI.png)

Click "⊕ Validator" Button

![](https://i.imgur.com/3UvpJZ4.png)

Select your Stash and Controller account that you created before.


![](https://i.imgur.com/fKZgnul.png)

And fill your Session Key.

![](https://i.imgur.com/YWyRx31.png)

Confirm transaction.

![](https://i.imgur.com/NQfKAA4.png)

After a while, you can see your account in wating list.

![](https://i.imgur.com/RCWzy9d.png)

Before the era close，validator will be re election，If your validator has a symbol in left ![](https://i.imgur.com/FxxOG9w.png) icon，thats mean your node will be the validator in thenext era.

![](https://i.imgur.com/PP7jg47.png)

As your can see ,our example node  `victor-hugo-1482` already produce two blocks.

# Maintenance

## Update nodes

The node update will delivery by docker image，you need to get the latest version of  validator in nftmart-validator repo's staging branch：
```shell=
git pull
```

Then pull the docker image：
```shell=
docker-compose pull
```
restart the node：
```shell=
docker-compose down nftmart
docker-compose up -d nftmart
```

Then the update will done.

##  Migrations
If you want migration your node to an other server, you shouild repeat the steps above, then update your new session key in account setting page.

After that, you can stop your old node with this cmd:

```shell=
docker-compose down nftmart
```


# FAQ

### What's different between Stash / Controller / Session Keys?

Please read these doc：

- https://wiki.polkadot.network/docs/learn-keys/#controller-and-stash-keys
- https://wiki.polkadot.network/docs/learn-keys/#session-keys

### Why my node is offline?
It maybe the network connect fail and node can not sync blocks.
Maybe the server hardware is not support the node server or the disk drive is full.


Recomend to use Digital Ocean, Vultr, Scaleway, AWS, Google Cloud or other 
overseas nodes.

### How to bring my node back online?
Restart your node ,and generate a new session key, and follow the steps above to create a new validator .
If your node offline too offten, it maybe slash by the network, and lose the token.



