#!/bin/bash

FILE="docker-compose.yml"
if [ "$GIN_WEB_MODE" == "staging" ]; then
  FILE=docker-compose.stage.yml
fi

WORKSPACE=$(
  cd "$(dirname "$0")"
  pwd
)
REPO=git@github.com:piupuer

function build() {
  branchName='master'
  if [ "$1" ]; then
    branchName=$1
  fi
  echo $branchName

  if [ ! -d "$WORKSPACE/gin-web" ]; then
    echo 'start clone gin-web...'
    git clone $REPO/gin-web
  else
    echo 'start update gin-web...'
    cd $WORKSPACE/gin-web
    git pull
  fi
  cd $WORKSPACE/gin-web
  git checkout $branchName

  cd $WORKSPACE

  if [ ! -d "$WORKSPACE/gin-web-vue" ]; then
    echo 'start clone gin-web-vue...'
    git clone $REPO/gin-web-vue
  else
    echo 'start update gin-web-vue...'
    cd $WORKSPACE/gin-web-vue
    git pull
  fi
  cd $WORKSPACE/gin-web-vue
  git checkout $branchName

  cd $WORKSPACE/gin-web
  chmod +x version.sh
  ./version.sh

  cd $WORKSPACE/gin-web-vue
  chmod +x version.sh
  ./version.sh

  cd $WORKSPACE

  nocache
}

function nocache() {
  stop
  # 重新拉取镜像
  docker-compose -f $FILE pull
  docker-compose -f $FILE build --no-cache
  # docker-compose -f $FILE build
  start
}

function start() {
  cd $WORKSPACE
  docker-compose -f $FILE up -d
}

function stop() {
  cd $WORKSPACE
  docker-compose -f $FILE down
}

function restart() {
  cd $WORKSPACE
  stop
  start
}

function status() {
  cd $WORKSPACE
  docker-compose -f $FILE top
}

function tail() {
  cd $WORKSPACE
  docker-compose -f $FILE logs -f --tail=50
}

function help() {
  echo "$0 build|remote|start|stop|restart|status|tail"
}

if [ "$1" == "tail" ]; then
  tail
elif [ "$1" == "status" ]; then
  status
elif [ "$1" == "start" ]; then
  start
elif [ "$1" == "stop" ]; then
  stop
elif [ "$1" == "restart" ]; then
  restart
elif [ "$1" == "build" ]; then
  build $2
elif [ "$1" == "remote" ]; then
  nocache
else
  help
fi
