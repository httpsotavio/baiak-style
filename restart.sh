#!/bin/bash

# Config
servername="Baiak Style"
##sqlpassword=""

# Allow core dumps
ulimit -c unlimited

# Set working directory
#cd ~/server/

# Main loop
while true;
do
    date=$(date "+%d-%m-%y-%H-%M-%S")
    filename="${servername}-${date}"
    logdir="/media/server/serverlog"
  logfile="${logdir}/${filename}.log"

  # Verifica se o diretório de log existe, se não, cria
  if [ ! -d "$logdir" ]; then
    mkdir -p "$logdir"
  fi

    expect -c "
        spawn gdb -ex \"set disable-randomization off\" -ex \"set detach-on-fork off\" --args ./executavel
        set timeout -1
        expect -re \".*gdb\"
        send \"run\r\"
        expect -re \".*gdb\"
        send \"call g_game.saveGameState(13)\r\"
        send \"bt full\r\"
    send \"detach\r\"
        send \"quit\r\"
        expect -re \"Quit anyway? (y or n)\"
        send \"y\r\"
        sleep 1
        interact
    " |& tee "$logfile"
  
    sleep 1
done;