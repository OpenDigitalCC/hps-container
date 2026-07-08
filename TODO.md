
## separate network

Once container migrates to DRH / SCH, it hsould use macvlan to separate it's network from the host
Note: MACVLAN means that the host can't talk to IPS which will be a problem
- Other option is a bridge however that has other issues

Back up plan is to set IPS inside VM that doesn't require persistent storage

Although if the host talks to IPS on localhost, it can just use host networking.

