# Pure-ftpd-mysql

## Usage

```bash
docker run --name=pure-ftpd-mysql \
  -v my_cert.pem:/etc/ssl/private/pure-ftpd.pem \
  -v my_mysql.conf:/etc/pure-ftpd/db/mysql.conf \
  --link mysql:mysql \
  -d kauden/pure-ftpd-mysql
```
