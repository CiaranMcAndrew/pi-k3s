# pi-k3s

Sets up a K3s cluster using Raspberry Pis as per the following guide:

https://rpi4cluster.com/k3s/k3s-nodes-setting/

## Deploy

1. Use [Raspberry Pi Imager](https://www.raspberrypi.com/software/) to create MicroSD Card images with the following:

   * Ubuntu Server 23.10 (64-Bit)
   * 1 or more controller node with name `conx` (e.g. `con01`)
   * 2 or more worker nodes with the name `nodex` (e.g. `node01`)
   * Username `pi` and a suitable password

2. Log onto the controller node

```
ssh pi@con01
```

3. Clone this repository

```
git clone https://github.com/CiaranMcAndrew/pi-k3s.git
cd pi-k3s
```

4. Set node password environment variable

```
export NODEPASSWORD=mypassword
```

5. Run the setup script

```
sh controller/scripts/setup-controller.sh
```

Or to cleanup a mistake

```
cd ~
rm -rf pi-k3s

git clone -b concept https://github.com/CiaranMcAndrew/pi-k3s.git
cd pi-k3s/controller/scripts/
bash setup-controller.sh
.
```
