#!/bin/bash
sudo apt update >>  maintenance.txt

sudo apt autoremove -y >>  maintenance.txt

sudo apt clean -y >>  maintenance.txt

df -h >>  maintenance.txt

users >> maintenance.txt

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 >> maintenance.txt


