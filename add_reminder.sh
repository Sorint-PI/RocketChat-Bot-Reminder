#add_reminder.sh - Add reminders

# Reminder file path
reminder_file="/root/scripts/reminder_file.txt"

function validate_date() {
    local input_date="$1"
    date -d "$input_date" &>/dev/null
}

function add_reminder() {
    local year="$1"
    local month="$2"
    local day="$3"

    while true; do
        read -p "Enter the reminder time (HH:MM): " time
        if [[ $time =~ ^([0-1][0-9]|2[0-3]):[0-5][0-9]$ ]]; then
            break
        else
            echo "Invalid time format. Try again."
        fi
    done

    read -p "Enter the text of the reminder: " reminder_text

    # Add the reminder to the file
    echo "${year}-${month}-${day} $time $reminder_text" >> "$reminder_file"

    echo "Reminder successfully added."
}

# Check if the reminder file exists
if [ ! -f "$reminder_file" ]; then
    touch "$reminder_file"
fi

while true; do
    read -p "Enter the year (YYYY): " year
    read -p "Enter the month (MM): " month
    read -p "Enter the day (DD): " day
    input_date="${year}-${month}-${day}"

    if validate_date "$input_date"; then
        add_reminder "$year" "$month" "$day"
        break
    else
        echo "Invalid date format. Try again."
    fi
done
