var urllib = require('url');
var request = require('request');

var mongoose = require('../connection');
var config = require('../../../config');

var Schema = mongoose.Schema;

var trackSchema = new Schema({
    userId: {type: String, index: true},
    providerId: {type: String, index: true},
    provider: {type: String, index: true},
    name: String,
    url: String,
    created: {type: Date, default: Date.now}
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
    var parsedUrl = urllib.parse(url, true);
    if (parsedUrl.host.indexOf('youtube') > -1) {
        this.buildYoutube(url, parsedUrl.query.v, cb);
    } else if (parsedUrl.host.indexOf('youtu.be') > -1) {
        this.buildYoutube(url, parsedUrl.pathname.slice(1), cb);
    } else if (parsedUrl.host.indexOf('soundcloud') > -1) {
        this.buildSoundcloud(url, cb);
    }
};

Track.buildYoutube = function (url, id, cb) {
    var youtube = require('youtube-api');
    youtube.authenticate({
        'type':'key', key:config.youtube.secretKey
    });
    youtube.videos.list({
        id: id,
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
            providerId: id
        });
    });
};

Track.buildSoundcloud = function (url, cb) {
    var requestURL = urllib.format({
        protocol: 'http:',
        host: 'api.soundcloud.com',
        pathname: 'resolve.json',
        query: {
            url: url,
            client_id: config.soundcloud.clientID
        }
    });
    request(requestURL, function (err, res, body) {
        if (err) {
            return cb(err, null);
        }
        body = JSON.parse(body);
        cb(null, {
            name: body.title,
            url: url,
            provider: 'soundcloud',
            providerId: body.id
        });
    });
};

Track.getTracksForUserId = function (uid, cb) {
    this.find({
        userId: uid
    }, cb);
};

module.exports = Track;
