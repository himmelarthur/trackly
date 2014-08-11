window.$ = require('jquery')
window._ = require('underscore')
window.Backbone = require('backbone')
Marionette = require('marionette')

Trackly = new Marionette.Application()

Player = require './player.coffee'
Trackly.module('Player', Player)

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
  vent: Trackly.vent

Trackly.addRegions
  form: '#form'
  list: '#list'

Trackly.addInitializer (opts) ->
  window.SC.initialize
    client_id: '0d5f0984aba3de0a9802dd84ad0e2627'
    redirect_uri: '/auth/soundcloud/callback'

Trackly.addInitializer (opts) ->
  Trackly.vent.on 'track:play', (track) ->
    Trackly.module('Player').play track


Trackly.addInitializer (opts) ->
  Trackly.form.show form
  Trackly.list.show list

$ ->
  Trackly.start()
