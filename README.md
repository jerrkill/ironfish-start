# ironfish 一键安装启动脚本

# usage


```
# 以非root用户运行
cd ~
git clone https://github.com/jerrkill/ironfish-start.git
cd ~/ironfish-start
chmod +x ./start.sh
./start.sh
```


or

```
mkdir -p ~/ironfish
cd ~/ironfish
wget -qO- https://raw.githubusercontent.com/jerrkill/ironfish-start/master/start.sh | bash
```

`ironfish status`



# logs

`tail -f ~/ironfish-start/logs/run.log`

`tail -f ~/ironfish-start/logs/mint.log`


