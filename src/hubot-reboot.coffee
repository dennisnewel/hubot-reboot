# Description:
#   Reboot command for hubot
#
# Configuration:
#   HUBOT_AUTH_ADMIN - A comma separate list of user IDs
#   HUBOT_REBOOT_COMMAND - set this to replace the default reboot commands
#   HUBOT_REBOOT_MESSAGE - change the default message hubot posts as a reply to being rebooted
#   HUBOT_REBOOT_DENIED - message to show users who are not admins
#
# Dependencies:
#   hubot-auth
#
# Commands:
#   hubot reboot - tells hubot to die. Use a service to auto-restart the process. The command can be renamed with HUBOT_REBOOT_COMMAND and a custom exit message can be set with HUBOT_REBOOT_MESSAGE
#
# Author:
#   Dennis Newel <dennis.newel@newelcorp.com>
#
# Notes:
#   copied/inspired from https://github.com/ClaudeBot/ClaudeBot/blob/master/scripts/claudebot.coffee

reboot_command = process.env.HUBOT_REBOOT_COMMAND ? 'reboot';
reboot_message = process.env.HUBOT_REBOOT_MESSAGE ? 'rebooting...brb';
denied_message = process.env.HUBOT_REBOOT_DENIED ? "Sorry, the command you have entered has been restricted to admins only."

module.exports = (robot) ->
    # Restrict commands
    if process.env.HUBOT_AUTH_ADMIN?
        robot.respond /(.*)/i, (msg) ->
            return unless msg.match[1]

            if (!!~ msg.match[1].indexOf reboot_command) && (robot.auth.isAdmin msg.message.user)
                msg.send reboot_message
                # logging the fact that hubot was asked to reboot
                console.log 'Rebooting as requested by ' + msg.message.user.name
                setTimeout ->
                    process.exit 0
                , 3000
            else if (!!~ msg.match[1].indexOf reboot_command)
                # following line logs the user id to the console; this is the value that's needed for HUBOT_AUTH_ADMIN 
                console.log msg.message.user.id.toString() + ' tried to invoke an admin command!'
                msg.message.done = true
                msg.reply denied_message