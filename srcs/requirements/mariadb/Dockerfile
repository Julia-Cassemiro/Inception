# Use the official MariaDB image as the base image
FROM mariadb

# Copy the custom .sh script to the container
COPY script.sh /docker-entrypoint-initdb.d/script.sh

# Grant execution permission to the custom script
RUN chmod +x /docker-entrypoint-initdb.d/script.sh

# Expose the default MariaDB port (3306) to allow external connections
EXPOSE 3306