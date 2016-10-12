umask 000
sudo -s mkdir -p /srv/promet
sudo -s chown -R nobody:users /srv/promet
sudo -s chmod 777 /srv/promet
xterm &
/usr/lib/promet-erp/prometerp --config-path=/srv/promet --database="/srv/promet/database.db"