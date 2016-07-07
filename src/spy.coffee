# Description
#   Display user id and name
#
# Commands:
#   <user> who are you? - Display <user> id and name
#   hubot who is <user>? - Display <user> id and name
#
# Notes:
#   * commands are all transformed to lower case

module.exports = (robot) ->

  class Spy

  robot.spy = new Spy

  robot.hear /@?(.+) who are you\?/i, (msg) ->
    name = msg.match[1].trim()
    user = robot.brain.userForName(name)
    return msg.reply "#{name} does not exist" unless user?
    msg.reply "#{name}'s id, name = " + [user.id, user.name].join(', ')

  robot.hear /who is @?(.+)\?/i, (msg) ->
    name = msg.match[1].trim()
    user = robot.brain.userForName(name)
    return msg.reply "#{name} does not exist" unless user?
    msg.reply "#{name}'s id, name = " + [user.id, user.name].join(', ')
