var express = require('express'),
    routes = require('./routes'),
    passport = require('./server/auth/passport');

var Track = require('./server/db/models/track');

var router = express.Router();

// PAGES
router.get('/', function (req, res, next) {
    if (req.user) {
        res.locals.expose = {};
        res.locals.expose.user = req.user;
        Track.getTracksForUserId(req.user._id, function (err, data) {
            if (err) {
                res.send(err);
            } else {
                res.locals.expose.tracks = data;
                next();
            }
        });
    } else {
        next();
    }
}, routes.index);

router.get('/login', routes.login);

// AUTH
router.get('/auth/facebook', passport.authenticate('facebook'));
router.get('/auth/facebook/callback', passport.authenticate('facebook', {
    successRedirect: '/',
    failureRedirect: '/'
}));
router.get('/logout', function (req, res) {
    req.logout();
    res.redirect('/');
});

// API
router.get('/api/user/:user_id/tracks', function (req, res) {
    Track.find({
        userId: req.user_id
    }, function (err, tracks) {
        if (err) {
            return res.send(err);
        }
        res.json(tracks);
    });
});

router.post('/api/user/:user_id/tracks', function (req, res) {
    Track.build(req.body.url, function(err, data) {
        if (err) {
            throw new Error(err);
        } else {
            data['userId'] = req.params.user_id;
            Track.create(data, function (err, track) {
                if (err) {
                    return res.send(err);
                }
                res.json(track);
            });
        }
    });
});

module.exports = router;