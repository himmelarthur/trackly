window.$ = require('jquery')
window._ = require('underscore')
window.Backbone = require('backbone')
Marionette = require('marionette')

User = require '../models/user.coffee'
user = new User
  _id: global.expose.uid

Tracks = require '../collections/tracks.coffee'
window.tracks = new Tracks([])

Trackly = new Marionette.Application()

Trackly.start()

