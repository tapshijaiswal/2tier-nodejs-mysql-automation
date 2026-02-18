#!/bin/bash

# ============================================
# deploy.sh - Automated Deployment Script
# Project: 2tier-nodejs-mysql-automation
# ============================================

APP_DIR="/home/ec2-user/2tier-nodejs-mysql-automation"
LOG_FILE="/home/ec2-user/deploy.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "============================================" >> $LOG_FILE
echo "Deployment Started: $TIMESTAMP" >> $LOG_FILE

# Step 1: Pull latest code
cd $APP_DIR
echo "[1] Pulling latest code from GitHub..." >> $LOG_FILE
git pull origin master >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "[1] Code pull SUCCESS" >> $LOG_FILE
else
    echo "[1] Code pull FAILED" >> $LOG_FILE
    exit 1
fi

# Step 2: Install dependencies
echo "[2] Running npm install..." >> $LOG_FILE
npm install >> $LOG_FILE 2>&1
echo "[2] npm install SUCCESS" >> $LOG_FILE

# Step 3: Restart application
echo "[3] Restarting Node.js app with PM2..." >> $LOG_FILE
pm2 restart nodejs-app >> $LOG_FILE 2>&1

if [ $? -eq 0 ]; then
    echo "[3] App restart SUCCESS" >> $LOG_FILE
else
    echo "[3] App restart FAILED" >> $LOG_FILE
    exit 1
fi

echo "Deployment Completed: $(date '+%Y-%m-%d %H:%M:%S')" >> $LOG_FILE
echo "============================================" >> $LOG_FILE
