#!/bin/bash

# filepath: /path/to/Untitled-1
# Extract the sleep duration and no_run_hours from the config file
SLEEP_SECONDS=$(grep sleep_seconds ./config/departures.yml | awk -F": " '{print $2}' | tr -d "'")
NO_RUN_HOURS=$(grep no_run_hours ./config/departures.yml | awk -F": " '{print $2}' | tr -d "'")

# Check if the configuration values were successfully extracted
if [ -z "$SLEEP_SECONDS" ] || [ -z "$NO_RUN_HOURS" ]; then
    echo "Error: Failed to extract configuration values."
    exit 1
fi

echo "Using sleep interval of $SLEEP_SECONDS seconds."
echo "No run hours set to: $NO_RUN_HOURS"

while true; do
    CURRENT_HOUR=$(date +"%H")
    SKIPPED=false
    
    # Iterate over the no_run_hours, splitting by ","
    for RANGE in $(echo $NO_RUN_HOURS | tr "," "\n"); do
        START_HOUR=$(echo $RANGE | cut -d "-" -f 1)
        END_HOUR=$(echo $RANGE | cut -d "-" -f 2)
        
        # Check if the current hour is within the no-run range
        if [ "$START_HOUR" -le "$END_HOUR" ]; then
            if [ "$START_HOUR" -le "$CURRENT_HOUR" ] && [ "$CURRENT_HOUR" -lt "$END_HOUR" ]; then
                echo "$(date) Skipping execution due to no run hours ($NO_RUN_HOURS)"
                SKIPPED=true
                break
            fi
        else
            if [ "$CURRENT_HOUR" -ge "$START_HOUR" ] || [ "$CURRENT_HOUR" -lt "$END_HOUR" ]; then
                echo "$(date) Skipping execution due to no run hours ($NO_RUN_HOURS)"
                SKIPPED=true
                break
            fi
        fi
    done

    if [ "$SKIPPED" = false ]; then
        # Run the main job
        python ./departures.py -c ./config/departures.yml
        echo "$(date) Executed departures.py"
    fi
    
    sleep $SLEEP_SECONDS
done