# ironfish 一键安装启动脚本

# usage


```
# 以非root用户运行
cd ~
git clone xxx
cd ~/ironfish
chmod +x ./start.sh
./start.sh
```


or

```
mkdir -p ~/ironfish
cd ~/ironfish
wget -qO- start.sh | bash
```

`ironfish status`



# logs

`tail -f ~/ironfish/logs/run.log`
`tail -f ~/ironfish/logs/mint.log`


