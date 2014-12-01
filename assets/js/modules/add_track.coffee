Form = require '../views/url_form.coffee'
module.exports = Backbone.Marionette.Module.extend

  initialize: ->
    @vent = @app.vent

  onStart: (options) ->
    @_region = @app.trackForm
    @form = new Form
      vent: @vent

    $('body').on('click', '.js-toggle-submit', =>
      @resetForm()
    )

    @vent.on 'form:up', @close, @
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

  close: ->
    @_region.$el.addClass('hidden')
