#1/usr/bin/env sh

ROOT_DIR=$(pwd)
NODE_VERSION="16.15.0"
DATA_DIR="$ROOT_DIR/data"
LOG_DIR="$ROOT_DIR/logs"
run_log="${LOG_DIR}/run.log"
mint_log="${LOG_DIR}/mint.log"
FISH_RUN_PID=0
FISH_MINT_PID=0

function install() {
  mkdir -p $DATA_DIR && mkdir -p $LOG_DIR && touch $run_log && touch $mint_log
  sudo apt update && sudo apt-get update && sudo apt-get install -y gcc make wget openssl openssl-devel
  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm install $NODE_VERSION
  nvm use $NODE_VERSION
  npm install -g ironfish
}

function start() {
  ironfish accounts:create $1
  FISH_RUN_PID=$(ironfish start --rpc.tcp --rpc.tcp.host=0.0.0.0 --rpc.tcp.port=$2 >>$run_log 2>>$run_log </dev/null &)
  ironfish status
}

function mint() {
  accountName=$1
  ironfish config:set blockGraffiti "$accountName"
  local publicKeyStr=$(ironfish accounts:publickey)
  local publicKey=${publicKeyStr#*key:}
  FISH_MINT_PID=$(ironfish miners:start --pool pool.ironfish.network --address $publicKey >> $mint_log 2>>$mint_log </dev/null &)
  #disown
  ironfish status
}

function remoteMint() {
  accountName=$1
  fhost=$2
  fport=$3
  ironfish config:set blockGraffiti "$accountName"
  FISH_MINT_PID=$(ironfish miners:start --pool pool.ironfish.network --rpc.tcp --rpc.tcp.host $fhost --rpc.tcp.port $fport --address $publicKey >> $mint_log 2>>$mint_log </dev/null &)
}

function print() {
  echo "run log: $run_log"
  echo "mint log: $mint_log"
  echo "Run PID: $FISH_RUN_PID"
  echo "Mint PID: $FISH_MINT_PID"
}


case $1 in
init)
  install
  start $2 $3
  mint $4
  print
  ;;
install)
  install
  ;;
start)
  start $2 $3
  ;;
mint)
  mint $2
  ;;
remoteMint)
  mint $2 $3 $4
  ;;
status)
  ironfish status
  ;;
usage|*)
  echo "usage ./fish.sh init <accountName> <port> <blockGraffiti>|install|start <accountName> <port>|mint <blockGraffiti>|remoteMint <blockGraffiti> <host> <port>|usage"
  ;;
esac