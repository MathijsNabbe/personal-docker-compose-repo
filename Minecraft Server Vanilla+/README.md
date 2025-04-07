# Minecraft Server Vanilla+
This docker-compose file will initialize a joinable minecraft server with a compatibility for CurseForge mods.

# Configurations
## Mods
All mods should be downloaded from [CurseForge](https://www.curseforge.com/minecraft), and should be placed in the mapped volume `/home/mahnabbe/gamedata/minecraft/data/mods`

## Dynmap error
If connecting to Dynmap via the [configured hostname](http://maps.mc.mathijsnabbe.ml) returns a port exhaustion / gateway timeout, an ip configuration is missing from Dynmap's configuration.txt. This file is located in `/home/mahnabbe/gamedata/minecraft/data/dynmap`. The reverse-proxy ip adress `0.0.0.0` should be added on the accepted ports, rights after localhost (`127.0.0.1`)

# Ports
25565: Minecraft\
8123: Dynmap web preview

# Hostnames
| Hostname | Service | Port |
| :------: | :-----: | :--: |
| mc.mathijsnabbe.nl | Connect to the minecraft server in the Minecraft client. | 25565 |
| maps.mc.mathijsnabbe.nl| Watch the Dynmap preview in a browser. | 8123 |
