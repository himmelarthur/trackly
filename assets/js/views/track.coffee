module.exports = Backbone.Marionette.ItemView.extend

  template: require '../templates/track.jade'

  ui:
    track: 'a'
    removeButton: '.js-remove'

  events:
    'click @ui.track': 'clickOnTrack'
    'click @ui.removeButton': 'removeModel'

  modelEvents:
    change: 'render'

  tagName: 'li'

  className: 'track table'

  initialize: (opts) ->
    @vent = opts.vent

  removeModel: ->
    @model.destroy()

  serializeData: ->
    iconClass = if @model.get('provider') is 'youtube' then 'fa-youtube-play' else 'fa-soundcloud'
    _.extend @model.toJSON(),
      iconClass: iconClass

  clickOnTrack: (evt) ->
    evt.preventDefault()
    evt.stopPropagation()
    @vent.trigger "track:play", @model
