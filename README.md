# Pure-ftpd-mysql

Pure-ftpd-mysql with TLS and Passive mode

## Environment variables

MYSQL_HOST
MYSQL_PORT (default 3306)
MYSQL_USER
MYSQL_PASSWORD
TLS (default 0, see: https://github.com/jedisct1/pure-ftpd/blob/master/README.TLS )
EXTERNALIP

## Usage example

Run mysql docker or use existing and load the sql into it.

```bash
docker run -p 20-21:20-21 -p 30000-30019:30000-30019 \
  -e MYSQL_HOST=172.18.0.1 -e MYSQL_USER=root -e MYSQL_PASSWORD=secret -e MYSQL_DATABASE=pureftpd \
  -e EXTERNALIP=172.18.0.1 \
  -d dblaci/pure-ftpd-mysql
```
