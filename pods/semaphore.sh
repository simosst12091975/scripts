#!/bin/bash
# LANCIARE CON PRIVILEGI DI ROOT

# NETWORK CREATION
podman network create semaphore_network

# DATABASE CREATION
podman run --name semaphore_db \
--network semaphore_network \
-e MYSQL_ROOT_PASSWORD=root_mole2026 \
-e MYSQL_USER=semaphore \
-e MYSQL_PASSWORD=mole2026 \
-e MYSQL_DATABASE=semaphore \
-v semaphore_mysql:/var/lib/mysql \
-d mysql

# SEMAPHORE CREATION
podman run --name semaphore \
-p 3000:3000 \
--network semaphore_network \
-e SEMAPHORE_DB_DIALECT=mysql \
-e SEMAPHORE_DB_HOST=semaphore_db \
-e SEMAPHORE_DB_PORT=3306 \
-e SEMAPHORE_DB_NAME=semaphore \
-e SEMAPHORE_DB_USER=semaphore \
-e SEMAPHORE_DB_PASS=mole2026 \
-e SEMAPHORE_ADMIN=admin \
-e SEMAPHORE_ADMIN_PASSWORD=mole2026 \
-e SEMAPHORE_ADMIN_NAME=operator \
-e SEMAPHORE_ADMIN_EMAIL=simosst.1975@gmail.com \
-e SEMAPHORE_EMAIL_ALERT=true \
-e SEMAPHORE_EMAIL_SENDER=simosst.1975@gmail.com \
-e SEMAPHORE_EMAIL_HOST=smtp-relay.brevo.com \
-e SEMAPHORE_EMAIL_PORT=587 \
-e SEMAPHORE_EMAIL_USERNAME=8d3d2b001@smtp-brevo.com \
-e SEMAPHORE_EMAIL_PASSWORD=x......................3 \
-v semaphore_data:/var/lib/semaphore \
-v semaphore_config:/etc/semaphore \
-v semaphore_tmp:/tmp/semaphore \
-d semaphoreui/semaphore:latest
