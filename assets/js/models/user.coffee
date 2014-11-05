module.exports = Backbone.Model.extend

  postTrack: (url, cb) ->
    api = '/api/user/%uid%/tracks'.replace '%uid%', @.get '_id'
    $.post api, url: url, (data) ->
      cb(data)
