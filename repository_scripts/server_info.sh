#!/bin/bash

# Output file
output_file="Report_$(hostname).txt"

# System Information
echo "***** System Information *****" > "$output_file"
echo "Hostname: $(hostname)" >> "$output_file"
echo "Kernel Version: $(uname -r)" >> "$output_file"
echo "Distribution: $(lsb_release -ds)" >> "$output_file"

# CPU Information
echo -e "\n***** CPU Information *****" >> "$output_file"
echo "CPU Model: $(grep "model name" /proc/cpuinfo | head -1 | cut -d ':' -f2 | sed -e 's/^ *//' -e 's/ *$//')" >> "$output_file"
echo "CPU Cores: $(grep -c "^processor" /proc/cpuinfo)" >> "$output_file"
echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')" >> "$output_file"

# Memory Information
echo -e "\n***** Memory Information *****" >> "$output_file"
echo "Total Memory: $(free -h | awk '/^Mem:/{print $2}')" >> "$output_file"
echo "Used Memory: $(free -h | awk '/^Mem:/{print $3}')" >> "$output_file"
echo "Free Memory: $(free -h | awk '/^Mem:/{print $4}')" >> "$output_file"

# Disk Usage
echo -e "\n***** Disk Usage *****" >> "$output_file"
df -h >> "$output_file"

# Network Information
echo -e "\n***** Network Information *****" >> "$output_file"
ifconfig -a >> "$output_file"
