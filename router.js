var express = require('express')
    , routes = require('./routes')
    , passport = require('./server/auth/passport');

var Track = require('./server/db/models/track');

var router = express.Router();

// PAGES
router.get('/', routes.index);
router.get('/login', routes.login);

// AUTH
router.get('/auth/facebook', passport.authenticate('facebook'));
router.get('/auth/facebook/callback', passport.authenticate('facebook', {
    successRedirect: '/',
    failureRedirect: '/'
}));

// API
router.get('/api/user/:user_id/tracks', function (req, res, next) {
    Track.find({
        userId: req.user_id
    }, function (err, tracks) {
        if (err) {
            return res.send(err);
        }
        res.json(tracks);
    })
});
router.post('/api/user/:user_id/tracks', function (req, res, next) {
    console.log(req);
    Track.create({
        userId: req.params.user_id,
        name: req.body.name,
        url: req.body.url,
        provider: req.body.provider
    }, function (err, track) {
        if (err) {
            return res.send(err);
        }
        res.json(track);
    });
})

module.exports = router;