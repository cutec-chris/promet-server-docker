umask 000
mkdir /srv/promet
lxterm&
/usr/lib/promet-erp/prometerp --config-path=/srv/promet --database="/srv/promet/database.db"