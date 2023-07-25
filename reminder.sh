#start_reminder.sh - Script to send reminder messages on Rocketchat

# Path reminder file
reminder_file="/path/reminder_file.txt"

# Set the Rocketchat webhook URL
webhook_url="insert rocketchat webhook"

function send_reminder() {
    local text="$1"
    local channel="#channel name"

    # Reminder message
    message=":rocket: *Reminder:* $text :rocket:"
    payload="payload={\"text\": \"$message\", \"channel\": \"$channel\"}"

    # Submit the request to webhook
    curl -s -d "$payload" "$webhook_url"
    echo "Reminder message sent successfully."
}

function is_one_hour_remaining() {
    local reminder_datetime="$1"
    local current_datetime=$(date +"%s")
    local reminder_timestamp=$(date -d "$reminder_datetime" +"%s")
    local one_hour=$((60*60))

    if [ "$((reminder_timestamp - current_datetime))" -le "$one_hour" ]; then
        return 0  # Returns 0 (true) if there is an hour or less left
    else
        return 1  # Returns 1 (false) if more than one hour left
    fi
}

# Check if the reminder file exists
if [ -f "$reminder_file" ]; then
    current_time=$(date +"%s")

    # Read the reminder file line by line
    while IFS= read -r line; do
        # Extract date, time and reminder text
        reminder_datetime=$(echo "$line" | cut -d' ' -f1-2)
        reminder_text=$(echo "$line" | cut -d' ' -f3-)

        # Check if it's time to send the reminder
        if is_one_hour_remaining "$reminder_datetime"; then
            # Extract the channel name from the reminder text
            channel_name=$(echo "$reminder_text" | grep -o '#[[:alnum:]_]*' | head -n1)

            # Send the reminder to the channel
            send_reminder "$reminder_text" "$channel_name"

            # Remove the reminder from the file
            sed -i "/^$reminder_datetime/d" "$reminder_file"
        fi
    done < "$reminder_file"
fi
