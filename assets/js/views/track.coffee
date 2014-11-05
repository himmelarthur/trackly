module.exports = Backbone.Marionette.ItemView.extend

  template: require '../templates/track.jade'

  ui:
    removeButton: '.js-remove'

  events:
    'click @ui.removeButton': 'removeModel'

  modelEvents:
    change: 'render'

  tagName: 'li'

  className: 'track table'

  removeModel: ->
    @model.destroy()

  serializeData: ->
    iconClass = if @model.get('provider') is 'youtube' then 'fa-youtube-play' else 'fa-soundcloud'
    _.extend @model.toJSON(),
      iconClass: iconClass
