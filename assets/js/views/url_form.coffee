module.exports = Backbone.Marionette.ItemView.extend

  template: require '../templates/url_form.jade'

  className: 'url-input input-button'

  tagName: 'form'

  ui:
    input: 'input'
    button: 'button'

  events:
    'submit': 'submit'

  initialize: (opts) ->
    @vent = opts.vent

  submit: (evt) ->
    evt.preventDefault()
    evt.stopPropagation()
    url = @ui.input.val()
    @ui.input.val("")
    @createModel url

  createModel: (url) ->
    @vent.trigger 'track:post', url

  onRender: ->
    $('.js-add-track').click (evt) =>
      @$el.slideToggle(200)
      @ui.input.focus()