Form = require '../views/url_form.coffee'
module.exports = Backbone.Marionette.Module.extend

  initialize: ->
    @vent = @app.vent

  onStart: (options) ->
    @_region = @app.trackForm
    @form = new Form
      vent: @vent
    $('.js-toggle-submit').click =>
      @resetForm()
    @vent.on 'track:added', @resetForm, @
    @vent.on 'track:error', (error) =>
      if error.responseJSON and error.responseJSON.error is 'duplicate'
        @resetForm()
      else
        @showError()

  display: ->
    @_region.show(@form)

  resetForm: ->
    @form.reset()
    @_region.$el.toggleClass('hidden')

  showError: ->
    @form.showError()
