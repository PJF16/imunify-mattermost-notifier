#!/bin/bash

# Mattermost webhook URL (replace with your actual URL)
WEBHOOK_URL="https://mattermost.example.com/hooks/XXXXXXXXXXXXXX"

# Run ImunifyAV command and get JSON output
JSON_OUTPUT=$(imunify360-agent malware user list --json)

# Extract users with "infected" or "infected_db" set to 1
INFECTED_USERS=$(echo "$JSON_OUTPUT" | jq -r '.items[] | select(.infected > 0 or .infected_db > 0) | .user')

# Check if there are infected users
if [ -z "$INFECTED_USERS" ]; then
    MESSAGE="✅ No infected users found."
else
    MESSAGE="🚨 Infected users detected:\n\`\`\`\n$INFECTED_USERS\n\`\`\`"
fi

# JSON payload for the request
# replace username with bot username
PAYLOAD=$(cat <<EOF
{
    "text": "$MESSAGE",
    "username": "notificationbot",
    "icon_url": "https://mattermost.example.com/static/images/icon.png"
}
EOF
)

# Send HTTP POST request to Mattermost
curl -X POST -H "Content-Type: application/json" -d "$PAYLOAD" "$WEBHOOK_URL"
