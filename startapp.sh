umask 000
mkdir /srv/promet
chown -R nobody:users /srv/promet
/usr/lib/promet-erp/prometerp --config-path=/srv/promet --database="/srv/promet/database.db"