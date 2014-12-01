# Lib Dependencies
window.$ = require('jquery')
window._ = require('underscore')
window.Backbone = require('backbone')
Marionette = require('marionette')

# Applications & Modules
Controller = require './controller.coffee'
Router = require './router.coffee'
AddTrack = require '../modules/add_track.coffee'

window.Trackly = Trackly = new Marionette.Application()
Trackly.module('AddTrack', AddTrack);

Trackly.addRegions
    trackForm: '#track-form'
    list: '#list'

# Models
User = require '../models/user.coffee'
user = new User
  _id: expose.user._id

# Collections
Tracks = require '../collections/tracks.coffee'
tracks = new Tracks(expose.tracks)

user.tracks = tracks

controller = new Controller
  vent: Trackly.vent
  models:
    user: user
  regions:
      trackForm: Trackly.trackForm
      list: Trackly.list
  collections:
    tracks: tracks

router = new Router
  controller: controller

Trackly.addInitializer (opts) ->
  Trackly.AddTrack.display(Trackly.trackForm)

$ ->
  Trackly.start()
  Backbone.history.start()
