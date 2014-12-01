# Lib Dependencies
window.$ = require('jquery')
window._ = require('underscore')
window.Backbone = require('backbone')
Marionette = require('marionette')

# Applications & Modules
Controller = require './controller.coffee'
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

# Views
List = require '../views/list.coffee'
list = new List
  collection: tracks

controller = new Controller
  vent: Trackly.vent
  models:
    user: user

Trackly.addInitializer (opts) ->
  Trackly.AddTrack.display(Trackly.trackForm)
  Trackly.list.show list

$ ->
  Trackly.start()
