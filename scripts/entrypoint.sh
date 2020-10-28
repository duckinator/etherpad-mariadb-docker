#!/bin/bash

cat <<-EOF > settings.json
{
    "title": "Etherpad",
    "ip": "0.0.0.0",
    "port": 9001,
    "dbType": "mysql",
    "dbSettings": {
        "host": "database",
        "port": 3306,
        "database": "etherpad",
        "user": "etherpad",
        "password": "password",
        "charset": "utf8mb4"
    },
    "users": {
        "ADMIN_USER": {
            "password": "ADMIN_PASS",
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
