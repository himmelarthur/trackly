module.exports = Backbone.Marionette.ItemView.extend

  template: require '../templates/url_form.jade'

  className: 'url-input input-button'

  tagName: 'form'

  ui:
    input: 'input'
    button: 'button'

  events:
    'submit': 'submit'
    'keyup': '_onKeyUp'

  initialize: (opts) ->
    @vent = opts.vent

  _onKeyUp: (evt) ->
    if evt.keyCode is 91
      @submit()

  submit: (evt) ->
    if evt
      evt.preventDefault()
      evt.stopPropagation()
    url = @ui.input.val()
    if url
      @disable()
      @createModel url

  disable: ->
    @ui.input.attr('disabled', on)

  enable: ->
    @ui.input.attr('disabled', off)

  createModel: (url) ->
    @vent.trigger 'track:post', url

  showError: ->
    @$el.addClass 'error'
    @enable()
    @ui.input.select()

  reset: ->
    @ui.input.focus()
    @ui.input.val('')
    @enable()
    @$el.removeClass 'error'
