# Traefik
This docker-compose file will initialize Traefik as a reverse-proxy, with all configurations and opened ports for the services in this repository.

# Hostnames & Ports
| Hostname | Service | Port |
| :------: | :-----: | :--: |
| [dashboard.mathijsnabbe.nl](https://dashboard.mathijsnabbe.nl) | Connect to the Traefik dashboard. | 8080 |

# Configurations
To enable Let's Encrypt, a private key must be set on the correct shared volume. On TransIP, generate an API key by adding a new KeyValue, and don't forget to enable the API. Place this file on the shared volume mapped in the `docker-compose.yml`. 

# Environment Variables
| Variable | Description |
| :------: | ----------- |
| EMAIL | Identification for Let's Encrypt |