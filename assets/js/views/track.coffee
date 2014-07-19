module.exports = Backbone.Marionette.ItemView.extend

  template: require '../templates/track.jade'

  modelEvents:
    change: 'render'

  tagName: 'li'

  className: 'track'
