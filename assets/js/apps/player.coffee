window.$ = require('jquery')
window._ = require('underscore')
window.Backbone = require('backbone')
Marionette = require('marionette')

module.exports = Backbone.Marionette.Module.extend

    play: (track) ->
        provider = track.get 'provider'
        switch provider
            when 'soundcloud'
                @playSoundcloudTrack track
            when 'youtube'
                @playYoutubeTrack track

    playSoundcloudTrack: (track) ->
        window.SC.stream track.getTrackURL(), (sound) ->
            sound.play()

    playYoutubeTrack: (track) ->
