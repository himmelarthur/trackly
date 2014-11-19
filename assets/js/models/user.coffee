module.exports = Backbone.Model.extend

  postTrack: (url, successCallback, errorCallback) ->
    api = '/api/user/%uid%/tracks'.replace '%uid%', @.get '_id'
    $.ajax
        type: 'POST'
        url: api
        data:
            url: url
        success: successCallback
        error: errorCallback
