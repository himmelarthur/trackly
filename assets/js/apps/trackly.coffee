# Lib Dependencies
window.$ = require('jquery')
window._ = require('underscore')
window.Backbone = require('backbone')
Marionette = require('marionette')

# Applications & Modules
Router = require './router.coffee'
Controller = require './controller.coffee'
AddTrack = require '../modules/add_track.coffee'

Trackly = new Marionette.Application()
Trackly.module('AddTrack', AddTrack);

Trackly.addRegions
    form: '#form'
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
router = new Router
  controller: controller

Trackly.addInitializer (opts) ->
  Trackly.AddTrack.display(Trackly.form)
  Trackly.list.show list

$ ->
  Backbone.history.start()
  Trackly.start()
