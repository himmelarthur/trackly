moment = require 'moment'

module.exports = Backbone.Marionette.ItemView.extend

  template: require '../templates/track.jade'

  ui:
    removeButton: '.js-remove'
    archiveButton: '.js-archive'

  events:
    'click @ui.removeButton': 'removeModel'
    'click @ui.archiveButton': 'archive'

  modelEvents:
    change: 'render'

  tagName: 'li'

  className: 'track table'

  removeModel: ->
    @model.destroy()

  serializeData: ->
    _.extend @model.toJSON(),
      created: moment(@model.get "created").fromNow()

  archive: ->
    @model.archive()
