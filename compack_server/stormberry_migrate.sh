export DB_HOST_ADDRESS=localhost
export DB_PORT=5432
export DB_NAME=postgres
export DB_USERNAME=postgres
export DB_SSL=false
export DB_PASSWORD=changeLater

dart run stormberry migrate #-o ./migrations/
