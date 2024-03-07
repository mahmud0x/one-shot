#!/bin/bash

# Function to check and print errors
check_error() {
    if [ $? -ne 0 ]; then
        echo "Error occurred while executing the last command: $1"
        exit 1
    fi
}

# Install prerequisite packages
sudo apt-get install -y apt-transport-https software-properties-common wget
check_error "sudo apt-get install -y apt-transport-https software-properties-common wget"

# Import the GPG key
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
check_error "wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null"

# Add repository for stable releases
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
check_error "echo \"deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main\" | sudo tee -a /etc/apt/sources.list.d/grafana.list"

# Update the list of available packages
sudo apt-get update
check_error "sudo apt-get update"

# Install Grafana OSS
sudo apt-get install grafana
check_error "sudo apt-get install grafana"

# Start Grafana server
sudo systemctl start grafana-server
check_error "sudo systemctl start grafana-server"

# Check Grafana server status
sudo systemctl status grafana-server
check_error "sudo systemctl status grafana-server"

echo "Grafana is running at http://localhost:3000/"

# Enable Grafana server to start on boot
sudo systemctl enable grafana-server
check_error "sudo systemctl enable grafana-server"

echo "Grafana installation completed"
