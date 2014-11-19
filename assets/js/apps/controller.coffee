module.exports = Backbone.Marionette.Controller.extend

  initialize: (opts) ->
    @vent = opts.vent
    @models = opts.models
    @vent.on 'track:post', @postTrack,
      user: @models.user
      vent: @vent
    @vent.on 'track:added', @addTrack,
      user: @models.user

  # ROUTES
  userRoute: (uid)->
    console.log uid

  # EVENTS
  postTrack: (url) ->
    @user.postTrack url, (data) =>
      @vent.trigger 'track:added', data
    , (error) =>
      @vent.trigger 'track:error', error

  addTrack: (track) ->
    @user.tracks.add track
