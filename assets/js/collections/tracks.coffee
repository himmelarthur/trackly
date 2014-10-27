moment = require 'moment'

Track = require '../models/track.coffee'

module.exports = Backbone.Collection.extend

  model: Track

  url: ->
    '/api/user/%uid%/tracks'.replace '%uid%', global.expose.user._id

  comparator: (a, b) ->
    if moment(a.get 'created') < moment(b.get 'created')
      1
    else
      -1