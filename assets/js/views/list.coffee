module.exports = Backbone.Marionette.CollectionView.extend

  childView: require './track.coffee'

  childViewOptions: ->
    vent: @vent

  initialize: (opts) ->
    @vent = opts.vent
