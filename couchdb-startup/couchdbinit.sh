#!/usr/bin/env bash

# Wait for the CouchDB instance container to be ready before executing setup commands
while [ "$(curl -s -o /dev/null -w ''%{http_code}'' couchdb-server:5984)" != "200" ]; do sleep 5; done

# Create system tables and table "aisonobuoy" which is used for synching all data from devices
curl -X PUT http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@couchdb-server:5984/_users
curl -X PUT http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@couchdb-server:5984/_replicator
curl -X PUT http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@couchdb-server:5984/_global_changes
curl -X PUT http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@couchdb-server:5984/aisonobuoy
curl -X GET http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@couchdb-server:5984/_all_dbs

# In case the container is being on a mobile device,
# create a replication task directed to the CouchDB sync server.

if ${PERIPHERAL}; then

    curl -X POST http://${COUCHDB_USER}:${COUCHDB_PASSWORD}@couchdb-server:5984/_replicator -d '{"source":"http://'${COUCHDB_USER}':'${COUCHDB_PASSWORD}'@couchdb-server:5984/aisonobuoy", "target":"http://'${COUCHDB_USER}':'${COUCHDB_PASSWORD}'@'${COUCHDB_SERVER_IP_ADDR}':5984/aisonobuoy", "continuous":true}' -H "Content-Type: application/json"

fi
