window.$ = require('jquery')
window._ = require('underscore')
window.Backbone = require('backbone')
Marionette = require('marionette')

Router = require './router.coffee'
Controller = require './controller.coffee'

controller = new Controller()
router = new Router
  controller: controller

User = require '../models/user.coffee'
user = new User
  _id: global.expose.uid

Tracks = require '../collections/tracks.coffee'
tracks = new Tracks(expose.tracks)

Form = require '../views/url_form.coffee'
List = require '../views/list.coffee'
form = new Form
  collection: tracks
list = new List
  collection: tracks

Trackly = new Marionette.Application()
Trackly.addRegions
  form: '#form'
  list: '#list'

Trackly.addInitializer (opts) ->
  Trackly.form.show form
  Trackly.list.show list

$ ->
  Backbone.history.start()
  Trackly.start()
