ubuntu224
da2f0fce-ed39-4fd9-bbfa-0c63b61adab9

sudo apt update
sudo apt install curl




crontab:
sudo apt-get install cron  # install
sudo systemctl start cron.service  # start(systemd)
sudo service cron start  # start(int)
sudo systemctl status cron
export EDITOR=vi
crontab -e
*/1 * * * * /home/yunshu/duckdns/update.sh >> /home/yunshu/duckdns/duck.log 2>&1
crontab -l
grep CRON /var/log/*


logrotate:
sudo chmod 777 /etc/logrotate.conf
vi /etc/logrotate.conf

/home/duckdns/updatelog.log {
size 10
rotate 1
copytruncate
compress
delaycompress
missingok
notifempty
}

logrotate -f /etc/logrotate.conf
error: error opening state file /var/lib/logrotate/status: Permission denied

sudo logrotate -f /etc/logrotate.conf
Potentially dangerous mode on /etc/logrotate.conf: 0777
error: Ignoring /etc/logrotate.conf because it is writable by group or others.

cd /var/lib/logrotate
sudo chmod 777 status
sudo chmod 777 /etc/logrotate.conf

sudo -i
logrotate -f /etc/logrotate.conf

sudo chmod 644 /etc/logrotate.conf
sudo logrotate -f /etc/logrotate.conf

xrdp:
sudo apt-get install xrdp
sudo systemctl status xrdp  # status: active
sudo systemctl enable xrdp  # start with system


vino:
sudo apt-get install vino
sudo apt install dconf-editor  # edit config
desktop/gnome/

