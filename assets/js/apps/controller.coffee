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

  addTrack: (track) ->
    FB.api
      'me/objects/trackly_arthur:track',
      'post',
        app_id: 809001332444427,
        type: 'trackly_arthur:track',
        url: 'http://samples.ogp.me/864398966904663',
        title: 'Sample Track',
        image: 'https://fbstatic-a.akamaihd.net/images/devsite/attachment_blank.png',
        description: 'Sample Track'
      , (response) -> console.log response
    @user.tracks.add track
