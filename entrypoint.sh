#!/bin/bash

# Preserve environment variables from docker-compose.yml
env >> /etc/environment

# Start apache
exec apache2-foreground
