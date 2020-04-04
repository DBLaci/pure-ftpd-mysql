#!/bin/bash

cat << EOM > /etc/pure-ftpd/db/mysql.conf
#MYSQLSocket      /var/run/mysqld/mysqld.sock
MYSQLServer     $MYSQL_HOST
MYSQLPort       ${MYSQL_PORT-3306}
MYSQLUser       $MYSQL_USER
MYSQLPassword   $MYSQL_PASSWORD
MYSQLDatabase   $MYSQL_DATABASE
#MYSQLCrypt      md5
MYSQLCrypt      cleartext
MYSQLGetPW      SELECT Password FROM users WHERE User="\L"
MYSQLGetUID     SELECT Uid FROM users WHERE User="\L"
MYSQLGetGID     SELECT Gid FROM users WHERE User="\L"
MYSQLGetDir     SELECT Dir FROM users WHERE User="\L"
EOM

# for options see: http://go2linux.garron.me/linux/2010/05/how-install-secure-pure-ftp-server-chrooted-virtual-users-743/
echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir
echo "yes" > /etc/pure-ftpd/conf/DontResolve
echo "no" > /etc/pure-ftpd/conf/PAMAuthentication
echo "no" > /etc/pure-ftpd/conf/UnixAuthentication
echo "30000 30019" > /etc/pure-ftpd/conf/PassivePortRange
echo "yes" > /etc/pure-ftpd/conf/VerboseLog
echo "yes" > /etc/pure-ftpd/conf/BrokenClientsCompatibility
# If you want to allow FTP and TLS sessions, run
echo "$TLS-0" > /etc/pure-ftpd/conf/TLS
echo 10 > /etc/pure-ftpd/conf/MaxIdleTime
echo 200 > /etc/pure-ftpd/conf/MaxClientsNumber
echo 10 > /etc/pure-ftpd/conf/MaxClientsPerIP

openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=${SUBJ_C-HU}/ST=Csongrad/L=${SUBJ_L-City}/O=${SUBJ_O-Organization}/OU=infra/CN=${SUBJ_CN-pureftp}"
#openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem
chmod 600 /etc/ssl/private/pure-ftpd.pem

#chown -R ftpuser:ftpgroup /ftpdata
#tail -f > /dev/null
#service pure-ftpd-mysql start && tail -f /var/log/*.log

/usr/sbin/pure-ftpd-mysql-virtualchroot -l mysql:/etc/pure-ftpd/db/mysql.conf -A -j -8 UTF-8 -u 33 -E -p 30000:30019 -d -P $EXTERNALIP
