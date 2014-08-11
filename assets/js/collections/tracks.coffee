YoutubeTrack = require '../models/youtube_track.coffee'
SoundcloudTrack = require '../models/soundcloud_track.coffee'

module.exports = Backbone.Collection.extend

  model: (attrs, opts) ->
    if attrs.provider is 'youtube' then return new YoutubeTrack attrs, opts
    if attrs.provider is 'soundcloud' then return new SoundcloudTrack attrs, opts

  url: ->
    '/api/user/%uid%/tracks'.replace '%uid%', global.expose.user._id
