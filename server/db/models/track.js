var urllib = require('url');
var mongoose = require('../connection');
var youtube = require('youtube-api');
var config = require('../../../config');

youtube.authenticate({
    'type':'key', key:config.youtube.secretKey
});

var Schema = mongoose.Schema;

var trackSchema = new Schema({
    userId: {type: String, index: true},
    providerId: {type: String, index: true},
    provider: {type: String, index: true},
    name: String,
    url: String,
});

trackSchema.index({
    userId: 1
}).index({
    provider: 1,
    providerId: 1
}, {
    unique: true
});

var Track = mongoose.model('Track', trackSchema);

Track.build = function (url, cb) {
    var youtubeId,
        parsedUrl = urllib.parse(url, true);
    if (parsedUrl.host.indexOf('youtube') > -1) {
        youtubeId = parsedUrl.query.v;
    } else if (parsedUrl.host.indexOf('youtu.be') > -1) {
        youtubeId = parsedUrl.pathname.slice(1);
    } else {
        return cb('Bad Provider', null);
    }
    youtube.videos.list({
        id: youtubeId,
        part: 'snippet'
    }, function (err, data) {
        if (err) {
            throw new Error(err);
        }
        var result = data.items[0];
        cb(null, {
            name: result.snippet.title,
            url: url,
            provider: 'youtube',
            providerId: youtubeId
        });
    });
};

Track.getTracksForUserId = function (uid, cb) {
    this.find({
        userId: uid
    }, cb);
};

module.exports = Track;
