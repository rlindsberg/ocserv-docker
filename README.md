## Docker Installation
1. Install Docker
```bash
sudo apt update
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt install docker-ce -y
```

```bash
git clone https://github.com/rlindsberg/ocserv-docker.git
cd ocserv-docker
```

Add your ca cert and private key to *.pem files.

2. Use TCP BBR algorithm
```bash
echo "net.core.default_qdisc=fq" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

3. Build and run docker container
```bash
docker build -t ocserv .
docker run --name ocserv --privileged -p 443:443 -d ocserv
```

4. Add user
```bash
docker exec -ti ocserv ocpasswd -c /etc/ocserv/ocpasswd testUserName
```

5. Change user password
```bash
docker exec -ti ocserv ocpasswd -c /etc/ocserv/ocpasswd testUserName
```

6. Delete user
```bash
docker exec -ti ocserv ocpasswd -c /etc/ocserv/ocpasswd -d testUserName
```

7. Lock user
```bash
docker exec -ti ocserv ocpasswd -c /etc/ocserv/ocpasswd -l testUserName
```

8. Unlock user
```bash
docker exec -ti ocserv ocpasswd -c /etc/ocserv/ocpasswd -u testUserName
```

9. Show all users and their hashed password
```bash
docker exec -ti ocserv cat /etc/ocserv/ocpasswd
```

## Script Installation
Tested on ubuntu 18.04 and 16.04.

Download and saving script on your server:
```bash
curl -O https://raw.githubusercontent.com/iw4p/OpenConnect-Cisco-AnyConnect-VPN-Server-OneKey-ocserv/master/ocserv-install.sh
```

Making script executable
```bash
chmod +x ocserv-install.sh
```

And then just run it:
```sh
./ocserv-install.sh
```
or
```sh
sudo bash ocserv-install.sh
```

## How to connect to it?
For making connection to your server, you can use `AnyConnect`, `OpenConnect` or other alternative clients.

- AnyConnect: [GUI AnyConnect client for available platforms](https://it.umn.edu/vpn-downloads-guides).
- OpenConnect: [OpenConnect client for Linux](https://computingforgeeks.com/how-to-connect-to-vpn-server-with-openconnect-ssl-vpn-client-on-linux/).
