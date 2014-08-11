Track = require './track.coffee'

module.exports = Track.extend

    getTrackURL: ->
        return '/tracks/' + @get 'providerId'
