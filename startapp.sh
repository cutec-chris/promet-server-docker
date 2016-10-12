umask 000
sudo mkdir -p /srv/promet
sudo chown -R nobody:users /srv/promet
sudo chmod 777 /srv/promet
/usr/lib/promet-erp/prometerp --config-path=/srv/promet --database="/srv/promet/database.db"