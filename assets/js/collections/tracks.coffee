Track = require '../models/track.coffee'

module.exports = Backbone.Collection.extend

  model: Track

  url: ->
    '/api/user/%uid%/tracks'.replace '%uid%', global.expose.user._id
