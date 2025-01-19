const webhook = require('webhook');

const config = require('./hooks/base-hooks.json');
webhook(config).then(server => {
  console.log(`Webhook listener running on port ${config.port}`);
});
