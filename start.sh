#!/bin/bash

# Function to detect operating system
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macOS"
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        OS="Windows"
    else
        OS="Unknown"
    fi
}

# Detect operating system
detect_os

# Set variables based on the operating system
case "$OS" in
    "Linux")
        sleep 20

        # Source the profile to refresh environment variables
        source /etc/profile
        #!/bin/bash
        export POSTGRES_PORT=5431
        export POSTGRES_HOSTNAME=$(hostname -I | awk '{print $1}')
        export KEYCLOAK_POSTGRES_PORT=5436
        export LOCAL_IP=$(hostname -I | awk '{print $1}')
        export KEYCLOAK_PORT=8083
        export KEYCLOAK_DATABASE_NAME=practicum_keycloak
        export DISCOVERY_SERVER_PORT= 8761
        export RANDOM_PORT=8089
        export PORT_BACKEND=8081

        docker-compose up -d
        docker-compose logs
        ;;
    "macOS")
        # Set variables for macOS if needed
         # Sleep if needed to allow services to start
        sleep 5
        #Set docker environment variable
        export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
        # Set macOS-specific environment variables
        export DATABASE_NAME=practicum_keycloak
        export POSTGRES_PORT=5432
        #export PREFECTURA_COTOPAXI_POSTGRES_HOSTNAME=$(hostname -I | awk '{print $1}')
        export KEYCLOAK_POSTGRES_PORT=5432
        export KEYCLOAK_PORT=8080
        export LOCAL_IP=$(ipconfig getifaddr en0) # Get local IP address for macOS
        export KEYCLOAK_DATABASE_NAME=practicum_keycloak
        export DISCOVERY_SERVER_PORT=8761
        export RANDOM_PORT=8089

        export KEYCLOAK_DB_USER=postgres
        export KEYCLOAK_DB_PASSWORD=postgres

        docker compose up 
        docker compose logs
        ;;
    "Windows")
        # Wait for a moment to allow services to start and set variables
        #!/bin/bash
        export POSTGRES_PORT=5432
        export POSTGRES_HOSTNAME=$(hostname -I | awk '{print $1}')
        export KEYCLOAK_POSTGRES_PORT=5432
        export KEYCLOAK_PORT=8080
        #export LOCAL_IP=$(powershell.exe -Command "(Test-Connection -ComputerName $(hostname | awk '{print $1}') -Count 1).IPV4Address.IPAddressToString")
        export LOCAL_IP=$(powershell.exe -Command "(Test-Connection -ComputerName $(hostname | awk '{print $1}') -Count 1).IPV4Address.IPAddressToString")
        export KEYCLOAK_DATABASE_NAME=practicum_keycloak
        
        export KEYCLOAK_DB_USER=postgres
        export KEYCLOAK_DB_PASSWORD=postgres
        export DISCOVERY_SERVER_PORT=8761
        export RANDOM_PORT=8089

        # Start Docker Compose in detached mode
        # Create a temporary docker-compose-subst.yml file with substituted values
        #envsubst < docker-compose.yml > docker-compose-subst.yml

        # Start Docker Compose with the substituted file
        #docker-compose -f docker-compose-subst.yml up -d
        #docker-compose down 
        
        #export DOCKER_BUILDKIT=0
        #export COMPOSE_DOCKER_CLI_BUILD=0

        #docker-compose build --no-cache
        docker-compose up -d 
        
        docker-compose logs

        # Rest of your script...
        ;;
    *)
        echo "Running on an unknown operating system"
        exit 1
        ;;
esac
