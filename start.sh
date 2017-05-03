#!/bin/bash

# First window dev environment
tmux new-session -d -s daryllxd

tmux new-window -t daryllxd:1 -n 'processes'
tmux select-window -t 1

tmux send-keys -t 0 'pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start' enter
tmux send-keys -t 0 'bundle exec rails s' enter

# # Select first Window to start coding!
tmux select-window -t 1

tmux attach
