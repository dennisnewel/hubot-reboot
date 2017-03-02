# hubot-reboot
Hubot command to reboot (really just kill the running process)

## Installation

In your hubot project, run:

`npm install hubot-reboot --save`

Then add **hubot-reboot** to your `external-scripts.json`:

```json
[
  "hubot-reboot"
]
```

## Dependencies

The script relies on `hubot-auth` to avoid letting everyone restart hubot.

You should also be running hubot with something that automatically restarts the process if it dies...otherwise this command just kills hubot

## Configuration

* HUBOT_AUTH_ADMIN - A comma separate list of user IDs
* HUBOT_REBOOT_COMMAND - set this to replace the default reboot commands
* HUBOT_REBOOT_MESSAGE - change the default message hubot posts as a reply to being rebooted

To populate the HUBOT_AUTH_ADMIN list, use https://api.slack.com/methods/users.list/test to get the actual ids...not the usernames or email addresses

## Sample Interaction

### Default
``` 
user1>> hubot reboot
hubot>> rebooting...brb
```
### Customized
```
user1>> bender: you are drunk!
bender>> Hasta la vista, meatbags!
```
