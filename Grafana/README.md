# Traefik
This container will kick-off a Grafana instance, combined with Node Exporter, Prometheus and DCGM Exporter to display a dashboard with system hardware statistics for the host machine. A few additional steps need to be taken to setup this instance. 

# Hostnames & Ports
| Hostname | Service | Port |
| :------: | :-----: | :--: |
| [stats.mathijsnabbe.nl](http://stats.mathijsnabbe.nl) | Connect to the Grafana dashboard. | 3000 |

## Prometheus Config
Prometheus needs a configuration file to bind all external services and translate this to Grafana. This configuration file must be placed in `/home/mahnabbe/configs/prometheus/prometheus.yml` and should look like this:

```yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['prometheus:9090']

  - job_name: 'node_exporter'
    static_configs:
      - targets: ['node_exporter:9100']

  - job_name: 'dcgm_exporter'
    static_configs:
      - targets: ['dcgm_exporter:9400']

  - job_name: 'cadvisor'
    static_configs:
      - targets: ['cadvisor:8080']
```
> [!IMPORTANT]
> The external port of Cadvisor is rebound to port 8081 in the docker-compose.yml, because port 8080 is already taken by the Traefik Dashboard. Since prometheus uses communication inside the docker network, the internal port > must be used, which is 808.

## Grafana Config
Once Grafana is up:
1. Visit http://stats.mathijsnabbe.nl/
2. Login: admin / password
3. Add Prometheus as a data source (http://serveripaddress:9090)
4. Import dashboards:
    - Node Exporter Full: ID `1860`
    - NVIDIA DCGM Exporter: ID `12239`

You can find these at: https://grafana.com/grafana/dashboards/

## Original Docker (not Snap)
An original Docker instance needs to be installed. If the installation of Docker is done through the 'Additional choices' option in the Linux installer, it is pulled from Snap, which does not work with the Nvidia Toolkit. You can if a 'Snap' directory is used with the command: 
```bash
which docker
```

If Snap Docker is installed, Docker must be migrated before continuing:

1. Stop docker 
```bash
sudo snap stop docker
```
2. Backup docker data
```bash
sudo cp -r /var/snap/docker/common/var-lib-docker ~/docker-snap-backup
```
3. Remove Snap Docker
```bash
sudo snap remove docker
```
4. Prepare Docker
```bash
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release
```
5. Setup Docker keys and repository
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
```
6. Install Docker
```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
7. Start Docker
```bash
sudo systemctl start docker
sudo systemctl enable docker
```
8. Restore Docker Data (Dangerous and optional)
```bash
sudo systemctl stop docker
sudo rm -rf /var/lib/docker
sudo cp -r ~/docker-snap-backup /var/lib/docker
sudo systemctl start docker
```

## Installing GPU stats
1. Check if the GPU is detected,
```bash
lspci | grep -i nvidia
```
2. Check if the correct drivers are installed,
```bash
dkms status
```
3. if not, install the drivers,
```bash
sudo apt install nvidia-driver-550-server
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo reboot
```
4. Confirm the Nvidia kernel is live,
```bash
lsmod | grep nvidia
```
5. If not, try:
```bash
sudo modprobe nvidia
```
6. Validate driver installation
```bash
nvidia-smi

# OR

docker run --rm --gpus all nvidia/cuda:12.2.0-base-ubuntu22.04 nvidia-smi
```
