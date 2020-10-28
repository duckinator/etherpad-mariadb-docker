#!/bin/bash

cat <<-EOF > settings.json
{
    "title": "Etherpad",
    "ip": "0.0.0.0",
    "port": ${ETHERPAD_PORT},
    "dbType": "mysql",
    "dbSettings": {
        "host": "database",
        "port": 3306,
        "database": "${MYSQL_DATABASE}",
        "user": "${MYSQL_USER}",
        "password": "${MYSQL_PASSWORD}",
        "charset": "utf8mb4"
    },
    "users": {
        "${ETHERPAD_ADMIN_USER}": {
            "password": "${ETHERPAD_ADMIN_PASSWORD}",
            "is_admin": true
        }
    }
}
EOF

# Wait for mariadb
sleep 20
#/usr/bin/mysqladmin -h 127.0.0.1 -P 3306 -u etherpad -ppassword ping || exit 1

# Actually start etherpad
node node_modules/ep_etherpad-lite/node/server.js || exit $?
