#!/usr/bin/bash

echo "######################################"
echo "# configure-cronjobs.sh"
echo "######################################" 

# create bad users

# memstealer runs every 4 hours at 0 minutes past
sudo adduser memstealer
(sudo crontab -l -u memstealer 2>/dev/null; echo "0 */4 * * * stress-ng --vm 2 --vm-bytes 2G -t 20s") | sudo crontab - -u memstealer
(sudo crontab -l -u memstealer 2>/dev/null; echo "*/3 * * * * stress-ng -c 0 -l 5 -t 200s") | sudo crontab - -u memstealer

# cpuhog runs every 4 hours at 30 minutes past
sudo adduser cpuhog
(sudo crontab -l -u cpuhog 2>/dev/null; echo "30 */4 * * * stress-ng -c 0 -l 70 -t 30s") | sudo crontab - -u cpuhog
(sudo crontab -l -u cpuhog 2>/dev/null; echo "*/3 * * * * stress-ng -c 0 -l 5 -t 200s") | sudo crontab - -u cpuhog

# networkguy runs every 8 hours at 15 minutes past
sudo adduser networkguy
(sudo crontab -l -u networkguy 2>/dev/null; echo "15 */8 * * * stress-ng --udp 0 --udp-lite --udp-domain ipv6 -t 60s") | sudo crontab - -u networkguy
(sudo crontab -l -u networkguy 2>/dev/null; echo "*/3 * * * * stress-ng -c 0 -l 5 -t 200s") | sudo crontab - -u networkguy

# iouser runs every 2 hours at 45 minutes past
sudo adduser iouser
(sudo crontab -l -u iouser 2>/dev/null; echo "45 */2 * * * stress-ng --class io --seq 1 -t 30s") | sudo crontab - -u iouser
(sudo crontab -l -u iouser 2>/dev/null; echo "*/3 * * * * stress-ng -c 0 -l 5 -t 200s") | sudo crontab - -u iouser

# filestressor runs every 1 hour at 5 minutes past
sudo adduser filestressor
(sudo crontab -l -u filestressor 2>/dev/null; echo "5 */1 * * * stress-ng --class io --seq 1 -t 30s") | sudo crontab - -u filestressor
(sudo crontab -l -u filestressor 2>/dev/null; echo "*/3 * * * * stress-ng -c 0 -l 5 -t 200s") | sudo crontab - -u filestressor
