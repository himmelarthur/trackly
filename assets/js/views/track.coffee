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
