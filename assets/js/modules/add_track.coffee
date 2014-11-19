Form = require '../views/url_form.coffee'
module.exports = Backbone.Marionette.Module.extend

  initialize: ->
    @vent = @app.vent

  onStart: (options) ->
    @form = new Form
      vent: @vent
    @vent.on 'track:added', @resetForm, @
    @vent.on 'track:error', (error) =>
      if error.responseJSON and error.responseJSON.error is 'duplicate'
        @resetForm()
      else
        @showError()

  display: (region) ->
    region.show(@form)

  resetForm: ->
    @form.reset()

  showError: ->
    @form.showError()
