List = require './list.coffee'

module.exports = List.extend

  childView: require './archived_track.coffee'

  emptyView: require './no_archived_track.coffee'
