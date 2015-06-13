# Pure-ftpd-mysql

Pure-ftpd-mysql with TLS and Passive mode

## Usage

```bash
docker run --name=pure-ftpd-mysql \
  -v my_cert.pem:/etc/ssl/private/pure-ftpd.pem \
  -v my_mysql.conf:/etc/pure-ftpd/db/mysql.conf \
  -v my_data:/ftpdata \
  --link mysql:mysql \
  -e EXTERNALIP=your_ip_for_passive_mode \
  -p 0.0.0.0:20-21:20-21 \
  -p 0.0.0.0:30000-30009:30000-30009 \
  -d kauden/pure-ftpd-mysql
```
