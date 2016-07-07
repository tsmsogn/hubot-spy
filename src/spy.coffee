# Description
#   Display user info
#
# Commands:
#   show <user> info - Display <user> info
#
# Notes:
#   * commands are all transformed to lower case

module.exports = (robot) ->

  class Spy

  robot.spy = new Spy

  robot.hear /show @?(.+) info/i, (msg) ->
    name = msg.match[1].trim()
    if name.toLowerCase() is 'my' then name = msg.message.user.name
    user = robot.brain.userForName(name)
    return msg.reply "#{name} does not exist" unless user?
    msg.reply "#{name}'s id, name = " + [user.id, user.name].join(', ')
