Form = require '../views/url_form.coffee'
module.exports = Backbone.Marionette.Module.extend

  initialize: ->
    @vent = @app.vent

  onStart: (options) ->
    @form = new Form
      vent: @vent

  display: (region) ->
    region.show(@form)
