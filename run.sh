#!/usr/bin/env bash
# Simple scheduling example:
# This uses a while-true loop to run script.py every 24 hours.
# Replace with cron if you prefer a more robust scheduling approach.

while true; do
  echo "Running citat_dne.py..."
  python /usr/src/app/citat_dne.py
  echo "Script finished. Sleeping for 24 hours..."
  sleep 86400 # 24 hours
done
