#!/bin/bash

accountName="jkk"
ROOT_DIR=$(pwd)
NODE_VERSION="16.15.0"
DATA_DIR="$ROOT_DIR/data"
LOG_DIR="$ROOT_DIR/logs"
run_log="${LOG_DIR}/run.log"
mint_log="${LOG_DIR}/mint.log"

function init() {
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
  ironfish start >>$run_log 2>>$run_log </dev/null &
  #disown
  ironfish config:set blockGraffiti "$accountName"
  local publicKeyStr=$(ironfish accounts:publickey)
  local publicKey=${publicKeyStr#*key:}
  ironfish miners:start --pool pool.ironfish.network --address $publicKey >> $mint_log 2>>$mint_log </dev/null &
  #disown
  ironfish status
}

init
start