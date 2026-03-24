#!/bin/bash

# Register Gardener commands with Telegram Bot API
# Usage: ./register-telegram-commands.sh <BOT_TOKEN>

BOT_TOKEN="$1"

if [ -z "$BOT_TOKEN" ]; then
  echo "Usage: ./register-telegram-commands.sh <BOT_TOKEN>"
  echo "Example: ./register-telegram-commands.sh 7123456789:AAH..."
  exit 1
fi

# Define commands
COMMANDS='[
  {"command": "garden", "description": "Show plant status and what needs attention"},
  {"command": "garden_add", "description": "Add a new plant to your garden"},
  {"command": "garden_water", "description": "Log watering a plant"},
  {"command": "garden_fertilize", "description": "Log fertilizing a plant"},
  {"command": "garden_repot", "description": "Log repotting a plant"},
  {"command": "garden_tomb", "description": "Move a plant to the graveyard"},
  {"command": "garden_graveyard", "description": "View deceased plants"},
  {"command": "garden_info", "description": "Show details for a specific plant"},
  {"command": "garden_setup", "description": "Change location or alert settings"}
]'

# Register with Telegram
RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/setMyCommands" \
  -H "Content-Type: application/json" \
  -d "{\"commands\": $COMMANDS}")

# Check result
if echo "$RESPONSE" | grep -q '"ok":true'; then
  echo "Commands registered successfully!"
  echo ""
  echo "Your Telegram bot now shows these commands:"
  echo "  /garden            - Show plant status"
  echo "  /garden_add        - Add a new plant"
  echo "  /garden_water      - Log watering"
  echo "  /garden_fertilize  - Log fertilizing"
  echo "  /garden_repot      - Log repotting"
  echo "  /garden_tomb       - Move to graveyard"
  echo "  /garden_graveyard  - View deceased plants"
  echo "  /garden_info       - Show plant details"
  echo "  /garden_setup      - Change settings"
else
  echo "Failed to register commands:"
  echo "$RESPONSE"
  exit 1
fi
