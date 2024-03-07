#!/bin/sh -
REGION=${REGION:='us-west-2'}
ENDPOINT_URL='http://localhost:4566'

echo "creating S3 Bucket"
aws s3 mb s3://testbucket --profile local --region $REGION --endpoint-url $ENDPOINT_URL

old_socket="/var/run/mysqld/mysqld.sock"
mysql5_socket="/usr/local/mysql-5.7.44/mysql.sock"
mysql8_socket="/usr/local/mysql-8.0.35/mysql.sock"

if [ -e "$old_socket" ]; then
  mysql_socket="$old_socket"
else
  mysql_socket="$mysql5_socket"
fi

echo "creating secret"
aws secretsmanager create-secret --profile local --region $REGION --endpoint-url $ENDPOINT_URL --name DevelopmentSecret --secret-string "{
  \"adapter\": \"mysql2\",
  \"host\": \"127.0.0.1\",
  \"encoding\": \"utf8mb4\",
  \"reconnect\": false,
  \"database\": \"testdb_development\",
  \"pool\": 5,
  \"username\": \"root\",
  \"password\": \"password\",
  \"socket\": \"$mysql_socket\"
}"

echo "fetching secret"
aws secretsmanager get-secret-value --endpoint-url=http://localhost:4566 --secret-id DevelopmentSecret --query SecretString --output text