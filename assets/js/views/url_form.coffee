module.exports = Backbone.Marionette.ItemView.extend

  template: require '../templates/url_form.jade'

  ui:
    input: 'input'
    button: 'button'

  events:
    'click @ui.button': 'submit'

  submit: (evt) ->
    url = @ui.input.val()
    @createModel url

  createModel: (url) ->
    @collection.create
      url: url