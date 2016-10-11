umask 000
mkdir /srv/promet
chmod 777 /srv/promet
/usr/lib/promet-erp/prometerp --config-path=/srv/promet --database="/srv/promet/database.db"