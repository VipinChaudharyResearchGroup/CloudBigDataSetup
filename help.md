# tunnel local address to a public url

create a new tmux session and name it tunnel

check 16010 port is open
```bash
ss -tulpn | grep 16010
netstat -tulpn | grep 16010
```



```bash
tmux new -d -s tunnel
tmux send-keys -t tunnel "lt --port 16010" C-m

# see the url
tmux capture-pane -t tunnel -pS -1000
```
```

