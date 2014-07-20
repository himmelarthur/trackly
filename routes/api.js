var Track = require('../server/db/models/track');

exports.tracks = {

    get: function (req, res) {
        Track.find({
            userId: req.user_id
        }, function (err, tracks) {
            if (err) {
                return res.send(500, err);
            }
            res.json(tracks);
        });
    },

    post: function (req, res) {
        Track.build(req.body.url, function(err, data) {
            if (err) {
                throw new Error(err);
            } else {
                data.userId = req.params.user_id;
                Track.create(data, function (err, track) {
                    if (err) {
                        return res.send(500, err);
                    }
                    res.json(track);
                });
            }
        });
    },

    delete: function (req, res) {
        Track.findById(req.params.track_id, function (err, track) {
            if (err) {
                return res.send(500, err);
            }
            track.remove();
            res.send(200);
        });
    }

};