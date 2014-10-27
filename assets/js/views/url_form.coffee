module.exports = Backbone.Marionette.ItemView.extend

  template: require '../templates/url_form.jade'

  className: 'url-input input-button'

  tagName: 'form'

  ui:
    input: 'input'
    button: 'button'

  events:
    'submit': 'submit'

  submit: (evt) ->
    evt.preventDefault()
    evt.stopPropagation()
    url = @ui.input.val()
    @ui.input.val("")
    @createModel url

  createModel: (url) ->
    @collection.create
      url: url
    , wait: true

  onRender: ->
    $('.js-add-track').click (evt) =>
      @$el.slideToggle(200)