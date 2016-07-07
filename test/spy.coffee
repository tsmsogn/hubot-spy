expect = require('chai').expect
path   = require 'path'

Robot       = require 'hubot/src/robot'
TextMessage = require('hubot/src/message').TextMessage

describe 'spy', ->
  robot = {}
  alice = {}
  bob = {}
  adapter = {}

  beforeEach (done) ->
    # Create new robot, without http, using mock adapter
    robot = new Robot null, "mock-adapter", false

    robot.adapter.on "connected", ->

      # load the module under test and configure it for the
      # robot. This is in place of external-scripts
      require("../src/spy")(robot)

      alice = robot.brain.userForId "1", {
        name: "alice"
        room: "#test"
      }

      bob = robot.brain.userForId "2", {
        name: "bob"
        room: "#test"
      }

      adapter = robot.adapter

      done()

    robot.run()

  afterEach ->
    robot.shutdown()

  describe 'alice', ->

    it 'fails to get unknown user info', (done) ->
      adapter.on "reply", (envelope, strings) ->
        expect(strings[0]).to.match /does not exist/i
        done()

      adapter.receive(new TextMessage alice, "show unknown_user info")

    it 'successfully gets bob info', (done) ->
      adapter.on "reply", (envelope, strings) ->
        expect(strings[0]).to.match /2/i
        done()

      adapter.receive(new TextMessage alice, "show bob info")

    it 'successfully gets her info with "my"', (done) ->
      adapter.on "reply", (envelope, strings) ->
        expect(strings[0]).to.match /1/i
        done()

      adapter.receive(new TextMessage alice, "show my info")
