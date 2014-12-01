List = require '../views/list.coffee'
ArchivedList = require '../views/archived_list.coffee'
Tracks = require '../collections/tracks.coffee'

module.exports = Backbone.Marionette.Controller.extend

  initialize: (opts) ->
    @vent = opts.vent
    @models = opts.models
    @regions = opts.regions
    @collections = opts.collections
    @views = {}
    @vent.on 'track:post', @postTrack,
      user: @models.user
      vent: @vent
    @vent.on 'track:added', @addTrack, @
    @collections.tracks.on 'change:archived', (track) =>
      @removeTrackFromList(track)

  # EVENTS
  postTrack: (url) ->
    @user.postTrack url, (data) =>
      @vent.trigger 'track:added', data
    , (error) =>
      @vent.trigger 'track:error', error

  addTrack: (track) ->
    @collections.tracks.add track
    @views.list.collection.add track

  # ROUTES
  home: ->
    @views.list = new List
      collection: new Tracks @collections.tracks.reject (track) -> track.get('archived')
    @regions.list.show @views.list

  archived: ->
    @views.archivedList = new ArchivedList
      collection: new Tracks @collections.tracks.filter (track) -> track.get('archived')
    @regions.list.show @views.archivedList

  removeTrackFromList: (track) ->
    @views.list.collection.remove(track)
