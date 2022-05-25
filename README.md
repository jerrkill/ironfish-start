# ironfish 一键安装启动脚本

# usage


```
# 以非root用户运行
cd ~
git clone https://github.com/jerrkill/ironfish-start.git
cd ~/ironfish-start
chmod +x ./fish.sh
./fish.sh init <accountName> <port> <blockGraffiti>
```

## command

* accountName 随便起个账户名
* port 端口
* host 节点的host
* blockGraffiti 从官网个人中心设置里获取

```
./fish.sh status
```

```
./fish.sh start <accountName> <port>
```

```
./fish.sh mint <blockGraffiti>
```


```
./fish.sh remoteMint <blockGraffiti> <host> <port>
```


check status

`ironfish status`



# logs

`tail -f ~/ironfish-start/logs/run.log`

`tail -f ~/ironfish-start/logs/mint.log`


