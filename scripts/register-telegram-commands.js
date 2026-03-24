#!/usr/bin/env node

/**
 * Register Gardener commands with Telegram Bot API
 * Usage: node register-telegram-commands.js <BOT_TOKEN>
 */

const BOT_TOKEN = process.argv[2];

if (!BOT_TOKEN) {
  console.log('Usage: node register-telegram-commands.js <BOT_TOKEN>');
  console.log('Example: node register-telegram-commands.js 7123456789:AAH...');
  process.exit(1);
}

const commands = [
  { command: 'garden', description: 'Show plant status and what needs attention' },
  { command: 'garden_add', description: 'Add a new plant to your garden' },
  { command: 'garden_water', description: 'Log watering a plant' },
  { command: 'garden_fertilize', description: 'Log fertilizing a plant' },
  { command: 'garden_repot', description: 'Log repotting a plant' },
  { command: 'garden_tomb', description: 'Move a plant to the graveyard' },
  { command: 'garden_graveyard', description: 'View deceased plants' },
  { command: 'garden_info', description: 'Show details for a specific plant' },
  { command: 'garden_setup', description: 'Change location or alert settings' }
];

async function registerCommands() {
  const url = `https://api.telegram.org/bot${BOT_TOKEN}/setMyCommands`;

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ commands })
    });

    const data = await response.json();

    if (data.ok) {
      console.log('✅ Commands registered successfully!\n');
      console.log('Your Telegram bot now shows these commands:');
      commands.forEach(cmd => {
        console.log(`  /${cmd.command} — ${cmd.description}`);
      });
    } else {
      console.error('❌ Failed to register commands:');
      console.error(data.description || JSON.stringify(data));
      process.exit(1);
    }
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

registerCommands();
